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

  # "grub" or "lanzaboote" (see ./bootloader)
  bootloader.type = "lanzaboote";

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
    package = pkgs.millennium-steam;
    gamescopeSession.enable = true;
    extraCompatPackages = with pkgs; [
      proton-ge-bin
    ];
  };

  programs.gamemode.enable = true;
  programs.gamescope.enable = true;

  programs.zsh.enable = true;

  programs.appimage = {
    enable = true;
    binfmt = true;
  };

  programs.nix-ld.enable = true;
    programs.nix-ld.libraries = with pkgs; [
    xorg.libX11 xorg.libxcb wayland zlib util-linux.lib fontconfig fribidi freetype
    gtk3 webkitgtk_4_1 libsoup_3 openssl glib cairo pango gdk-pixbuf
    expat harfbuzz libgbm libdrm libgpg-error libGL gmp
    ];

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
    wireguard-tools
    proton-vpn
    unzip
    fastfetch
  ];

  networking.firewall.checkReversePath = false;  # for proton vpn

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
