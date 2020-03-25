require 'spec_helper'

describe 'consul::default' do
  platform 'ubuntu'

  context 'with default attributes' do
    describe 'creates the necessary directories for Consul' do
      it {
        is_expected.to create_directory('/etc/consul.d').with(
          user: 'consul',
          group: 'consul'
        )
      }
      it {
        is_expected.to create_directory('/etc/consul.d/tls').with(
          user: 'consul',
          group: 'consul'
        )
      }
      it {
        is_expected.to create_directory('/var/lib/consul').with(
          user: 'consul',
          group: 'consul'
        )
      }
    end

    describe 'sets the Consul autocompletion' do
      it {
        is_expected.to create_file('/etc/profile.d/99-consul-completion.sh').with(
          user: 'root',
          group: 'root'
        )
      }
    end

    describe 'installs the Consul binary' do
      it { is_expected.to render_file('/usr/local/bin/consul') }
    end

    describe 'creates a systemd unit for Consul' do
      it { is_expected.to create_systemd_unit('consul') }
    end
  end
end
