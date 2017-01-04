require "chromedriver/helper/google_code_parser"

module Chromedriver
  class Configuration
    attr_accessor :version

    def initialize
      @version = nil
    end
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configuration=(config)
    @configuration = config
  end

  def self.configure
    yield configuration
  end
end
