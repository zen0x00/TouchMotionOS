{ lib, modulesPath, ... }:

{
  imports = [
    "${modulesPath}/installer/cd-dvd/installation-cd-minimal.nix"
    ../../../modules/system/quiet-boot.nix
    ../../../modules/system/plymouth-theme.nix
    ../../../modules/kiosk
  ];

  image.fileName = lib.mkForce "tomoro-live.iso";
  isoImage.squashfsCompression = "zstd -Xcompression-level 6";

  # Early KMS so plymouth and cage get a DRM device on real hardware.
  boot.initrd.availableKernelModules = [ "virtio_gpu" ];
  boot.initrd.kernelModules = [ "nvidia" "nvidia_modeset" "nvidia_uvm" "nvidia_drm" ];

  # RTX 4050 (Ada) — proprietary userspace with the open kernel module.
  # Nouveau is not usable on this generation.
  nixpkgs.config.allowUnfree = true;
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia = {
    modesetting.enable = true;
    open = true;
  };

  networking.hostName = "tomoro-live";

  # Skip onboarding on live ISO — marker file would be lost on every reboot
  # anyway (squashfs root), so pre-seed it into the image via activation.
  system.activationScripts.tomoroSkipOnboarding = ''
    install -d -m 755 -o tomoro -g users /home/tomoro/.local/share/tomoro
    touch /home/tomoro/.local/share/tomoro/onboarding_done
    chown tomoro:users /home/tomoro/.local/share/tomoro/onboarding_done
  '';
}
