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

if [ ! -f "$TEMPDIR/client-cert.json" ]; then
cat <<CERT | sudo tee $TEMPDIR/${ORG}_vault.json
{
  "CN": "$DOMAIN",
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
  ]
}
CERT
fi

if [ ! -f "$TEMPDIR/int-client-cert.json" ]; then
cat <<INTCERT | sudo tee $TEMPDIR/int-client-cert.json
{
	"signing": {
		"profiles": {
			"CA": {
				"usages": ["cert sign"],
				"expiry": "8760h"
			}
		},
		"default": {
			"usages": ["digital signature"],
			"expiry": "8760h"
		}
	}
}
INTCERT
fi

cfssl gencert -ca ${ORG}_root_CA.pem -ca-key ${ORG}_root_CA-key.pem \
-hostname="vault,vault.$DOMAIN,vault1.$DOMAIN,vault2.$DOMAIN,*.node.consul,*.service.consul,server.$DC.consul,*.$DC.consul,localhost,127.0.0.1" \
-config int-client-cert.json ${ORG}_vault.json | cfssljson -bare ${ORG}_vault
