{ config, pkgs, lib, ... }:

{
	imports = [
		./modules/atproto-pds.nix
		./modules/cloudflare.nix
		./modules/knot.nix
		../../modules/force.nix
	];

	# gcc. shit breaks. wtf
	environment.sessionVariables.LD_LIBRARY_PATH = "${pkgs.gcc15}/lib";

	systemd.services.ocbwoy3-start-pm2 = {
		enable = true;
		description = "Start PM2";
		after = [ "network.target" ];
		wantedBy = [ "multi-user.target" ];
		serviceConfig = {
			Type = "forking";
			User = "ocbwoy3";
			LimitNOFILE = "infinity";
			LimitNPROC = "infinity";
			LimitCORE = "infinity";
			Environment = "PM2_HOME=/home/ocbwoy3/.pm2";
			PIDFile = "/home/ocbwoy3/.pm2/pm2.pid";
			Restart = "on-failure";

			ExecStart = "${pkgs.pm2}/bin/pm2 resurrect";
			ExecReload = "${pkgs.pm2}/bin/pm2 reload all";
			ExecStop = "${pkgs.pm2}/bin/pm2 kill";
		};
	};

	services.openssh.settings = {
		PubkeyAuthentication = "yes";
		TrustedUserCAKeys = "/etc/ssh/ca.pub";
	};

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
