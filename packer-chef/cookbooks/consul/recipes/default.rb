# Install the Consul binary
cookbook_file "/tmp/consul-enterprise_#{node['consul']['version']}+prem_linux_amd64.zip" do
  source "consul-enterprise_#{node['consul']['version']}+prem_linux_amd64.zip"
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

archive_file 'consul' do
  path "/tmp/consul-enterprise_#{node['consul']['version']}+prem_linux_amd64.zip"
  destination node['consul']['directory']['binary']
  owner 'root'
  group 'root'
  action :extract
end

# Add in auto-completion for Consul
file '/etc/profile.d/99-consul-completion.sh' do
  content 'complete -C "/usr/local/bin/consul" "consul"'
  owner 'root'
  group 'root'
  mode '0644'
  action :create
end

# Add in the Consul user
user 'consul' do
  comment 'Consul user'
  home node['consul']['directory']['config']
  shell '/bin/false'
  action :create
end

# Create configuration and TLS directories
[node['consul']['directory']['config'], node['consul']['directory']['tls']].each do |dir|
  directory dir do
    owner node['consul']['user']
    group node['consul']['group']
    mode '0750'
    action :create
  end
end

link '/usr/local/bin/consul' do
  to '/bin/consul'
  link_type :symbolic
end

# Data directory
directory node['consul']['directory']['data'] do
  owner node['consul']['user']
  group node['consul']['group']
  mode '0700'
  action :create
end

# Setup the service for the agent
systemd_unit 'consul' do
  content(
    Unit: {
      Description: 'HashiCorp Consul',
      Documentation: 'https://www.consul.io/',
      Requires: 'network-online.target',
      After: 'network-online.target',
      ConditionFileNotEmpty: "#{node['consul']['directory']['config']}/consul.hcl",
    },
    Service: {
      User: node['consul']['user'],
      Group: node['consul']['user'],
      ExecStart: "#{node['consul']['directory']['binary']}/consul agent -config-dir=#{node['consul']['directory']['config']}/",
      ExecReload: "#{node['consul']['directory']['binary']}/consul reload",
      KillMode: 'process',
      Restart: 'on-failure',
      LimitNOFILE: '65536',
    },
    Install: {
      WantedBy: 'multi-user.target',
    }
  )
  action [:create, :enable, :start]
end
