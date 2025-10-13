{ config, pkgs, ...}:

{
  programs.zsh = {
   enable = true ;
   shellAliases = {
	btw = "echo i use nixos btw ";
 	nrs = "sudo nixos-rebuild switch" ;
	ff  = "fastfetch" ;
	hsf = "home-manager switch --flake";
	};
   };
 programs.zsh.plugins = [

   {name = "powerlevel10k";src = pkgs.zsh-powerlevel10k;file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";}

]; 
  programs.zsh.initContent = ''
  source ~/.p10k.zsh
  typeset -g POWERLEVEL9K\_INSTANT\_PROMPT=quiet
  typeset -g POWERLEVEL9K\_INSTANT\_PROMPT=off
  fastfetch
  '';
}




