{ pkgs, inputs, ... }:

{
  home.username = "kroma";
  home.homeDirectory = "/home/kroma";

  home.stateVersion = "26.05";


  ### PROGRAMS ###
  programs.home-manager.enable = true;

  programs.caelestia = {
    enable = true;
    cli.enable = true;
  };

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

      PROMPT='%F{4}%~%f''${vcs_info_msg_0_} %F{2}〉%f'
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


  ### PACKAGES ###
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
