require 'spec_helper'

describe 'torrent_client' do
  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        let(:facts) do
          facts
        end

        context "torrent_client class without any parameters" do
          it { is_expected.to compile.with_all_deps }

          it { is_expected.to contain_class('torrent_client::params') }
          it { is_expected.to contain_class('torrent_client::install').that_comes_before('torrent_client::config') }
          it { is_expected.to contain_class('torrent_client::config') }
          it { is_expected.to contain_class('torrent_client::service').that_subscribes_to('torrent_client::config') }

          it { is_expected.to contain_service('torrent_client') }
          it { is_expected.to contain_package('torrent_client').with_ensure('present') }
        end
      end
    end
  end

  context 'unsupported operating system' do
    describe 'torrent_client class without any parameters on Solaris/Nexenta' do
      let(:facts) do
        {
          :osfamily        => 'Solaris',
          :operatingsystem => 'Nexenta',
        }
      end

      it { expect { is_expected.to contain_package('torrent_client') }.to raise_error(Puppet::Error, /Nexenta not supported/) }
    end
  end
end
