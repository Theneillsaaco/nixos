{
  cursor.no_hardware_cursors = false;

  general = {
    resize_on_border = true;
    gaps_in = 6;
    gaps_out = 6;
    border_size = 2;
    layout = "master";
  };

  decoration = {
    active_opacity = 1.0;
    inactive_opacity = 1.0;
    rounding = 17;
    rounding_power = 2;
    shadow = {
      enabled = true;
      range = 15;
      render_power = 4;
    };

    blur = {
      enabled = true;
      size = 8;
      passes = 2;
      xray = false;
      ignore_opacity = true;
      new_optimizations = true;
      popups = true;
      input_methods = true;
    };
  };

  master = {
    new_status = "master";
    allow_small_split = true;
    mfact = 0.5;
  };

  misc = {
    vrr = 0;
    disable_hyprland_logo = true;
    disable_splash_rendering = true;
    focus_on_activate = true;
    middle_click_paste = false;
    force_default_wallpaper = 0;
    allow_session_lock_restore = true;
    animate_manual_resizes = false;
    animate_mouse_windowdragging = false;
    on_focus_under_fullscreen = 2;
    mouse_move_enables_dpms = true;
    key_press_enables_dpms = true;
  };

  binds.scroll_event_delay = 0;

  input = {
    kb_layout = "us";
    follow_mouse = 1;
    sensitivity = 0;
    repeat_delay = 300;
    repeat_rate = 50;
    focus_on_close = 1;
    touchpad = {
      natural_scroll = true;
      tap_to_click = true;
      drag_lock = false;
      scroll_factor = 0.3;
    };
  };

  debug.disable_logs = false;
}