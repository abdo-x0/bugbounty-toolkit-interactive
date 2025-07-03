#!/bin/bash

set -e

# Colors
GREEN="\033[1;32m"
RED="\033[1;31m"
YELLOW="\033[1;33m"
RESET="\033[0m"

# Ensure dialog is installed
if ! command -v dialog &> /dev/null; then
    echo -e "${YELLOW}[!] dialog not found. Installing...${RESET}"
    sudo apt-get update && sudo apt-get install -y dialog
fi

# Fix for snap not found
function install_snap_if_needed() {
    if ! command -v snap &> /dev/null; then
        dialog --yesno "Snap is not installed. Do you want to install it automatically?" 10 50
        if [ $? -eq 0 ]; then
            sudo apt update && sudo apt install -y snapd
            dialog --msgbox "Snap installed successfully." 8 40
        else
            dialog --msgbox "Snap installation skipped. Some tools may not work." 8 50
        fi
    fi
}

# Install a tool with a message
function install_tool() {
    TOOL_NAME="$1"
    INSTALL_CMD="$2"

    dialog --infobox "Installing $TOOL_NAME..." 5 40
    if eval "$INSTALL_CMD"; then
        dialog --msgbox "$TOOL_NAME installed successfully." 6 50
    else
        dialog --msgbox "Failed to install $TOOL_NAME." 6 50
    fi
}

# Main menu
function main_menu() {
    while true; do
        CHOICE=$(dialog --clear --title "Bug Bounty Toolkit - abdo___x" \
            --menu "Select a tool to install:" 20 60 10 \
            1 "Install All Tools" \
            2 "Install Amass" \
            3 "Install Sublist3r" \
            4 "Install Nmap" \
            5 "Open GitHub Repo" \
            6 "Exit" \
            3>&1 1>&2 2>&3)

        case $CHOICE in
            1)
                install_snap_if_needed
                install_tool "Amass" "sudo snap install amass"
                install_tool "Sublist3r" "sudo apt install -y sublist3r || pip install sublist3r"
                install_tool "Nmap" "sudo apt install -y nmap"
                ;;
            2)
                install_snap_if_needed
                install_tool "Amass" "sudo snap install amass"
                ;;
            3)
                install_tool "Sublist3r" "sudo apt install -y sublist3r || pip install sublist3r"
                ;;
            4)
                install_tool "Nmap" "sudo apt install -y nmap"
                ;;
            5)
                xdg-open "https://github.com/abdo-x0/bugbounty-toolkit-interactive"
                ;;
            6)
                clear
                echo -e "${GREEN}Thank you for using Bug Bounty Toolkit - abdo___x${RESET}"
                exit 0
                ;;
        esac
    done
}

main_menu
