#!/bin/bash

expectedusers=("root" "daemon" "bin" "sys" "sync" "games" "man" "lp" "mail" "news" "uucp" "proxy" "www-data" "backup" "list" "irc" "nobody" "systemd-network"  "dhcpcd" "systemd-resolve" "systemd-timesync" "messagebus" "syslog" "_apt" "system-oom" "avahi-autoipd" "kernoops" "whoopsie" "dnsmasq" "avahi" "cups-pk-helper" "speech-dispatcher" "fwupd-refresh" "saned" "geoclue" "cups-broswed" "hplip" "polkitd" "rtkit" "colord" "gnome-initial-setup" "gdm" "nm-openvpn" "tss" "uuidd" "tcpdump" "landscape" "pollinate" "sshd" "ubuntu" "BanditAlex" "MarshalJustice" "usbmux" "systemd-oom" "sssd" "cups-browsed" "postfix" "PrairiePioneer" "OutlawOutlook" "CalamityJane" "SheriffMcCoy" "SaloonSally" "DocHolliday")

for user in $(cut -f1 -d: /etc/passwd); do
 if [[ ! "${expectedusers[@]}" =~ $user ]]; then
  echo "$user"
 fi
done
