{ pkgs, ... }:

let
  connectTheme = pkgs.stdenvNoCC.mkDerivation {
    pname = "plymouth-theme-connect";
    version = "unstable";

    src = pkgs.fetchFromGitHub {
      owner = "adi1090x";
      repo = "plymouth-themes";
      rev = "master";
      hash = "sha256-e3lRgIBzDkKcWEp5yyRCzQJM6yyTjYC5XmNUZZroDuw=";
    };

    installPhase = ''
      mkdir -p $out/share/plymouth/themes/connect
      cp -r pack_1/connect/. $out/share/plymouth/themes/connect/

      # Strip verbose status text: MessageCallback draws systemd boot messages
      # onscreen; blank it so only the theme's animation shows.
      substituteInPlace $out/share/plymouth/themes/connect/connect.script \
        --replace-fail \
          'fun MessageCallback(text) {' \
          'fun MessageCallback(text) {
    return;'

      # Theme ships with hardcoded FHS paths (/usr/share/...) that don't
      # exist on NixOS; plymouth silently falls back to the text "details"
      # plugin when it can't resolve them, which is what prints the OK lines.
      substituteInPlace $out/share/plymouth/themes/connect/connect.plymouth \
        --replace-fail \
          '/usr/share/plymouth/themes/connect' \
          "$out/share/plymouth/themes/connect"
    '';
  };
in
{
  boot.plymouth.enable = true;
  boot.plymouth.theme = "connect";
  boot.plymouth.themePackages = [ connectTheme ];
}
