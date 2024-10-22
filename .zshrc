# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
  docker
)

# load oh-my-zsh
source $ZSH/oh-my-zsh.sh

# Loads all my custom files
for file in ~/.{function,environment,path,alias}; do
	[ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;