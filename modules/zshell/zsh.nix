{ config, pkgs, ...}:

{
  # Add local bin path (pipx / custom scripts)
  home.sessionPath = [
    "${config.home.homeDirectory}/.local/bin"
  ];

  programs.zsh = {
    enable = true;

    shellAliases = {
      btw = "echo i use nixos btw";
      nrs = "sudo nixos-rebuild switch";
      ff  = "fastfetch";
      hsf = "home-manager switch --flake";
    };

    plugins = [
      {
        name = "powerlevel10k";
        src = pkgs.zsh-powerlevel10k;
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
    ];

    # initContent = always loaded when zsh starts
    initExtra = ''
      # Powerlevel10k config
      source ~/.p10k.zsh
      typeset -g POWERLEVEL10K_INSTANT_PROMPT=off

      # Run fastfetch only on interactive shells
      [[ $- == *i* ]] && fastfetch
    '';
  };
}
