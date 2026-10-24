-- Hyprland config entry point.
-- Each section lives in its own module under config/.
-- Refer to https://wiki.hypr.land/Configuring/Start/ for more information.

-- Hyprland resolves this file to its real (Nix store) path, so point
-- require at ~/.config/hypr explicitly.
package.path = os.getenv("HOME") .. "/.config/hypr/?.lua;" .. package.path

require("config.monitors")
require("config.programs")
require("config.autostart")
require("config.env")
require("config.permissions")
require("config.appearance")
require("config.animations")
require("config.layouts")
require("config.misc")
require("config.input")
require("config.keybinds")
require("config.media_keys")
require("config.window_rules")
