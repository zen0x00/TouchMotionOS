{ stdenv
, autoPatchelfHook
, makeWrapper
, alsa-lib
, libglvnd
, libpulseaudio
, udev
, vulkan-loader
, libx11
, libxcursor
, libxext
, libxi
, libxinerama
, libxrandr
, libxrender
, zlib
}:

stdenv.mkDerivation {
  pname = "tomoro-dashlands";
  version = "0.1.0";

  # Game blobs are gitignored (temporary setup), so flake filtering hides
  # ./game; read it straight off disk instead. Requires building with
  # --impure and the files present at this path.
  src = /home/aman/Repos/TouchMotionOS/games/dashlands/game;

  nativeBuildInputs = [ autoPatchelfHook makeWrapper ];

  buildInputs = [
    stdenv.cc.cc.lib
    alsa-lib
    libglvnd
    libpulseaudio
    libx11
    libxcursor
    libxext
    libxi
    libxinerama
    libxrandr
    libxrender
    zlib
  ];

  # Unity dlopens these at runtime, so autoPatchelf can't discover them
  # from ELF headers; they end up on the wrapper's RUNPATH instead.
  runtimeDependencies = [ libglvnd libpulseaudio udev vulkan-loader ];

  installPhase = ''
    runHook preInstall

    mkdir -p $out/opt/dashlands $out/bin
    cp -r Dashlands_Data UnityPlayer.so Dashlands.x86_64 $out/opt/dashlands/
    chmod +x $out/opt/dashlands/Dashlands.x86_64

    # Unity resolves Dashlands_Data relative to the cwd.
    makeWrapper $out/opt/dashlands/Dashlands.x86_64 $out/bin/tomoro-dashlands \
      --chdir $out/opt/dashlands

    runHook postInstall
  '';

  meta.description = "Dashlands (Unity) for TOMORO";
}
