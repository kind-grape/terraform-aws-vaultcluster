#!/bin/bash -x
TEMPDIR="/tmp/certs"
VAULTDIR="/etc/vault.d/tls"
CANAME="rootCA"
DOMAIN="example.com"
DC="dc1"
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

cat <<CACERT | sudo tee $TEMPDIR/ca-cert.json
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

cfssl gencert -initca ca-cert.json | cfssljson -bare ${ORG}_root_CA
