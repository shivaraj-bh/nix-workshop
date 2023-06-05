{
  inputs = {
    # Principle inputs (updated by `nix run .#update`)
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    flake-parts.url = "github:hercules-ci/flake-parts";
    nixos-flake.url = "github:srid/nixos-flake";
    
    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, ... }:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" ];
      imports = [ inputs.nixos-flake.flakeModule  ];
      flake =
        let
          myUserName = "mango";
        in
        {
          # Configurations for Linux (NixOS) machines
          nixosConfigurations.office = self.nixos-flake.lib.mkLinuxSystem {
            imports = [
	      inputs.disko.nixosModules.disko
              # Your machine's configuration.nix goes here
              ({ pkgs, lib, ... }: {
		
		# Disk partioning scheme
		disko.devices = import ./disk-config.nix {
		  inherit lib;
		};

		# Boot manager
	  	boot = {
		  loader.grub = {
		    devices = [ "/dev/sda" ];
		    efiSupport = true;
		    efiInstallAsRemovable = true;
		  };
		};

		# System services
		services = {
		  openssh.settings.permitRootLogin = "prohibit-password";
		  openssh.settings.PasswordAuthentication = false;
		  openssh.enable = true;
		};

		# The Internet
		networking = {
		  hostName = "user";
		  networkmanager.enable = true;
		};
		
		# User settings
		users.users = {
		  root.initialHashedPassword = "";
		  root.openssh.authorizedKeys.keys = [
		    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAkoJbpc6g08mGMtpExeD0Fiiu0IWbVVc90ozCVsJqfm"
		  ];
                  ${myUserName} = {
		    isNormalUser = true;
		    initialHashedPassword = "";
		    openssh.authorizedKeys.keys = [
		      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOZaSBdDB7D4ceQgghss2xrI7MEwFyN2tRMkgkUTBOg8"
		      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAkoJbpc6g08mGMtpExeD0Fiiu0IWbVVc90ozCVsJqfm"
		    ];
		  };
		};

		# Enable flakes
		nix.settings.experimental-features = [ "nix-command" "flakes" ];
		system.stateVersion = "22.11";
              })
              # Setup home-manager in NixOS config
              self.nixosModules.home-manager
              {
                home-manager.users.${myUserName} = {
                  imports = [ self.homeModules.default  ];
                  home.stateVersion = "22.11";
                };
              }
            ];
          };

          # home-manager configuration goes here.
          homeModules.default = { pkgs, ... }: {
            imports = [ ./home/neovim.nix ];
            programs.git.enable = true;
            programs.starship.enable = true;
            programs.bash.enable = true;
	    programs.direnv = {
	      enable = true;
	      nix-direnv.enable = true;
	    };
          };
        };
    };
}
