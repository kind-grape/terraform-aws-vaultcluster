#!/usr/bin/env bash
set -x
export REGION="${region}"
export TEMPDIR="${tempdir}"

if [ ! -d "$TEMPDIR" ]; then
	mkdir -p $TEMPDIR
fi

cd $TEMPDIR
consul tls ca create
consul tls cert create -server -dc $REGION
consul tls cert create -client -dc $REGION
