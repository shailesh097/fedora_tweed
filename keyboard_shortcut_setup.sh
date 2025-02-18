#!/bin/bash

gnome_keyboard_shortcut(){

FOLDER="$HOME/setup_files/SetupLinux/keyboard_shortcuts"  # Change this to your folder name

# Ensure the folder exists
if [ -d "$FOLDER" ]; then
    for file in "$FOLDER"/*.sh; do
        # Check if there are any .sh files before sourcing
        [ -f "$file" ] && source "$file"
    done
else
    error "Folder '$FOLDER' does not exist!"
fi

}
