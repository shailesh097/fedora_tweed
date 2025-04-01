#!/bin/bash

 
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
  printf '%s\n' "${CYAN}==> $* ${NO_COLOR} "
}

warn() {
  printf '%s\n' "${YELLOW}! $*${NO_COLOR}"
}

error() {
  printf '%s\n' "${RED}x $*${NO_COLOR}" >&2
}

message() {
  printf '%s\n' "${GREEN}✓ $* ${NO_COLOR} "
}

sync_nvim(){
  message "Syncing nvim configurations..."
  # Define source and destination directories
  local CONFIG_DIR="$HOME/.config/nvim"
  local DOTFILES_DIR="$HOME/dotfiles"

  # Sync each selected directory using rsync
  local SRC_PATH_MP="$CONFIG_DIR/lua/mappings.lua"
  local DEST_PATH_MP="$DOTFILES_DIR/nvim/mappings.lua"
  
  if [ -f "$SRC_PATH_MP" ]; then
	if [ -f "$DEST_PATH_MP" ]; then
	  info "Syncing mappings.lua..."
	  # The trailing slash on the source ensures the contents are copied into the destination directory.
	  rsync -av --delete "$SRC_PATH_MP" "$DEST_PATH_MP"
	else
	  warn "\nDirectory $DEST_PATH_MP does not exist, skipping syncing $folder"
	fi
  else
	  warn "Directory $SRC_PATH_MP does not exist, skipping syncing $folder..."
  fi

  local SRC_PATH_OP="$CONFIG_DIR/lua/options.lua"
  local DEST_PATH_OP="$DOTFILES_DIR/nvim/options.lua"
  
  if [ -f "$SRC_PATH_OP" ]; then
	if [ -f "$DEST_PATH_OP" ]; then
	  info "Syncing mappings.lua..."
	  # The trailing slash on the source ensures the contents are copied into the destination directory.
	  rsync -av --delete "$SRC_PATH_OP" "$DEST_PATH_OP"
	else
	  warn "\nDirectory $DEST_PATH_OP does not exist, skipping syncing $folder"
	fi
  else
	  warn "Directory $SRC_PATH_OP does not exist, skipping syncing $folder..."
  fi

  }

sync_nvim
