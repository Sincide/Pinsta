#!/bin/bash

# Test version of the Arch Linux Hyprland Setup Script
# This version runs in demo mode to show the interface

# Color definitions
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
WHITE='\033[1;37m'
NC='\033[0m' # No Color

# Unicode symbols
CHECK_MARK="✓"
CROSS_MARK="✗"
ARROW="→"
STAR="★"

# Enable demo mode
DEMO_MODE=true

# Package lists for display
HYPRLAND_PACKAGES=(
    "hyprland"
    "waybar"
    "kitty"
    "wofi"
    "mako"
    "swww"
    "hyprpaper"
)

# Print functions
print_header() {
    clear
    echo -e "${CYAN}╔══════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${CYAN}║                                                              ║${NC}"
    echo -e "${CYAN}║          ${WHITE}Arch Linux Hyprland Setup Script${CYAN}               ║${NC}"
    echo -e "${CYAN}║                                                              ║${NC}"
    echo -e "${CYAN}║     ${YELLOW}Automated setup for Hyprland desktop environment${CYAN}      ║${NC}"
    echo -e "${CYAN}║                                                              ║${NC}"
    echo -e "${CYAN}╚══════════════════════════════════════════════════════════════╝${NC}"
    echo
}

print_success() {
    echo -e "${GREEN}${CHECK_MARK} $1${NC}"
}

print_error() {
    echo -e "${RED}${CROSS_MARK} $1${NC}"
}

print_info() {
    echo -e "${BLUE}${ARROW} $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠ $1${NC}"
}

print_step() {
    echo -e "${PURPLE}${STAR} $1${NC}"
}

# Demo installation function
demo_installation() {
    print_header
    echo -e "${YELLOW}Starting full installation (Demo Mode)...${NC}"
    echo
    
    print_step "Checking system compatibility..."
    print_warning "Demo mode: Not running on Arch Linux - showing interface only"
    print_success "System compatibility check passed"
    echo
    
    print_step "Updating system packages..."
    print_info "Demo mode: Simulating system update..."
    sleep 1
    print_success "System updated successfully (demo)"
    echo
    
    print_step "Installing essential packages..."
    for i in {1..5}; do
        print_info "Installing package $i/5..."
        sleep 0.3
    done
    print_success "Essential packages installation completed (demo)"
    echo
    
    print_step "Installing yay AUR helper..."
    print_info "Demo mode: Simulating yay installation..."
    sleep 1
    print_success "yay installed successfully (demo)"
    echo
    
    print_step "Installing Hyprland and related packages..."
    for package in "${HYPRLAND_PACKAGES[@]}"; do
        print_info "Installing $package..."
        sleep 0.3
    done
    print_success "Hyprland packages installation completed (demo)"
    echo
    
    print_step "Installing AUR packages..."
    for i in {1..3}; do
        print_info "Installing AUR package $i/3..."
        sleep 0.3
    done
    print_success "AUR packages installation completed (demo)"
    echo
    
    print_step "Setting up configuration files..."
    print_success "Hyprland configuration copied"
    print_success "Waybar configuration copied"
    print_success "Waybar styles copied"
    print_success "Kitty configuration copied"
    print_success "Configuration files setup completed"
    echo
    
    print_step "Enabling system services..."
    print_info "Demo mode: Simulating service enablement..."
    sleep 1
    print_success "Audio services enabled (demo)"
    print_success "Services enabled successfully (demo)"
    echo
    
    print_header
    echo -e "${GREEN}${CHECK_MARK} Full installation completed successfully! (Demo)${NC}"
    echo
    echo -e "${CYAN}Next steps:${NC}"
    echo -e "${WHITE}1.${NC} Reboot your system"
    echo -e "${WHITE}2.${NC} Select Hyprland from your display manager"
    echo -e "${WHITE}3.${NC} Use Super+Return to open terminal (Kitty)"
    echo -e "${WHITE}4.${NC} Use Super+D to open application launcher (Wofi)"
    echo
    read -p "Press Enter to return to main menu..."
}

# Show system information
show_system_info() {
    print_header
    echo -e "${WHITE}System Information (Demo Mode):${NC}"
    echo
    echo -e "${CYAN}OS:${NC} Arch Linux (Demo)"
    echo -e "${CYAN}Kernel:${NC} 6.6.10-arch1-1"
    echo -e "${CYAN}Architecture:${NC} x86_64"
    echo -e "${CYAN}Shell:${NC} /bin/bash"
    echo -e "${CYAN}User:${NC} $USER"
    echo -e "${CYAN}Home:${NC} $HOME"
    echo
    echo -e "${WHITE}Package Managers:${NC}"
    echo -e "${RED}${CROSS_MARK} pacman (demo mode)${NC}"
    echo -e "${RED}${CROSS_MARK} yay (demo mode)${NC}"
    echo
    echo -e "${WHITE}Essential Packages Status (Demo):${NC}"
    for package in "${HYPRLAND_PACKAGES[@]}"; do
        echo -e "${RED}${CROSS_MARK} $package (not installed - demo)${NC}"
    done
}

# Interactive menu
show_menu() {
    while true; do
        print_header
        echo -e "${WHITE}Select installation options:${NC}"
        echo
        echo -e "${CYAN}1.${NC} Full installation (demo mode)"
        echo -e "${CYAN}2.${NC} Custom installation (demo mode)"
        echo -e "${CYAN}3.${NC} System update only (demo mode)"
        echo -e "${CYAN}4.${NC} Configuration files only"
        echo -e "${CYAN}5.${NC} View system information"
        echo -e "${CYAN}6.${NC} Exit"
        echo
        read -p "$(echo -e "${YELLOW}Enter your choice [1-6]: ${NC}")" choice
        
        case $choice in
            1)
                demo_installation
                ;;
            2)
                print_header
                echo -e "${YELLOW}Custom installation would show individual package selection here${NC}"
                echo -e "${CYAN}This is demo mode - full functionality available on Arch Linux${NC}"
                read -p "Press Enter to continue..."
                ;;
            3)
                print_header
                print_step "Updating system packages..."
                print_info "Demo mode: Simulating system update..."
                sleep 2
                print_success "System updated successfully (demo)"
                read -p "Press Enter to continue..."
                ;;
            4)
                print_header
                print_step "Setting up configuration files..."
                print_success "Configuration files would be copied here"
                print_info "Config files are included: hyprland.conf, waybar configs, kitty.conf"
                read -p "Press Enter to continue..."
                ;;
            5)
                show_system_info
                read -p "Press Enter to continue..."
                ;;
            6)
                print_header
                echo -e "${GREEN}Thank you for trying the Arch Linux Hyprland Setup Script!${NC}"
                echo -e "${CYAN}On a real Arch Linux system, this would install:${NC}"
                echo -e "${WHITE}• Hyprland (Wayland compositor)${NC}"
                echo -e "${WHITE}• Waybar (Status bar)${NC}"
                echo -e "${WHITE}• Kitty (Terminal emulator)${NC}"
                echo -e "${WHITE}• Brave Browser${NC}"
                echo -e "${WHITE}• All essential packages and dependencies${NC}"
                echo
                exit 0
                ;;
            *)
                print_error "Invalid option. Please try again."
                sleep 2
                ;;
        esac
    done
}

# Main execution
main() {
    print_header
    echo -e "${WHITE}Welcome to the Arch Linux Hyprland Setup Script! (Demo Mode)${NC}"
    echo
    echo -e "${CYAN}This script helps set up a complete Hyprland desktop environment${NC}"
    echo -e "${CYAN}with all essential packages and configurations.${NC}"
    echo
    echo -e "${YELLOW}Demo Mode Features:${NC}"
    echo -e "${WHITE}• Interactive menu navigation${NC}"
    echo -e "${WHITE}• Simulated installation process${NC}"
    echo -e "${WHITE}• System information display${NC}"
    echo -e "${WHITE}• Configuration file management${NC}"
    echo
    read -p "$(echo -e "${GREEN}Press Enter to start the interactive demo...${NC}")"
    
    show_menu
}

# Run main function
main "$@"