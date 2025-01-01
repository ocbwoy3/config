{ config, inputs, pkgs, lib, ... }:

{

	system.activationScripts.installRoblox = {
		text = ''
			flatpak install https://sober.vinegarhq.org/sober.flatpakref
		'';
	};


}
