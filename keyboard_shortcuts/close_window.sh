#!/bin/bash

close_window(){
  # Define the shortcut key combination
  local NEW_SHORTCUT='<Super>q'

  # Find the schema and key for closing a window
  local SCHEMA='org.gnome.desktop.wm.keybindings'
  local KEY='close'

  # Set the new shortcut
  gsettings set $SCHEMA $KEY "['$NEW_SHORTCUT']"

  info " - Shortcut for closing windows changed to $NEW_SHORTCUT"
}

close_window
