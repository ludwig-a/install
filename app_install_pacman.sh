#!/bin/bash

# Programs to install
PROGRAMS=(
  "vim"
  "git"
  "htop"
  "unzip"
  "mc"
  "tree"
  "ranger"
  "glances"
  "neofetch"
  "rsync"
  "zsh"
  "ufw"
  "keepassxc"
  "light"
  "nvidia-dkms"
  "nvidia-settings"
  "nvidia-utils"
  "meld"
  "firefox"
  "alacritty" 
  "i3-gaps"
  "i3status"
  "i3blocks"
  "dmenu"
  "rofi"
  "polybar"
  "autotiling"
  "autorandr"
  "feh"
  "nitrogen"
  "archiso"
  "virtualbox"
  "virtualbox-guest-utils"
  )
# Counter for failed installations
FAILED=0

# Loop through programs
for PROGRAM in "${PROGRAMS[@]}"; do
  # Check if program is already installed
  if command -v "$PROGRAM" >/dev/null 2>&1; then
    echo "$PROGRAM is already installed"
  else
    # Install program
    if sudo pacman -S --noconfirm "$PROGRAM"; then
      echo "$PROGRAM successfully installed"
    else
      echo -e "\e[31mFailed to install $PROGRAM\e[0m"
      ((FAILED++))
    fi
  fi
done

# Display results
if [ "$FAILED" -eq 0 ]; then
  echo -e "\e[32mAll programs successfully installed\e[0m"
else
  echo -e "\e[31m$FAILED programs failed to install:\e[0m"
  for PROGRAM in "${PROGRAMS[@]}"; do
    if ! command -v "$PROGRAM" >/dev/null 2>&1; then
      echo -e "\e[31m- $PROGRAM\e[0m"
    fi
  done
fi
