{ config, pkgs, ...}:

{
  # 1. ADD THIS BLOCK to fix the PATH issue
  # The path where tools like mov-cli-youtube (installed via pipx in user space) live.
  home.sessionPath = [
    "$HOME/.local/bin"
  ];
  # --- END OF FIX ---

  programs.zsh = {
    enable = true ;
    shellAliases = {
      btw = "echo i use nixos btw ";
      # Assuming you have a flake configuration, use 'home-manager switch'
      # for the user configuration and 'sudo nixos-rebuild switch' for the system.
      nrs = "sudo nixos-rebuild switch" ;
      ff  = "fastfetch" ;
      hsf = "home-manager switch --flake";
    };
  };

  programs.zsh.plugins = [
    {
      name = "powerlevel10k";
      src = pkgs.zsh-powerlevel10k;
      file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
    }
  ];

  programs.zsh.initContent = ''
    # Your p10k configuration
    source ~/.p10k.zsh
    typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet
    typeset -g POWERLEVEL9K_INSTANT_PROMPT=off
    
    # Running fastfetch here is okay, but it might slow down your shell startup.
    # A cleaner place might be in programs.zsh.profileExtra or similar.
    fastfetch
  '';
}
