set -e

echo "Applying macOS defaults..."

# Trackpad: enable tap to click for this user and for the login screen
defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

# Enable volume change feedback beep
defaults write NSGlobalDomain com.apple.sound.beep.feedback -int 1

# Disable auto correct and other substitutions
defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

# Date formats
defaults write com.apple.menuextra.clock DateFormat -string "EEE MMM d h:mm a"
defaults write NSGlobalDomain AppleICUDateFormatStrings -dict \
  1 -string "y-MM-dd" \
  2 -string "y-MM-dd" \
  3 -string "y-MM-dd" \
  4 -string "y-MM-dd"

# Allow Finder to be quit normally
defaults write com.apple.finder QuitMenuItem -bool true

# Show the Finder path bar
defaults write com.apple.finder ShowPathbar -bool true

# Show the Finder status bar
defaults write com.apple.finder ShowStatusBar -bool true

# Hide Finder recent tags
defaults write com.apple.finder ShowRecentTags -bool false

# Open folders in new Finder windows instead of tabs
defaults write com.apple.finder FinderSpawnTab -bool false

# Use list view in all Finder windows by default
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"

# Keep directories at the top when sorting in Finder
defaults write com.apple.finder _FXSortFoldersFirst -bool true

# Use the home directory as the default location for new Finder windows
defaults write com.apple.finder NewWindowTarget -string "PfHm"
defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}/"

# Finder should search the current directory by default
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

# Turn off automatic Desktop icons
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool false
defaults write com.apple.finder ShowHardDrivesOnDesktop -bool false
defaults write com.apple.finder ShowMountedServersOnDesktop -bool false
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool false

# Automatically open a new Finder window when a volume is mounted
defaults write com.apple.frameworks.diskimages auto-open-ro-root -bool true
defaults write com.apple.frameworks.diskimages auto-open-rw-root -bool true
defaults write com.apple.finder OpenWindowForNewRemovableDisk -bool true

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

# Automatic updates
sudo defaults write /Library/Preferences/com.apple.SoftwareUpdate.plist AutomaticallyInstallMacOSUpdates -bool true
sudo defaults write /Library/Preferences/com.apple.SoftwareUpdate.plist AutomaticCheckEnabled -bool true
sudo defaults write /Library/Preferences/com.apple.SoftwareUpdate.plist AutomaticDownload -bool true
sudo defaults write /Library/Preferences/com.apple.SoftwareUpdate.plist ConfigDataInstall -bool true
sudo defaults write /Library/Preferences/com.apple.SoftwareUpdate.plist CriticalUpdateInstall -bool true
sudo defaults write /Library/Preferences/com.apple.commerce.plist AutoUpdate -bool true

# Don’t display the annoying prompt when quitting iTerm
defaults write com.googlecode.iterm2 PromptOnQuit -bool false
defaults write com.googlecode.iterm2 OnlyWhenMoreTabs -bool false
defaults write com.googlecode.iterm2 PrefsCustomFolder -string "$HOME/Google Drive/Configuration/iTerm"
defaults write com.googlecode.iterm2 LoadPrefsFromCustomFolder -bool true

# Don't display first-time Spotlight messages
defaults write com.apple.spotlight showedFTE 1
defaults write com.apple.spotlight showedLearnMore 1

# Spotlight autocomplete sources
defaults write com.apple.spotlight orderedItems -array \
  '{"enabled" = 1;"name" = "APPLICATIONS";}' \
  '{"enabled" = 1;"name" = "MENU_SPOTLIGHT_SUGGESTIONS";}' \
  '{"enabled" = 1;"name" = "MENU_CONVERSION";}' \
  '{"enabled" = 1;"name" = "MENU_EXPRESSION";}' \
  '{"enabled" = 1;"name" = "MENU_DEFINITION";}' \
  '{"enabled" = 1;"name" = "SYSTEM_PREFS";}' \
  '{"enabled" = 0;"name" = "MESSAGES";}' \
  '{"enabled" = 0;"name" = "DOCUMENTS";}' \
  '{"enabled" = 0;"name" = "DIRECTORIES";}' \
  '{"enabled" = 0;"name" = "PRESENTATIONS";}' \
  '{"enabled" = 0;"name" = "SPREADSHEETS";}' \
  '{"enabled" = 0;"name" = "PDF";}' \
  '{"enabled" = 0;"name" = "MESSAGES";}' \
  '{"enabled" = 0;"name" = "CONTACT";}' \
  '{"enabled" = 0;"name" = "EVENT_TODO";}' \
  '{"enabled" = 0;"name" = "IMAGES";}' \
  '{"enabled" = 0;"name" = "BOOKMARKS";}' \
  '{"enabled" = 0;"name" = "MUSIC";}' \
  '{"enabled" = 0;"name" = "MOVIES";}' \
  '{"enabled" = 0;"name" = "FONTS";}' \
  '{"enabled" = 0;"name" = "MENU_OTHER";}'

# Touch bar customization
defaults write com.apple.controlstrip MiniCustomized "(com.apple.system.media-play-pause, com.apple.system.mute, com.apple.system.volume, com.apple.system.brightness)"

# Save screenshots to a dedicated directory
mkdir -p "$HOME/Screenshots"
defaults write com.apple.screencapture location -string "$HOME/Screenshots"

# Save screenshots in PNG format (other options: BMP, GIF, JPG, PDF, TIFF)
defaults write com.apple.screencapture type -string "png"

killall \
  "Address Book" \
  "Calendar" \
  "ControlStrip" \
  "cfprefsd" \
  "Contacts" \
  "Dock" \
  "Finder" \
  "iCal" \
  "iTunes" \
  "Mail" \
  "Safari" \
  "Spotlight" \
  "SystemUIServer"
