{ ... }:

{
  imports = [
    ./hardware.nix
    ./disko.nix
    ../../modules/system/quiet-boot.nix
    ../../modules/system/plymouth-theme.nix
    ../../modules/system/autologin.nix
    ../../modules/kiosk
    ../../modules/system/debug-ssh.nix
  ];

  # Filesystems by label — both disko and the legacy installer script format
  # the disk with these labels, so this config works on any target disk
  # (sda/nvme/...). disko.enableConfig=false keeps disko as format-only;
  # these label-based mounts stay the single source of truth.
  disko.enableConfig = false;
  fileSystems."/" = {
    device = "/dev/disk/by-label/tomoro-root";
    fsType = "ext4";
  };
  fileSystems."/boot" = {
    device = "/dev/disk/by-label/TOMORO-ESP";
    fsType = "vfat";
  };

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.timeout = 0;

  networking.networkmanager.enable = true;

  system.stateVersion = "26.11";
}
