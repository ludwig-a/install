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
  if ! yay -S --noconfirm "$PROGRAM"; then
    echo "Failed to install $PROGRAM."
    ERRORS=$((ERRORS+1))
  fi
done

if [[ $ERRORS -eq 0 ]]; then
  echo "All programs installed successfully."
else
  echo "$ERRORS program(s) failed to install."
fi

exit $ERRORS
