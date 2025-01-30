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
      fzf
      zsh-fzf-tab
      zoxide

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

        # Zinit installation and setup
        ZINIT_HOME="''${XDG_DATA_HOME:-''${HOME}/.local/share}/zinit/zinit.git"
        [ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
        [ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
        source "''${ZINIT_HOME}/zinit.zsh"

        # Zinit plugins
        zinit light zsh-users/zsh-syntax-highlighting
        zinit light zsh-users/zsh-completions
        zinit light zsh-users/zsh-autosuggestions
        zinit light Aloxaf/fzf-tab
        zinit snippet OMZP::command-not-found
        # Load completions
        autoload -Uz compinit && compinit

        zinit cdreplay -q

        # Enhanced keybindings
        bindkey -e
        bindkey '\e[A' history-search-backward
        bindkey '^p' history-search-backward
        bindkey '\e[B' history-search-forward
        bindkey '^n' history-search-forward
        bindkey '^[w' kill-region

        # FZF-tab styling
        zstyle ':completion:*:descriptions' format '[%d]'
        zstyle ':completion:*' list-colors ''${(s.:.)LS_COLORS}
        zstyle ':completion:*' menu no
        zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

        # FZF-tab preview configuration
        zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'eza -1 --color=always $realpath'
        zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'
        zstyle ':fzf-tab:complete:ls:*' fzf-preview 'cat $realpath'
        zstyle ':fzf-tab:*' switch-group '<' '>'

        # Shell integrations
        eval "$(fzf --zsh)"
        eval "$(zoxide init --cmd cd zsh)"

        # Load starship prompt
        eval "$(starship init zsh)"
      '';
    };

    # Enhanced FZF configuration
    fzf = {
      enable = true;
      enableZshIntegration = true;
      defaultOptions = [
        "--color=bg+:#414559"
        "--color=bg:#303446"
        "--color=spinner:#f2d5cf"
        "--color=hl:#e78284"
        "--color=fg:#c6d0f5"
        "--color=header:#e78284"
        "--color=info:#ca9ee6"
        "--color=pointer:#f2d5cf"
        "--color=marker:#f2d5cf"
        "--color=fg+:#c6d0f5"
        "--color=prompt:#ca9ee6"
        "--color=hl+:#e78284"
      ];
    };

    # Enhanced zoxide configuration
    zoxide = {
      enable = true;
      enableZshIntegration = true;
      options = [
        "--cmd"
        "cd"
      ];
    };
  };
}
