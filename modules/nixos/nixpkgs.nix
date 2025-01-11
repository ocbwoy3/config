{ config, pkgs, ... }:

{

	nixpkgs.config.allowUnfree = true;
	nixpkgs.config.packageOverrides = pkgs: {
		vaapiIntel = pkgs.vaapiIntel.override { enableHybridCodec = true; };
	};

	nix.settings.experimental-features = [ "nix-command" "flakes" ];

	nix.settings = {
		substituters = [
			"https://hyprland.cachix.org"
			"https://ghostty.cachix.org"
			"https://hyprpanel.cachix.org"
		];
		trusted-public-keys = [
			"hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
			"ghostty.cachix.org-1:QB389yTa6gTyneehvqG58y0WnHjQOqgnA+wBnpWWxns="
			"hyprpanel.cachix.org-1:tYDZEqAUAqgIz+zYwJ5+v5J62AnYqA/WEXv4VHA/XRs="
		];
	};

}
