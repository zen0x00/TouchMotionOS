{ pkgs, ... }:

let
  launcher = pkgs.callPackage ../../../launcher { };
  platform = pkgs.callPackage ../../../platform { };
  dashlands = pkgs.callPackage ../../../games/dashlands { };
in
{
  # iw: tomoro-net shells out to it for the connected SSID.
  # wpa_supplicant: provides wpa_cli, which tomoro-net drives for
  # wifi scan/connect from the settings screen.
  environment.systemPackages = [ launcher platform dashlands pkgs.iw pkgs.wpa_supplicant ];

  # Wifi managed by wpa_supplicant; userControlled exposes the control
  # socket to the "users" group so the launcher (running as tomoro) can
  # scan and join networks, and lets save_config persist them.
  networking.wireless = {
    enable = true;
    userControlled = {
      enable = true;
      group = "users";
    };
    allowAuxiliaryImperativeNetworks = true;
  };

  # wlroots (cage) needs a GL/EGL stack; without this it dies on real
  # hardware before the launcher ever starts.
  hardware.graphics.enable = true;

  users.users.tomoro = {
    isNormalUser = true;
    # wpa_supplicant runs as its own user; control sockets in
    # /run/wpa_supplicant are group wpa_supplicant, so the launcher
    # needs membership to scan/join wifi via wpa_cli.
    extraGroups = [ "wpa_supplicant" ];
  };

  services.cage = {
    enable = true;
    user = "tomoro";
    program = "${launcher}/bin/tomoro_launcher";
  };
}
