#!/bin/bash

setup_arch_linux(){
    # Update the system
    info "Updating the system"
    sudo pacman -Syu
    completed "The System has been Updated!"

    info "Installing Default Applications..."
    sudo pacman -S git kitty fish dmenu rofi conky polybar neovim arandr i3-gaps npm feh i3status
    completed "Default Applications Installed!"

    info "Setting up git..."
    git config --global user.name "shailesh097"
    git config --global user.email "sailesh.pokharel.234@gmail.com"
    completed "Git setup Completed!"

    info "Install Other Programs..."
}
