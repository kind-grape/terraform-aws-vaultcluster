#!/bin/bash -x
TEMPDIR="${tempdir}"
DOMAIN="${domain}"
DC="${dc}"
COUNTRY="${country}"
STATE="${state}"
LOCATION="${location}"
ORG="${org}"
OU="${ou}"
HOSTNAMES="vault,vault.$DOMAIN,vault1.$DOMAIN,vault2.$DOMAIN,*.node.consul,*.service.consul,server.$DC.consul,*.$DC.consul"

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
cat <<CACERT | tee $TEMPDIR/vault_root_CA.json
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

if [ ! -f "$TEMPDIR/vault-client-cert.json" ]; then
cat <<CERT | tee $TEMPDIR/vault-client-cert.json
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

if [ ! -f "$TEMPDIR/vault-int-client-cert.json" ]; then
cat <<INTCERT | tee $TEMPDIR/vault-int-client-cert.json
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

cfssl gencert -initca vault_root_CA.json | cfssljson -bare vault_root_CA
cat vault_root_CA.pem > vault_bundle.pem

cfssl gencert -ca vault_root_CA.pem -ca-key vault_root_CA-key.pem \
-hostname="$HOSTNAMES,localhost,127.0.0.1" \
-config vault-int-client-cert.json vault-client-cert.json | cfssljson -bare vault_cert
