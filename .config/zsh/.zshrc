[ -f  "$XDG_CONFIG_HOME/shell/alias" ] && source "$XDG_CONFIG_HOME/shell/alias"
[ -f  "$XDG_CONFIG_HOME/shell/var" ] &&  source "$XDG_CONFIG_HOME/shell/var"
[ -f  "$XDG_CONFIG_HOME/shell/script" ] &&  source "$XDG_CONFIG_HOME/shell/script"

HISTSIZE=10000
SAVEHIST=10000
HISTCONTROL=ignoreboth
HISTFILE="$XDG_CACHE_HOME/zsh_history"
ZLE_REMOVE_SUFFIX_CHARS=""

setopt autocd beep interactive_comments # General
setopt extendedglob nomatch notify kshglob globdots # Globbing
setopt append_history inc_append_history share_history # History
setopt menu_complete # Autocomplete menu
setopt HIST_SAVE_NO_DUPS # Do not write a duplicate event to the history file.
setopt PROMPT_SUBST
setopt AUTO_PUSHD # Push the current directory visited on the stack.
setopt PUSHD_IGNORE_DUPS # Do not store duplicates in the stack.
# setopt PROMPT_CR

autoload -Uz colors && colors
autoload -U compinit && compinit
autoload -Uz run-help  

zstyle :compinstall filename "$XDG_CONFIG_HOME/.zshrc"
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':fzf-tab:*' use-fzf-default-opts yes
 
[ -f  "$XDG_CONFIG_HOME/zsh/keymaps" ] &&  source "$XDG_CONFIG_HOME/zsh/keymaps" 

PROMPT='
 %F{red}%~%f $(git_branch)%F{119}%?%f %F{105}%h%f
%# '

plug https://github.com/zsh-users/zsh-syntax-highlighting.git zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
plug https://github.com/Aloxaf/fzf-tab fzf-tab/fzf-tab.plugin.zsh
plug https://github.com/Tarrasch/zsh-bd zsh-bd/bd.zsh
# plug https://github.com/jeffreytse/zsh-vi-mode.git zsh-vi-mode/zsh-vi-mode.plugin.zsh

source <(fzf --zsh)
