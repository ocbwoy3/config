{ config, inputs, pkgs, lib, ... }:

{

	system.activationScripts.installRoblox = {
		text = ''
			${pkgs.flatpak}/bin/flatpak install https://sober.vinegarhq.org/sober.flatpakref
		'';
	};


}
