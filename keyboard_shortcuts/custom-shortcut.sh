#!/bin/bash
# This script adds a custom GNOME keyboard shortcut to launch kitty
# Shortcut: Super+Return

custom_shortcut(){
  # Define variables
  local KEYBINDING_NAME="$1"
  local KEYBINDING_COMMAND="$2"
  local KEYBINDING_BINDING="$3"
  local KEYBINDING_PATH="/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/$KEYBINDING_COMMAND/"

  # Get current list of custom keybindings (a GVariant string, e.g. "[]", or "['/some/path/']")
  local current_bindings=$(gsettings get org.gnome.settings-daemon.plugins.media-keys custom-keybindings)

  if [[ "$current_bindings" == "@as []" ]]; then
    current_bindings="[]"
  fi

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

  info " - $KEYBINDING_BINDING set to launch $KEYBINDING_NAME"
}

custom_shortcut "Brave" "brave" "<super>b"
custom_shortcut "Kitty" "kitty" "<super>Return"
custom_shortcut "Nautilus" "nautilus" "<super>f"
