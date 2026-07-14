{ ... }:

{
  # Single-disk GPT A/B layout: ESP + two equal system slots + shared data.
  # Labels match the appliance config so the same system closure works
  # whether installed by disko or the legacy installer script. The installer
  # puts the initial system in slot A; OTA updates write the inactive slot
  # and flip the default boot entry. Target disk overridable at install time:
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
        slot-a = {
          size = "16G";
          content = {
            type = "filesystem";
            format = "ext4";
            extraArgs = [ "-L" "tomoro-a" ];
            mountpoint = "/";
          };
        };
        slot-b = {
          size = "16G";
          content = {
            type = "filesystem";
            format = "ext4";
            extraArgs = [ "-L" "tomoro-b" ];
          };
        };
        data = {
          size = "100%";
          content = {
            type = "filesystem";
            format = "ext4";
            extraArgs = [ "-L" "tomoro-data" ];
            mountpoint = "/data";
          };
        };
      };
    };
  };
}
