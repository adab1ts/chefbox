#!/usr/bin/env bash


hosts_file='/etc/hosts'
chefsvr_alias='@@CHEF_SVR_ALIAS@@'
chefsvr_fqdn='@@CHEF_SVR_FQDN@@'
chefsvr_ip='@@CHEF_SVR_IP@@'
ocsvr_alias='@@OC_SVR_ALIAS@@'
ocsvr_fqdn='@@OC_SVR_FQDN@@'
ocsvr_ip='@@OC_SVR_IP@@'

echo
echo -n "El proceso de instalación está a punto de comenzar. Deseas continuar? [S/n] "
read must_continue
echo

if [[ "$must_continue" != "n" ]]; then
  if [[ ! -f "${hosts_file}.orig" ]]; then
    sudo cp "${hosts_file}" "${hosts_file}.orig"
    echo "${chefsvr_ip}		${chefsvr_fqdn}		${chefsvr_alias}" | sudo tee -a "${hosts_file}" &>/dev/null
  fi
  echo "${ocsvr_ip}		${ocsvr_fqdn}		${ocsvr_alias}" | sudo tee -a "${hosts_file}" &>/dev/null

  sudo chef-client

  find $HOME -maxdepth 1 -name dead.letter -delete

  sudo rm -f "${hosts_file}"
  sudo mv "${hosts_file}.orig" "${hosts_file}"

  sleep 3
fi

