#!/bin/bash -x
TEMPDIR="/tmp/certs"
VAULTDIR="/etc/vault.d/tls"
CERTOPTS="-nameopt utf8,multiline,align -enddate -certopt no_header,no_version,no_serial,no_signame,no_validity,no_pubkey,no_sigdump,no_aux"

if [ ! -d "$TEMPDIR" ]; then
	mkdir -p $TEMPDIR
fi

openssl x509 -in $TEMPDIR/${ORG}_root_CA.pem -noout -text $CERTOPTS
openssl x509 -in $TEMPDIR/${ORG}_vault.pem -noout -text $CERTOPTS

cp $TEMPDIR/${ORG}_root_CA.pem $VAULTDIR/vault_tls_ca_bundle
cp $TEMPDIR/${ORG}_vault.pem $VAULTDIR/vault_client_tls_cert
cp $TEMPDIR/${ORG}_vault-key.pem $VAULTDIR/vault_client_tls_key

chown vault:consul $VAULTDIR/*
