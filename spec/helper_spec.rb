require "spec_helper"

describe Chromedriver::Helper do
  before do
    allow(helper).to receive(:newest_download_version).and_return(newest_download_version)
  end
  let(:helper) { Chromedriver::Helper.new }
  let(:newest_download_version) { '1.2.3' }

  describe "#binary_path" do
    context "on a linux platform" do
      before { allow(helper).to receive(:platform) { "linux32" } }
      it { expect(helper.binary_path).to match(/chromedriver$/) }
    end

    context "on a windows platform" do
      before { allow(helper).to receive(:platform) { "win" } }
      it { expect(helper.binary_path).to match(/chromedriver\.exe$/) }
    end
  end

  describe '#download' do
    before do
      $stdout = StringIO.new
    end

    context 'when the download_version is installed' do
      before do
        allow(File).to receive(:exist?).and_return(true)
        allow(helper).to receive(:current_version).and_return(newest_download_version)
      end

      it 'outputs a message' do
        helper.download
        expect($stdout.string).to include("already installed")
      end
    end
  end

  describe '#platform' do
    os_cpu_matrix = [
      { 'host_os' => 'darwin','host_cpu' => 'irrelevant', 'expected_platform' => 'mac' },
      { 'host_os' => 'linux', 'host_cpu' => 'amd64',      'expected_platform' => 'linux64' },
      { 'host_os' => 'linux', 'host_cpu' => 'irrelevant', 'expected_platform' => 'linux32' },
      { 'host_os' => 'linux', 'host_cpu' => 'x86_64',     'expected_platform' => 'linux64' },
      { 'host_os' => 'mingw', 'host_cpu' => 'irrelevant', 'expected_platform' => 'win' },
      { 'host_os' => 'mswin', 'host_cpu' => 'irrelevant', 'expected_platform' => 'win' }
    ]

    os_cpu_matrix.each do |config|
      expected_platform = config['expected_platform']
      host_cpu          = config['host_cpu']
      host_os           = config['host_os']

      context "given host OS #{host_os} and host CPU #{host_cpu}" do
        before do
          RbConfig.send(:remove_const, :CONFIG)
          RbConfig::CONFIG = { 'host_os' => host_os, 'host_cpu' => host_cpu }
        end

        it "returns #{expected_platform}" do
          expect(helper.platform).to eq(expected_platform)
        end
      end
    end

    describe '#update' do
      before do
        allow(helper).to receive(:download).and_return(nil)
      end
      let(:version) { '1.0.0' }

      context 'when a version is given' do
        it 'sets @download_version as given' do
          expect(helper.instance_variable_get(:@download_version)).to eql(nil)
          helper.update(version)
          expect(helper.instance_variable_get(:@download_version)).to eql(version)
        end
      end

      context 'when no version is given' do
        it 'sets @download_version as newest' do
          expect(helper.instance_variable_get(:@download_version)).to eql(nil)
          helper.update
          expect(helper.instance_variable_get(:@download_version)).to eql(newest_download_version)
        end
      end
    end

    context 'given an unknown host OS' do
      before do
        RbConfig.send(:remove_const, :CONFIG)
        RbConfig::CONFIG = { 'host_os' => 'freebsd', 'host_cpu' => 'irrelevant' }
      end

      it 'raises an exception' do
        expect { helper.platform }.to raise_error("Unsupported host OS 'freebsd'")
      end
    end
  end
end
