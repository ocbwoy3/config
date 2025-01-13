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
		wireplumber = {
			enable = true;
			configPackages = [
				(pkgs.writeTextDir "share/wireplumber/wireplumber.conf.d/51-mitigate-annoying-profile-switch.conf" ''
					wireplumber.settings = {
						bluetooth.autoswitch-to-headset-profile = false
					}
					
					monitor.bluez.properties = {
						bluez5.roles = [ a2dp_sink a2dp_source ]
					}
        		'')
			];
		};
	};

	system.stateVersion = "24.11";

}
