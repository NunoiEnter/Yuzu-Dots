# etc/nixos/fonts.nix

{ pkgs , ...} :

{
 fonts.packages = [
    pkgs.noto-fonts
    pkgs.noto-fonts-cjk-sans
    pkgs.noto-fonts-emoji
    pkgs.font-awesome
    pkgs.nerd-fonts.jetbrains-mono
 ] ;
    fonts.fontconfig.enable = true ;
}

