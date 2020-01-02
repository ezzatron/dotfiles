set -e

echo "Applying macOS defaults..."

function plist-set-or-add () {
  local ENTRY="$1"
  local TYPE="$2"
  local VALUE="$3"
  local PLIST="$4"

  /usr/libexec/PlistBuddy -c "Set $1 $3" "$4" ||
  /usr/libexec/PlistBuddy -c "Add $1 $2 $3" "$4" ||
  echo "Unable to set or add plist with args:" "$@"
}

# Allow touch ID for sudo
# If using iTerm, you must also disable "Allow sessions to survive logging out and back in" in preferences > advanced
grep -q pam_tid /etc/pam.d/sudo || sudo sed -i.bak $'2i\\\nauth       sufficient     pam_tid.so\n' /etc/pam.d/sudo

# Set a blazingly fast keyboard repeat rate
defaults write NSGlobalDomain KeyRepeat -int 2
defaults write NSGlobalDomain InitialKeyRepeat -int 25

# Disable janky animation when zooming windows (works intermittently)
defaults write NSGlobalDomain NSAutomaticWindowAnimationsEnabled -bool false

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

# Set menu bar items
defaults write com.apple.systemuiserver menuExtras -array \
  "/System/Library/CoreServices/Menu Extras/Clock.menu" \
  "/System/Library/CoreServices/Menu Extras/Battery.menu" \
  "/System/Library/CoreServices/Menu Extras/Airport.menu" \
  "/System/Library/CoreServices/Menu Extras/Bluetooth.menu" \
  "/System/Library/CoreServices/Menu Extras/Displays.menu"

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

# Sort icon views by name
plist-set-or-add :DesktopViewSettings:IconViewSettings:arrangeBy string name "$HOME/Library/Preferences/com.apple.finder.plist"
plist-set-or-add :FK_StandardViewSettings:IconViewSettings:arrangeBy string name "$HOME/Library/Preferences/com.apple.finder.plist"
plist-set-or-add :StandardViewSettings:IconViewSettings:arrangeBy string name "$HOME/Library/Preferences/com.apple.finder.plist"

# Show item info in icon views
plist-set-or-add :DesktopViewSettings:IconViewSettings:showItemInfo bool true "$HOME/Library/Preferences/com.apple.finder.plist"
plist-set-or-add :FK_StandardViewSettings:IconViewSettings:showItemInfo bool true "$HOME/Library/Preferences/com.apple.finder.plist"
plist-set-or-add :StandardViewSettings:IconViewSettings:showItemInfo bool true "$HOME/Library/Preferences/com.apple.finder.plist"

# Minimize grid spacing in icon views
plist-set-or-add :DesktopViewSettings:IconViewSettings:gridSpacing int 1 "$HOME/Library/Preferences/com.apple.finder.plist"
plist-set-or-add :FK_StandardViewSettings:IconViewSettings:gridSpacing int 1 "$HOME/Library/Preferences/com.apple.finder.plist"
plist-set-or-add :StandardViewSettings:IconViewSettings:gridSpacing int 1 "$HOME/Library/Preferences/com.apple.finder.plist"

# Set the icon size in icon views
plist-set-or-add :DesktopViewSettings:IconViewSettings:iconSize int 64 "$HOME/Library/Preferences/com.apple.finder.plist"
plist-set-or-add :FK_StandardViewSettings:IconViewSettings:iconSize int 64 "$HOME/Library/Preferences/com.apple.finder.plist"
plist-set-or-add :StandardViewSettings:IconViewSettings:iconSize int 64 "$HOME/Library/Preferences/com.apple.finder.plist"

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

# Disable the Dock by default
defaults write com.apple.dock autohide-delay -float 1000

# Right-oriented Dock
defaults write com.apple.Dock orientation -string "right"

# Automatically hide and show the Dock
defaults write com.apple.dock autohide -bool true

# Show only open applications in the Dock
defaults write com.apple.dock static-only -bool true

# Wipe all (default) app icons from the Dock
defaults write com.apple.dock persistent-apps -array

# Show hidden dock items as translucent
defaults write com.apple.dock showhidden -bool true

# Set the dock icon size
defaults write com.apple.dock tilesize -int 64

# Speed up Mission Control animations
defaults write com.apple.dock expose-animation-duration -float 0.1

# Top-left hot corner tuns on screen saver
defaults write com.apple.dock wvous-tl-corner -int 5
defaults write com.apple.dock wvous-tl-modifier -int 0

# Top-right hot corner tuns off screen
defaults write com.apple.dock wvous-tr-corner -int 10
defaults write com.apple.dock wvous-tr-modifier -int 0

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

# Touch bar customization
defaults write com.apple.controlstrip MiniCustomized "(com.apple.system.brightness, com.apple.system.volume, com.apple.system.mute, com.apple.system.media-play-pause)"

# Save screenshots to a dedicated directory
mkdir -p "$HOME/Screenshots"
defaults write com.apple.screencapture location -string "$HOME/Screenshots"

# Save screenshots in PNG format (other options: BMP, GIF, JPG, PDF, TIFF)
defaults write com.apple.screencapture type -string "png"

# Mac Media Key Forwarder should prioritize Spotify
defaults write com.milgra.hsmke user_priority_option -int 2

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
