# Arch Linux Hyprland Setup Script

A beautiful and interactive bash post-installation script for Arch Linux that automates the setup of Hyprland desktop environment with essential packages and configurations.

## Features

- 🎨 **Beautiful Interface**: Colorful output with progress bars and Unicode symbols
- 🔧 **Interactive Menu**: Choose between full installation, custom installation, or specific components
- 📦 **Complete Package Management**: Handles both official repositories and AUR packages
- ⚙️ **Pre-configured Setup**: Includes optimized configuration files for all components
- 🛡️ **Safe Installation**: System compatibility checks and error handling
- 📝 **Detailed Logging**: Complete installation log for troubleshooting

## What Gets Installed

### Essential Packages
- **Development Tools**: base-devel, git, wget, curl, vim, nano
- **System Integration**: polkit-gnome, xdg-desktop-portal-hyprland, xdg-desktop-portal-gtk
- **Wayland Support**: qt5-wayland, qt6-wayland
- **Audio System**: pipewire, pipewire-alsa, pipewire-pulse, wireplumber
- **Screenshots**: grim, slurp, wl-clipboard
- **Hardware Control**: brightnessctl, playerctl, pamixer
- **Connectivity**: network-manager-applet, bluez, bluez-utils
- **File Management**: firefox, file-roller

### Hyprland Desktop Environment
- **hyprland**: Dynamic tiling Wayland compositor
- **waybar**: Highly customizable status bar
- **kitty**: GPU-accelerated terminal emulator
- **wofi**: Application launcher
- **mako**: Notification daemon
- **swww**: Wallpaper manager
- **hyprpaper**: Wallpaper utility
- **swaylock-effects**: Screen locker with effects
- **wlogout**: Logout menu
- **xdg-utils**: Desktop integration utilities

### AUR Packages
- **brave-bin**: Privacy-focused web browser
- **visual-studio-code-bin**: Code editor
- **discord**: Communication platform
- **spotify**: Music streaming
- **ttf-jetbrains-mono**: Programming font
- **noto-fonts-emoji**: Emoji support
- **thunar**: File manager
- **pavucontrol**: Audio control

## Pre-Installation Requirements

- Fresh Arch Linux installation
- Internet connection
- User account with sudo privileges
- **DO NOT** run as root

## Usage

1. **Download the script**:
   ```bash
   git clone <repository-url>
   cd arch-hyprland-setup
   ```

2. **Make executable**:
   ```bash
   chmod +x arch-hyprland-setup.sh
   ```

3. **Run the script**:
   ```bash
   ./arch-hyprland-setup.sh
   ```

4. **Follow the interactive menu**:
   - Option 1: Full installation (recommended)
   - Option 2: Custom installation
   - Option 3: System update only
   - Option 4: Configuration files only
   - Option 5: View system information

## Configuration Files

The script includes pre-configured files for optimal Hyprland experience:

### Hyprland Configuration (`hyprland.conf`)
- Modern keybindings (Super key as modifier)
- Beautiful animations and blur effects
- Optimized for productivity
- Media keys support
- Screenshot functionality

### Waybar Configuration
- Clean, informative status bar
- System monitoring (CPU, memory, temperature)
- Network and battery status
- Workspace indicators
- Custom styling with attractive colors

### Kitty Terminal Configuration
- Gruvbox Dark color scheme
- JetBrains Mono font
- Optimized performance settings
- Custom keybindings
- Semi-transparent background

## Key Bindings (After Installation)

| Key Combination | Action |
|----------------|--------|
| `Super + Return` | Open terminal (Kitty) |
| `Super + D` | Application launcher (Wofi) |
| `Super + C` | Close active window |
| `Super + M` | Exit Hyprland |
| `Super + V` | Toggle floating mode |
| `Super + 1-9` | Switch to workspace |
| `Super + Shift + 1-9` | Move window to workspace |
| `Super + B` | Open Brave browser |
| `Super + F` | Open Firefox |
| `Super + Shift + F` | Open file manager |
| `Super + L` | Lock screen |
| `Super + Print` | Screenshot selection |
| `Print` | Full screenshot |

## Post-Installation Steps

1. **Reboot your system**:
   ```bash
   sudo reboot
   ```

2. **Select Hyprland** from your display manager login screen

3. **Enjoy your new Hyprland desktop environment!**

## Troubleshooting

### Installation Logs
Check the installation log for detailed information:
```bash
cat ~/.hyprland-setup.log
```

### Common Issues

**Script fails with "Not Arch Linux"**:
- Ensure you're running on Arch Linux
- The script includes system compatibility checks

**Package installation fails**:
- Check internet connection
- Update system first: `sudo pacman -Syu`
- Check the log file for specific errors

**Display manager doesn't show Hyprland**:
- Install a display manager: `sudo pacman -S sddm`
- Enable it: `sudo systemctl enable sddm`

### Manual Configuration

If you need to modify configurations after installation:
- Hyprland: `~/.config/hypr/hyprland.conf`
- Waybar: `~/.config/waybar/config` and `~/.config/waybar/style.css`
- Kitty: `~/.config/kitty/kitty.conf`

## Customization

The script is designed to be easily customizable:

1. **Add/Remove Packages**: Edit the package arrays in the script
2. **Modify Configurations**: Update files in the `configs/` directory
3. **Custom Themes**: Replace color schemes in configuration files

## Contributing

Feel free to:
- Report issues
- Suggest improvements
- Submit pull requests
- Share your customizations

## License

This project is open source and available under the MIT License.

## Disclaimer

This script modifies system packages and configurations. While tested, use at your own risk. Always backup important data before running system modification scripts.

---

**Enjoy your beautiful Hyprland desktop environment!** 🚀