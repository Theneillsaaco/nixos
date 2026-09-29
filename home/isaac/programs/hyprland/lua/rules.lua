local function tag(name, field, list)
    for _, m in ipairs(list) do
        hl.window_rule({ match = { [field] = m }, tag = "+" .. name })
    end
end

-- Opacidad global (excepto fullscreen) y centrado de flotantes
hl.window_rule({ match = { fullscreen = false }, opacity = "0.95 override" })
hl.window_rule({ match = { float = true, xwayland = false }, center = true })

-- Picture in picture (Zen/Firefox)
hl.window_rule({
    match = { title = "Picture(-| )in(-| )[Pp]icture" },
    move = "(monitor_w*0.98-window_w) (monitor_h*0.97-window_h)",
    pin = true, float = true, keep_aspect_ratio = true,
})

-- Tags
tag("opaque", "class", {
    "foot", "discord", "org.quickshell",
    "feh|imv|swappy", "krita|gimp|inkscape", "blender|godot",
})
tag("float", "class", { "blueman-manager", "org.quickshell", "yad|zenity", "wev" })
tag("float", "title", { "File (Operation|Upload)( Progress)?", ".* Properties", 'Rename ".*"' })
tag("float_60_70", "title", { "(Select|Open)( a)? (File|Folder)(s)?", "Save As" })
tag("float_60_70", "class", { "org.pulseaudio.pavucontrol|com.saivert.pwvucontrol" })
tag("game", "class", { "steam_app_[0-9]+", "steam_app_default", "gamescope" })
tag("xwl_popup", "title", { "win[0-9]+" })
tag("music", "class", { "com.github.th[-_]ch.youtube[-_]music" })  -- verifica con `hyprctl clients`
tag("comms", "class", { "discord" })

-- Definiciones (van DESPUÉS de todos los usos)
hl.window_rule({ match = { tag = "opaque" }, opaque = true })
hl.window_rule({ match = { tag = "float" }, float = true })
hl.window_rule({ match = { tag = "float_60_70" }, float = true, size = "(monitor_w*0.6) (monitor_h*0.7)", center = true })
hl.window_rule({ match = { tag = "game" }, opaque = true, immediate = true, idle_inhibit = "always" })
hl.window_rule({ match = { tag = "xwl_popup" }, no_dim = true, no_shadow = true, no_blur = true, opaque = true, rounding = 10 })
hl.window_rule({ match = { tag = "music" }, workspace = "special:music" })
hl.window_rule({ match = { tag = "comms" }, workspace = "special:communication" })

-- Gaps mayores con una sola ventana
hl.workspace_rule({ workspace = "w[tv1]s[false]", gaps_out = 20 })
hl.workspace_rule({ workspace = "f[1]s[false]", gaps_out = 20 })

-- Layer rules
hl.layer_rule({ match = { namespace = "hyprpicker" }, animation = "fade" })
hl.layer_rule({ match = { namespace = "selection" }, animation = "fade" })
hl.layer_rule({ match = { namespace = "caelestia-(border-exclusion|area-picker)" }, no_anim = true })
hl.layer_rule({ match = { namespace = "caelestia-(drawers|background)" }, animation = "fade" })
hl.layer_rule({ match = { namespace = "launcher" }, animation = "popin 80%", blur = true })