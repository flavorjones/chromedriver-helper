require "spec_helper"

describe Chromedriver::Helper do
  let(:helper) { Chromedriver::Helper.new }

  describe "#binary_path" do
    context "preexisting installation" do
      before { allow(helper).to receive(:preexisting_installation) { "/usr/local/bin/chromedriver" } }
      it { expect(helper.binary_path).to match(/chromedriver$/) }
    end

    context "on a linux platform" do
      before do
        allow(helper).to receive(:preexisting_installation).and_return(nil)
        allow(helper).to receive(:platform) { "linux32" }
      end
      it { expect(helper.binary_path).to match(/chromedriver$/) }
    end

    context "on a windows platform" do
      before do
        allow(helper).to receive(:preexisting_installation).and_return(nil)
        allow(helper).to receive(:platform) { "win" }
      end
      it { expect(helper.binary_path).to match(/chromedriver\.exe$/) }
    end
  end
end
