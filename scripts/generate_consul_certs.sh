#!/usr/bin/env bash
set -x
export REGION="${region}"
export TEMPDIR="${tempdir}"
# export DOMAIN="${domain}"

if [ ! -d "$TEMPDIR" ]; then
	mkdir -p $TEMPDIR
fi

cd $TEMPDIR
consul tls ca create # -domain $DOMAIN
consul tls cert create -server -dc $REGION # -domain $DOMAIN
consul tls cert create -client -dc $REGION # -domain $DOMAIN
