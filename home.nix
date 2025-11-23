{ config, pkgs, ... }:

{
  # --- User and State ---
  home.username = "monica";
  home.homeDirectory = "/home/monica";
  home.stateVersion = "25.05";
    

  home.sessionPath = [
    "$HOME/.local/bin"
  ];
  
  # Add this to home.nix
  systemd.user.services.swww = {
    Unit = {
      Description = "Wayland Wallpaper Daemon";
      PartOf = [ "graphical-session.target" ];
      After = [ "graphical-session.target" ];
    };
    Service = {
      ExecStart = "${pkgs.swww}/bin/swww-daemon";
      Restart = "on-failure";
    };
    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };
  
  # --- Imports ---
  imports = [
    ./modules/zshell/zsh.nix
    ./modules/Fastfetch/fastfetch.nix
    ./packages.nix 
  ];

 programs.home-manager.enable = true;
}
