{ pkgs, ... }:

{
  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;

    # Install custom profile-set in the correct directory
    configPackages = [
      (pkgs.writeTextDir "share/alsa-card-profile/steelseries.conf" ''
        [ProfileSet]

        [Profile "steelseries"]
        description = "SteelSeries GameDAC / Arctis Pro"
        priority = 10

        devices = [
          "output:usb:SteelSeries_SteelSeries_GameDAC_000000000000-00:0",
          "output:usb:SteelSeries_SteelSeries_GameDAC_000000000000-00:1",
          "input:usb:SteelSeries_SteelSeries_GameDAC_000000000000-00:2"
        ]
      '')
    ];

    # IMPORTANT:
    # Do NOT manually load libpipewire-module-alsa-card.
    # WirePlumber handles card discovery automatically.
    #
    # So we REMOVE the entire extraConfig.pipewire."99-steelseries" block.
  };

  # WirePlumber ACP override (safe + stable)
  services.pipewire.wireplumber.extraConfig."10-steelseries-disable-acp" = {
    "monitor.alsa.rules" = [
      {
        matches = [
          # This match is stable across PipeWire versions
          { "api.alsa.card.name" = "SteelSeries GameDAC"; }
        ];
        actions.update-props = {
          "api.alsa.use-acp" = false;
        };
      }
    ];
  };
}
