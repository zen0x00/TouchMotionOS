{ lib, ... }:

{
  boot.initrd.systemd.enable = true;

  boot.kernelParams = [
    "quiet"
    "splash"
    "loglevel=3"
    "udev.log_level=3"
    "rd.udev.log_level=3"
    "rd.systemd.show_status=false"
    "systemd.show_status=false"
    "vt.global_cursor_default=0"
    # Drop firmware ACPI boot logo (e.g. Intel NUC) so it can't override the
    # plymouth theme.
    "bgrt_disable"
  ];
  # mkDefault so NixOS VM tests (test-instrumentation sets 7) can override
  boot.consoleLogLevel = lib.mkDefault 0;
  boot.initrd.verbose = false;
}
