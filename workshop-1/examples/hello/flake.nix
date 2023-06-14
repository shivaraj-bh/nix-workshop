{
  inputs.nixpkgs.url = "github:nixos/nixpkgs";
  outputs = { self, nixpkgs }: {
      packages.aarch64-darwin.default = 
      let
        pkgs = nixpkgs.legacyPackages.aarch64-darwin;
      in
      derivation {
        name = "myHello";
        builder = "${pkgs.bash}/bin/bash";
        args = [ ./hello_builder.sh ];
        system = "aarch64-darwin";
        src = builtins.fetchurl 
        { 
          url = "https://ftp.gnu.org/gnu/hello/hello-2.12.tar.gz"; 
          sha256 = "1ayhp9v4m4rdhjmnl2bq3cibrbqqkgjbl3s7yk2nhlh8vj3ay16g";    
        };
        # gnutar is needed to unpack the source
        gnutar = pkgs.gnutar;
        # gnutar depends on gzip
        gzip = pkgs.gzip;
        # Compiler
        gcc = pkgs.clang;
        # Build tools
        gnumake = pkgs.gnumake;
        # Packages below are needed during the configuration phase.
        # During this phase the Makefile is generated
        inherit (pkgs) gnused coreutils gnugrep gawk;
        bintools = pkgs.clang.bintools.bintools_bin;
      };
  };
}