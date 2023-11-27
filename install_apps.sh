#!/bin/zsh

sudo -v

printf "Installing xcode cli utils\n"
xcode-select --install && printf "installed\n"

printf "Installing brew\n"
if ! command -v brew > /dev/null; then
    printf "Installing homebrew\n"
    NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

printf "Updating brew and installing notifier\n"
brew upgrade && brew update
brew upgrade --cask && brew update --cask

brew install terminal-notifier
terminal-notifier -title "Terminal Notifier" \
    -subtitle "Installed" \
    -message "pls allow notifications"

FORMULAE=(
    awscli
    brew-cask-completion
    gh
    git
    pandoc
    parallel
    terraform
    wget
)
printf "brew: Installing cli packages\n"
brew install --formula $FORMULAE

CASKS=(
    authy
    balance-lock
    balenaetcher
    bitwarden
    docker
    firefox
    google-chrome
    google-drive
    julia
    libreoffice
    logi-options-plus
    powershell
    mactex
    macvim
    miniconda
    rectangle
    r
    rstudio
    spotify
    steam
    virtualbox
    visual-studio-code
    vlc
    wireshark
    zoom
)
printf "brew: Fetching apps\n"
brew fetch -q --cask $CASKS

printf "brew: Installing apps\n"
for app in $CASKS
do
    brew install --cask $app
done

OSA='tell app "Terminal"
   do script "gh auth login"
end tell'
terminal-notifier -title "App Installer" \
    -subtitle "Github CLI Installed" \
    -message "click to login" \
    -execute "osascript -e '$OSA'"

if command -v conda > /dev/null; then
    printf "Initialising conda\n"
    conda init zsh
    exec zsh -l
    conda install -y jupyter
fi

if command -v Rscript > /dev/null; then
    printf "Linking R to jupyter\n"
    Rscript -e "install.packages('IRkernel', repos='https://cloud.r-project.org/')"
    Rscript -e "IRkernel::installspec(user = FALSE)"
fi

# printf "Installing terraform autocomplete"
# touch ~/.zshrc
# echo "autoload -Uz compinit\ncompinit" >> ~/.zshrc
# terraform -install-autocomplete

terminal-notifier -title "App Installer Finished" \
    -subtitle "Don't forget - 'gem install jekyll bundler' after reboot!" \
    -message "Restart now?" \
    -execute reboot
