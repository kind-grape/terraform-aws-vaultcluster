default['consul']['directory'] = {
  config: '/etc/consul.d',
  tls: '/etc/consul.d/tls',
  data: '/var/lib/consul',
  binary: '/usr/local/bin',
}
default['consul']['version'] = '1.6.1'
default['consul']['user'] = 'consul'
default['consul']['group'] = 'consul'
