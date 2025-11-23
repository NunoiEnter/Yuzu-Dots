  { config, pkgs, lib, inputs, ... }:

let
   # Copy your wallpaper into the Nix store
   # Ensure this file actually exists at this path!
   myWallpaper = pkgs.copyPathToStore ./assets/wallpaper.jpg;
   
   # SDDM Chili theme with custom background
   sddm-chili-fixed = pkgs.stdenv.mkDerivation {
    name = "sddm-chili-theme-fixed";
    src = pkgs.fetchFromGitHub {
      owner = "MarianArlt";
      repo = "sddm-chili";
      rev = "6516d50176c3b34df29003726ef9708813d06271";
      sha256 = "036fxsa7m8ymmp3p40z671z163y6fcsa9a641lrxdrw225ssq5f3";
    };
    installPhase = ''
      mkdir -p $out/share/sddm/themes/chili
      cp -r * $out/share/sddm/themes/chili/
      
      # Replace the default background with your custom one
      cp ${myWallpaper} $out/share/sddm/themes/chili/assets/background.jpg
    '';
  };
in
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./fonts.nix 
    ];

  # FLAKES SETTINGS
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Bootloader.
  boot.loader.systemd-boot.enable = false;
  
  boot.loader.efi.canTouchEfiVariables = true;
  
  boot.kernelPackages = pkgs.linuxPackages_latest;
  
  boot.loader.grub = {
    enable = true;
    device = "nodev"; # "nodev" is required for UEFI
    efiSupport = true;
    useOSProber = true; # Finds Windows if you have it
    
    # 3. YUZUSOFT THEMING
    # This will set your background image
    splashImage = ./assets/boot-background.jpg;
    
    # Optional: If you want a full pre-made theme (like Catppuccin)
    # theme = pkgs.catzppuccin-grub; 
  };



  # SHELL ZSH
  programs.zsh.enable = true;
  environment.shells = with pkgs; [ zsh ];
  users.defaultUserShell = pkgs.zsh;
  
  # HOSTNAME
  networking.hostName = "nixchanclanker"; 

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Bangkok";

  # INTERNATIONALISATION
  i18n.defaultLocale = "en_US.UTF-8";
  
  # Define all locales to be built (en, ja, th)
  i18n.supportedLocales = [
    "en_US.UTF-8/UTF-8"
    "ja_JP.UTF-8/UTF-8"
    "th_TH.UTF-8/UTF-8"
  ];

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "th_TH.UTF-8";
    LC_IDENTIFICATION = "th_TH.UTF-8";
    LC_MEASUREMENT = "th_TH.UTF-8";
    LC_MONETARY = "th_TH.UTF-8";
    LC_NAME = "th_TH.UTF-8";
    LC_NUMERIC = "th_TH.UTF-8";
    LC_PAPER = "th_TH.UTF-8";
    LC_TELEPHONE = "th_TH.UTF-8";
    LC_TIME = "th_TH.UTF-8";
  };

  # GRAPHICAL ENVIRONMENT
  services.xserver.enable = true;
  
services.displayManager.sddm = {
    enable = true;
    theme = "chili";
    
    # REMOVE the 'package = ...' line if it's still there.

    extraPackages = with pkgs; [
      qt6.qt5compat        # Provides the graphical effects for old themes
      qt6.qtdeclarative    # Required for loading QML
      qt6.qtsvg            # Required for SVG icons
    ];
  };

  services.desktopManager.gnome.enable = true;
  
  # VIDEO DRIVERS
  services.xserver.videoDrivers = [ "amdgpu" ];

  # NIRI
  programs.niri.enable = true;

  # KEYMAP
  services.xserver.xkb = {
    layout = "us,th";
    options = "grp:alt_shift_toggle";
  };

  services.printing.enable = true;

  # SOUND (Pipewire)
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # GRAPHICS DRIVERS
  # "hardware.opengl" is deprecated in unstable, changed to "hardware.graphics"
  hardware.graphics = {
    enable = true;
    enable32Bit = true; # Replaces driSupport32Bit
  };

  # USER ACCOUNT
  users.users.monica = {
    isNormalUser = true;
    description = "monica";
    extraGroups = [ "networkmanager" "wheel" "libvirtd" ];
    packages = with pkgs; [ ];
  };

  # ENV VARIABLES
  environment.sessionVariables = {
    ELECTRON_OZONE_PLATFORM_HINT = "wayland";
    NIXOS_OZONE_WL = "1";
  };
  
  system.stateVersion = "25.05";

  # PERMITTED INSECURE PACKAGES
  nixpkgs.config.permittedInsecurePackages = [
    "mbedtls-2.28.10"
  ];
  nixpkgs.config.allowUnfree = true;

  # SYSTEM PACKAGES
  # (Note: Your detailed packages are inside ./packages.nix, these are extras)
  environment.systemPackages = with pkgs; [
    foot
    neovim
    vim
    git
    lutris
    vulkan-tools
    glxinfo
    # Add the fixed SDDM Chili theme
    sddm-chili-fixed
 ];

  services.openssh.enable = true;
  services.flatpak.enable = true;
}