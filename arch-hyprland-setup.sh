#!/bin/bash

# Arch Linux Hyprland Post-Installation Setup Script
# Author: Auto-generated setup script
# Description: Interactive script to setup Hyprland desktop environment

# Remove set -e to handle errors manually
# set -e

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
    "unzip"
    "nano"
    "vim"
    "fish"
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
    "network-manager-applet"
    "bluez"
    "bluez-utils"
    "firefox"
    "file-roller"
)

HYPRLAND_PACKAGES=(
    "hyprland"
    "waybar"
    "kitty"
    "wofi"
    "mako"
    "swww"
    "hyprpaper"
    "xdg-utils"
)

AUR_PACKAGES=(
    "brave-bin"
    "visual-studio-code-bin"
    "discord"
    "spotify"
    "ttf-jetbrains-mono"
    "noto-fonts-emoji"
    "thunar"
    "pavucontrol"
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
    
    # Simpler progress display
    printf "\r${CYAN}[${current}/${total}] ${WHITE}%d%% ${YELLOW}%s${NC}" $percentage "$description"
}

# System compatibility check
check_system_compatibility() {
    print_step "Checking system compatibility..."
    
    # Check if running on Arch Linux
    if [[ ! -f /etc/arch-release ]]; then
        print_error "This script is designed for Arch Linux only!"
        exit 1
    fi
    
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
    
    print_success "System compatibility check passed"
}

# Update system
update_system() {
    print_step "Updating system packages..."
    
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
    local failed_packages=()
    
    for package in "${ESSENTIAL_PACKAGES[@]}"; do
        ((current++))
        show_progress $current $total "Installing $package"
        if ! install_package "$package"; then
            failed_packages+=("$package")
        fi
        sleep 0.2
    done
    
    echo
    if [[ ${#failed_packages[@]} -gt 0 ]]; then
        print_warning "Some packages failed to install: ${failed_packages[*]}"
        print_info "Continuing with installation..."
    fi
    print_success "Essential packages installation completed"
    return 0
}

# Install yay AUR helper
install_yay() {
    print_step "Installing yay AUR helper..."
    
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
    local failed_packages=()
    
    for package in "${HYPRLAND_PACKAGES[@]}"; do
        ((current++))
        show_progress $current $total "Installing $package"
        if ! install_package "$package"; then
            failed_packages+=("$package")
        fi
        sleep 0.2
    done
    
    echo
    if [[ ${#failed_packages[@]} -gt 0 ]]; then
        print_warning "Some packages failed to install: ${failed_packages[*]}"
        print_info "Continuing with installation..."
    fi
    print_success "Hyprland packages installation completed"
    return 0
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
    local failed_packages=()
    
    for package in "${AUR_PACKAGES[@]}"; do
        ((current++))
        show_progress $current $total "Installing $package"
        if ! install_package "$package" "yay"; then
            failed_packages+=("$package")
        fi
        sleep 0.2
    done
    
    echo
    if [[ ${#failed_packages[@]} -gt 0 ]]; then
        print_warning "Some AUR packages failed to install: ${failed_packages[*]}"
        print_info "Continuing with installation..."
    fi
    print_success "AUR packages installation completed"
    return 0
}

# Setup configuration files
setup_configurations() {
    print_step "Setting up configuration files..."
    
    # Create config directories
    mkdir -p "$HOME/.config/hypr"
    mkdir -p "$HOME/.config/waybar"
    mkdir -p "$HOME/.config/kitty"
    mkdir -p "$HOME/.config/fish/functions"
    
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
    
    if [[ -f "$SCRIPT_DIR/configs/wallpaper.svg" ]]; then
        cp "$SCRIPT_DIR/configs/wallpaper.svg" "$HOME/.config/hypr/"
        print_success "Wallpaper copied"
    fi
    
    # Setup Fish shell configuration
    if [[ -f "$SCRIPT_DIR/configs/fish-config.fish" ]]; then
        cp "$SCRIPT_DIR/configs/fish-config.fish" "$HOME/.config/fish/config.fish"
        print_success "Fish configuration copied"
    fi
    
    if [[ -f "$SCRIPT_DIR/configs/fish-aliases.fish" ]]; then
        # Add aliases to config.fish
        echo "" >> "$HOME/.config/fish/config.fish"
        echo "# Load aliases" >> "$HOME/.config/fish/config.fish"
        cat "$SCRIPT_DIR/configs/fish-aliases.fish" >> "$HOME/.config/fish/config.fish"
        print_success "Fish aliases added"
    fi
    
    if [[ -f "$SCRIPT_DIR/configs/fish-prompt.fish" ]]; then
        cp "$SCRIPT_DIR/configs/fish-prompt.fish" "$HOME/.config/fish/functions/fish_prompt.fish"
        # Extract other functions from the prompt file
        sed -n '/function fish_right_prompt/,/^end$/p' "$SCRIPT_DIR/configs/fish-prompt.fish" > "$HOME/.config/fish/functions/fish_right_prompt.fish"
        sed -n '/function fish_mode_prompt/,/^end$/p' "$SCRIPT_DIR/configs/fish-prompt.fish" > "$HOME/.config/fish/functions/fish_mode_prompt.fish"
        print_success "Fish prompt functions setup"
    fi
    
    print_success "Configuration files setup completed"
}

# Set fish as default shell
setup_fish_shell() {
    print_step "Setting up Fish shell as default..."
    
    # Check if fish is in /etc/shells
    if ! grep -q "/usr/bin/fish" /etc/shells; then
        echo "/usr/bin/fish" | sudo tee -a /etc/shells > /dev/null
        print_success "Fish added to /etc/shells"
    else
        print_info "Fish already in /etc/shells"
    fi
    
    # Change default shell to fish
    if [[ "$SHELL" != "/usr/bin/fish" ]]; then
        chsh -s /usr/bin/fish
        print_success "Default shell changed to Fish"
        print_info "You'll need to log out and back in for the shell change to take effect"
    else
        print_info "Fish is already the default shell"
    fi
}

# Enable services
enable_services() {
    print_step "Enabling system services..."
    
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
    
    # Run each step and check for errors
    print_info "Starting system compatibility check..."
    if ! check_system_compatibility; then
        print_error "System compatibility check failed"
        read -p "Press Enter to return to menu..."
        return 1
    fi
    print_info "System compatibility check completed successfully"
    
    if ! update_system; then
        print_error "System update failed"
        read -p "Press Enter to return to menu..."
        return 1
    fi
    
    if ! install_essential_packages; then
        print_error "Essential packages installation failed"
        read -p "Press Enter to return to menu..."
        return 1
    fi
    
    if ! install_yay; then
        print_error "yay installation failed"
        read -p "Press Enter to return to menu..."
        return 1
    fi
    
    if ! install_hyprland_packages; then
        print_error "Hyprland packages installation failed"
        read -p "Press Enter to return to menu..."
        return 1
    fi
    
    if ! install_aur_packages; then
        print_error "AUR packages installation failed"
        read -p "Press Enter to return to menu..."
        return 1
    fi
    
    if ! setup_configurations; then
        print_error "Configuration setup failed"
        read -p "Press Enter to return to menu..."
        return 1
    fi
    
    if ! enable_services; then
        print_error "Service enablement failed"
        read -p "Press Enter to return to menu..."
        return 1
    fi
    
    if ! setup_fish_shell; then
        print_error "Fish shell setup failed"
        read -p "Press Enter to return to menu..."
        return 1
    fi
    
    print_header
    echo -e "${GREEN}${CHECK_MARK} Full installation completed successfully!${NC}"
    echo
    echo -e "${CYAN}Next steps:${NC}"
    echo -e "${WHITE}1.${NC} Log out and back in for Fish shell to take effect"
    echo -e "${WHITE}2.${NC} Reboot your system"
    echo -e "${WHITE}3.${NC} Select Hyprland from your display manager"
    echo -e "${WHITE}4.${NC} Use Super+Return to open terminal (Kitty with Fish shell)"
    echo -e "${WHITE}5.${NC} Use Super+D to open application launcher (Wofi)"
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
    read -p "$(echo -e "${CYAN}Set Fish as default shell? [Y/n]: ${NC}")" setup_fish
    
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
    [[ ${setup_fish,,} != "n" ]] && setup_fish_shell
    
    print_header
    echo -e "${GREEN}${CHECK_MARK} Custom installation completed!${NC}"
    read -p "Press Enter to exit..."
}

# Show system information
show_system_info() {
    print_header
    echo -e "${WHITE}System Information:${NC}"
    echo
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
