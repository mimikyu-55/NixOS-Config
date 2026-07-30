{ config, lib, pkgs, ... }:

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
        "en_GB.UTF-8/UTF-8" "en_US.UTF-8/UTF-8"
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

    programs.zsh.enable = true;
    environment.shells = [ pkgs.zsh ];

    users.users.ollie = {
        isNormalUser = true;
        extraGroups = [ "wheel" ];
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
    hyprland
    hyprpaper
    pcmanfm
    pulseaudio
    ];

    boot.kernelModules = [ "hid-playstation" ];

    nixpkgs.config.allowUnfree = true;  

    nix.settings.experimental-features = ["nix-command" "flakes"];

    system.stateVersion = "26.05"; # Did you read the comment?

}

