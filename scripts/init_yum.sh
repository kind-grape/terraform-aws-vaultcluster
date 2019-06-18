#!/bin/bash -x
set -x
JAIL="/home/jail"
function create_Service {
cat <<- _EOF_
useradd -m -d /home/\$1 -k /etc/skel -s /bin/bash -U \$1 && \\
OUTPUT="\$(date +%s | sha256sum | base64 | head -c 10)" && \\
echo \$1:\$OUTPUT | chpasswd && \\
echo "Username \$1 Password \$OUTPUT" >> /home/jail/passwords
_EOF_
}
export -f create_Service

sudo yum repolist
echo "LOADING REPO LIST"
sudo yum install -y git unzip epel-release
echo "REPO LIST LOADED"
sudo yum repolist
sudo yum install -y wget nano net-tools htop sshpass multitail jnettop mlocate tcpdump screen tmux
sudo yum --enablerepo=epel-testing -y install jnettop dnsmasq

function create_dnsmaq {
cat <<- _EOF_
server=/consul/127.0.0.1#8600
_EOF_
}
export -f create_dnsmaq

sudo mkdir -p $JAIL && sudo chmod 0700 $JAIL

if [ -L "/sbin/createService" ]; then
	echo "createService already exists, skipping..."
else
	sudo bash -c "$(declare -f create_Service); create_Service | tee $JAIL/createService > /dev/null"
  sudo chmod +x $JAIL/createService
  sudo ln -s $JAIL/createService /sbin/createService
  echo "createService file created in $JAIL and linked inside of /sbin"
fi

sudo mv /etc/localtime $JAIL/
sudo ln -s /usr/share/zoneinfo/America/New_York /etc/localtime

sudo sed -i 's/#force_color/force_color/g' /etc/skel/.bashrc
sudo dircolors -p 2>&1 | sudo tee /etc/skel/.dircolors
sudo sed -i 's/DIR\ 01;34/DIR\ 01;36/g' /etc/skel/.dircolors
