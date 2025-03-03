#!/bin/bash
# This script adds GNOME keyboard shortcuts for switching workspaces

# Remove (Super+l) keybind which locked the screen
remove_lock_keybind(){
  gsettings set org.gnome.settings-daemon.plugins.media-keys screensaver "['']"
}

change_workspace(){
  # Set Super+j to switch to the workspace on the left
  gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-left "['<Super>j']"

  # Set Super+l to switch to the workspace on the right
  gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-right "['<Super>l']"

  # Set new keybindings to move the current window to the workspace to the left and right
  gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-left "['<Shift><Super>j']"
  gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-right "['<Shift><Super>l']"

  info "Custom shortcuts set:"
  info "  - Super+j to switch to previous workspace"
  info "  - Super+l to switch to next workspace"
  info "  - Shift+Super+j to move current window 1 workspace to the left"
  info "  - Shift+Super+l to move current window 1 workspace to the right"
}

remove_lock_keybind
change_workspace
