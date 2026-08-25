local vars = require("vars")

hl.on("hyprland.start", function()
    -- environment / activation
    hl.exec_cmd("dbus-update-activation-environment --systemd --all")
    hl.exec_cmd("systemctl --user start hyprpolkitagent")

    -- Cursor
    hl.exec_cmd("hyprctl setcursor phinger-cursors-light 24")

    -- Keyring
    hl.exec_cmd("/run/current-system/sw/libexec/pam_kwallet_init")

    -- Apps
    hl.exec_cmd("uwsm app -- discord --start-minimized")
    hl.exec_cmd("uwsm app -- kdeconnect-indicator")

    -- Bluetooth media
    hl.exec_cmd("mpris-proxy")

    -- Shell de Caelestia
    hl.exec_cmd("uwsm app -- caelestia shell")
end)