{ rustPlatform }:

rustPlatform.buildRustPackage {
  pname = "tomoro-platform";
  version = "0.1.0";

  src = ./.;
  cargoLock.lockFile = ./Cargo.lock;

  meta.description = "TOMORO platform binaries (tomoro-net network detection)";
}
