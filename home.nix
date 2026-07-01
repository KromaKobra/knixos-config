{ pkgs, inputs, ... }:

{
  home.username = "kroma";
  home.homeDirectory = "/home/kroma";

  home.stateVersion = "26.05";

  # Dark mode fix on thunar I think
  gtk = {
    enable = true;
    theme = {
      name = "adw-gtk3-dark";
      package = pkgs.adw-gtk3;
    };
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = true;
    };
    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = true;
    };
  };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
  };
  # Dark mode fix END


  ### PROGRAMS ###
  programs.home-manager.enable = true;

  programs.caelestia = {
    enable = true;
    cli.enable = true;
  };

  programs.fish.enable = true;

  programs.zsh = {
    enable = true;
    oh-my-zsh = {
      enable = true;
      theme = "";
      plugins = [
        "git"
        "sudo"
        "zsh-autosuggestions"
        "zsh-syntax-highlighting"
      ];
    };
    plugins = [
      {
        name = "zsh-autosuggestions";
        src = pkgs.zsh-autosuggestions;
      }
      {
        name = "zsh-syntax-highlighting";
        src = pkgs.zsh-syntax-highlighting;
      }
    ];
    initExtra = ''
      # --- Fancy launch screen ---
      if [[ -o interactive ]] && [[ -z "$FASTFETCH_SHOWN" ]]; then
        export FASTFETCH_SHOWN=1
        fastfetch
      fi

      # --- Custom minimal prompt: path + git branch ---
      autoload -Uz vcs_info
      precmd_vcs_info() { vcs_info }
      precmd_functions+=( precmd_vcs_info )

      setopt PROMPT_SUBST
      zstyle ':vcs_info:git:*' formats ' %F{3}(%b)%f'
      zstyle ':vcs_info:*' enable git

      PROMPT='%F{4}%~%f''${vcs_info_msg_0_} %F{2}❯ %f'
    '';
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

  programs.zen-browser = {
    enable = true;
    setAsDefaultBrowser = true;
  };


  ### CURSOR ### # Later switch to using hyprcursor which just renders local svg icons
  home.pointerCursor = {
    gtk.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Ice";
    size = 24;
  };


  ### PACKAGES ###
  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    quickshell

    kitty       # terminal
    firefox     # web browser
    obsidian    # notetaking
    vscodium    # code editor
    claude-code	# ai client
    thunar 	# file browser
    inkscape	# svg editor
    libreoffice # doc editor suite
    vesktop	# discord client
    lunar-client # minecraft :)

    fastfetch
    app2unit

    material-symbols
    jetbrains-mono
    nerd-fonts.jetbrains-mono

    wl-clipboard
    grim
    slurp
    jq
    unzip

    pavucontrol	# audio controls 
    nomacs	# media viewer

    # Cyber
    bind	# nslookup, etc.
  ];
}
