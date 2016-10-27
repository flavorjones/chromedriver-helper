require "chromedriver/configuration"

describe Chromedriver::Configuration do
  describe 'version' do
    it 'defaults to nil' do
      expect(Chromedriver.configuration.version).to eq nil
    end

    it 'can be set' do
      Chromedriver.configure do |configure|
        configure.version = "2.24"
      end

      expect(Chromedriver.configuration.version).to eq "2.24"
    end
  end
end
