#!/bin/bash

function run_pre_install_checks() {
  # Check we're running as root and exit if not
  if [[ $EUID -gt 0 ]]
  then
    echo "ERROR: This script must be ran with root/sudo privileges"
    exit 1
  fi
}

function install_hadolint() {
  wget -O /bin/hadolint https://github.com/hadolint/hadolint/releases/download/v2.12.0/hadolint-Linux-x86_64
  chmod +x /bin/hadolint
}

run_pre_install_checks
echo "Installing Hadolint. The executable binary will end up in the /bin directory so it's globally executable."
install_hadolint
echo
echo "Hadolint successfully installed!"
