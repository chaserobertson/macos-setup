#! /usr/bin/env bash

gem install terminal-notifier
terminal-notifier -title "Terminal Notifier" -subtitle "Installed" -message "pls allow"

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
brew install wget
brew install python3

printf "brew: Installing apps\n"
brew install balenaetcher &
brew install firefox &
brew install gh &
brew install google-drive &
brew install google-chrome &
brew install spotify &
brew install terminal-notifier &
brew install virtualbox &
brew install virtualbox-extension-pack &
brew install visual-studio-code &
brew install vlc &
brew install windscribe &
brew install wireshark &
brew install zoomus

terminal-notifier -title "App Installer" -subtitle "Finished" -message "Restart now?" -execute reboot
