#!/bin/bash

# Set download directory path
DOWNLOAD_DIR="$HOME/Downloads"

# Check if git is installed
if ! command -v git &> /dev/null; then
  echo "Git is not installed. Please install git and try again."
  exit 1
fi

# Check if yay is already installed
if command -v yay &> /dev/null; then
  echo "yay is already installed."
  exit 0
fi

# Create download directory if it doesn't exist
mkdir -p "$DOWNLOAD_DIR"

# Clone yay repository
cd "$DOWNLOAD_DIR" || exit 1
if ! git clone https://aur.archlinux.org/yay.git; then
  echo "Failed to clone yay repository."
  exit 1
fi

# Enter yay directory
cd yay || exit 1

# Build and install yay
if ! makepkg -si; then
  echo "Failed to build and install yay."
  exit 1
fi

# Remove yay directory
cd .. && rm -rf yay

# Programs to install
PROGRAMS_TO_INSTALL=(
  "brave-bin"
  "neovim"
  "sublime-text-4"
  "timeshift"
  "hollywood"
)

# Install programs with yay
ERRORS=0
for PROGRAM in "${PROGRAMS_TO_INSTALL[@]}"; do
  if ! command -v "$PROGRAM" >/dev/null 2>&1; then
    if ! yay -S --noconfirm "$PROGRAM"; then
      echo -e "\e[31mFailed to install $PROGRAM\e[0m"
      ERRORS=$((ERRORS+1))
    else
      echo "$PROGRAM successfully installed"
    fi
  else
    echo "$PROGRAM is already installed"
  fi
done

if [[ $ERRORS -eq 0 ]]; then
  echo -e "\e[32mAll programs installed successfully.\e[0m"
else
  echo -e "\e[31m$ERRORS program(s) failed to install.\e[0m"
fi

exit $ERRORS
