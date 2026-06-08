{ pkgs, ... }:

{
  home.username = "kroma";
  home.homeDirectory = "/home/kroma";

  home.stateVersion = "26.05";

  programs.home-manager.enable = true;
  programs.caelestia = {
    enable = true;
    cli.enable = true;
  };

  home.packages = with pkgs; [
    fastfetch

    kitty
    firefox
    obsidian

    wl-clipboard
    grim
    slurp

    pavucontrol
  ];
}
