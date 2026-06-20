{ lib, ... }: 
let 
  inline = lib.generators.mkLuaInline;

  mkBind = { key, dispatcher, flags ? null }:
  {
    _args = [ (inline key) (inline dispatcher) ] ++ lib.optional (flags != null) flags;
  };
in 
{
  wayland.windowManager.hyprland = {
    submaps.global.settings.bind = [
      (mkBind {
        key = ''"Super_L"'';
        dispatcher = ''hl.dsp.global("caelestia:launcher")'';
        flags = { ignore_mods = true; };
      })

      (mkBind {
        key = ''"catchall"'';
        dispatcher = ''hl.dsp.global("caelestia:launcherInterrupt")'';
        flags = { ignore_mods = true; non_consuming = true; };
      })
      (mkBind { key = ''"Ctrl + Super_L"''; dispatcher = ''hl.dsp.global("caelestia:launcherInterrupt")''; })
      (mkBind { key = ''"Ctrl + Super_R"''; dispatcher = ''hl.dsp.global("caelestia:launcherInterrupt")''; })
      (mkBind { key = ''"Super + mouse:272"''; dispatcher = ''hl.dsp.global("caelestia:launcherInterrupt")''; })
      (mkBind { key = ''"Super + mouse:273"''; dispatcher = ''hl.dsp.global("caelestia:launcherInterrupt")''; })
      (mkBind { key = ''"Super + mouse:274"''; dispatcher = ''hl.dsp.global("caelestia:launcherInterrupt")''; })
      (mkBind { key = ''"Super + mouse:275"''; dispatcher = ''hl.dsp.global("caelestia:launcherInterrupt")''; })
      (mkBind { key = ''"Super + mouse:276"''; dispatcher = ''hl.dsp.global("caelestia:launcherInterrupt")''; })
      (mkBind { key = ''"Super + mouse:277"''; dispatcher = ''hl.dsp.global("caelestia:launcherInterrupt")''; })
      (mkBind { key = ''"Super + mouse_up"''; dispatcher = ''hl.dsp.global("caelestia:launcherInterrupt")''; })
      (mkBind { key = ''"Super + mouse_down"''; dispatcher = ''hl.dsp.global("caelestia:launcherInterrupt")''; })
    ];
  };
}