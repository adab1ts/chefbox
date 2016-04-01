#!/usr/bin/env bash


hosts_file='/etc/hosts'
cacert_file='/opt/chef/embedded/ssl/certs/cacert.pem'
oc_cert_file='/opt/chef/embedded/ssl/certs/ocserver.pem'
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
  if [[ ! -f "${cacert_file}.orig" ]]; then
    echo
    echo "Adding OwnCloud self-signed certificate to list of CA certs..."
    echo

    sudo cp "${cacert_file}" "${cacert_file}.orig"

    echo "OwnCloud Server" | sudo tee -a "${cacert_file}" &>/dev/null
    echo "===============" | sudo tee -a "${cacert_file}" &>/dev/null
    cat "${oc_cert_file}" | sudo tee -a "${cacert_file}" &>/dev/null
  fi

  if [[ ! -f "${hosts_file}.orig" ]]; then
    echo
    echo "Adding Chef server to static table lookup for hostnames..."
    echo

    sudo cp "${hosts_file}" "${hosts_file}.orig"
    echo "${chefsvr_ip}		${chefsvr_fqdn}		${chefsvr_alias}" | sudo tee -a "${hosts_file}" &>/dev/null
  fi

  echo
  echo "Adding OwnCloud server to static table lookup for hostnames..."
  echo

  echo "${ocsvr_ip}		${ocsvr_fqdn}		${ocsvr_alias}" | sudo tee -a "${hosts_file}" &>/dev/null

  echo
  echo "Provisioning node..."
  echo

  sudo chef-client

  echo
  echo "Cleaning up..."
  echo

  find $HOME -maxdepth 1 -name dead.letter -delete

  echo
  echo "Restoring original static table lookup for hostnames..."
  echo

  sudo rm -f "${hosts_file}"
  sudo mv "${hosts_file}.orig" "${hosts_file}"

  echo
  echo "Restoring original CA certs file..."
  echo

  sudo rm -f "${cacert_file}"
  sudo mv "${cacert_file}.orig" "${cacert_file}"

  sleep 3
fi
