# ~/Yuzu-Dots/packages.nix
{ pkgs, ... }:

# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# 🍋 YUZU-DOTS :: PACKAGE MANAGEMENT
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

{
  home.packages = let
    
    # ─── System & Core Utilities ──────────────────────────────────
    coreUtils = with pkgs; [
      btop            # Resource monitor
      curl
      fastfetch       # System info fetcher
      flatpak
      gnumake
      jq              # JSON processor
      killall
      networkmanager
      pamixer         # PulseAudio mixer
      pavucontrol     # PulseAudio GUI control
      stow            # Dotfile manager
      vim
      wget
      gh
      firefox
      xwayland
      xorg.xeyes  # for testing
      xorg.xclock # for testing
    ];

    # ─── Shells, Terminals & CLI Tools ────────────────────────────
    shellsAndTerminals = with pkgs; [
      # Terminals & Shells
      alacritty
      fish
      foot
      ghostty
      zsh
      
      # CLI Media & Tools
      ani-cli         # Watch anime via CLI
      ffmpeg
      fzf             # Fuzzy finder
      imv             # Image viewer
      mpd             # Music Player Daemon
      mpv             # Media player
      ueberzugpp      # Image previews in terminal
      vlc
      yazi            # Terminal file manager 🦀
      yt-dlp-light    # YouTube downloader
      ytfzf           # YouTube fuzzy finder
    ];

    # ─── Development & Coding ─────────────────────────────────────
    development = with pkgs; [
      # Editors
      neovim
      vscode
      jdk
      code-cursor
      netbeans
      # Languages & Runtimes
      bun
      gcc
      git
      go
      nodejs
      pnpm
      python3
      pipx
      rustup
      pkg-config
      
      # Windows Cross-Compilation
      pkgsCross.mingwW64.stdenv.cc
      pkgsCross.mingwW64.windows.pthreads
      
      # Tools
      github-desktop
      p7zip
      qbittorrent
      tree
      unrar
    ];

    # ─── GUI Applications ─────────────────────────────────────────
    guiApps = with pkgs; [
      kdePackages.dolphin # Updated to Qt6 version
      fuzzel              # App launcher
      niri                # Scrollable Tiling Window Manager
      obs-studio
      vesktop             # Custom Discord client
    ];

    # ─── Ricing & Customization ───────────────────────────────────
    customization = with pkgs; [
      # Theming
      catnip              # System monitor
      cava                # Audio visualizer
      cmatrix             # Matrix rain
      htop
      pywal               # Generate color schemes from images
      swww                # Wayland wallpaper daemon
      tty-clock
      wpgtk
      wbg 
      # Wayland Widgets & Utilities
      dunst               # Notifications
      eww                 # ElKowars wacky widgets
      mpvpaper            # Video wallpapers
      rofi                # App launcher / Menu
      waybar              # Status bar
      wl-clipboard
      xwayland
      
      # Qt Theming (Cleaned up duplicates)
      libsForQt5.qt5.qtgraphicaleffects
      libsForQt5.qt5.qtquickcontrols2
      sddm-chili-theme    # Note: Login themes usually go in system config
    ];

  in
    # Combine all groups into the final list
    coreUtils 
    ++ shellsAndTerminals 
    ++ development 
    ++ guiApps 
    ++ customization;
}
