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

cat <<INTCERT | sudo tee $TEMPDIR/int-cert.json
{
  "CN": "$ORG-Intermediate-CA",
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
     "expiry": "42720h"
  }
}
INTCERT

cat <<CACERT | sudo tee $TEMPDIR/root-int-cert.json
{
	"signing": {
		"default": {
			"usages": [
				"digital signature",
				"cert sign",
				"crl sign",
				"signing"
			],
			"expiry": "262800h",
			"ca_constraint": {
				"is_ca": true, "max_path_len":0, "max_path_len_zero": true
			}
		}
	}
}
CACERT

cfssl gencert -initca int-cert.json | cfssljson -bare ${ORG}_intermediate_CA
cfssl sign -ca ${ORG}_root_CA.pem -ca-key ${ORG}_root_CA-key.pem -config root-int-cert.json ${ORG}_intermediate_CA.csr | cfssljson -bare ${ORG}_intermediate_CA

cat ${ORG}_root_CA.pem ${ORG}_intermediate_CA.pem > ${ORG}_bundle.pem
