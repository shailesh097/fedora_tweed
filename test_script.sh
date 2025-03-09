#!/bin/bash

source color_setup.sh

# install dotfiles sync
install_dotfiles_sync(){
  info "Installing dotfiles syncing script..."
  
  local BIN_SCRIPT_DIR="$HOME/git_clone/fedora_tweed/bins/dotfiles_sync.sh"
  local BIN_DIR="$HOME/.local/bin"

  # set user path for fish shell
  set -U fish_user_paths $fish_user_paths ~/.local/bin

  mkdir -p $BIN_DIR
  chmod +x "$BIN_SCRIPT_DIR" 

  cp "$BIN_SCRIPT_DIR" "$BIN_DIR"
}

install_dotfiles_sync
