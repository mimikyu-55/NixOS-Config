{ config, pkgs, ... }:
{
  programs.vscodium = {
    enable = true;
  };

  programs.git = {
    enable = true;

    settings = {
      user.name = "Oliver";
      user.email = "github.visibly545@passmail.com";

      init.defaultBranch = "main";
      pull.rebase = true;
    };
  };

  programs.waybar = {
    enable = true;
    systemd.enable = true;
  };
}
