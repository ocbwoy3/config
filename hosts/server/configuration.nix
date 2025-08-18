{ config, pkgs, ... }:

{
	imports = [
		./modules/atproto-pds.nix
	];

	services.openssh.enable = true;

	users.users.ocbwoy3 = {
		initialPassword = "thisisapassword42069!"; # not the type passwords i use
		isNormalUser = true;
		extraGroups = [ "wheel" "networkmanager" ];
	};

	virtualisation.docker.enable = true;

	networking.firewall = {
		enable = true;
		allowedTCPPorts = [ 8080 443 25565 ];
		allowedUDPPorts = [  ];
	}

	catppuccin = {
		enable = true;
		flavor = "mocha";
		accent = "blue";
	};

	system.stateVersion = "23.05"; # DO NOT TOUCH

}
