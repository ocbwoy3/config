{ config, pkgs, ... }:

{

	boot.extraModprobeConfig = ''options nvidia_drm modeset=1 fbdev=1'';

	environment.variables = {
		LIBVA_DRIVER_NAME = "nvidia";
		GBM_BACKEND = "nvidia-drm";
		__GLX_VENDOR_LIBRARY_NAME = "nvidia";
		NVD_BACKEND = "direct";
		EGL_PLATFORM = "wayland";
		VDPAU_DRIVER = "va_gl";
		WAYLAND_DISPLAY = "wayland-1";
		DISPLAY = ":0";
		XDG_CURRENT_DESKTOP = "Hyprland";
	};

	environment.sessionVariables = {
		NIXOS_OZONE_WL = 1;
		LIBVA_DRIVER_NAME = "nvidia";
		GBM_BACKEND = "nvidia-drm";
		__GLX_VENDOR_LIBRARY_NAME = "nvidia";
		NVD_BACKEND = "direct";
		EGL_PLATFORM = "wayland";
	};

	hardware.graphics = {
		enable = true;
		# driSupport = true;
		# driSupport32bit = true;
		extraPackages = with pkgs; [
			intel-media-driver
			intel-vaapi-driver
			libvdpau-va-gl
			vulkan-validation-layers
		];
	};

	# environment.variables.VDPAU_DRIVER = "va_gl";
	# environment.variables.LIBVA_DRIVER_NAME = "nvidia";

	hardware.nvidia = {
		modesetting.enable = true;
		powerManagement.enable = false;
		powerManagement.finegrained = false;
		open = false;
		nvidiaSettings = true;
		# prime = {
		# 	offload = {
		# 		enable = true;
		# 		enableOffloadCmd = true;
		# 	};
		# 	intelBusId = "PCI:0:2:0";
		# 	nvidiaBusId = "PCI:1:0:0";
		# };
		package = config.boot.kernelPackages.nvidiaPackages.stable;
	};

	services.xserver.enable = true;
	services.xserver.videoDrivers = ["nvidia"];

}
