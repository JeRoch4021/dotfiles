#!/usr/bin/env bash

# Function to check if a command exists
check_command() {
    local cmd="$1"
    command -v "$cmd" &> /dev/null
}

create_symlinks() {
    echo "Removing existing dotfiles..."
    rm -rf  ~/.zshrc ~/.zprofile ~/.alias ~/.environment ~/.path ~/.function 2>/dev/null

    echo "Creating symlinks..."
    ln -s ~/dotfiles/.alias ~/.alias
    ln -s ~/dotfiles/.environment ~/.environment
    ln -s ~/dotfiles/.function ~/.function
    ln -s ~/dotfiles/.path ~/.path
    ln -s ~/dotfiles/.zshrc ~/.zshrc
    ln -s ~/dotfiles/.zprofile ~/.zprofile
}

install_brew() {
	if ! check_command brew; then
		echo "Installing Brew..."
	    	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
		if [[ $os_type == "Linux" ]]; then
			echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> "$HOME/.bashrc"
			eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
		fi
	fi
        eval "$(/opt/homebrew/bin/brew shellenv)"
}

install_brew_packages() {
	brew update

  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  
  brew install spaceship
  brew install git
  brew install asdf
	brew install zsh-autosuggestions
	brew install zsh-syntax-highlighting
  brew install htop

  echo -e "Configuring Java (openjdk-18.0.2.1) \n"
  asdf plugin-add java https://github.com/halcyon/asdf-java.git
  asdf install java openjdk-18.0.2.1
  asdf global java openjdk-18.0.2.1

  echo -e "Configuring Python  \n"
  asdf plugin-add python
  asdf install python 3.12.7
  asdf global python openjdk-18.0.2.1
}

install_brew_packages_for_mac() {
	brew install --cask lastpass
	brew install --cask docker
	brew install --cask google-chrome
	brew install --cask logi-options+
	brew install --cask visual-studio-code
  brew install --cask netbeans
  brew install --cask iterm2
  brew install --cask warp
  brew install --cask font-fira-code
  brew install --cask font-source-code-pro
  brew install --cask spotify
}

setup_linux() {
  echo -e "nothing implemented for linux"
}

setup_mac() {
  echo -e "Using specific config for Mac \n"

  create_symlinks

  install_brew

  install_brew_packages

  install_brew_packages_for_mac
}

os_type=""

if [[ $(uname) == "Darwin" ]]; then
    os_type="Mac"
else
    os_type="Linux"
fi

echo -e "$os_type detected. Using $os_type config... \n"


case $os_type in
    "Mac")
        setup_mac
        ;;
    "Linux")
        setup_linux
        ;;
    *)
        echo "Unknown OS type: $os_type. Exiting."
        exit 1
        ;;
esac

echo -e "\n\n\n\nAll systems operational. 🤖"
echo "JESHUA'S MACBOOK"
echo "Your development environment is ready! Blast off!"
