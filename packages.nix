# ~/Yuzu-Dots/packages.nix
{ pkgs, ... }:

# This file is now a full module that sets the home.packages option.
{
  home.packages = let
    # Define your package categories as separate lists
    coreUtils = with pkgs; [
      stow killall vim wget curl jq btop gnumake
      networkmanager pavucontrol pamixer fastfetch flatpak
    ];

    shellsAndTerminals = with pkgs; [
      zsh fish foot alacritty ghostty
    ];

    development = with pkgs; [
      neovim vscode
      git gcc pkg-config
      go nodejs pnpm python3 pipx
      wails gtk3 libappindicator libnotify
      tesseract leptonica imagemagick
      bun npx mnpm
    ];

    guiApps = with pkgs; [
      niri fuzzel vesktop obs-studio
    ];

    customization = with pkgs; [
      swww pywal wpgtk
      eww waybar rofi
      cava xwayland wl-clipboard dunst mpvpaper
    ];
  in
    # Combine all the lists into the final list
    coreUtils ++ shellsAndTerminals ++ development ++ guiApps ++ customization;

}
