{ config, pkgs, lib, ... }:

{
	imports = [
		./modules/atproto-pds.nix
		./modules/cloudflare.nix
		../../modules/force.nix
	];

	# gcc. shit breaks. wtf
	environment.sessionVariables.LD_LIBRARY_PATH = "${pkgs.gcc15}/lib";

	services.openssh.enable = lib.mkForce true;

	environment.systemPackages = with pkgs; [
		fastfetch
		hyfetch
		pm2
	];

	users.users.ocbwoy3 = {
		initialPassword = "thisisapassword42069!"; # not the type passwords i use
		isNormalUser = true;
		extraGroups = [ "wheel" "networkmanager" ];
		shell = pkgs.zsh;
	};

	virtualisation.docker.enable = true;

	networking.firewall = {
		enable = true;
		allowedTCPPorts = [ 22 443 3000 3001 8080 25565 ];
		allowedUDPPorts = [ 22 443 3000 3001 8080 25565 ];
	};

	catppuccin = {
		enable = true;
		flavor = "mocha";
		accent = "blue";
	};

	system.stateVersion = "23.05"; # DO NOT TOUCH

}
