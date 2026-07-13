{ ... }:

{
  # Single-disk GPT layout: ESP + root. Labels match the appliance config so
  # the same system closure works whether installed by disko or the legacy
  # installer script. Target disk overridable at install time:
  #   nixos-anywhere --disko-arg disk /dev/nvme0n1 ...
  disko.devices.disk.main = {
    type = "disk";
    device = "/dev/sda";
    content = {
      type = "gpt";
      partitions = {
        esp = {
          size = "512M";
          type = "EF00";
          content = {
            type = "filesystem";
            format = "vfat";
            extraArgs = [ "-n" "TOMORO-ESP" ];
            mountpoint = "/boot";
            mountOptions = [ "umask=0077" ];
          };
        };
        root = {
          size = "100%";
          content = {
            type = "filesystem";
            format = "ext4";
            extraArgs = [ "-L" "tomoro-root" ];
            mountpoint = "/";
          };
        };
      };
    };
  };
}
