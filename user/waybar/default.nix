{ pkgs, ... }:
{
  programs.waybar.settings = builtins.fromJSON (builtins.readFile ./config.json);
  programs.waybar.style = builtins.readFile ./style.css;

  # The bar has its own Bluetooth module, so stop blueman-applet adding a second tray icon
  xdg.configFile."autostart/blueman.desktop".text = ''
    [Desktop Entry]
    Hidden=true
  '';

  # Icons in the bar come from a Nerd Font
  home.packages = [ pkgs.nerd-fonts.jetbrains-mono ];
  fonts.fontconfig.enable = true;
}
