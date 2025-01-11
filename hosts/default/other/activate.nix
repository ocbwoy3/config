{ config, inputs, pkgs, lib, ... }:

{

	system.nixos = {
		distroName = "OCbwoy3";
		extraOSReleaseArgs = {
			HOME_URL="https://ocbwoy3.dev/";
			VERSION_CODENAME="";
			NAME="OCbwoy3";
			PRETTY_NAME="OCbwoy3";
		};
	};

	system.activationScripts.installRoblox = {
		text = ''
			trap "${pkgs.flatpak}/bin/flatpak install -y https://sober.vinegarhq.org/sober.flatpakref" EXIT
		'';
	};

}
