#!/bin/bash

source color_setup.sh


# install dotfiles sync
install_dotfiles_sync(){
  info "Installing dotfiles syncing script..."
  
  local BIN_SCRIPT="$HOME/git_clone/fedora_tweed/bins/dotfiles_sync.sh"
  local BIN_FILE="$HOME/git_clone/fedora_tweed/bins/sync-dotfiles"
  local BIN_DIR="$HOME/.local/bin"

  mkdir -p $BIN_DIR
  chmod +x "$BIN_SCRIPT"

  # compile $BIN_SCRIPT
  shc -f $BIN_SCRIPT -o "$BIN_FILE"
  cp "$BIN_FILE" "$BIN_DIR"
}

install_dotfiles_sync
