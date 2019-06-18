#!/usr/bin/env bash
set -x
DC="${region}-${env}"
ROLE="${role}"
# DC="g-east-npd"
# ROLE="consul"
URL="https://artifacts.mlbinfra.net/artifactory/infra-local/certs/$DC"
DIR="/home/$ROLE/tls"

function copytls {
  for file in $(curl -s $URL/ |
                    grep href |
                    sed 's/.*href="//' |
                    sed 's/".*//' |
                    grep '^[a-zA-Z].*'); do
      cd $DIR; curl -s -O $URL/$file
  done
}
export -f copytls

if [ ! -d "$DIR" ]; then
  echo "Creating $ROLE TLS Directory, and downloading certs"
  mkdir -p $DIR
  copytls
  chown -R $ROLE:$ROLE $DIR
  cp $DIR/ca.crt.pem /etc/pki/ca-trust/source/anchors/
  update-ca-trust enable; update-ca-trust extract
else
  echo "$ROLE TLS directory already exists, downloading certs"
  copytls
  chown -R $ROLE:$ROLE $DIR
  cp $DIR/ca.crt.pem /etc/pki/ca-trust/source/anchors/
  update-ca-trust enable; update-ca-trust extract
fi
