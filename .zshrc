for file in ~/.{function,environment,path,alias}; do
	[ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;


# Path to your oh-my-zsh installation.
export ZSH="/Users/jeroch/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
  docker
)

source $ZSH/oh-my-zsh.sh
