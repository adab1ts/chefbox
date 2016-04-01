#!/usr/bin/env bash


usr=$(whoami)

edb_key_file='/etc/chef/edb'
oc_cert_file='/opt/chef/embedded/ssl/certs/ocserver.pem'


echo
echo "Limpiando el entorno..."
echo

sudo apt-get -y purge ssmtp mutt openssh-server

sudo rm /etc/sudoers.d/10_${usr}
find $HOME -maxdepth 1 -name dead.letter -delete
rm ${HOME}/.muttrc
rm ${HOME}/.ssh/authorized_keys
rm ${HOME}/.bash_history

sudo rm "${edb_key_file}"
sudo rm "${oc_cert_file}"
sudo apt-get -y purge chef

sudo apt-get -y autoremove

echo
echo "La limpieza ha finalizado. Cierra la sesión e inicia una nueva"
echo "para empezar a usar tu nuevo entorno."
echo

sleep 3
