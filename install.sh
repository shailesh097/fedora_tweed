#!/bin/bash

source color_setup.sh
source setup_power_profile.sh
source fedora_setup.sh
source dotfiles_setup.sh
source keyboard_shortcut_setup.sh


# Check the type of OS
check_os_type(){
  if [ -f /etc/os-release ]; then
      . /etc/os-release
      OS=$ID
      info "Detected $OS as linux distribution!"
      read -p "Do you want to continue setting up $OS? [y/n]: " continue_setup
      if [[ "$continue_setup" == "n" ]]; then
          warn "Setup process stopped!"
          exit 1
      elif [[ "$continue_setup" == "y" ]]; then
          info "You chose to continue with the setup process..."
      else
          error "Invalid input please enter 'y' or 'n'."
          exit 1
      fi
  else
      error "Unable to detect the operating system."
      exit 1
  fi
}

os_setup(){
  case $OS in
    "fedora")
		setup_fedora
      ;;
      "pop")
		info "Setting up PoPOS..."
		setup_ubuntu_flavors
      ;;
  "arch")
      info "Setting up Arch Linux..."
      setup_arch_linux
      ;;
    *)
      error "Unsupported Operating System $OS"
      exit 1
      ;;
  esac
}

main(){
  check_os_type
  os_setup
  }

main
