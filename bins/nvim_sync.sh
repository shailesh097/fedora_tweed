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
	printf '%s\n' "${GREEN} $* ${NO_COLOR} "
}
 
sync_nvim(){
	message "Syncing nvim configurations..."
	# Define source and destination directories
	local CONFIG_DIR="$HOME/.config/nvim"
	local DOTFILES_DIR="$HOME/dotfiles/nvim"

	mkdir -p $DOTFILES_DIR

	if [ -d "$CONFIG_DIR" ]; then
		if [ -d "$DOTFILES_DIR" ]; then
			# The trailing slash on the source ensures the contents are copied into the destination directory.
			rsync -av --delete  --exclude=".git/" "$CONFIG_DIR/" "$DOTFILES_DIR/"
		else
		warn "\nDirectory $DOTFILES_DIR does not exist, skipping syncing $folder"
		fi
	else
		warn "Directory $CONFIG_DIR does not exist, skipping syncing $folder..."
	fi
}

sync_nvim
