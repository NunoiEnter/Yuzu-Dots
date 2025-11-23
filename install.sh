#!/usr/bin/env bash

# Yuzu-Dots Installer
# Theme: Yuzusoft (Pink/Cyan)

set -e # Exit immediately if a command exits with a non-zero status

# --- COLORS ---
PINK='\033[1;35m'
CYAN='\033[1;36m'
WHITE='\033[1;37m'
GREEN='\033[1;32m'
RED='\033[1;31m'
NC='\033[0m' # No Color

# --- CONFIG ---
FLAKE_DIR="$HOME/Yuzu-Dots"
DEFAULT_HOST="nixchanclanker"

# --- FUNCTIONS ---

show_banner() {
    clear
    echo -e "${PINK}"
    cat << "EOF"

$$\     $$\                              $$$$$$$\             $$\               
\$$\   $$  |                             $$  __$$\            $$ |              
 \$$\ $$  /$$\   $$\ $$$$$$$$\ $$\   $$\ $$ |  $$ | $$$$$$\ $$$$$$\    $$$$$$$\ 
  \$$$$  / $$ |  $$ |\____$$  |$$ |  $$ |$$ |  $$ |$$  __$$\\_$$  _|  $$  _____|
   \$$  /  $$ |  $$ |  $$$$ _/ $$ |  $$ |$$ |  $$ |$$ /  $$ | $$ |    \$$$$$$\  
    $$ |   $$ |  $$ | $$  _/   $$ |  $$ |$$ |  $$ |$$ |  $$ | $$ |$$\  \____$$\ 
    $$ |   \$$$$$$  |$$$$$$$$\ \$$$$$$  |$$$$$$$  |\$$$$$$  | \$$$$  |$$$$$$$  |
    \__|    \______/ \________| \______/ \_______/  \______/   \____/ \_______/ 
                                                                                

EOF
    echo -e "${CYAN}    :: NixOS Flake Installer / Yuzusoft Edition ::${NC}"
    echo -e "${PINK}    -------------------------------------------${NC}"
    echo ""
}

log_info() {
    echo -e "${CYAN}[INFO]${NC} $1"
}

log_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

log_step() {
    echo -e "${PINK}[STEP]${NC} $1..."
}

# --- MAIN SCRIPT ---

show_banner

# 1. Check Directory
if [ "$(pwd)" != "$FLAKE_DIR" ]; then
    echo -e "${RED}[ERROR]${NC} You are not in the correct directory!"
    echo "Please run: cd ~/Yuzu-Dots"
    exit 1
fi

# 2. Ask for Hostname
echo -e "${WHITE}Which host configuration would you like to install?${NC}"
echo -e "Default: ${PINK}$DEFAULT_HOST${NC}"
read -p "Hostname (Press Enter for default): " HOSTNAME
HOSTNAME=${HOSTNAME:-$DEFAULT_HOST}

echo ""
log_info "Selected Host: ${WHITE}$HOSTNAME${NC}"
echo ""

# 3. Handle Hardware Config (The Critical Step)
log_step "Detecting Hardware Configuration"

if [ -f /etc/nixos/hardware-configuration.nix ]; then
    echo -e "${WHITE}Found system hardware-configuration.nix.${NC}"
    echo -e "${CYAN}Copying it to the Flake to ensure this machine boots correctly...${NC}"
    
    # We copy the generated config over the repo config
    # This ensures UUIDs match the current disk
    cp /etc/nixos/hardware-configuration.nix ./hardware-configuration.nix
    
    log_success "Hardware configuration synced!"
else
    echo -e "${RED}[WARNING]${NC} /etc/nixos/hardware-configuration.nix not found!"
    read -p "Are you sure you want to continue? (y/n) " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        exit 1
    fi
fi

# 4. Git Staging (Required for Flakes)
log_step "Staging files for Nix Flakes"
git add .
log_success "Git stage updated."

# 5. Build System
echo ""
echo -e "${PINK}------------------------------------------------${NC}"
echo -e "${WHITE}  Ready to build Yuzu-Dots for ${PINK}$HOSTNAME${WHITE}...${NC}"
echo -e "${PINK}------------------------------------------------${NC}"
echo -e "${CYAN}Note: You will be asked for your sudo password.${NC}"
echo ""

# We use --extra-experimental-features to ensure it works even on fresh install
sudo nixos-rebuild switch --flake .#$HOSTNAME --extra-experimental-features 'nix-command flakes'

echo ""
show_banner
echo -e "${GREEN}  INSTALLATION COMPLETE!  ${NC}"
echo -e "${WHITE}  Welcome home, Master!   ${NC}"
echo ""