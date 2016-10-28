require "chromedriver/helper/version"
require "chromedriver/helper/google_code_parser"
require 'fileutils'
require 'rbconfig'
require 'open-uri'
require 'archive/zip'

module Chromedriver
  def self.root
    File.dirname __dir__
  end

  def self.set_version(version)
    Chromedriver::Helper.new.update(version)
  end

  class Helper
    def run(*args)
      download
      exec binary_path, *args
    end

    def download(hit_network = false)
      return if File.exist?(binary_path) && !hit_network

      raise "Version not found for #{download_version}" unless download_url

      filename = File.basename download_url
      Dir.chdir platform_install_dir do
        FileUtils.rm_f filename
        File.open(filename, "wb") do |saved_file|
          URI.parse(download_url).open("rb") do |read_file|
            saved_file.write(read_file.read)
          end
        end

        raise "Could not download #{download_url}" unless File.exists? filename
        Archive::Zip.extract(filename, '.', :overwrite => :all)
      end
      raise "Could not unzip #{filename} to get #{binary_path}" unless File.exists? binary_path
      FileUtils.chmod "ugo+rx", binary_path
      File.open(version_path, 'w') { |file| file.write(download_version) }
    end

    def update(version = nil)
      if version
        @download_version = version
      end

      hit_network = (current_version != download_version) ? true : false
      download(hit_network)
    end

    def current_version
      @current_version ||= FileUtils.touch(version_path) && File.read(version_path).strip
    end

    def download_version
      @download_version ||= current_version || google_code_parser.newest_download_version
    end

    def download_url
      @download_url ||= google_code_parser.version_download_url(download_version)
    end

    def google_code_parser
      @google_code_parser ||= GoogleCodeParser.new(platform)
    end

    def version_path
      @version_path ||= File.join(File.expand_path("..", Chromedriver.root), ".chromedriver-version")
    end

    def binary_path
      if platform == "win"
        File.join platform_install_dir, "chromedriver.exe"
      else
        File.join platform_install_dir, "chromedriver"
      end
    end

    def platform_install_dir
      dir = File.join install_dir, platform
      FileUtils.mkdir_p dir
      dir
    end

    def install_dir
      dir = File.expand_path File.join(ENV['HOME'], ".chromedriver-helper", download_version)
      FileUtils.mkdir_p dir
      dir
    end

    def platform
      cfg = RbConfig::CONFIG
      case cfg['host_os']
      when /linux/ then
        cfg['host_cpu'] =~ /x86_64|amd64/ ? "linux64" : "linux32"
      when /darwin/ then "mac"
      else "win"
      end
    end
  end
end
