{ pkgs, ... }:

let
  tomoroUpdate = pkgs.writeShellApplication {
    name = "tomoro-update";
    runtimeInputs = with pkgs; [
      util-linux
      e2fsprogs
      nix
      systemd
    ];
    text = ''
      if [ "$(id -u)" -ne 0 ]; then
        exec sudo "$0" "$@"
      fi

      usage() {
        echo "usage: tomoro-update <toplevel-store-path> [--reboot]" >&2
        echo "  <toplevel-store-path> must be the appliance system closure" >&2
        echo "  built for the INACTIVE slot (appliance-a or appliance-b)." >&2
        exit 1
      }

      closure="''${1:-}"
      [ -n "$closure" ] || usage
      [ -e "$closure/init" ] || { echo "not a system closure: $closure" >&2; exit 1; }

      # Which slot are we running from?
      rootdev=$(findmnt -no SOURCE /)
      current=$(lsblk -no LABEL "$rootdev")
      case "$current" in
        tomoro-a) target=b ;;
        tomoro-b) target=a ;;
        *) echo "unknown root label '$current'; not an A/B install" >&2; exit 1 ;;
      esac
      part="/dev/disk/by-label/tomoro-$target"
      [ -b "$part" ] || { echo "target partition $part not found" >&2; exit 1; }

      echo ">>> Active slot: $current — updating slot $target"

      echo ">>> Formatting slot $target"
      mkfs.ext4 -F -L "tomoro-$target" "$part"
      udevadm settle

      mnt=$(mktemp -d /run/tomoro-update.XXXXXX)
      trap 'umount -R "$mnt" 2>/dev/null || true; rmdir "$mnt" 2>/dev/null || true' EXIT
      mount "$part" "$mnt"

      echo ">>> Copying system closure to slot $target"
      nix copy --no-check-sigs --to "local?root=$mnt" "$closure"
      mkdir -p "$mnt/nix/var/nix/profiles" "$mnt/etc" "$mnt/data"
      nix-env --store "local?root=$mnt" \
        -p "$mnt/nix/var/nix/profiles/system" --set "$closure"
      touch "$mnt/etc/NIXOS"

      echo ">>> Writing boot entry for slot $target"
      espdir="/boot/EFI/tomoro-$target"
      mkdir -p "$espdir"
      cp -f "$closure/kernel" "$espdir/linux"
      cp -f "$closure/initrd" "$espdir/initrd"
      rm -f /boot/loader/entries/tomoro-"$target"*.conf
      # +3 boot counter: systemd-boot skips this entry after 3 failed boots
      # and falls back to the current slot's entries (Automatic Boot
      # Assessment; systemd-bless-boot marks it good once boot completes).
      {
        echo "title TOMORO OS (slot ''${target^^})"
        echo "version $(basename "$closure")"
        echo "linux /EFI/tomoro-$target/linux"
        echo "initrd /EFI/tomoro-$target/initrd"
        echo "options init=$closure/init $(cat "$closure/kernel-params")"
      } > "/boot/loader/entries/tomoro-$target+3.conf"

      bootctl set-default "tomoro-$target.conf"

      echo ">>> Slot $target ready; default boot entry switched."
      if [ "''${2:-}" = "--reboot" ]; then
        reboot
      else
        echo "Reboot to activate."
      fi
    '';
  };
in
{
  environment.systemPackages = [ tomoroUpdate ];

  # Automatic Boot Assessment: entries carry a boot counter; a slot that
  # fails to reach boot-complete.target 3 times is skipped and systemd-boot
  # falls back to the previous slot.
  boot.loader.systemd-boot.bootCounting.enable = true;
}
