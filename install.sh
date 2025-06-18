#!/bin/bash

# Quick installer for Arch Linux Hyprland Setup Script
# This script downloads and runs the main setup script

set -e

# Color definitions
GREEN='\033[0;32m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
WHITE='\033[1;37m'
NC='\033[0m'

echo -e "${CYAN}╔══════════════════════════════════════════════════════════════╗${NC}"
echo -e "${CYAN}║                                                              ║${NC}"
echo -e "${CYAN}║          ${WHITE}Arch Linux Hyprland Quick Installer${CYAN}             ║${NC}"
echo -e "${CYAN}║                                                              ║${NC}"
echo -e "${CYAN}╚══════════════════════════════════════════════════════════════╝${NC}"
echo

echo -e "${BLUE}→ Checking system requirements...${NC}"

# Check if running on Arch Linux
if [[ ! -f /etc/arch-release ]]; then
    echo -e "${RED}✗ This installer is designed for Arch Linux only!${NC}"
    exit 1
fi

# Check if running as root
if [[ $EUID -eq 0 ]]; then
    echo -e "${RED}✗ Do not run this installer as root!${NC}"
    exit 1
fi

echo -e "${GREEN}✓ System requirements met${NC}"
echo

echo -e "${BLUE}→ Starting Arch Linux Hyprland Setup Script...${NC}"
echo

# Run the main setup script
if [[ -f "arch-hyprland-setup.sh" ]]; then
    chmod +x arch-hyprland-setup.sh
    ./arch-hyprland-setup.sh
else
    echo -e "${RED}✗ Main setup script not found!${NC}"
    echo -e "${BLUE}→ Please ensure arch-hyprland-setup.sh is in the current directory${NC}"
    exit 1
fi