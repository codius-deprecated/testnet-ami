(
  wget http://169.254.169.254/latest/user-data -O /root/testnet-config.yml
  ansible-playbook -vvvv -c local /root/testnet-boot.yml
) 2>&1 | tee /var/log/testnet_boot.log
