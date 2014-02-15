#!/usr/bin/env bash


recipient='@@CHEF_REPORT_RECIPIENT@@'

usr=$(whoami)
box=$(hostname)
lpwd=$(pwd)

config="${lpwd}/config"
keys="${lpwd}/keys"

hosts_file='/etc/hosts'
chefsvr_alias='@@CHEF_SVR_ALIAS@@'
chefsvr_fqdn='@@CHEF_SVR_FQDN@@'
chefsvr_ip='@@CHEF_SVR_IP@@'

ssmtp_path='/etc/ssmtp'
ssmtp_file='ssmtp.conf'
ssmtp_aliases='revaliases'
muttrc_file='muttrc'

sudoers_path='/etc/sudoers.d'
sudo_file='10_user'

ssh_path='/etc/ssh'
pub_key='key.pub'

chef_path='/etc/chef'
edb_key='edb'


echo
echo "Adding Chef server to static table lookup for hostnames..."
echo

sudo cp "${hosts_file}" "${hosts_file}.orig"
echo "${chefsvr_ip}		${chefsvr_fqdn}		${chefsvr_alias}" | sudo tee -a "${hosts_file}" &>/dev/null

echo
echo "Installing a simple MTA to get mail off the system to Gmail hub..."
echo

echo -n "Enter your gmail address (username@gmail.com): "
read gmail_address

echo -n "Enter your gmail password: "
read -s gmail_passwd
echo

echo
echo "Installing SSMTP Mail Transfer Agent..."
echo

sudo apt-get -y install ssmtp mutt curl

echo
echo "Configuring SSMTP Mail Transfer Agent..."
echo

cat "${config}/${ssmtp_file}" \
  | sed "s/@@EMAIL@@/${gmail_address}/g" \
  | sed "s/@@PASSWORD@@/${gmail_passwd}/g" \
  | sed "s/@@HOSTNAME@@/$(hostname)/g" \
  | sudo tee "${ssmtp_path}/${ssmtp_file}" &>/dev/null

sudo chmod 600 "${ssmtp_path}/${ssmtp_file}" &>/dev/null

cat "${config}/${ssmtp_aliases}" \
  | sed "s/@@EMAIL@@/${gmail_address}/g" \
  | sed "s/@@USER@@/${usr}/g" \
  | sudo tee "${ssmtp_path}/${ssmtp_aliases}" &>/dev/null

cp "${config}/${muttrc_file}" "${HOME}/.muttrc"


echo
echo "Configuring sudo..."
echo

sed "s/@@USER@@/${usr}/g" "${config}/${sudo_file}" | sudo tee "${sudoers_path}/10_${usr}" &>/dev/null
sudo chmod 440 "${sudoers_path}/10_${usr}" &>/dev/null


echo
echo "Installing Secure Shell server..."
echo

sudo apt-get -y install openssh-server


echo
echo "Configuring Secure Shell service..."
echo

sudo mv "${ssh_path}/sshd_config" "${ssh_path}/sshd_config.orig" \
  && sudo chmod a-w "${ssh_path}/sshd_config.orig" \
  && sudo cp "${config}/sshd_config" "${ssh_path}/sshd_config" \
  && sudo service ssh restart


echo
echo "Adding public key..."
echo

[[ ! -d "${HOME}/.ssh" ]] && mkdir "${HOME}/.ssh"
cat "${keys}/${pub_key}" >> "${HOME}/.ssh/authorized_keys" \
  && chmod 600 "${HOME}/.ssh/authorized_keys"


echo
echo "Adding encrypted data bags secret..."
echo

[[ ! -d "${chef_path}" ]] && sudo mkdir "${chef_path}"
sudo cp "${keys}/${edb_key}" "${chef_path}/${edb_key}" \
  && sudo chmod 600 "${chef_path}/${edb_key}"


echo
echo "Sending report..."
echo

ip_service='icanhazip.com'
ip=$(curl $ip_service 2>/dev/null)
iface=$(ifconfig | grep -E '^@@IFACE@@' | awk '{print $1}' 2>/dev/null)
pip=$(ip address show $iface | grep -E 'inet\s' | awk '{print $2}' 2>/dev/null)

subject="[CHEF | SUCCESS] ${usr}@${box} -- $(date +'%Y-%m-%d-%H%M%S')"
body="Phase 1 completed. IP: ${ip} - Private IP: ${pip}"

echo $body | sudo mutt -s "'$subject'" -- $recipient
find $HOME -maxdepth 1 -name dead.letter -delete


echo
echo "Installation complete"
echo

sleep 3

