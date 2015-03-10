curl http://169.254.169.254/latest/user-data > /root/testnet-config.yml
ansible-playbook -c local /root/testnet-boot.yml
