{
  description = "TOMORO OS";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
    in
    {
      nixosConfigurations = {
        appliance = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [ ./hosts/appliance ];
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
      };
    };
}
