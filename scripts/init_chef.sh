#!/bin/bash -x
set -x
###############################
## Chef Prep and Setup
###############################

CHEFDIR="/home/chef"
CHEFVER="14.0.202"
PROJECT="${project}"
GITURL="${git_url}"
GITACCT="${git_acct}"
# [[ -z "$1" ]] && PROJECT="${project}" || PROJECT="$1"

function create_config {
cat <<- _EOF_
chef_dir                "/home/chef/.chef"
log_level               :info
log_location            "/tmp/chefdebug.log"
cookbook_path           "#{chef_dir}/cookbooks"
file_cache_path         "#{chef_dir}/cache"
environment_path        "#{chef_dir}/environments"
role_path               "#{chef_dir}/roles"
local_mode              :true
solo                    :true
_EOF_
}

# Key missing half to keep anon
function create_ssh_key {
cat <<- _EOF_
${ssh_private_key}
_EOF_
}

# Key missing half to keep anon
function create_ssh_pub {
cat <<- _EOF_
${ssh_public_key}
_EOF_
}

##############################
# Init
##############################
export -f create_config
export -f create_ssh_key
export -f create_ssh_pub

###############################
## Chef Setup
###############################
chef-client -version | awk '{print $2}'
retval="$?"
if [ $retval -ne 0 ]; then
  echo "Chef is already installed"
else
  rpm -ivh https://packages.chef.io/files/stable/chef/$CHEFVER/el/7/chef-$CHEFVER-1.el7.x86_64.rpm
fi

mkdir -p /etc/chef && create_config > /etc/chef/solo.rb && create_config > /etc/chef/client.rb

if [ ! -d "$CHEFDIR/.chef" ]; then
  echo "Creating Chef User"
  createService chef || :
  if [ ! -d "$CHEFDIR/.ssh" ]; then
    echo "Creating .ssh directory for Chef User"
    su chef -c 'mkdir -p ~/.ssh && chmod 0700 ~/.ssh && create_ssh_key > ~/.ssh/id_rsa && create_ssh_pub > ~/.ssh/id_rsa.pub && chmod 600 ~/.ssh/id_rsa && echo -e "Host *\n\tStrictHostKeyChecking no" > ~/.ssh/config'
  else
    echo ".ssh directory already exists for Chef User"
  fi
  echo "pulling chef directory from git"
  su chef -c "cd ~ && git clone $GITURL:$GITACCT/$PROJECT.git ~/.chef" chef
else
  echo ".chef directory already exists for Chef User"
fi

chef-client -E ${environment} -o role[base]

su chef -c 'cp /etc/skel/.* ~' || :
su ${user} -c 'cp /etc/skel/.* ~' || :

#########################################################################
## Finished Common Script
#########################################################################
