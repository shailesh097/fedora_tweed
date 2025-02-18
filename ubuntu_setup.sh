#!/bin/bash

# function to setup ubuntu
setup_ubuntu_flavors(){
	#update the system
	sudo apt update && sudo apt upgrade -y
	
  #install essential tools (curl, wget, git)
  info "Installing essential tools (curl, wget, git, nvim, fzf)"
  sudo apt install curl wget git fzf -y
  completed "Installed essential tools! (curl, wget, git, fzf)"
  
  #configure git
	info "Configuring git..."
	git config --global user.name "shailesh097"
	git config --global user.email "sailesh.pokharel.234@gmail.com"
	completed "Git configured!"

  # Create Templates
  info "Creating templates for files(.txt, .sh)..."
  touch untitled.txt
  touch blank-script.sh
  echo "#!/bin/bash" | tee blank-script.sh
  completed "Created Templates Successfully!"

	#install gnome tweaks
	info "Installing Gnome Tweaks app..."
	sudo apt install gnome-tweaks -y
	completed "Installed Gnome Tweaks!"

  # setup dotfiles
  setup_dotfiles

  # install nevoim
  install_neovim_ubuntu

  # install brave browser
  info "Installing Brave Browser..."
  sudo apt install curl
  sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
  echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list
  sudo apt update
  sudo apt install brave-browser -y
  completed "Brave Browser Installed"

  # install flatpak
  info "Installing and Setting up Flatpak..."
  install_flatpak_ubuntu

  #install extension manager
  info "Installing ExtensionManager..."
  flatpak install flathub com.mattjakeman.ExtensionManager -y
  completed "ExtensionManager Installed!"
  
  # install vscode
  install_vscode_ubuntu

  # Install essential applications
  info "Installing Essential Applications (conky, kitty, fish, nvtop, btop)"
  sudo apt install conky kitty fish nvtop btop -y
  completed "Essential applications installed!"

  # Install exa
  info "Installing exa..."
  sudo apt install exa -y
  completed "Exa Installed"

  # Install Sublime Text dnf4
  install_sublimetext4_ubuntu

  # Install Discord
  info "Installing Discord..."
  sudo apt install discord -y
  completed "Discord Installed"

  # Install Obsidian
  info "Installing Obsidian via Flatpak..."
  flatpak install flathub md.obsidian.Obsidian -y
  completed "Obsidian Installed Successfully!"

  info "Installing VLC Media Player..."
  sudo apt install vlc -y
  completed "VLC Installed"

  info "Installing npm Repository..."
  sudo apt install npm -y
  completed "npm Installed"

  completed "Ubuntu Setup Complete!"
}

install_sublimetext4_ubuntu(){
    info "Setting up Sublime Text 4 Repository..."
    wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/sublimehq-archive.gpg > /dev/null
    echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
    info "Installing Sublime Text 4..."
    sudo apt-get update
    sudo apt-get install sublime-text
    completed "Sublime Text 4 Installed"
}

install_vscode_ubuntu(){
  info "Installing VScode"
  info "Setting up Vscode Repository..."
  sudo apt-get install wget gpg -y
  wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
  sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
  echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" |sudo tee /etc/apt/sources.list.d/vscode.list > /dev/null
  rm -f packages.microsoft.gpg
  
  info "Installing Code..."
  sudo apt install apt-transport-https -y
  sudo apt update -y
  sudo apt install code -y
  completed "VScode Installed"
}

install_flatpak_ubuntu(){
    # Check if Flatpak is already installed
  if command -v flatpak &> /dev/null; then
      completed "Flatpak is already installed"
  else
      # Install Flatpak
      info "Installing Flatpak..."
      sudo apt update
      sudo apt install -y flatpak

      if [ $? -ne 0 ]; then
          error "Failed to install Flatpak. Exiting"
          exit 1
      fi
      completed "Flatpak installed successfully"
  fi

  # Add Flathub repository if not already added
  if ! flatpak remote-list | grep -q "flathub"; then
      info "Adding Flathub repository..."
      sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

      if [ $? -ne 0 ]; then
          error "Failed to add Flathub repository. Exiting"
          exit 1
      fi
      info "Flathub repository added successfully"
  else
      info "Flathub repository is already added"
  fi

  # Print completion message
  completed "Flatpak is installed and configured on your system"
}

#function to install neovim and nvchad on ubuntu
install_neovim_ubuntu(){
	# Install prerequisits
	info "Downloading Prerequisites to Build Neovim..."
	sudo apt install -y ninja-build gettext libtool libtool-bin autoconf automake cmake g++ pkg-config unzip curl doxygen
	completed "Prerequisites Downloaded"
	
	
	# Download and install the latest stable release of Neovim
	info "Downloading and installing Neovim..."
	curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz

	# Extract the downloaded archive
	info "Extracting Neovim..."
	tar -xzf nvim-linux64.tar.gz
	
	# Move Neovim to /opt directory
	info "Installing Neovim to /opt..."
	sudo mv nvim-linux64 /opt/neovim
	
	# Create symlinks to make Neovim accessible from anywhere
	info "Creating symlinks..."
	sudo ln -s /opt/neovim/bin/nvim /usr/local/bin/nvim
	
	# Clean up downloaded tarball
    info "Cleaning up..."
	rm nvim-linux64.tar.gz
	
	completed "Neovim installation complete!"
	
	info "Installing Nvchad"
  # check if nvim directory already exists
  if [ -d "/home/pokhares/.config/nvim" ]; then
    rm -rf /home/pokhares/.config/nvim
    warn "Deleted Previous Neovim Configuration file ~/.config/nvim"
  fi

	git clone https://github.com/NvChad/starter ~/.config/nvim
	completed "Nvchad Installed! To update nvchad to latest version run :MasonInstallAll"
}


