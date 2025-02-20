#!/bin/bash
# This script adds a custom GNOME keyboard shortcut to launch kitty
# Shortcut: Super+Return


custom_shortcut() {
  # Define variables
  local KEYBINDING_NAME="$1"
  local KEYBINDING_COMMAND="$2"
  local KEYBINDING_BINDING="$3"
  local KEYBINDING_PATH="/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/$KEYBINDING_COMMAND"

  # Get current list of custom keybindings
  local current_bindings=$(gsettings get org.gnome.settings-daemon.plugins.media-keys custom-keybindings)
  local new_bindings

  # Remove surrounding single quotes
  # current_bindings=${current_bindings//\'/}

  # Ensure it's a valid list, otherwise initialize as an empty list
  if [[ "$current_bindings" == "@as []" ]]; then
    current_bindings="[]"
  fi

  # Check if the keybinding is already in the list
  if [[ "$current_bindings" != *"$KEYBINDING_PATH"* ]]; then
      new_bindings="${current_bindings/]/, '$KEYBINDING_PATH']}"
    else
      echo "Custom keybinding of $KEYBINDING_COMMAND has already been set. Please edit or remove $KEYBINDING_PATH"
  fi

  # Apply the updated keybindings
  gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings "$new_bindings"

  # Configure the keybinding properties
  gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:"$KEYBINDING_PATH" name "$KEYBINDING_NAME"
  gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:"$KEYBINDING_PATH" command "$KEYBINDING_COMMAND"
  gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:"$KEYBINDING_PATH" binding "$KEYBINDING_BINDING"

  echo "Custom shortcut set: $KEYBINDING_BINDING will launch $KEYBINDING_NAME"
}

custom_shortcut "Brave" "brave-browser" "<super>b"
custom_shortcut "Kitty" "kitty" "<super>Return"
