#!/usr/bin/env bash


recipient='@@CHEF_REPORT_RECIPIENT@@'

usr=$(whoami)
box=$(hostname)

hosts_file='/etc/hosts'
chefsvr_alias='@@CHEF_SVR_ALIAS@@'
chefsvr_fqdn='@@CHEF_SVR_FQDN@@'
chefsvr_ip='@@CHEF_SVR_IP@@'

echo
echo -n "El proceso de instalación está a punto de comenzar. Deseas continuar? [S/n] "
read must_continue
echo

if [[ "$must_continue" != "n" ]]; then
  if [[ ! -f "${hosts_file}.orig" ]]; then
    sudo cp "${hosts_file}" "${hosts_file}.orig"
    echo "${chefsvr_ip}		${chefsvr_fqdn}		${chefsvr_alias}" | sudo tee -a "${hosts_file}" &>/dev/null
  fi

  sudo chef-client

  sudo rm -f "${hosts_file}"
  sudo mv "${hosts_file}.orig" "${hosts_file}"

  file_cache_path="/var/chef/cache"
  filename="chef-stacktrace.out"
  logfile=$(find $file_cache_path -maxdepth 1 -mmin -5 -name $filename)

  if [[ -n "$logfile" ]]; then
    echo
    echo "El proceso no se completó con éxito. Enviando informe..."
    echo

    subject="[CHEF | FAIL] ${usr}@${box} -- $(date +'%Y-%m-%d-%H%M%S')"

    echo | sudo mutt -s "'$subject'" -a $logfile -- $recipient
    find $HOME -maxdepth 1 -name dead.letter -delete

    echo
    echo "El administrador se pondrá en contacto en breve."
    echo
  else
    echo
    echo "El proceso se completó con éxito. Enviando informe..."
    echo

    subject="[CHEF | SUCCESS] ${usr}@${box} -- $(date +'%Y-%m-%d-%H%M%S')"

    echo | sudo mutt -s "'$subject'" -- $recipient
    find $HOME -maxdepth 1 -name dead.letter -delete
  fi

  sleep 3
fi

