{ config, pkgs, ... }:

{

	nixpkgs.config.allowUnfree = true;
	nixpkgs.config.packageOverrides = pkgs: {
		vaapiIntel = pkgs.vaapiIntel.override { enableHybridCodec = true; };
	};

	nix.settings.experimental-features = [ "nix-command" "flakes" ];

}
