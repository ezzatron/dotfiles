set -e

echo "Applying OSX defaults..."

# Trackpad: enable tap to click for this user and for the login screen
defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

# Enable volume change feedback beep
defaults write NSGlobalDomain com.apple.sound.beep.feedback -int 1

# Disable auto correct and other substitutions
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

# Date formats
defaults write com.apple.menuextra.clock DateFormat -string "EEE MMM d h:mm a"
defaults write NSGlobalDomain AppleICUDateFormatStrings -dict \
  1 -string "y-MM-dd" \
  2 -string "y-MM-dd" \
  3 -string "y-MM-dd" \
  4 -string "y-MM-dd"

# Automatically open a new Finder window when a volume is mounted
defaults write com.apple.frameworks.diskimages auto-open-ro-root -bool true
defaults write com.apple.frameworks.diskimages auto-open-rw-root -bool true
defaults write com.apple.finder OpenWindowForNewRemovableDisk -bool true

# Use list view in all Finder windows by default
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"

# Right-oriented Dock
defaults write com.apple.Dock orientation -string "right"

# Automatically hide and show the Dock
defaults write com.apple.dock autohide -bool true

# Show only open applications in the Dock
defaults write com.apple.dock static-only -bool true

# Wipe all (default) app icons from the Dock
defaults write com.apple.dock persistent-apps -array

# Speed up Mission Control animations
defaults write com.apple.dock expose-animation-duration -float 0.1

# Don’t show Dashboard as a Space
defaults write com.apple.dock dashboard-in-overlay -bool true

# Disable Dashboard
defaults write com.apple.dashboard mcx-disabled -bool true

# Don’t display the annoying prompt when quitting iTerm
defaults write com.googlecode.iterm2 PromptOnQuit -bool false
defaults write com.googlecode.iterm2 OnlyWhenMoreTabs -bool false
defaults write com.googlecode.iterm2 PrefsCustomFolder -string "$HOME/Dropbox/Configuration/iTerm"
defaults write com.googlecode.iterm2 LoadPrefsFromCustomFolder -bool true

killall \
    "Address Book" \
    "Calendar" \
    "cfprefsd" \
    "Contacts" \
    "Dock" \
    "Finder" \
    "iCal" \
    "iTunes" \
    "Mail" \
    "Safari" \
    "SystemUIServer"
