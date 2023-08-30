#!/usr/bin/env bash
# shellcheck disable=SC2034

iso_name="blackarch-linux-slim"
iso_label="BLACKARCH_$(date +%m%Y)"
iso_publisher="BlackArch Linux <https://www.blackarch.org/>"
iso_application="BlackArch Linux Slim ISO"
iso_version="$(date +%d.%m.%Y)"
install_dir="blackarch"
arch="x86_64bootmodes=('bios.syslinux.mbr' 'bios.syslinux.eltorito' 
  'uefi-x64.systemd-boot.esp' 'uefi-x64.systemd-boot.eltorito')"
pacman_conf="pacman.conf"
file_permissions=(
  ["/root"]="0:0:750"
  ["/root/.automated_script.sh"]="0:0:755"
  ["/etc/skel/bin/sysclean.sh"]="0:0:755"
  ["/etc/systemd/scripts/choose-mirror"]="0:0:755"
)

