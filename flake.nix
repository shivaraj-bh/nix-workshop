{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
  };
  outputs = inputs@{ self, nixpkgs, flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; }
      {
        systems = nixpkgs.lib.systems.flakeExposed;
        perSystem = { self', pkgs, lib, ... }: {
          apps =
            let
              slidesScript = workshop: pkgs.writeShellApplication {
                name = "workshop-slides";
                runtimeInputs = with pkgs; [ graph-easy slides ];
                # self points to the source directory in /nix/store
                # allowing us to run the presentation without having to clone
                text = "slides ${self}/${workshop}/presentation.md";
              };
              workshopNames = [ "workshop-0" "workshop-1" ];
            in
            lib.listToAttrs
              (map (workshop: lib.nameValuePair workshop { program = lib.getExe (slidesScript workshop); })
                workshopNames);
          devShells.default = pkgs.mkShell {
            name = "nix-workshop";
            buildInputs = with pkgs; [ graph-easy slides ];
          };
        };
      };
}
