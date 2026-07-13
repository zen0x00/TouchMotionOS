{ lib, ... }:

{
  # Getty autologin for debug shells on secondary VTs. Do not import on
  # hosts where cage owns tty1 unattended (live ISO) — the getty races
  # the cage service for the console.
  services.getty.autologinUser = lib.mkForce "tomoro";
}
