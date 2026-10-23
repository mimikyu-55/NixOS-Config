{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
    ./bootloader
    ./nvidia
    ./audio
  ];

  # Networking
  networking.hostName = "nixos"; # Define your hostname.
  networking.networkmanager.enable = true;

  # TZ and Locale
  time.timeZone = "Europe/London";
  i18n.defaultLocale = "en_GB.UTF-8";
  i18n.supportedLocales = [
    "en_GB.UTF-8/UTF-8"
    "en_US.UTF-8/UTF-8"
  ];

  console = {
    font = null;
    keyMap = "uk";
  };

  # Bluetooth
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings.General.Experimental = true;
    settings.Policy.AutoEnable = true;
  };

  services.blueman.enable = true;

  # Also enables the default display manager (LightDM), so this is the login screen
  services.xserver.enable = true;

  programs.hyprland = {
    enable = true;
    withUWSM = true;
    xwayland.enable = true;
  };

  # Steam
  programs.steam = {
    enable = true;
    gamescopeSession.enable = true;
    extraCompatPackages = with pkgs; [
      proton-ge-bin
    ];
  };

  programs.gamemode.enable = true;
  programs.gamescope.enable = true;

  programs.zsh.enable = true;

  users.users.ollie = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "networkmanager"
    ];
    packages = with pkgs; [
      tree
    ];

    shell = pkgs.zsh;
  };

  security.polkit.enable = true;

  environment.systemPackages = with pkgs; [
    btop
    kitty
    rofi
    hyprpaper
    pcmanfm
    pulseaudio
  ];

  boot.kernelModules = [ "hid-playstation" ];
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Disable NVMe APST; DRAM-less Crucial P3 drives can freeze with it
  boot.kernelParams = [ "nvme_core.default_ps_max_latency_us=0" ];

  nixpkgs.config.allowUnfree = true;

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  nix.settings.auto-optimise-store = true;
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 14d";
  };

  system.stateVersion = "26.05"; # Did you read the comment?

}
