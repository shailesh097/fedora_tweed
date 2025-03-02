#!/bin/bash

#function to clone the dotfiles from git repo
setup_dotfiles(){
  info "Setting up dotfiles..."
  # Define the repository URL and target directory
  REPO_URL="https://github.com/shailesh097/dotfiles.git"
  TARGET_DIR="$HOME/dotfiles"
  BACKUP_DIR="$HOME/Documents/Backup/dotfiles_backup_$(date +%Y%m%d_%H%M%S)"
  BACKUP_CONFIGS="$HOME/Documents/Backup/configuration_files_backup_$(date +%Y%m%d_%H%M%S)"

  # Check if the dotfiles folder already exists
  if [ -d "$TARGET_DIR" ]; then
  	if [ ! -d "$HOME/Documents/Backup" ]; then
  		mkdir -p $HOME/Documents/Backup
  	fi
      warn "Dotfiles folder already exists. Moving it to $BACKUP_DIR..."
      mv "$TARGET_DIR" "$BACKUP_DIR"
  fi

  mkdir -p "$TARGET_DIR"
  # Clone the repository into a new dotfiles folder
  git clone "$REPO_URL" "$TARGET_DIR"

  # Check if cloning was successful
  if [ $? -eq 0 ]; then
      info "Dotfiles repository cloned successfully into $TARGET_DIR."
  else
      error "Failed to clone the dotfiles repository. Please check the repository URL or your internet connection."
      exit 1
  fi

  # Define the target configuration directory
  CONFIG_DIR="$HOME/.config"
  FONTS_DIR="$HOME/.fonts"
  ICONS_DIR="$HOME/.icons"
  THEMES_DIR="$HOME/.themes"
  PICTURES_DIR="$HOME/Pictures"

  # Ensure the .config, .fonts, .themes and .icons directories exist
  mkdir -p "$CONFIG_DIR"
  mkdir -p "$FONTS_DIR"
  mkdir -p "$ICONS_DIR"
  mkdir -p "$THEMES_DIR"
  mkdir -p "$PICTURES_DIR"

  local folder_list=("coky" "fish" "kitty" "i3")

  # Move the specific folders to .config if they don't already exist
  for folder in conky fish kitty i3 fastfetch; do
      if [ -d "$TARGET_DIR/${folder[@]}" ]; then
          if [ ! -d "$CONFIG_DIR/${folder[@]}" ]; then
              info "Copying ${folder[@]}to $CONFIG_DIR"
              cp -r "$TARGET_DIR/${folder[@]}" "$CONFIG_DIR"
          else
              info "${folder[@]} already exists in $CONFIG_DIR"
              warn "Backing up configuration files of ${folder[@]}to $BACKUP_CONFIGS"
              mv "$CONFIG_DIR/${folder[@]}" "$BACKUP_CONFIGS"
              cp -r "$TARGET_DIR/${folder[@]}" "$CONFIG_DIR"
          fi
      else
          warn "Folder ${folder[@]} does not exist in $TARGET_DIR. Skipping..."
      fi
  done

  # Move wallpapers to ~/Pictures directory
  if [ -d "$TARGET_DIR/wallpapers" ]; then
      info "Moving wallpapers to ~/Pictures directory"
      cp -r "$TARGET_DIR/wallpapers" "$PICTURES_DIR"
  fi

  # Move the contents of the fonts folder to ~/.fonts
  if [ -d "$TARGET_DIR/fonts" ]; then
      info "Installing fonts to ~/.fonts directory..."
      cp -r "$TARGET_DIR/fonts"/* "$FONTS_DIR/"
  else
      warn "Fonts folder does not exist in $TARGET_DIR. Skipping..."
  fi

  # Move the contents of icons folder to ~/.icons
  if [ -d "$TARGET_DIR/icons" ]; then
      info "Copying icons to ~/.icons directory..."
      cp -r "$TARGET_DIR/icons"/* "$ICONS_DIR"
  else
    warn "icons directory does not exist in $TARGET_DIR. Skipping..."
  fi

  # Move the starship.toml file to ~/.config if not already present
  if [ -f "$TARGET_DIR/starship.toml" ]; then
      if [ ! -f "$CONFIG_DIR/starship.toml" ]; then
          info "Copying starship.toml to $CONFIG_DIR..."
          cp "$TARGET_DIR/starship.toml" "$CONFIG_DIR/"
      else
          warn "starship.toml already exists in $CONFIG_DIR. Skipping..."
      fi
  else
      warn "starship.toml file does not exist in $TARGET_DIR. Skipping..."
  fi

  completed "Dotfiles setup complete!"
}


