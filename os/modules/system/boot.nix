{ lib, ... }:

{
  fileSystems."/" = {
    device = "/dev/vda1";
    fsType = "ext4";
  };

  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/vda";
  boot.loader.timeout = 0;

  boot.initrd.systemd.enable = true;
  boot.initrd.kernelModules = [ "virtio_gpu" ];

  virtualisation.vmVariant.virtualisation.qemu.options = [ "-vga none" "-device virtio-gpu-pci" ];
  # Serial console on the kernel cmdline makes plymouth force its text
  # "details" plugin on every display, so the graphical theme never loads.
  virtualisation.vmVariant.virtualisation.qemu.consoles = lib.mkForce [ "tty0" ];

  boot.plymouth.enable = true;
  boot.kernelParams = [
    "quiet"
    "splash"
    "loglevel=3"
    "udev.log_level=3"
    "rd.udev.log_level=3"
    "rd.systemd.show_status=false"
    "systemd.show_status=false"
    "vt.global_cursor_default=0"
  ];
  boot.consoleLogLevel = 0;
  boot.initrd.verbose = false;

  system.stateVersion = "26.11";
}
