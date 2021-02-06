#! /usr/bin/env bash

# Installs Homebrew software.
if ! command -v brew > /dev/null; then
    ruby -e "$(curl --location --fail --show-error https://raw.githubusercontent.com/Homebrew/install/master/install)"
    export PATH="/usr/local/bin:$PATH"
    printf "export PATH=\"/usr/local/bin:$PATH\"\n" >> $HOME/.bash_profile
fi

printf "Updating brew\n"
brew upgrade && brew update

printf "Installing xcode cli utils\n"
xcode-select --install

printf "brew: Installing cli packages\n"
brew install git
#brew install mas            # Apple store cli
brew install npm
#brew install wakeonlan
brew install wget
brew install python3

printf "brew: Installing apps\n"
#brew install activitywatch &
#brew install atom &
brew install balenaetcher &
brew install evernote &
brew install firefox &
brew install google-backup-and-sync &
brew install google-chrome &
brew install iterm2 &
brew install lastpass &
brew install lastpass-cli &
brew install spotify &
brew install the-unarchiver &
#brew install tor-browser &
brew install virtualbox &
brew install virtualbox-extension-pack &
brew install visual-studio-code &
brew install vlc &
#brew install windscribe &
brew install wireshark &
brew install zoomus
