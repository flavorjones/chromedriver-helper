begin
  require "selenium-webdriver"
  Selenium::WebDriver::Chrome.driver_path=Gem.bin_path("chromedriver-helper","chromedriver-helper")
rescue LoadError
  # ignore
end
