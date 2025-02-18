#!/bin/bash

BOLD="$(tput bold 2>/dev/null || printf '')"
GREY="$(tput setaf 7 2>/dev/null || printf '')"
RED="$(tput setaf 1 2>/dev/null || printf '')"
RED="$(tput setaf 1 2>/dev/null || printf '')"
GREEN="$(tput setaf 2 2>/dev/null || printf '')"
YELLOW="$(tput setaf 3 2>/dev/null || printf '')"
BLUE="$(tput setaf 4 2>/dev/null || printf '')"
MAGENTA="$(tput setaf 5 2>/dev/null || printf '')"
NO_COLOR="$(tput sgr0 2>/dev/null || printf '')"
LIGHT_GREEN="$(tput setaf 10 2>/dev/null || printf '')"
CYAN="$(tput setaf 37 2>/dev/null || printf '')"


info() {
  printf '%s\n' "${CYAN}>>> $* ${NO_COLOR} "
}

warn() {
  printf '%s\n' "${YELLOW}! $*${NO_COLOR}"
}

error() {
  printf '%s\n' "${RED}x $*${NO_COLOR}" >&2
}

completed() {
  printf '%s\n' "${GREEN}✓ $* ${NO_COLOR} "
}

remove_quick_settings_shortcut(){
  # Define the schema and keybinding path
  SCHEMA="org.gnome.shell.keybindings"
  KEY="toggle-quick-settings"

  # Check the current keybinding
  CURRENT_BINDING=$(gsettings get "$SCHEMA" "$KEY")

  echo "Current binding for Quick Settings: $CURRENT_BINDING"

  # Remove the shortcut by setting it to an empty array
  gsettings set "$SCHEMA" "$KEY" "[]"

  # Verify the change
  NEW_BINDING=$(gsettings get "$SCHEMA" "$KEY")
  echo "New binding for Quick Settings: $NEW_BINDING"

  echo "Shortcut for Quick Settings (Super+S) has been removed."
}

remove_quick_settings_shortcut
