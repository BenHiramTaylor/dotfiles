{ pkgs, ... }:
{
  nixpkgs.config.allowUnfree = true;

  # Home manager configs
  home = {
    username = "bentaylor";
    homeDirectory = "/home/bentaylor";

    # Packages that should be installed to the user profile
    packages = with pkgs; [
      # Development
      ## IDEs
      vscode
      jetbrains.rust-rover
      jetbrains.goland
      jetbrains.pycharm-professional

      # Python
      python311
      pyenv

      # Go
      go
      goreleaser

      # Rust
      rustup

      # Nix specific tools
      nil # Nix language server
      statix # Linter
      deadnix # Find dead code

      # DevOps
      talosctl
      k9s
      zellij
      alacritty

      # System monitoring
      btop
      fastfetch

      # Browsers
      firefox
      brave

      # Communication
      discord

      # Shell utilities
      starship
      eza
      watch

      # Applications
      _1password-gui
      dbeaver-bin
      spotify
      vlc
    ];

    # State version
    stateVersion = "24.11";
  };

  # XDG
  xdg = {
    enable = true;
    configFile = {
      "k9s".source = ./k9s;
      "btop".source = ./btop;
      "starship.toml".source = ./starship/starship.toml; # Changed this line
      "alacritty".source = ./alacritty;
      "zellij".source = ./zellij;
    };
    dataFile = {
      "konsole".source = ./konsole;
    };
  };

  # Program configurations
  programs = {
    home-manager = {
      enable = true;
    };

    # Git configuration
    git = {
      enable = true;
      userName = "Ben Taylor";
      userEmail = "63203762+BenHiramTaylor@users.noreply.github.com";
    };

    # Starship configuration
    starship = {
      enable = true;
      enableZshIntegration = true;
    };

    # ZSH configuration
    zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;

      history = {
        size = 5000;
        save = 5000;
        path = "$HOME/.zsh_history";
        ignoreDups = true;
        share = true;
        extended = true;
      };

      shellAliases = {
        ls = "eza -la";
        c = "clear";
      };

      initExtra = ''
        # FZF Catppuccin Theme
        export FZF_DEFAULT_OPTS=" \
        --color=bg+:#414559,bg:#303446,spinner:#f2d5cf,hl:#e78284 \
        --color=fg:#c6d0f5,header:#e78284,info:#ca9ee6,pointer:#f2d5cf \
        --color=marker:#f2d5cf,fg+:#c6d0f5,prompt:#ca9ee6,hl+:#e78284"

        # Keybindings
        bindkey -e
        bindkey '\e[A' history-search-backward # Mac Up Key
        bindkey '^p' history-search-backward # Linux Up Key
        bindkey '\e[B' history-search-forward # Mac Down Key
        bindkey '^n' history-search-forward # Mac Down Key
        bindkey '^[w' kill-region

        # Completion styling
        zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
        zstyle ':completion:*' list-colors ''${(s.:.)LS_COLORS}
        zstyle ':completion:*' menu no
        zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
        zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

        # Load starship prompt
        eval "$(starship init zsh)"
      '';
    };

    # Zoxide & FZF configuration
    fzf = {
      enable = true;
      enableZshIntegration = true;
    };

    zoxide = {
      enable = true;
      enableZshIntegration = true;
      options = [ "--cmd cd" ];
    };
  };
}
