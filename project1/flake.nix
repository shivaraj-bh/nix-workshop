{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    flake-root.url = "github:srid/flake-root";
    mission-control.url = "github:Platonic-Systems/mission-control";
  };
  outputs = inputs@{ self, nixpkgs, flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = nixpkgs.lib.systems.flakeExposed;
      imports = [
        inputs.flake-root.flakeModule
        inputs.mission-control.flakeModule
      ];
      perSystem = { self', pkgs, ... }: {
        mission-control.scripts = {
          pg = {
            description = "Start postgres server";
            exec = "pg";
          };
        };
        devShells.default =
          let
            postgres = (pkgs.writeShellApplication {
              name = "pg";
              runtimeInputs = with pkgs;
                [
                  postgresql_11
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
            packages = [ postgres pkgs.postgresql_11 pkgs.nodejs-18_x pkgs.ormolu ];
          };
      };
    };
}
