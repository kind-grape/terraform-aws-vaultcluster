service consul stop
rm -rf ~/.ansible/
rm -rf /etc/consul.d/tokens/*
rm -rf /etc/consul.d/*.hcl
rm -rf /var/lib/consul/*
aws ssm put-parameter --overwrite --region {{ ansible_ec2_placement_region }} --type SecureString --name consul-{{ consul_join_tag_value }}-acl-agent --value REPLACEME
aws ssm put-parameter --overwrite --region {{ ansible_ec2_placement_region }} --type SecureString --name consul-{{ consul_join_tag_value }}-acl-vault --value REPLACEME
