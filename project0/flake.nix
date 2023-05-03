{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nixpkgs_22_11.url = "github:nixos/nixpkgs/22.11";
    flake-parts.url = "github:hercules-ci/flake-parts";
  };
  outputs = inputs@{ self, nixpkgs, flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = nixpkgs.lib.systems.flakeExposed;

      perSystem = { self', pkgs, system, ... }: {
        _module.args.pkgs = import self.inputs.nixpkgs {
          inherit system;
          overlays =
            [
              (self: super: { ormolu = inputs.nixpkgs_22_11.legacyPackages.${system}.ormolu; })
            ];
        };
        devShells.default =
          pkgs.mkShell {
            packages = [ pkgs.nodejs-14_x pkgs.ormolu ];
          };
      };
    };
}
