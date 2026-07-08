{ lib, flutter, ... }:

flutter.buildFlutterApplication {
  pname = "tomoro-launcher";
  version = "0.1.0";

  src = lib.cleanSource ./.;

  pubspecLock = lib.importJSON ./pubspec.lock.json;

  meta = {
    description = "TOMORO launcher UI";
    mainProgram = "tomoro_launcher";
    platforms = lib.platforms.linux;
  };
}
