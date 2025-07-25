{ config, pkgs, ... }:

{

	#! Disable default nameservers to prevent ISP espionage
	networking.nameservers = [ "1.1.1.1" "1.0.0.1" ];

	networking.hostName = "ocbwoy3-pc";
	networking.networkmanager.enable = true;
	networking.resolvconf.enable = false;

}
