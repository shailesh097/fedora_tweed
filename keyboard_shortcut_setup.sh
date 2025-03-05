#!/bin/bash

gnome_keyboard_shortcut(){

  FOLDER="$HOME/git_clone/fedora-gnome-setup/keyboard_shortcuts"  # Change this to your folder name

  # Ensure the folder exists
  if [ -d "$FOLDER" ]; then
      for file in "$FOLDER"/*.sh; do
          # Check if there are any .sh files before sourcing
          [ -f "$file" ] && source "$file"
      done
  else
      echo "Folder '$FOLDER' does not exist!"
  fi
}

