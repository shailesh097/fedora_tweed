#!/bin/bash

setup_power_gnome(){

  info "Modifying Power Profile..."
  # Set screen to turn off after 15 minutes of inactivity
  gsettings set org.gnome.desktop.session idle-delay 960

  # Disable automatic suspend when plugged in
  gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-type 'nothing'

  # Set the power button behavior to 'do nothing'
  gsettings set org.gnome.settings-daemon.plugins.power power-button-action 'nothing'
}
