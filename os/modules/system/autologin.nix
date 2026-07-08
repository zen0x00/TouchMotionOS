{ ... }:

{
  users.users.tomoro = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
  };

  services.getty.autologinUser = "tomoro";
}
