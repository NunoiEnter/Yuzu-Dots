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
  home.packages = import ./packages.nix { inherit pkgs; };
  programs.home-manager.enable = true;
}
