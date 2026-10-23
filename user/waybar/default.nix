{ pkgs, ... }:
{
  programs.waybar.settings = builtins.fromJSON (builtins.readFile ./config.json);
  programs.waybar.style = builtins.readFile ./style.css;

  # Icons in the bar come from a Nerd Font
  home.packages = [ pkgs.nerd-fonts.jetbrains-mono ];
  fonts.fontconfig.enable = true;
}
