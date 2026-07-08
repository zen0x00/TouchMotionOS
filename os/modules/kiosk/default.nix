{ pkgs, ... }:

let
  launcher = pkgs.callPackage ../../../launcher { };
in
{
  environment.systemPackages = [ launcher ];

  services.cage = {
    enable = true;
    user = "tomoro";
    program = "${launcher}/bin/tomoro_launcher";
  };
}
