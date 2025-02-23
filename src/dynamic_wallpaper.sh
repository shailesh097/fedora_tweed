#!/bin/bash

# Change the wallpaper after a certain interval from a directory
change_wallpaper(){
  WALLPAPER_DIR="$HOME/Pictures/wallpapers"
  INTERVAL=300

  while true; do
      # Get a random wallpaper from the directory
      WALLPAPER=$(find "$WALLPAPER_DIR" -type f | shuf -n 1)

      # Set the wallpaper using gsettings
      gsettings set org.gnome.desktop.background picture-uri-dark "file://$WALLPAPER"

      # Wait for the specified interval before changing the wallpaper again
      sleep $INTERVAL
  done
}

change_wallpaper
