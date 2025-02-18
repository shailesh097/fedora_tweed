#!/bin/bash
# This script adds a custom GNOME keyboard shortcut to launch kitty
# Shortcut: Super+Return

remove_quick_settings_shortcut(){
  # Define the schema and keybinding path
  local SCHEMA="org.gnome.shell.keybindings"
  local KEY="toggle-quick-settings"

  # Check the current keybinding
  local CURRENT_BINDING=$(gsettings get "$SCHEMA" "$KEY")

  info "Current binding for Quick Settings: $CURRENT_BINDING"

  # Remove the shortcut by setting it to an empty array
  gsettings set "$SCHEMA" "$KEY" "[]"

  # Verify the change
  local NEW_BINDING=$(gsettings get "$SCHEMA" "$KEY")
  info "New binding for Quick Settings: $NEW_BINDING"

  info "Shortcut for Quick Settings (Super+S) has been removed."
}

open_settings_shortcut(){
  # Define variables
  local KEYBINDING_NAME="Settings"
  local KEYBINDING_COMMAND="gnome-control-center"
  local KEYBINDING_BINDING="<Super>s"
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

remove_quick_settings_shortcut
open_settings_shortcut
