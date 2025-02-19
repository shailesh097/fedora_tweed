#!/bin/bash
# This script adds a custom GNOME keyboard shortcut to launch kitty
# Shortcut: Super+Return

open_brave(){
  # Define variables
  local KEYBINDING_NAME="Barve Browser"
  local KEYBINDING_COMMAND="brave-browser"
  local KEYBINDING_BINDING="<Super>b"
  local KEYBINDING_PATH="/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/kitty/"

  # Get current list of custom keybindings (a GVariant string, e.g. "[]", or "['/some/path/']")
  local current_bindings=$(gsettings get org.gnome.settings-daemon.plugins.media-keys custom-keybindings)

  # Append our new keybinding if it's not already in the list.
  if [[ "$current_bindings" != *"$KEYBINDING_PATH"* ]]; then
      # Use python3 to convert the string to a list, append our path, and output the new list.
      local new_bindings=$(python3 -c "import ast,sys; arr = ast.literal_eval(sys.argv[1]); arr.append('$KEYBINDING_PATH'); print(arr)" "$current_bindings")
      gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings "$new_bindings"
  fi

  # Now configure the keybinding properties
  gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:"$KEYBINDING_PATH" name "$KEYBINDING_NAME"
  gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:"$KEYBINDING_PATH" command "$KEYBINDING_COMMAND"
  gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:"$KEYBINDING_PATH" binding "$KEYBINDING_BINDING"

  echo "Custom shortcut set: $KEYBINDING_BINDING will launch $KEYBINDING_NAME"
}

open_brave
