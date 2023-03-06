#!/bin/zsh

sudo -v

printf "Installing xcode cli utils\n"
xcode-select --install

if ! command -v brew > /dev/null; then
    printf "Installing homebrew\n"
    NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

printf "Updating brew and installing notifier\n"
brew upgrade && brew update
brew upgrade --cask && brew update --cask
brew install terminal-notifier
terminal-notifier -title "Terminal Notifier" -subtitle "Installed" -message "pls allow"

printf "brew: Installing cli packages\n"
FORMULAE=(
    aws
    brew-cask-completion
    chruby
    git
    gh
    parallel
    ruby-install
    terraform
    wget
)
brew install --formula $FORMULAE

git config --global user.email chaserobertson208@gmail.com
git config --global user.name Chase Robertson
mkdir .parallel && touch .parallel/will-cite

CASKS=(
    authy
    balance-lock
    balenaetcher
    bitwarden
    docker
    firefox
    forticlient-vpn
    google-chrome
    google-drive
    grammarly
    julia
    libreoffice
    homebrew/cask-drivers/logi-options-plus
    powershell
    mactex
    macvim
    rectangle
    r
    rstudio
    spotify
    virtualbox
    virtualbox-extension-pack
    visual-studio-code
    vlc
    wireshark
    zoom
)
printf "brew: Fetching apps\n"
parallel -j ${#CASKS[@]} 'brew fetch -q --cask {}' ::: $CASKS

printf "brew: Installing apps\n"
brew install --cask $CASKS

printf "Installing terraform autocomplete"
touch ~/.zshrc
echo "autoload -Uz compinit\ncompinit" >> ~/.zshrc
terraform -install-autocomplete

if ! command -v brew > /dev/null; then
    printf "Installing miniconda"
    wget https://repo.anaconda.com/miniconda/Miniconda3-latest-MacOSX-x86_64.sh -O ~/Downloads/miniconda.sh
    bash ~/Downloads/miniconda.sh -b -u -p ~/miniconda3
    ~/miniconda3/bin/conda init zsh
fi

if ! command -v Rscript > /dev/null; then
    printf "Linking R to jupyter"
    Rscript -e "install.packages('IRkernel', repos='https://cloud.r-project.org/')"
    Rscript -e "IRkernel::installspec(user = FALSE)"
fi

if [ ! -e /Applications/logioptionsplus.app ]; then
    printf "Installing Logi Options+"
    open /usr/local/Caskroom/logi-options-plus/latest/logioptionsplus_installer.app
fi

printf "Chrome autoupdate"
zsh chrome-autoupdate.sh
open -a "Google Chrome" chrome://settings/help --args --make-default-browser 

terminal-notifier -title "App Installer" -subtitle "Github CLI Installed" -message "Log in"
gh auth login

ruby-install ruby
echo "source $(brew --prefix)/opt/chruby/share/chruby/chruby.sh" >> ~/.zshrc
echo "source $(brew --prefix)/opt/chruby/share/chruby/auto.sh" >> ~/.zshrc
echo "chruby ruby-3.1.2" >> ~/.zshrc

terminal-notifier -title "App Installer Finished" -subtitle "Don't forget - gem install jekyll bundler" -message "Restart now?" -execute reboot
