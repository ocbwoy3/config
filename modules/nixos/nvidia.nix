{ config, pkgs, ... }:

{

	boot.extraModprobeConfig = ''options nvidia_drm modeset=1 fbdev=1'';

	environment.variables = {
		LIBVA_DRIVER_NAME = "nvidia";
		GBM_BACKEND = "nvidia-drm";
		__GLX_VENDOR_LIBRARY_NAME = "nvidia";
		NVD_BACKEND = "direct";
		EGL_PLATFORM = "wayland";
	};

	hardware.graphics = {
		enable = true;

		extraPackages = with pkgs; [
			intel-media-driver
			vaapiIntel
			vaapiVdpau
			libvdpau-va-gl
		];
	};

	environment.sessionVariables.NIXOS_OZONE_WL = "1";

	hardware.nvidia = {
		modesetting.enable = true;
		powerManagement.enable = false;
		powerManagement.finegrained = false;
		open = false;
		package = config.boot.kernelPackages.nvidiaPackages.latest;
	};

	services.xserver.enable = true;
	services.xserver.videoDrivers = ["nvidia"];

}
