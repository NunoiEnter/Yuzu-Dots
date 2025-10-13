{ config, pkgs, ... }:

{
 home.username = "monica";
 home.homeDirectory = "/home/monica";
 home.stateVersion = "25.05" ;

  import = [
	./modules/zshell/zsh.nix
  # This is the main list of packages that Home Manager will install
  home.packages = let
    # Define your package categories as separate lists
    coreUtils = with pkgs; [
      stow killall vim wget curl jq btop gnumake
      networkmanager pavucontrol pamixer fastfetch flatpak
    ];

    shellsAndTerminals = with pkgs; [
      zsh fish foot alacritty
    ];

    development = with pkgs; [
      # NixOS
      pkgs.home-manager # Good to keep for the standalone command
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
    # Combine all the lists into the final home.packages list
    coreUtils ++ shellsAndTerminals ++ development ++ guiApps ++ customization;

  # Make sure to enable the Home Manager program itself
  programs.home-manager.enable = true;
programs.zsh = {
  enable = true ;
  shellAliases = {
	btw = "echo i use nixos btw ";
 	nrs = "sudo nixos-rebuild switch" ;
	};
   };
 programs.zsh.plugins = [

   {name = "powerlevel10k";src = pkgs.zsh-powerlevel10k;file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";}

]; 
  programs.zsh.initExtra = ''
  typeset -g POWERLEVEL9K\_INSTANT\_PROMPT=quiet
  typeset -g POWERLEVEL9K\_INSTANT\_PROMPT=off
  source ~/.p10k.zsh
  fastfetch
  '';
}



