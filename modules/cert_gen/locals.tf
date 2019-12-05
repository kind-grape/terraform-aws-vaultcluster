locals {
  certs = merge(var.example_cert, var.certs)
  serverinfo = merge(var.custom_serverinfo, var.serverinfo)
}
