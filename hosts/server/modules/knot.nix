{ config, pkgs, lib, ... }:

{
	services.tangled-knot = {
		enable = true;
		server = {
			listenAddr = "0.0.0.0:3003";
			secretFile = "/private/tangled.env";
			hostname = "knot.ocbwoy3.dev";
		};
	};
}
