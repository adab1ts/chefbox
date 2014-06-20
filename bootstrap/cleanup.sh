#!/usr/bin/env bash


usr=$(whoami)


echo
echo "Limpiando el entorno..."
echo

sudo apt-get -y purge ssmtp mutt openssh-server
sudo apt-get -y autoremove

sudo rm /etc/sudoers.d/10_${usr}
find $HOME -maxdepth 1 -name dead.letter -delete
rm ${HOME}/.muttrc
rm ${HOME}/.ssh/authorized_keys
rm ${HOME}/.bash_history

echo
echo "La limpieza ha finalizado. Cierra la sesión e inicia una nueva"
echo "para empezar a usar tu nuevo entorno."
echo

sleep 3

