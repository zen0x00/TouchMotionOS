{ lib, ... }:

{
  imports = [ ./quiet-boot.nix ];

  fileSystems."/" = {
    device = "/dev/vda1";
    fsType = "ext4";
  };

  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/vda";
  boot.loader.timeout = 0;

  boot.initrd.kernelModules = [ "virtio_gpu" ];

  virtualisation.vmVariant.virtualisation.qemu.options = [ "-vga none" "-device virtio-gpu-pci" ];
  # Serial console on the kernel cmdline makes plymouth force its text
  # "details" plugin on every display, so the graphical theme never loads.
  virtualisation.vmVariant.virtualisation.qemu.consoles = lib.mkForce [ "tty0" ];

  boot.plymouth.enable = true;

  system.stateVersion = "26.11";
}
