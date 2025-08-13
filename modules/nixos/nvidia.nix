{ config, pkgs, lib, ... }:

{

	# options nvidia NVreg_PreserveVideoMemoryAllocations=1
	boot.extraModprobeConfig = ''
		options nvidia_drm modeset=1 fbdev=1
	'';

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
		MOZ_ENABLE_WAYLAND = "1"; # Enable Wayland for Firefox
		CHROMIUM_FLAGS = "--enable-features=UseOzonePlatform --ozone-platform=wayland --enable-gpu-rasterization --enable-zero-copy"; # Enable Wayland and hardware acceleration for Chromium
	};

	environment.sessionVariables = {
		NIXOS_OZONE_WL = 1;
		LIBVA_DRIVER_NAME = "nvidia";
		GBM_BACKEND = "nvidia-drm";
		__GLX_VENDOR_LIBRARY_NAME = "nvidia";
		NVD_BACKEND = "direct";
		EGL_PLATFORM = "wayland";
	};

	# obs moment
	# nixpkgs.config.cudaSupport = true;

	hardware.graphics = { # hardware.graphics since NixOS 24.11
		enable = true;
		# driSupport = true;
		extraPackages = with pkgs; [
			nvidia-vaapi-driver
			libvdpau-va-gl
			vaapiVdpau
			libvdpau
		];
	};

	hardware.nvidia = {
		modesetting.enable = true;
		powerManagement.enable = false;
		powerManagement.finegrained = false;
		open = true;
		nvidiaSettings = true;
		package = config.boot.kernelPackages.nvidiaPackages.beta;
	};

	boot.kernelModules = [ "nvidia-uvm" "nvidia-drm" ];
	boot.blacklistedKernelModules = [ "nouveau" ];

	boot.kernelParams = [ "nvidia-drm.modeset=1" "nvidia-drm.fbdev=1" ];

	services.xserver.videoDrivers = ["nvidia"];

}
