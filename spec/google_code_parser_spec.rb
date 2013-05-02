require "spec_helper"

describe Chromedriver::Helper::GoogleCodeParser do
  describe ".new" do
    it "takes HTML" do
      html = "<html><body><div>hello</div></body></html>"
      parser = Chromedriver::Helper::GoogleCodeParser.new html
      parser.html.should == html
    end
  end

  describe "#downloads" do
    it "returns a hash of names and urls" do
      parser = Chromedriver::Helper::GoogleCodeParser.new File.read(File.join(File.dirname(__FILE__), "assets/google-code.html"))
      parser.downloads.should == [
        "//chromium.googlecode.com/files/chromedriver2_win_16.0.902.0.zip",
        "//chromium.googlecode.com/files/chromedriver2_mac32_16.0.902.0.zip",
        "//chromium.googlecode.com/files/chromedriver2_linux64_16.0.902.0.zip",
        "//chromium.googlecode.com/files/chromedriver2_linux32_16.0.902.0.zip",
        "//chromium.googlecode.com/files/Chrome552.215.exe",
        "//chromium.googlecode.com/files/Chrome517.41.exe",
        "//chromium.googlecode.com/files/codesite.crx",
        "//chromium.googlecode.com/files/chromecomicJPGS.zip"
        ]
    end
  end
end

