{
    description = "v9 install";

    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";

        dms = {
            url = "github:AvengeMedia/DankMaterialShell/stable";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        home-manager = {
            url = "github:nix-community/home-manager/release-26.05";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        spotifast = {
            url = "github:crmne/spotifast";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        nix-auth = {
            url = "github:numtide/nix-auth";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    outputs = { self, nixpkgs, dms, home-manager, spotifast, nix-auth, ... }@inputs: {
        nixosConfigurations.v9 = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            specialArgs = { inherit inputs; };

            modules = [
                ./host/configuration.nix
                home-manager.nixosModules.home-manager
                {
                    home-manager = {
                        useGlobalPkgs = true;
                        useUserPackages = true;
                        backupFileExtension = "backup";
                        extraSpecialArgs = { inherit inputs; };
                        users.v9 = import ./home;
                    };
                }
            ];
        };
    };
}
