#!/usr/bin/env bash
export TEMPDIR="."
export PATH=$PATH:$TEMPDIR
export REGION="us-west-1"
export VLTIP=$(aws ec2 describe-instances --region=$REGION --output text --filters "Name=tag:Role,Values=vault" --query 'Reservations[*].Instances[*].{ExtIP:PublicIpAddress}' | grep -v "None" | head -1)
export VAULT_ADDR="http://$VLTIP:8200"

# [[ -z "$1" ]] && VERSION="2" || VERSION="$1"
TIMELIMIT=$((SECONDS+300))
echo "Waiting for vault server validation.  Ctrl+C to skip.";
until $(vault status |grep "Initialized" >/dev/null); do
	printf '.';
	sleep 2;
	if [ $SECONDS -gt $TIMELIMIT ]; then
		echo "";
		echo "Waited $SECONDS seconds however validation has failed.  Exiting now.";
		exit
	fi
done
echo "";
echo "Vault Startup completed successfully in $SECONDS seconds";
