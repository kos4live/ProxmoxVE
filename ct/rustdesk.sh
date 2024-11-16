#!/usr/bin/env bash
source <(curl -s https://raw.githubusercontent.com/kos4live/ProxmoxVE/rustdesk-kos4live/misc/build.func)
# Copyright (c) 2021-2024 community-scripts ORG
# Author: kos4live
# License: MIT
# https://github.com/community-scripts/ProxmoxVE/raw/main/LICENSE

function header_info {
clear
cat <<"EOF"
    ____             __  ____            __
   / __ \__  _______/ /_/ __ \___  _____/ /__
  / /_/ / / / / ___/ __/ / / / _ \/ ___/ //_/
 / _, _/ /_/ (__  ) /_/ /_/ /  __(__  ) ,<
/_/ |_|\__,_/____/\__/_____/\___/____/_/|_|
 OSS / Docker

EOF
}
header_info
echo -e "Loading..."
APP="RustDesk OSS"
var_disk="4"
var_cpu="2"
var_ram="1024"
var_os="debian"
var_version="12"
variables
color
catch_errors

function default_settings() {
  CT_TYPE="1"
  PW=""
  CT_ID=$NEXTID
  HN=$NSAPP
  DISK_SIZE="$var_disk"
  CORE_COUNT="$var_cpu"
  RAM_SIZE="$var_ram"
  BRG="vmbr0"
  NET="dhcp"
  GATE=""
  APT_CACHER=""
  APT_CACHER_IP=""
  DISABLEIP6="no"
  MTU=""
  SD=""
  NS=""
  MAC=""
  VLAN=""
  SSH="no"
  VERB="no"
  echo_default
}

function update_script() {
header_info
if [[ ! -d /opt/rustdesk-server ]]; then msg_error "No ${APP} Installation Found!"; exit; fi

msg_info "Updating ${APP}"
mv /opt/rustdesk-server/compose.yml /opt/rustdesk-server/compose.yml.bak-$(date +%Ymd)
wget -q https://rustdesk.com/oss.yml -O /opt/rustdesk-server/compose.yml
docker compose up -d
msg_ok "Updated ${APP}"

msg_ok "Updated Successfully"
exit
}

start
build_container
description

msg_ok "Completed Successfully!\n"
