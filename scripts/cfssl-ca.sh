#!/bin/bash -x
TEMPDIR="."
VAULTDIR="/etc/vault.d/tls"
DOMAIN="example.com"
DC="vault"
COUNTRY="CA"
STATE="Ontario"
LOCATION="Ottawa"
ORG="ACME"
OU="IT"

if [ ! -f "/usr/local/bin/cfssl" ]; then
	curl -s -L -o /usr/local/bin/cfssl https://pkg.cfssl.org/R1.2/cfssl_linux-amd64
  chmod +x /usr/local/bin/cfssl
  ln -s /usr/local/bin/cfssl /bin/cfssl
fi
if [ ! -f "/usr/local/bin/cfssljson" ]; then
	curl -s -L -o /usr/local/bin/cfssljson https://pkg.cfssl.org/R1.2/cfssljson_linux-amd64
  chmod +x /usr/local/bin/cfssljson
  ln -s /usr/local/bin/cfssljson /bin/cfssljson
fi

if [ ! -d "$TEMPDIR" ]; then
	mkdir -p $TEMPDIR
fi
cd $TEMPDIR

if [ ! -f "$TEMPDIR/vault_root_CA.json" ]; then
cat <<CACERT | sudo tee $TEMPDIR/vault_root_CA.json
{
  "CN": "$ORG-ROOT-CA",
  "key": {
     "algo": "ecdsa",
     "size": 256
  },
  "names": [
    {
      "C": "$COUNTRY",
      "L": "$LOCATION",
      "O": "$ORG",
      "OU": "$OU",
      "ST": "$STATE"
    }
  ],
  "ca": {
     "expiry": "262800h"
  }
}
CACERT
fi

cfssl gencert -initca vault_root_CA.json | cfssljson -bare vault_root_CA
cat vault_root_CA.pem > vault_bundle.pem
