#!/bin/bash

gnome_shell_extensions(){
  dash-to-dock
  user-theme
  blur-my-shell
  search-light
  caffeine
  appindicator
  netspeed
  workspace-indicator
  coverflow-alt-tab
  clipboard-indicator
}

clipboard-indicator(){
  git clone https://github.com/Tudmotu/gnome-shell-extension-clipboard-indicator.git ~/.local/share/gnome-shell/extensions/clipboard-indicator@tudmotu.com
}

coverflow-alt-tab(){
  info "Installing Gnome Shell Extension: Coverflow Alt+Tab..."

  # create a directory to clone
  local UNZIP_DIR="$HOME/git_clone"
  mkdir -p "$UNZIP_DIR"

  # Download CoverflowAltTab version 76
  wget https://github.com/dsheeler/CoverflowAltTab/archive/refs/tags/v76.zip
  unzip v76.zip -d "$UNZIP_DIR"
  make -C "$UNZIP_DIR/CoverflowAltTab-76"

  # Cleanup installed files
  if [ $? -eq 0 ]; then
    rm v76.zip
    rm -r "$UNZIP_DIR/CoverflowAltTab-76"
  else
    warn "Error while installing Coverflow Alt-Tab"
    warn "Install it manually by running 'make all' command in "$UNZIP_DIR/CoverflowAltTab-76" directory."
  fi
  
}

# Install workspace-indicaotr
workspace-indicator(){
  info "Installing Gnome Shell Extension: Workspace Indicator..."
  sudo dnf install -y gnome-shell-extension-workspace-indicator
}

# Install netspeed
netspeed(){
  info "Installing Gnome Shell Extension: Netspeed..." 
  git clone https://github.com/AlynxZhou/gnome-shell-extension-net-speed.git ~/.local/share/gnome-shell/extensions/netspeed@alynx.one
}

# Install appindicator
appindicator(){
  info "Installing Gnome Shell Extension: AppIndicator and KStatusNotifierItem..."
  sudo dnf install -y gnome-shell-extension-appindicator
}

# Install Caffeine
caffeine(){
  info "Installing Gnome Shell Extension: Caffeine..."
  sudo dnf install -y gnome-shell-extension-caffeine
}

# Install user theme
user-theme(){
  info "Installing Gnome Shell Extension: User Theme..."
  sudo dnf install -y gnome-shell-extension-user-theme
}

# Install blur my shell
blur-my-shell(){
  info "Installing Gnome Shell Extension: Blur My Shell..."
  sudo dnf install -y gnome-shell-extension-blur-my-shell
}

# Install search light
search-light(){
  info "Installing Gnome Shell Extension: Search Light..."
  local CLONE_DIR="$HOME/git_clone/search-light"
  mkdir -p "$CLONE_DIR"

  git clone https://github.com/icedman/search-light "$CLONE_DIR"
  make -C "$CLONE_DIR"
  # check if last command run successfully
  if [ $? -eq 0 ]; then
      sudo rm -r "$CLONE_DIR"
  else
    warn "Error while installing search light"
    warn "Install it manually by running 'make' command in "$CLONE_DIR" directory."
  fi
}


# Install dash-to-dock extension
dash-to-dock(){
  # Download the latest Dash to Dock extension
  info "Installing Gnome Shell Extension: Dash To Dock..."
  wget https://github.com/micheleg/dash-to-dock/releases/latest/download/dash-to-dock@micxgx.gmail.com.zip

  # Create the user extensions directory if it doesn't exist
  local DSH_EXT_DIR="$HOME/.local/share/gnome-shell/extensions/dash-to-dock@micxgx.gmail.com"

  mkdir -p "$DSH_EXT_DIR"

  # Extract the extension files
  unzip -q dash-to-dock@micxgx.gmail.com.zip -d "$DSH_EXT_DIR"

  # Clean up downloaded zip file
  rm dash-to-dock@micxgx.gmail.com.zip
}

gnome_shell_extensions
