

ui = true
plugin_directory = "/etc/vault.d/plugin"

listener "tcp" {
  address       = "0.0.0.0:8200"
  <% if @tlslistener == false -%>
  tls_disable   = 1
  <% end -%>
  <% if @tlslistener == true -%>
  tls_cert_file = "/path/to/fullchain.pem"
  tls_key_file  = "/path/to/privkey.pem"
  <% end -%>
}

#ha_storage "consul" {
#  address   = "127.0.0.1:8500"
#}

storage "consul" {
  address = "consul-vault.service.consul:7500"
  path    = "vault"
  <% if @tlslistener == true -%>
  token   = "REPLACEMECONSULTOKEN"
  scheme  = "https"
  tls_ca_file   = "/opt/vault/tls/consul-ca.crt"
  tls_cert_file = "/opt/vault/tls/consul.crt"
  tls_key_file  = "/opt/vault/tls/consul.key"
  <% end -%>
}

<% if @telemetry == true -%>
telemetry {
  statsite_address = "127.0.0.1:8125"
  disable_hostname = true
}
<% end -%>

{% if enterprise == 'true' %}
{% if seal == 'gcpckms' %}
seal "gcpckms" {
  project     = "vaultprojectREPLACE"
  region      = "regionREPLACE"
  key_ring    = "vaultkeyringREPLACE"
  crypto_key  = "vaultkeyREPLACE"
}
{% elif seal == 'awskms' %}
seal "awskms" {
  region     = "us-east-1"
  access_key = "AKIAIOSFODNN7EXAMPLE"
  secret_key = "wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY"
  kms_key_id = "19ec80b0-dfdd-4d97-8164-c6examplekey"
  endpoint   = "https://vpce-0e1bb1852241f8cc6-pzi0do8n.kms.us-east-1.vpce.amazonaws.com"
}
{% endif %}
{% end %}
