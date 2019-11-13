service consul stop
rm -rf ~/.ansible/
rm -rf /etc/consul.d/tokens/*
rm -rf /etc/consul.d/*.hcl
rm -rf /var/lib/consul/*
