#!/bin/bash

# Arch Linux Hyprland Post-Installation Setup Script
# Author: Auto-generated setup script
# Description: Interactive script to setup Hyprland desktop environment

set -e

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

# Script configuration
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LOG_FILE="$HOME/.hyprland-setup.log"

# Package lists
ESSENTIAL_PACKAGES=(
    "base-devel"
    "git"
    "wget"
    "curl"
    "polkit-gnome"
    "xdg-desktop-portal-hyprland"
    "xdg-desktop-portal-gtk"
    "qt5-wayland"
    "qt6-wayland"
    "pipewire"
    "pipewire-alsa"
    "pipewire-pulse"
    "wireplumber"
    "grim"
    "slurp"
    "wl-clipboard"
    "brightnessctl"
    "playerctl"
    "pamixer"
)

HYPRLAND_PACKAGES=(
    "hyprland"
    "waybar"
    "kitty"
    "wofi"
    "mako"
    "swww"
    "hyprpaper"
)

AUR_PACKAGES=(
    "yay-bin"
    "brave-bin"
    "visual-studio-code-bin"
    "discord"
    "spotify"
)

# Logging function
log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" >> "$LOG_FILE"
}

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
    log "SUCCESS: $1"
}

print_error() {
    echo -e "${RED}${CROSS_MARK} $1${NC}"
    log "ERROR: $1"
}

print_info() {
    echo -e "${BLUE}${ARROW} $1${NC}"
    log "INFO: $1"
}

print_warning() {
    echo -e "${YELLOW}⚠ $1${NC}"
    log "WARNING: $1"
}

print_step() {
    echo -e "${PURPLE}${STAR} $1${NC}"
    log "STEP: $1"
}

# Progress bar function
show_progress() {
    local current=$1
    local total=$2
    local description=$3
    local percentage=$((current * 100 / total))
    local completed=$((percentage / 2))
    local remaining=$((50 - completed))
    
    printf "\r${CYAN}[${NC}"
    printf "%0.s█" $(seq 1 $completed)
    printf "%0.s─" $(seq 1 $remaining)
    printf "${CYAN}] ${WHITE}%d%% ${YELLOW}%s${NC}" $percentage "$description"
}

# System compatibility check
check_system_compatibility() {
    print_step "Checking system compatibility..."
    
    # Demo mode detection (for testing environments)
    if [[ "${DEMO_MODE:-}" == "true" ]] || [[ ! -f /etc/arch-release ]]; then
        if [[ ! -f /etc/arch-release ]]; then
            print_warning "Demo mode: Not running on Arch Linux - showing interface only"
            DEMO_MODE=true
        fi
    else
        # Check if pacman is available
        if ! command -v pacman &> /dev/null; then
            print_error "Pacman package manager not found!"
            exit 1
        fi
        
        # Check if running as root
        if [[ $EUID -eq 0 ]]; then
            print_error "Do not run this script as root!"
            exit 1
        fi
        
        # Check internet connectivity
        if ! ping -c 1 archlinux.org &> /dev/null; then
            print_error "No internet connection detected!"
            exit 1
        fi
    fi
    
    print_success "System compatibility check passed"
}

# Update system
update_system() {
    print_step "Updating system packages..."
    
    if [[ "${DEMO_MODE:-}" == "true" ]]; then
        print_info "Demo mode: Simulating system update..."
        sleep 2
        print_success "System updated successfully (demo)"
        return 0
    fi
    
    if sudo pacman -Syu --noconfirm; then
        print_success "System updated successfully"
    else
        print_error "Failed to update system"
        return 1
    fi
}

# Install package with verification
install_package() {
    local package=$1
    local package_manager=${2:-"pacman"}
    
    if [[ "${DEMO_MODE:-}" == "true" ]]; then
        print_info "Demo mode: Simulating installation of $package..."
        sleep 0.5
        print_success "Installed $package (demo)"
        return 0
    fi
    
    if [[ $package_manager == "pacman" ]]; then
        if pacman -Qi "$package" &> /dev/null; then
            print_info "$package is already installed"
            return 0
        fi
        
        if sudo pacman -S --noconfirm "$package"; then
            print_success "Installed $package"
            return 0
        else
            print_error "Failed to install $package"
            return 1
        fi
    elif [[ $package_manager == "yay" ]]; then
        if yay -Qi "$package" &> /dev/null; then
            print_info "$package is already installed"
            return 0
        fi
        
        if yay -S --noconfirm "$package"; then
            print_success "Installed $package (AUR)"
            return 0
        else
            print_error "Failed to install $package (AUR)"
            return 1
        fi
    fi
}

# Install essential packages
install_essential_packages() {
    print_step "Installing essential packages..."
    
    local total=${#ESSENTIAL_PACKAGES[@]}
    local current=0
    
    for package in "${ESSENTIAL_PACKAGES[@]}"; do
        ((current++))
        show_progress $current $total "Installing $package"
        install_package "$package"
        sleep 0.5
    done
    
    echo
    print_success "Essential packages installation completed"
}

# Install yay AUR helper
install_yay() {
    print_step "Installing yay AUR helper..."
    
    if [[ "${DEMO_MODE:-}" == "true" ]]; then
        print_info "Demo mode: Simulating yay installation..."
        sleep 2
        print_success "yay installed successfully (demo)"
        return 0
    fi
    
    if command -v yay &> /dev/null; then
        print_info "yay is already installed"
        return 0
    fi
    
    cd /tmp
    if git clone https://aur.archlinux.org/yay-bin.git; then
        cd yay-bin
        if makepkg -si --noconfirm; then
            print_success "yay installed successfully"
            cd "$SCRIPT_DIR"
            return 0
        else
            print_error "Failed to build yay"
            cd "$SCRIPT_DIR"
            return 1
        fi
    else
        print_error "Failed to clone yay repository"
        return 1
    fi
}

# Install Hyprland packages
install_hyprland_packages() {
    print_step "Installing Hyprland and related packages..."
    
    local total=${#HYPRLAND_PACKAGES[@]}
    local current=0
    
    for package in "${HYPRLAND_PACKAGES[@]}"; do
        ((current++))
        show_progress $current $total "Installing $package"
        install_package "$package"
        sleep 0.5
    done
    
    echo
    print_success "Hyprland packages installation completed"
}

# Install AUR packages
install_aur_packages() {
    print_step "Installing AUR packages..."
    
    if ! command -v yay &> /dev/null; then
        print_error "yay is not installed. Cannot install AUR packages."
        return 1
    fi
    
    local total=${#AUR_PACKAGES[@]}
    local current=0
    
    for package in "${AUR_PACKAGES[@]}"; do
        ((current++))
        show_progress $current $total "Installing $package"
        install_package "$package" "yay"
        sleep 0.5
    done
    
    echo
    print_success "AUR packages installation completed"
}

# Setup configuration files
setup_configurations() {
    print_step "Setting up configuration files..."
    
    # Create config directories
    mkdir -p "$HOME/.config/hypr"
    mkdir -p "$HOME/.config/waybar"
    mkdir -p "$HOME/.config/kitty"
    
    # Copy configuration files if they exist in the script directory
    if [[ -f "$SCRIPT_DIR/configs/hyprland.conf" ]]; then
        cp "$SCRIPT_DIR/configs/hyprland.conf" "$HOME/.config/hypr/"
        print_success "Hyprland configuration copied"
    fi
    
    if [[ -f "$SCRIPT_DIR/configs/waybar-config.json" ]]; then
        cp "$SCRIPT_DIR/configs/waybar-config.json" "$HOME/.config/waybar/config"
        print_success "Waybar configuration copied"
    fi
    
    if [[ -f "$SCRIPT_DIR/configs/waybar-style.css" ]]; then
        cp "$SCRIPT_DIR/configs/waybar-style.css" "$HOME/.config/waybar/style.css"
        print_success "Waybar styles copied"
    fi
    
    if [[ -f "$SCRIPT_DIR/configs/kitty.conf" ]]; then
        cp "$SCRIPT_DIR/configs/kitty.conf" "$HOME/.config/kitty/"
        print_success "Kitty configuration copied"
    fi
    
    print_success "Configuration files setup completed"
}

# Enable services
enable_services() {
    print_step "Enabling system services..."
    
    if [[ "${DEMO_MODE:-}" == "true" ]]; then
        print_info "Demo mode: Simulating service enablement..."
        sleep 1
        print_success "Audio services enabled (demo)"
        print_success "Services enabled successfully (demo)"
        return 0
    fi
    
    # Enable pipewire services
    systemctl --user enable pipewire pipewire-pulse wireplumber
    print_success "Audio services enabled"
    
    print_success "Services enabled successfully"
}

# Interactive menu
show_menu() {
    while true; do
        print_header
        echo -e "${WHITE}Select installation options:${NC}"
        echo
        echo -e "${CYAN}1.${NC} Full installation (recommended)"
        echo -e "${CYAN}2.${NC} Custom installation"
        echo -e "${CYAN}3.${NC} System update only"
        echo -e "${CYAN}4.${NC} Configuration files only"
        echo -e "${CYAN}5.${NC} View system information"
        echo -e "${CYAN}6.${NC} Exit"
        echo
        read -p "$(echo -e "${YELLOW}Enter your choice [1-6]: ${NC}")" choice
        
        case $choice in
            1)
                full_installation
                break
                ;;
            2)
                custom_installation
                break
                ;;
            3)
                update_system
                read -p "Press Enter to continue..."
                ;;
            4)
                setup_configurations
                read -p "Press Enter to continue..."
                ;;
            5)
                show_system_info
                read -p "Press Enter to continue..."
                ;;
            6)
                echo -e "${GREEN}Goodbye!${NC}"
                exit 0
                ;;
            *)
                print_error "Invalid option. Please try again."
                sleep 2
                ;;
        esac
    done
}

# Full installation
full_installation() {
    print_header
    echo -e "${YELLOW}Starting full installation...${NC}"
    echo
    
    check_system_compatibility
    update_system
    install_essential_packages
    install_yay
    install_hyprland_packages
    install_aur_packages
    setup_configurations
    enable_services
    
    print_header
    echo -e "${GREEN}${CHECK_MARK} Full installation completed successfully!${NC}"
    echo
    echo -e "${CYAN}Next steps:${NC}"
    echo -e "${WHITE}1.${NC} Reboot your system"
    echo -e "${WHITE}2.${NC} Select Hyprland from your display manager"
    echo -e "${WHITE}3.${NC} Use Super+Return to open terminal (Kitty)"
    echo -e "${WHITE}4.${NC} Use Super+D to open application launcher (Wofi)"
    echo
    read -p "Press Enter to exit..."
}

# Custom installation
custom_installation() {
    print_header
    echo -e "${WHITE}Custom Installation Options:${NC}"
    echo
    
    # Ask for each component
    read -p "$(echo -e "${CYAN}Install essential packages? [Y/n]: ${NC}")" install_essential
    read -p "$(echo -e "${CYAN}Install yay AUR helper? [Y/n]: ${NC}")" install_yay_choice
    read -p "$(echo -e "${CYAN}Install Hyprland packages? [Y/n]: ${NC}")" install_hypr
    read -p "$(echo -e "${CYAN}Install AUR packages? [Y/n]: ${NC}")" install_aur
    read -p "$(echo -e "${CYAN}Setup configuration files? [Y/n]: ${NC}")" setup_configs
    
    print_header
    echo -e "${YELLOW}Starting custom installation...${NC}"
    echo
    
    check_system_compatibility
    update_system
    
    [[ ${install_essential,,} != "n" ]] && install_essential_packages
    [[ ${install_yay_choice,,} != "n" ]] && install_yay
    [[ ${install_hypr,,} != "n" ]] && install_hyprland_packages
    [[ ${install_aur,,} != "n" ]] && install_aur_packages
    [[ ${setup_configs,,} != "n" ]] && setup_configurations
    
    enable_services
    
    print_header
    echo -e "${GREEN}${CHECK_MARK} Custom installation completed!${NC}"
    read -p "Press Enter to exit..."
}

# Show system information
show_system_info() {
    print_header
    echo -e "${WHITE}System Information:${NC}"
    echo
    
    if [[ "${DEMO_MODE:-}" == "true" ]]; then
        echo -e "${CYAN}OS:${NC} Arch Linux (Demo Mode)"
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
    else
        echo -e "${CYAN}OS:${NC} $(cat /etc/os-release | grep PRETTY_NAME | cut -d'"' -f2)"
        echo -e "${CYAN}Kernel:${NC} $(uname -r)"
        echo -e "${CYAN}Architecture:${NC} $(uname -m)"
        echo -e "${CYAN}Shell:${NC} $SHELL"
        echo -e "${CYAN}User:${NC} $USER"
        echo -e "${CYAN}Home:${NC} $HOME"
        echo
        echo -e "${WHITE}Package Managers:${NC}"
        command -v pacman &> /dev/null && echo -e "${GREEN}${CHECK_MARK} pacman${NC}" || echo -e "${RED}${CROSS_MARK} pacman${NC}"
        command -v yay &> /dev/null && echo -e "${GREEN}${CHECK_MARK} yay${NC}" || echo -e "${RED}${CROSS_MARK} yay${NC}"
        echo
        echo -e "${WHITE}Essential Packages Status:${NC}"
        for package in "${HYPRLAND_PACKAGES[@]}"; do
            if pacman -Qi "$package" &> /dev/null; then
                echo -e "${GREEN}${CHECK_MARK} $package${NC}"
            else
                echo -e "${RED}${CROSS_MARK} $package${NC}"
            fi
        done
    fi
}

# Cleanup function
cleanup() {
    print_info "Cleaning up temporary files..."
    # Add cleanup commands here if needed
}

# Signal handlers
trap cleanup EXIT
trap 'print_error "Script interrupted"; exit 1' INT TERM

# Main execution
main() {
    # Initialize log file
    echo "=== Arch Linux Hyprland Setup Script Log ===" > "$LOG_FILE"
    log "Script started by user: $USER"
    
    # Check if configuration files exist
    if [[ ! -d "$SCRIPT_DIR/configs" ]]; then
        print_warning "Configuration files directory not found. Some features may be limited."
    fi
    
    # Show welcome message
    print_header
    echo -e "${WHITE}Welcome to the Arch Linux Hyprland Setup Script!${NC}"
    echo
    echo -e "${CYAN}This script will help you set up a complete Hyprland desktop environment${NC}"
    echo -e "${CYAN}with all essential packages and configurations.${NC}"
    echo
    echo -e "${YELLOW}Make sure you have:${NC}"
    echo -e "${WHITE}• A fresh Arch Linux installation${NC}"
    echo -e "${WHITE}• Internet connection${NC}"
    echo -e "${WHITE}• Sudo privileges${NC}"
    echo
    read -p "$(echo -e "${GREEN}Press Enter when ready to continue...${NC}")"
    
    # Start main menu
    show_menu
}

# Run main function
main "$@"
