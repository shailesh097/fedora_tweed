#!/bin/bash
# This script adds GNOME keyboard shortcuts for switching workspaces

# Remove (Super+l) keybind to lock the screen
remove_lock_keybind(){
  gsettings set org.gnome.settings-daemon.plugins.media-keys screensaver "['']"
  echo "Super+L lock keybind removed."
}

change_workspace(){
  # Set Super+[ to switch to the workspace on the left
  gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-left "['<Super>j']"

  # Set Super+] to switch to the workspace on the right
  gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-right "['<Super>l']"

  # Set new keybindings to move the current window to the workspace to the left and right
  gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-left "['<Shift><Super>j']"
  gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-right "['<Shift><Super>l']"

  echo "Custom shortcuts set:"
  echo "  - Super+j to switch to previous workspace"
  echo "  - Super+l to switch to next workspace"
  echo "  - Shift+Super+j to move current window 1 workspace to the left"
  echo "  - Shift+Super+l to move current window 1 workspace to the right"
}

remove_lock_keybind
change_workspace
