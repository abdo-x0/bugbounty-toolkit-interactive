#!/bin/bash

# Ensure dialog is installed
if ! command -v dialog &> /dev/null; then
    echo "Installing 'dialog'..."
    sudo apt update && sudo apt install -y dialog
fi

# Show ASCII banner
clear
cat assets/banner.txt
echo ""
echo "Welcome to Bug Bounty Toolkit - abdo___x"
sleep 2

# Main menu
while true; do
    CHOICE=$(dialog --clear --backtitle "Bug Bounty Toolkit - abdo___x" \
        --title "Main Menu" \
        --menu "Choose an option:" 15 50 6 \
        1 "Install All Tools" \
        2 "Install Nmap" \
        3 "Install Sublist3r" \
        4 "Install Amass" \
        5 "Visit GitHub Repo" \
        6 "Exit" \
        3>&1 1>&2 2>&3)

    case $CHOICE in
        1)
            clear
            echo "[*] Installing all tools..."
            sudo apt install -y nmap
            sudo apt install -y python3-pip && pip3 install sublist3r
            sudo snap install amass
            ;;
        2)
            clear
            echo "[*] Installing Nmap..."
            sudo apt install -y nmap
            ;;
        3)
            clear
            echo "[*] Installing Sublist3r..."
            sudo apt install -y python3-pip && pip3 install sublist3r
            ;;
        4)
            clear
            echo "[*] Installing Amass..."
            sudo snap install amass
            ;;
        5)
            xdg-open "https://github.com/abdo-x0/bugbounty-toolkit-interactive"
            ;;
        6)
            clear
            echo "Exiting. Thank you for using Bug Bounty Toolkit - abdo___x!"
            exit 0
            ;;
    esac
    echo ""
    read -p "Press Enter to return to menu..."
done

