{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
  };
  outputs = inputs@{ self, nixpkgs, flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = nixpkgs.lib.systems.flakeExposed;

      perSystem = { self', pkgs, system, ... }: {
        _module.args.pkgs =
          import nixpkgs {
            inherit system;
            config = {
              # For jp2a
              allowBroken = true;
            };
          };
        devShells.default = pkgs.mkShell { packages = with pkgs; [ graph-easy slides jp2a ]; };
      };
    };
}
