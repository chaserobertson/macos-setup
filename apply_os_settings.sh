#!/bin/zsh

# Apply machine hostname
read "mac_os_name?What is this machine's name (Example: \"ernie\")? "
if [[ -z "$mac_os_name" ]]; then
    printf "ERROR: Invalid MacOS name.\n"
    exit 1
fi

printf "Setting system label and name...\n"
sudo scutil --set ComputerName $mac_os_name
sudo scutil --set HostName $mac_os_name
sudo scutil --set LocalHostName $mac_os_name
sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server NetBIOSName -string $mac_os_name

printf "Disabling guest user..\n"
sudo dscl . -delete /Users/Guest
sudo security delete-generic-password -a Guest -s com.apple.loginwindow.guest-account -D "application password" /Library/Keychains/System.keychain
sudo defaults write /Library/Preferences/com.apple.loginwindow GuestEnabled -bool FALSE


# Applies system and application defaults.

printf "System - Disable boot sound effects and power chime\n"
sudo nvram SystemAudioVolume=" "
defaults write com.apple.PowerChime ChimeOnAllHardware -bool false

printf "System - Expand save panel and disable quarantine\n"
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write com.apple.LaunchServices LSQuarantine -bool false

printf "System - Disable smart quotes dashes and autocorrect\n"
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

printf "System - Require password immediately after sleep begins\n"
defaults write -currentHost com.apple.screensaver idleTime -int 0
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0

printf "System - Avoid creating .DS_Store files on network & USB volumes\n"
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

printf "System - Disable Bonjour\n"
sudo defaults write /System/Library/LaunchDaemons/com.apple.mDNSResponder.plist ProgramArguments -array-add "-NoMulticastAdvertisements"


# Customised from options at https://macos-defaults.com/

printf "Customise Dock\n"
defaults write com.apple.dock static-only -bool true
defaults write com.apple.dock mineffect -string "scale"
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock autohide-delay -float 0
defaults write com.apple.dock autohide-time-modifier -float 0
killall Dock

printf "Customise Screenshots\n"
defaults write com.apple.screencapture "disable-shadow" -bool "true" 
defaults write com.apple.screencapture "location" -string "~/Downloads"
killall SystemUIServer

printf "Customise Safari\n"
defaults write com.apple.safari "ShowFullURLInSmartSearchField" -bool "true"
killall Safari

printf "Customise Finder\n"
chflags nohidden $HOME/Library
defaults write com.apple.finder ShowStatusBar -bool true
defaults write com.apple.finder QLEnableTextSelection -bool true
defaults write com.apple.finder "QuitMenuItem" -bool "true"
defaults write NSGlobalDomain "AppleShowAllExtensions" -bool "true"
defaults write com.apple.finder "ShowPathbar" -bool "true"
defaults write com.apple.finder "FXPreferredViewStyle" -string "clmv"
defaults write com.apple.finder "FXDefaultSearchScope" -string "SCcf"
defaults write com.apple.finder "FXRemoveOldTrashItems" -bool "true"
defaults write com.apple.finder "FXEnableExtensionChangeWarning" -bool "false"
defaults write NSGlobalDomain "NSDocumentSaveNewDocumentsToCloud" -bool "false" 
defaults write NSGlobalDomain "NSTableViewDefaultSizeMode" -int "1"
killall Finder

printf "Customise Menu Bar\n"
defaults write com.apple.menuextra.clock "DateFormat" -string "EEE d MMM HH:mm:ss"
defaults write com.apple.controlcenter "NSStatusItem Visible Battery" -bool "true" 
defaults write com.apple.controlcenter "NSStatusItem Visible BentoBox" -bool "true" 
defaults write com.apple.controlcenter "NSStatusItem Visible Bluetooth" -bool "true" 
defaults write com.apple.controlcenter "NSStatusItem Visible Clock" -bool "true" 
defaults write com.apple.controlcenter "NSStatusItem Visible KeyboardBrightness" -bool "true" 
defaults write com.apple.controlcenter "NSStatusItem Visible NowPlaying" -bool "true" 
defaults write com.apple.controlcenter "NSStatusItem Visible Sound" -bool "true" 
defaults write com.apple.controlcenter "NSStatusItem Visible WiFi" -bool "true" 

defaults -currentHost write com.apple.controlcenter "Battery" -int "3"
defaults -currentHost write com.apple.controlcenter "BatteryShowPercentage" -bool "true"
defaults -currentHost write com.apple.controlcenter "Bluetooth" -int "18"
defaults -currentHost write com.apple.controlcenter "KeyboardBrightness" -int "8"
defaults -currentHost write com.apple.controlcenter "Sound" -int "16"

printf "Customise Misc\n"
defaults write com.apple.TimeMachine "DoNotOfferNewDisksForBackup" -bool "true" 
defaults write com.apple.ActivityMonitor "IconType" -int "6"
defaults write com.apple.ActivityMonitor "UpdatePeriod" -int "2"
killall Activity\ Monitor


# --------------------------

printf "TextEdit\n"
defaults write com.apple.TextEdit RichText -int 0
defaults write com.apple.TextEdit PlainTextEncoding -int 4
defaults write com.apple.TextEdit PlainTextEncodingForWrite -int 4

printf "Printer\n"
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true

printf "Game Center off\n"
defaults write com.apple.gamed Disabled -bool true
