self: super:

{
  env-multimedia = super.pkgs.buildEnv {
    name = "env-multimedia";
    meta.priority = 0;
    paths = with super.pkgs;
      [ cmus ffmpeg mpv sox streamripper youtube-dl ]
      ++ lib.optional stdenv.isLinux [
        alsaLib
        alsaPluginWrapper
        alsaPlugins
        alsaTools
        alsaUtils
        beets
        fluidsynth
        soundfont-fluid
        opusTools
        pms
        pulseaudio
        youtube-viewer
      ];
  };
}
