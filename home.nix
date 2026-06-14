{ pkgs, inputs, ... }:

{
  home.username = "kroma";
  home.homeDirectory = "/home/kroma";

  home.stateVersion = "26.05";

  programs.home-manager.enable = true;
  programs.caelestia = {
    enable = true;
    cli.enable = true;
  };
  programs.zsh = {
    enable = true;
  };
  programs.spicetify =
    let
      spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
    in {
      enable = true;
      enabledExtensions = with spicePkgs.extensions; [
        adblockify
        hidePodcasts
        shuffle
      ];
      theme = spicePkgs.themes.catppuccin;
      colorScheme = "mocha";
    };

  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    fastfetch

    kitty       # terminal
    firefox     # web browser
    obsidian    # notetaking
    vscodium    # code editor
    xfce.thunar # file browser
    libreoffice # doc editor suite
    lunar-client # Minecraft :)

    app2unit

    wl-clipboard
    grim
    slurp

    pavucontrol	# audio controls 
    nomacs	# media viewer

    # Cyber
    bind	# nslookup, etc.
  ];
}
