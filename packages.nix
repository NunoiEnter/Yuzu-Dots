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
      zsh fish foot alacritty ghostty ani-cli ytfzf yt-dlp-light
      mpv mpd imv vlc fzf dmenu ueberzugpp ffmpeg jq curl
    ];

    development = with pkgs; [
      neovim vscode tree
      git gcc pkg-config
      go nodejs pnpm python3 pipx
      wails gtk3 libappindicator libnotify
      tesseract leptonica imagemagick
      bun qbittorrent nemo-with-extensions p7zip
    ];

    guiApps = with pkgs; [
      niri fuzzel vesktop obs-studio lutris-unwrapped
    ];

    customization = with pkgs; [
      swww pywal wpgtk
      eww waybar rofi
      cava xwayland wl-clipboard dunst mpvpaper
      htop cmatrix tty-clock catnip
    ];
  in
    # Combine all the lists into the final list
    coreUtils ++ shellsAndTerminals ++ development ++ guiApps ++ customization;

}
