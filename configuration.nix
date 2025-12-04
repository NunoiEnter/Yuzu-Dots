{config, pkgs, lib, inputs, ... }:

let
  # --- CUSTOM SDDM THEME ---
  # We override the Astronaut theme to use your wallpaper
  custom-sddm-astronaut = pkgs.sddm-astronaut.override {
    themeConfig = {
      # FIX 1: Use "${ ... }" to force it to be a string path in the Nix Store
      Background = "${./assets/wallpaper.jpg}";
     PartialBlur = "true"; 
      FormPosition = "left";
    };
  };

in
{
  imports =
    [ 
      ./hardware-configuration.nix
      ./fonts.nix 
    ];

  # --- FLAKES & SYSTEM ---
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  system.stateVersion = "25.05";

  # Garbage Collection
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  # --- BOOTLOADER ---
  boot.loader.systemd-boot.enable = false;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;
  
  boot.loader.grub = {
    enable = true;
    device = "nodev";
    efiSupport = true;
    useOSProber = true;
  };

  # --- NETWORKING & TIME ---
  networking.hostName = "nixchanclanker"; 
  networking.networkmanager.enable = true;
  time.timeZone = "Asia/Bangkok";

  # --- LOCALES ---
  i18n.defaultLocale = "en_US.UTF-8";
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

  # --- GRAPHICAL ENVIRONMENT ---
  services.xserver.enable = true;
  services.xserver.videoDrivers = [ "amdgpu" ];
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  # --- SDDM CONFIGURATION (FIXED) ---
  services.displayManager.sddm = {
    enable = true;
    # FIX 2: Explicitly use Qt6 SDDM
    package = pkgs.kdePackages.sddm;
    
    # Use the official theme name (our override updates the config inside it)
    theme = "sddm-astronaut-theme";
    
    # FIX 3: Add the missing dependencies! (This fixes the white screen)
    extraPackages = with pkgs; [
      custom-sddm-astronaut
      qt6.qt5compat
      qt6.qtdeclarative
      qt6.qtsvg
      qt6.qtmultimedia   # <--- The background renderer needs this!
      qt6.qtvirtualkeyboard
    ];
  };

  # --- DESKTOP & WINDOW MANAGER ---
  services.desktopManager.gnome.enable = true;
  programs.niri.enable = true;
  

  environment.sessionVariables = {
  _JAVA_AWT_WM_NONREPARENTING = "1";
  AWT_TOOLKIT = "XToolkit";
};

  systemd.user.services.xwayland = {
  description = "XWayland server";
  wantedBy = [ "graphical-session.target" ];
  serviceConfig = {
    ExecStart = "${pkgs.xwayland}/bin/Xwayland :0";
    Restart = "on-failure";
  };
};
  # --- INPUT ---
  services.xserver.xkb = {
    layout = "us,th";
    options = "grp:alt_shift_toggle";
  };

  # --- SOUND ---
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # --- USER ---
  users.users.monica = {
    isNormalUser = true;
    description = "monica";
    extraGroups = [ "networkmanager" "wheel" "libvirtd" ];
    packages = with pkgs; [];
  };
  
  programs.zsh.enable = true;
  environment.shells = with pkgs; [ zsh ];
  users.defaultUserShell = pkgs.zsh;

  # --- PACKAGES ---
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.permittedInsecurePackages = [ "mbedtls-2.28.10" ];

  environment.systemPackages = with pkgs; [
    foot
    neovim
    vim
    git
    lutris
    vulkan-tools
    glxinfo
    # Add your custom theme here too just in case
    custom-sddm-astronaut
  ];

  services.printing.enable = true;
  services.openssh.enable = true;
  services.flatpak.enable = true;
  
  environment.sessionVariables = {
    ELECTRON_OZONE_PLATFORM_HINT = "wayland";
    NIXOS_OZONE_WL = "1";
  };
}
