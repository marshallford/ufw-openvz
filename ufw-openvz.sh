#!/bin/bash
function print_info {
	echo -n -e '\e[1;36m'
	echo -n $1
	echo -e '\e[0m'
}
# Do some sanity checking.
if [ $(/usr/bin/id -u) != "0" ]
then
	die 'Must be run by root user'
fi

if [ ! -f /etc/debian_version ]
then
	die "Distribution is not supported"
fi
print_info "Fixing UFW to run on OpenVZ containers..."
sed '/A ufw-after-input -m addrtype --dst-type BROADCAST -j ufw-skip-to-policy-input/s/^/#/' /etc/ufw/after.rules > ~/temp
cp temp /etc/ufw/after.rules
sed '/-A ufw-not-local -m addrtype --dst-type LOCAL -j RETURN/s/^/#/' /etc/ufw/before.rules > ~/temp
cp temp /etc/ufw/before.rules
sed '/-A ufw-not-local -m addrtype --dst-type MULTICAST -j RETURN/s/^/#/' /etc/ufw/before.rules > ~/temp
cp temp /etc/ufw/before.rules
sed '/-A ufw-not-local -m addrtype --dst-type BROADCAST -j RETURN/s/^/#/' /etc/ufw/before.rules > ~/temp
cp temp /etc/ufw/before.rules
rm -f /sbin/modprobe
ln -s /bin/true /sbin/modprobe
rm -f /sbin/sysctl
ln -s /bin/true /sbin/sysctl
apt-get -y purge rsyslog
apt-get install -y syslog-ng
echo start on startup >> /etc/init/ufw.conf
echo #console output >> /etc/init/ufw.conf
sed '/IPV6=yes/s/yes/no/' /etc/default/ufw > ~/temp
cp temp /etc/default/ufw
rm ~/temp
print_info "Assuming everything ran ok, UFW should work now. Have Fun!"
