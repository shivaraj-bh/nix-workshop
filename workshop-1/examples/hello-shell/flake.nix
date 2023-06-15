{
    inputs.nixpkgs.url = "github:nixos/nixpkgs";
    outputs = {self, nixpkgs}:{
        packages."aarch64-darwin".default = 
        let
            pkgs = nixpkgs.legacyPackages.aarch64-darwin;
        in
        pkgs.mkShell {
            buildInputs = [
                pkgs.gnutar
                pkgs.gzip
                pkgs.clang
                pkgs.gnumake
                pkgs.gnused
                pkgs.coreutils
                pkgs.gnugrep
                pkgs.gawk
                pkgs.clang.bintools.bintools_bin
            ];
        };
    };
}