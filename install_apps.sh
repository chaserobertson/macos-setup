#!/bin/bash

sudo -v

printf "Installing xcode cli utils\n"
xcode-select --install

printf "Installing homebrew\n"
NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

printf "Updating brew\n"
brew upgrade && brew update
brew upgrade --cask && brew update --cask

brew install terminal-notifier
terminal-notifier -title "Terminal Notifier" -subtitle "Installed" -message "pls allow"

printf "brew: Installing cli packages\n"
FORMULAE=(
    brew-cask-completion
    git
    gh
    wget
    wireshark
)
brew install --formula $FORMULAE

printf "brew: Installing apps\n"
CASKS=(
    authy
    balance-lock
    balenaetcher
    bitwarden
    firefox
    forticlient-vpn
    google-chrome
    google-drive
    grammarly
    istat-menus
    libreoffice
    powershell
    rectangle
    rstudio
    spotify
    virtualbox
    virtualbox-extension-pack
    visual-studio-code
    vlc
    windscribe
    zoom
)
brew install --cask $CASKS

printf "Chrome autoupdate and Logi Options install"
bash chrome-autoupdate.sh & brew install homebrew/cask-drivers/logi-options-plus

printf "Installing miniconda"
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-MacOSX-x86_64.sh -O ~/Downloads/miniconda.sh
bash ~/Downloads/miniconda.sh -b -u -p ~/miniconda3
~/miniconda3/bin/conda init zsh

terminal-notifier -title "Github CLI Installed" -message "Log in"
open -a "Google Chrome" --args --make-default-browser
gh auth login

terminal-notifier -title "App Installer" -subtitle "Finished" -message "Restart now?" -execute reboot
