# /home/monica/Yuzu-Dots/flake.nix
{
  description = "Yuzu-Dots Nix Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

# ... (inputs section is the same) ...

outputs = { self, nixpkgs, home-manager, ... }@inputs:
  let
    system = "x86_64-linux";
    username = "monica";
  in {
    homeConfigurations."${username}" = home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgs.legacyPackages.${system};
      
      # This is the important part!
      # We pass our local packages file into the modules.
      # Home Manager will automatically interpret it as an overlay.
      modules = [ 
        ./home.nix 
        ./packages.nix # <-- ADD THIS LINE
      ];
    };
  };
}
