{ config, pkgs, ... }:

{
  # --- User and State ---
  nixpkgs.config.allowUnfree = true;
  home.username = "monica";
  home.homeDirectory = "/home/monica";
  home.stateVersion = "25.05";
    

  home.sessionPath = [
    "$HOME/.local/bin"
  ];
  
  # --- Imports ---
  imports = [
    ./modules/zshell/zsh.nix
    ./modules/Fastfetch/fastfetch.nix
    ./packages.nix 
  ];

 programs.home-manager.enable = true;
}
