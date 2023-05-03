{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
  };
  outputs = inputs@{ self, nixpkgs, flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = nixpkgs.lib.systems.flakeExposed;

      perSystem = { self', pkgs, system, ... }:
        let
          common_packages = with pkgs; [ graph-easy slides ];
        in
        {
          devShells.default = pkgs.mkShell { packages = common_packages; };
          apps.default.program = toString
            (pkgs.writeShellApplication {
              name = "slides";
              runtimeInputs = common_packages;
	      # self points to the source directory in /nix/store
              text = "slides ${self}/presentation.md";
            }) + "/bin/slides";
        };
    };
}
