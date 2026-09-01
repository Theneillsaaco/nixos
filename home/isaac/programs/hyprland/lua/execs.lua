local vars = require("vars")
local kwallet_path = require("kwallet_path")

hl.on("hyprland.start", function()
    -- environment / activation
    hl.exec_cmd("dbus-update-activation-environment --systemd --all WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
    hl.exec_cmd("systemctl --user start hyprpolkitagent")

    -- Keyring: Invocar el binario dentro del mismo subshell pasando la variable
    local cmd = string.format("sh -c 'export PAM_KWALLET6_LOGIN=\"${PAM_KWALLET6_LOGIN:-$PAM_KWALLET5_LOGIN}\"; %s'", pam_kwallet_path)
    hl.exec_cmd(cmd)
    hl.exec_cmd("uwsm app -- kwalletd6")
        
    -- Apps
    hl.exec_cmd("uwsm app -- discord --start-minimized")
    hl.exec_cmd("uwsm app -- kdeconnect-indicator")

    -- Cursor
    hl.exec_cmd("hyprctl setcursor phinger-cursors-light 24")

    -- Bluetooth media
    hl.exec_cmd("mpris-proxy")

    -- Shell de Caelestia
    hl.exec_cmd("pkill caelestia; uwsm app -- caelestia shell")
end)

hl.on("hyprland.shutdown", function()
    hl.exec_cmd("pkill -9 caelestia")
    hl.exec_cmd("pkill -9 quickshell")
end)
