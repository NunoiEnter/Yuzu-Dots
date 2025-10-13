{ config, pkgs, ... }:

{
  # --- User and State ---
  home.username = "monica";
  home.homeDirectory = "/home/monica";
  home.stateVersion = "25.05";

  # --- Imports ---
  imports = [
    ./modules/zshell/zsh.nix
    ./modules/Fastfetch/fastfetch.nix
    ./packages.nix 
  ];

 programs.home-manager.enable = true;
}
