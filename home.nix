{ config, pkgs, ... }:

{
  # --- User and State ---
  home.username = "monica";
  home.homeDirectory = "/home/monica";
  home.stateVersion = "25.05";

  # --- Imports ---
  imports = [
    ./modules/zshell/zsh.nix
  ];

  # --- Packages ---
  home.packages = let
    coreUtils = with pkgs; [
      stow killall vim wget curl jq btop gnumake
      networkmanager pavucontrol pamixer fastfetch flatpak
    ];
    shellsAndTerminals = with pkgs; [
      zsh fish foot alacritty
    ];
    development = with pkgs; [
      pkgs.home-manager
      neovim vscode
      git gcc pkg-config
      go nodejs pnpm python3 pipx
      wails gtk3 libappindicator libnotify
      tesseract leptonica imagemagick
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
    # Combine all the lists into the final home.packages list
    coreUtils ++ shellsAndTerminals ++ development ++ guiApps ++ customization;

  programs.home-manager.enable = true;
}
