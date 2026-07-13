{
  description = "TOMORO OS";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, disko }:
    let
      system = "x86_64-linux";
    in
    {
      nixosConfigurations = {
        appliance = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            disko.nixosModules.disko
            ./hosts/appliance
          ];
        };

        factory = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [ ./hosts/factory ];
        };

        recovery = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [ ./hosts/recovery ];
        };

        vm = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [ ./hosts/vm ];
        };

        iso = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit self; };
          modules = [ ./hosts/iso ];
        };

        live = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [ ./hosts/live ];
        };
      };
    };
}
