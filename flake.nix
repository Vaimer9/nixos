{
    description = "v9 install";

    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";

        dms = {
            url = "github:AvengeMedia/DankMaterialShell/stable";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    outputs = { self, nixpkgs, dms, ... }@inputs: {
        nixosConfigurations.v9 = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            specialArgs = { inherit inputs; };

            modules = [
                dms.nixosModules.dank-material-shell
                ./host/configuration.nix
                ./host/hardware.nix
            ];
        };
    };
}
