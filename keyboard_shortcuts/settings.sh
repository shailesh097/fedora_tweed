#!/bin/bash
# This script adds a custom GNOME keyboard shortcut to launch kitty
# Shortcut: Super+Return
source keyboard_shortcuts/custom-shortcut.sh

remove_quick_settings_shortcut(){
  # Define the schema and keybinding path
  local SCHEMA="org.gnome.shell.keybindings"
  local KEY="toggle-quick-settings"

  # Check the current keybinding
  local CURRENT_BINDING=$(gsettings get "$SCHEMA" "$KEY")


  # Remove the shortcut by setting it to an empty array
  gsettings set "$SCHEMA" "$KEY" "[]"

  # Verify the change
  local NEW_BINDING=$(gsettings get "$SCHEMA" "$KEY")

  echo "Shortcut for Quick Settings (Super+S) has been removed."
}


remove_quick_settings_shortcut
custom_shortcut "Settings" "gnome-control-center" "<super>s"
