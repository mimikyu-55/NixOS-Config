-------------------
---- AUTOSTART ----
-------------------

hl.on("hyprland.start", function()
    hl.exec_cmd("hyprpaper")
    hl.exec_cmd("protonvpn-app")
    hl.exec_cmd("qs")
    hl.exec_cmd("discordptb --start-minimized")
    hl.exec_cmd("spotify")
end)
