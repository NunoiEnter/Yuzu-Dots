# This file is now a function that returns a LIST of packages.

{ pkgs, libs , ... }:

let
  # Define your package categories as separate lists
  coreUtils = with pkgs; [
    stow killall vim wget curl jq btop gnumake
    networkmanager pavucontrol pamixer fastfetch flatpak
  ];

  shellsAndTerminals = with pkgs; [
    zsh fish foot alacritty
  ];

  development = with pkgs; [
    #NixOS
    pkgs.home-manager
    # Editors
    neovim vscode
    # Core Tools
    git gcc pkg-config
    # Languages & Runtimes
    go nodejs pnpm python3 pipx
    # Build Dependencies & Libs
    wails gtk3 libappindicator libnotify
    # Image & OCR
    tesseract leptonica imagemagick
  ];

  guiApps = with pkgs; [
    niri fuzzel vesktop obs-studio
  ];

  customization = with pkgs; [
    # Theming & Visuals
    swww pywal wpgtk
    # Bars & Launchers
    eww waybar rofi
    # Utilities
    cava xwayland wl-clipboard dunst mpvpaper
  ];

in
  # Combine and RETURN all the lists
  coreUtils ++ shellsAndTerminals ++ development ++ guiApps ++ customization
