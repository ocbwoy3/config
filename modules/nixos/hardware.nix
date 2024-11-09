{ config, pkgs, ... }:

{

	hardware.bluetooth.enable = true;
	services.blueman.enable = true;
	
	hardware.bluetooth.settings = {
		General = {
			Experimental = true;
			ControllerMode = "bredr";
		};
	};

	hardware.enableAllFirmware = true;

	security.rtkit.enable = true;

	services.pipewire = {
		enable = true;
		alsa.enable = true;
		alsa.support32Bit = true;
		pulse.enable = true;
	};

}
