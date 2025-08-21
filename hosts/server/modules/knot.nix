{ config, pkgs, lib, ... }:

{
	services.tangled-knot = {
		enable = true;
		listenAddr = "0.0.0.0:3003";
		dataDir = "/var/lib/knot";
		secretFile = "/private/tangled.env";
		hostname = "knot.ocbwoy3.dev";
	};
}
