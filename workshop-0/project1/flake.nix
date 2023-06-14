{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
  };
  outputs = inputs@{ self, nixpkgs, flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = nixpkgs.lib.systems.flakeExposed;
      perSystem = { self', pkgs, ... }: {
        devShells.default =
          pkgs.mkShell {
            packages = [ pkgs.nodejs-18_x pkgs.ormolu ];
          };
      };
    };
}
