#!/usr/bin/env bash


lpwd=$(pwd)
mobile3g_conf='mobile3g.conf'


echo
echo -n "Plug in your HSPA USB Stick. When you are done, press any key..."
read ahead
echo

sleep 3

echo -n "Enter the USB Stick vendor [ZTE]: "
read modem_vendor
[[ -z "$modem_vendor" ]] && modem_vendor="ZTE"

usb_id=$(lsusb | grep -i "$modem_vendor" | awk '{ print $6 }')
if [[ -z "$usb_id" ]]; then
  echo "USB Stick from vendor ${modem_vendor} not found. Check your device information and try again."
  sleep 3
  exit -1
fi

echo -n "Enter the USB interface to use. If unsure press <Enter> [0-5]: "
read usb_iface
[[ -z "$usb_iface" ]] && usb_iface="0"

echo -n "Enter the PIN number of the USB Stick SIM card [0000]: "
read sim_pin
[[ -z "$sim_pin" ]] && sim_pin="0000"

echo -n "Enter operator AP Name [ac.vodafone.es]: "
read apn
if [[ -z "$apn" ]]; then
  echo "Invalid APN. AP Name is mandatory. Check your operator mobile broadband information and try again."
  sleep 3
  exit -1
fi

echo -n "Enter operator AP User [user]: "
read apn_user
[[ -z "$apn_user" ]] && apn_user="user"

echo -n "Enter operator AP Password [pass]: "
read apn_pass
[[ -z "$apn_pass" ]] && apn_pass="pass"

echo
echo "Configuring Mobile Broadband parameters..." 
echo

cat "${lpwd}/${mobile3g_conf}" \
  | sed "s/@@USB_ID@@/${usb_id}/g" \
  | sed "s/@@USB_IFACE@@/${usb_iface}/g" \
  | sed "s/@@SIM_PIN@@/${sim_pin}/g" \
  | sed "s/@@APN@@/${apn}/g" \
  | sed "s/@@APN_USER@@/${apn_user}/g" \
  | sed "s/@@APN_PASS@@/${apn_pass}/g" \
  | sudo tee /etc/sakis3g.conf &>/dev/null

sudo chmod 664 /etc/sakis3g.conf &>/dev/null

echo
echo "Configuration complete"
echo

sleep 3

