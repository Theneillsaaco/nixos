{
  programs.foot = {
    enable = true;
    settings = {
      main = {
        title = "foot";
        font = "JetBrainsMono Nerd Font:size=13";
        letter-spacing = 0;
        pad = "25x25";
        bold-text-in-bright = "no";
        gamma-correct-blending = "no";
      };

      tweak = {
        font-monospace-warn = "no";
      };

      scrollback = {
        lines = 10000;
      };

      cursor = {
        style = "beam";
        beam-thickness = "1.5";
      };

      colors-dark = {
        alpha = 0.78;
        alpha-mode = "matching";
        blur = "yes";
      };
    };
  };
}
