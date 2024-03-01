SSHD_CONF_LOC="/etc/ssh/sshd_config"
sed -i -e 's/^.*PermitRootLogin.*$/PermitRootLogin no/' $SSHD_CONF_LOC

#finish later
