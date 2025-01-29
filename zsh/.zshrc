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
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# Aliases
alias ls='ls -la --color'
alias c='clear'

# Aliases
alias ls='ls -la --color'
alias c='clear'


# Shell integrations
eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"

# Load starship prompt
eval "$(starship init zsh)"
