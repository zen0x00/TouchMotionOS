{ pkgs, ... }:

let
  launcher = pkgs.callPackage ../../../launcher { };
in
{
  environment.systemPackages = [ launcher ];

  # wlroots (cage) needs a GL/EGL stack; without this it dies on real
  # hardware before the launcher ever starts.
  hardware.graphics.enable = true;

  users.users.tomoro = {
    isNormalUser = true;
  };

  services.cage = {
    enable = true;
    user = "tomoro";
    program = "${launcher}/bin/tomoro_launcher";
  };
}
