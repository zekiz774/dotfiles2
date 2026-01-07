# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

source /usr/share/cachyos-zsh-config/cachyos-config.zsh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# === init zoxide ==
eval "$(zoxide init zsh)"

# ===Plugins ===
plugins=(
  git
  zsh-autosuggestions
  zsh-syntax-highlighting
)

# === Initialize Oh My Zsh ===
source $ZSH/oh-my-zsh.sh

ZSH_AUTOSUGGEST_STRATEGY=(match_prev_cmd completion)

unsetopt correct_all
unsetopt correct

