#!/bin/bash

loop(){
  local folder_list=("kitty" "i3" "conky")
  for folder in ${folder_list[@]}; do 
    echo "The folder is: $folder"
  done
}

loop
