#!/bin/bash

#function to setup fedora
setup_fedora(){
  # Ensure defaultyes=True is set
  if ! grep -q "^defaultyes=True" /etc/dnf/dnf.conf; then
    echo "defaultyes=True" | sudo tee -a /etc/dnf/dnf.conf > /dev/null
  fi

  # Ensure max_parallel_downloads=10 is set
  if ! grep -q "^max_parallel_downloads=10" /etc/dnf/dnf.conf; then
    echo "max_parallel_downloads=10" | sudo tee -a /etc/dnf/dnf.conf > /dev/null
  fi

  info "Setting up Fedora system..."
  info "Created Workspace directory at $HOME/Workspace/"
  mkdir -p $HOME/Workspace

  # Setup power profile for gnome system
  setup_power_gnome

  #update the system
  sudo dnf update -y
  message "System Updated!"
  sleep 1

  #enable rpm fusion repository
  info "Enabling RPM Fusion repositories..."
  sudo dnf install -y \
      https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm \
      https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

  #enable flatpak repository
  info "Enabling Flatpak Repositories.."
  sudo dnf install -y flatpak
  flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

  #install eDM Mononstall curl wget git neovim fzf conky kitty fish nvtop btop
  info "Installing Essential Tools..."
  sudo dnf install -y curl wget git neovim fzf conky kitty fish nvtop btop fastfetch npm eza gnome-tweaks discord vlc gparted bash shc zoxide tldr--skip-unavailable

  # Set Catppuccin-Mocha theme for kitty
  info "Setting Catppuccin-Mocha theme for kitty..."
  kitty +kitten themes Catppuccin-Mocha

  # Installing gnome-shell-extensions
  message "Installing Gnome Shell Extensions..."
  gnome-shell-extensions

  #configure git
  info "Configuring git..."
  git config --global user.name "shailesh097"
  git config --global user.email "sailesh.pokharel.234@gmail.com"

  # Install nvchad
  info "Installing Nvchad..."
  git clone https://github.com/NvChad/starter ~/.config/nvim

  #install flatpak apps
  #install extension manager
  info "Installing ExtensionManager..."
  flatpak install -y flathub com.mattjakeman.ExtensionManager

  #setup dotfiles from github
  setup_dotfiles

  # Install Visual Studio Code
  install_vscode

  # Install Brave Browser
  install_brave

  # Install starship prompt
  # Initialize copr repository
  info "Installing Starship Prompt..."
  sudo dnf copr enable atim/starship -y
  sudo dnf install -y starship

  # Installed sublime text
  install_sublimetext4

  # Install Obsidian
  info "Installing Obsidian via Flatpak..."
  flatpak install -y flathub md.obsidian.Obsidian

  # Install Flatpak
  info "Installing Spotify via Flatpak..."
  flatpak install -y flathub com.spotify.Client

  info "Installing X11..."
  sudo dnf install -y gnome-session-xsession
  sudo dnf install -y gnome-classic-session-xsession

  # Enable minimize and maximize buttons on titlebar
  info "Enabling maximize and minimize buttons in titlebar..."
  gsettings set org.gnome.desktop.wm.preferences button-layout 'appmenu:minimize,maximize,close'

  # Setup wallpaper changer
  install_wallpaper_changer

  # Setup dotfiles sync
  install_dotfiles_sync

  # Setup Keyboard Shortcuts
  info "Setting up Keyboard Shortcuts..."
  gnome_keyboard_shortcut

  # Changin shell to fish
  info "Changing Shell to fish..."
  chsh -s /usr/bin/fish

  # Install Nvidia Drivers
  install_nvidia_drivers

  message "Fedora Setup Complete!"
}

# install dotfiles sync
install_dotfiles_sync(){
  info "Installing dotfiles syncing script..."
  local BIN_SCRIPT="$HOME/git_clone/fedora_tweed/bins/dotfiles_sync.sh"
  local BIN_FILE="$HOME/git_clone/fedora_tweed/bins/dotfiles-sync"
  local BIN_DIR="$HOME/.local/bin"
  mkdir -p $BIN_DIR

  # check if binary file is already present in path variable
  if [[ -f $BIN_DIR/sync-dotfiles ]]; then
    warn "sync-dotfiles binary already present at $BIN_DIR. Removing sync-dotfiles binary..."
    rm "$BIN_DIR/sync-dotfiles"
  fi

  chmod +x "$BIN_SCRIPT"
  # compile $BIN_SCRIPT
  sudo dnf install -y shc --skip-unavailable
  shc -f $BIN_SCRIPT -o "$BIN_FILE"
  cp "$BIN_FILE" "$BIN_DIR"
}

# change wallpaper every 5 minutes
install_wallpaper_changer(){
  info "Installing Desktop Wallpaper Changer Service..."
  local SERVICES_DIR="$HOME/.config/systemd/user/"
  local SCRIPT_DIR="$HOME/.config/myscripts/"
  mkdir -p "$SERVICES_DIR"
  mkdir -p "$SCRIPT_DIR"
  cp "$HOME/git_clone/fedora_tweed/services/wallpaper-changed.service" "$SERVICES_DIR" 
  cp "$HOME/git_clone/fedora_tweed/dynamic_wallpaper.sh" "$SCRIPT_DIR"
  systemctl --user daemon-reload
  systemctl --user enable wallpaper-changed.service
  systemctl --user start wallpaper-changed.service
}

# functionto install nvidia drivers for fedora
install_nvidia_drivers(){
  info "Installing Nvidia Driver..."
  sudo dnf update -y
  sudo dnf install -y akmod-nvidia
  sleep 1
  info "NVIDIA drivers installed successfully!"
  info "A reboot is required to load the NVIDIA drivers"
  info "Close all the files and reboot your system"

  read -p "Do you want to reboot now? (y/n): " REBOOT
  if [[ "$REBOOT" == "y" || "$REBOOT" == "Y" ]]; then
      sudo reboot
  else
      info "Please reboot your system later to apply the changes."
  fi
}

# function o install sublime text 4
install_sublimetext4(){

  info "Installing Sublime Text 4..."
  # Get the Fedora version
  FEDORA_VERSION=$(rpm -E %fedora)

  # install gpg key
  sudo rpm -v --import https://download.sublimetext.com/sublimehq-rpm-pub.gpg

  # Check which version of dnf to use based on Fedora version
  if [ "$FEDORA_VERSION" -le 40 ]; then
      sudo dnf config-manager --add-repo https://download.sublimetext.com/rpm/stable/x86_64/sublime-text.repo
  else
      sudo dnf config-manager addrepo --from-repofile=https://download.sublimetext.com/rpm/stable/x86_64/sublime-text.repo
  fi

  sudo dnf install sublime-text -y
}

# function to install brave-browser
install_brave(){
  info "Installing Brave Browser..."
  # Get the Fedora version
  FEDORA_VERSION=$(rpm -E %fedora)

  sudo dnf install -y dnf-plugins-core
  # Check which version of dnf to use based on Fedora version
  if [ "$FEDORA_VERSION" -le 40 ]; then
      sudo dnf config-manager --add-repo https://brave-browser-rpm-release.s3.brave.com/brave-browser.repo
  else
      sudo dnf config-manager addrepo --from-repofile=https://brave-browser-rpm-release.s3.brave.com/brave-browser.repo
  fi

  sudo dnf install -y brave-browser
}

#function to install vscode
install_vscode(){
  info "Installing Visual Studio Code..."
  sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
  sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
  sudo dnf check-update
  sudo dnf install -y code

  if [ ! $? -eq 0 ]; then
      error "Failed to install Visual Studio Code. Please check your internet connection or repository setup."
      exit 1
  fi
}


