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
          let
            postgres = (pkgs.writeShellApplication {
              name = "pg";
              runtimeInputs = with pkgs;
                [
                  postgresql
                  coreutils
                ];
              text =
                ''
                  # Initialize a database with data stored in current project dir
                  [ ! -d "./data/db" ] && initdb --no-locale -D ./data/db
                  postgres -D ./data/db -k "$PWD"/data
                '';
            });
          in
          pkgs.mkShell {
            packages = [ postgres pkgs.postgresql pkgs.nodejs-14_x pkgs.ormolu ];
          };
      };
    };
}
