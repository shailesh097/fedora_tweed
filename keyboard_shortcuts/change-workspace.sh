#!/bin/bash
# This script adds GNOME keyboard shortcuts for switching workspaces

change_workspace(){
  # Set Super+[ to switch to the workspace on the left
  gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-left "['<Super>bracketleft']"

  # Set Super+] to switch to the workspace on the right
  gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-right "['<Super>bracketright']"

  # Set new keybindings to move the current window to the workspace to the left and right
  gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-left "['<Shift><Super>bracketleft']"
  gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-right "['<Shift><Super>bracketright']"

  info "Custom shortcuts set:"
  info "  - Super+[ to switch to previous workspace"
  info "  - Super+] to switch to next workspace"
  info "  - Shift+Super+[ to move current window 1 workspace to the left"
  info "  - Shift+Super+] to move current window 1 workspace to the right"
}
