self: super:

{
  env-multimedia = super.pkgs.buildEnv {
    name = "env-multimedia";
    meta.priority = 0;
    paths = with super.pkgs;
      [ cmus ffmpeg mpv sox streamripper youtube-dl ]
      ++ lib.lists.optionals stdenv.isLinux [
        alsaLib
        alsaPluginWrapper
        alsaPlugins
        alsaTools
        alsaUtils
        beets
        fluidsynth
        gource
        soundfont-fluid
        opusTools
        pms
        pulseaudio
        youtube-viewer
      ];
  };
}
