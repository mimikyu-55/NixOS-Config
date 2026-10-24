------------------
---- MONITORS ----
------------------

-- See https://wiki.hypr.land/Configuring/Basics/Monitors/
hl.monitor({
    output   = "DP-1",
    mode     = "1920x1080@180",
    position = "0x0",
    scale    = 1,
})
hl.monitor({
    output = "DP-3",
    mode = "1920x1080@180",
    position = "1920x0",
    scale = 1,
})

-- Shared with other modules (window rules)
return {
    left  = "DP-1",
    right = "DP-3",
}
