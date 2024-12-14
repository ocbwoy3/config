{ config, pkgs, ... }:

{

	# using cloudflare dns instead of apollo.lv (which might be spying)
	networking.nameservers = [ "1.1.1.1" "1.0.0.1" ];

	networking.hostName = "nixos";
	networking.networkmanager.enable = true;

}
