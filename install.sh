#!/bin/bash

BLUE="\033[1;34m"
RED="\033[1;31m"
GREEN="\033[1;32m"
RESET="\033[0m"

INFO="${BLUE}[INFO]${RESET}"
ERROR="${RED}[ERROR]${RESET}"
SUCCESS="${GREEN}[SUCCESS]${RESET}"

BFETCH_URL="https://raw.githubusercontent.com/Justus0405/bfetch/main/bfetch"
INSTALL_DIR="/usr/bin"
BFETCH_PATH="$INSTALL_DIR/bfetch"

echo_info() { echo -e "$INFO $1"; }
echo_error() { echo -e "$ERROR $1"; }
echo_success() { echo -e "$SUCCESS $1"; }


# for avoiding conflicts
if [[ -f "$BFETCH_PATH" ]]; then
    echo_info "Existing bfetch found at $BFETCH_PATH. Removing it..."
    if sudo rm -f "$BFETCH_PATH"; then
        echo_success "Existing bfetch removed successfully."
    else
        echo_error "Failed to remove existing bfetch. Please check permissions."
        exit 1
    fi
fi

echo_info "Downloading bfetch from $BFETCH_URL..."
if sudo wget -q "$BFETCH_URL" -O "$BFETCH_PATH"; then
    echo_success "bfetch downloaded successfully."
else
    echo_error "Failed to download bfetch."
    exit 1
fi

echo_info "Setting execute permissions for bfetch..."
sudo chmod +x "$BFETCH_PATH"

if [[ -f "$BFETCH_PATH" && -x "$BFETCH_PATH" ]]; then
    echo_success "bfetch installed successfully at $BFETCH_PATH."
    echo -e "${GREEN}You can now run 'bfetch' from the terminal.${RESET}"
else
    echo_error "Installation failed. Please check your setup."
    exit 1
fi

