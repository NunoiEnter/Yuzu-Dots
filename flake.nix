{
  description = "Yuzu-Dots NixOS System Flake";

  inputs = {
    # Official NixOS Package source (Unstable)
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # Home Manager
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs: {
    
    # 1. SYSTEM CONFIGURATION (NixOS)
    nixosConfigurations = {
      # Hostname: nixchanclanker
      nixchanclanker = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        
        # Pass 'inputs' to modules so we can use them there
        specialArgs = { inherit inputs; }; 
        
        modules = [
          # Import your main configuration
          ./configuration.nix
          
          # Import Home Manager module so it builds with the system
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.backupFileExtension = "hm-bak";
            
            # Import your home.nix here
            home-manager.users.monica = import ./home.nix;
            
            # Pass arguments to home.nix
            home-manager.extraSpecialArgs = { inherit inputs; };
          }
        ];
      };
    };

    # 2. STANDALONE HOME MANAGER (Optional, keep if you want)
    homeConfigurations."monica" = home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
      modules = [ 
        ./home.nix 
        ./packages.nix 
      ];
    };
  };
}
