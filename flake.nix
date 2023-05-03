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
          common_packages = with pkgs; [ graph-easy slides jp2a ];
        in
        {
          _module.args.pkgs =
            import nixpkgs {
              inherit system;
              config = {
                # For jp2a
                allowBroken = true;
              };
            };
          devShells.default = pkgs.mkShell { packages = common_packages; };
          apps.default.program = toString
            (pkgs.writeShellApplication {
              name = "slides";
              runtimeInputs = common_packages;
              text = "slides ${self}/presentation.md";
            }) + "/bin/slides";
        };
    };
}
