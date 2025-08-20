{ config, pkgs, lib, ... }:

{
	imports = [
		./modules/atproto-pds.nix
		../../modules/nixos/bootloader.nix
		../../modules/nixos/network.nix
		../../modules/nixos/hardware.nix
		../../modules/nixos/nixpkgs.nix
	];

	services.openssh.enable = lib.mkForce true;

	users.users.ocbwoy3 = {
		initialPassword = "thisisapassword42069!"; # not the type passwords i use
		isNormalUser = true;
		extraGroups = [ "wheel" "networkmanager" ];
	};

	virtualisation.docker.enable = true;

	networking.firewall = {
		enable = true;
		allowedTCPPorts = [ 22 443 8080 25565 ];
		allowedUDPPorts = [  ];
	};

	catppuccin = {
		enable = true;
		flavor = "mocha";
		accent = "blue";
	};

	system.stateVersion = "23.05"; # DO NOT TOUCH

}
