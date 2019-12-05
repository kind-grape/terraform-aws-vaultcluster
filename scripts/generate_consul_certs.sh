#!/usr/bin/env bash
set -x
export REGION="${region}"
export TEMPDIR="${tempdir}"

cd $TEMPDIR
consul tls ca create
consul tls cert create -server -dc $REGION
consul tls cert create -client -dc $REGION
