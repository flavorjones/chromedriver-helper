require "spec_helper"

describe "integration specs" do
  WINDOWS_P = RbConfig::CONFIG['host_os'] !~ /linux|darwin/

  if WINDOWS_P
    context "via the command line" do
      it "downloads an appropriate executable and runs it" do
        begin
          old_path = ENV['PATH']
          Dir.mktmpdir do |dir|
            ENV['CHROMEDRIVER_HELPER_ROOT'] = dir
            ENV['PATH'] = "#{File.join(Dir.pwd, "bin")};#{old_path}"

            puts ENV['PATH']
            puts Dir["bin/**"]
            exe = windows? ? "chromedriver.exe" : "chromedriver"
            cmd = %Q{"#{exe}" -v}
            puts "command: #{cmd}"
            output = `#{cmd}`
            puts "chromedriver version: #{output}"
            expect(output).to match(/^ChromeDriver [0-9]+\.[0-9]+\.[0-9]+/)
          end
        ensure
          ENV['CHROMEDRIVER_HELPER_ROOT'] = nil
          ENV['PATH'] = old_path
        end
      end
    end
  end
end
