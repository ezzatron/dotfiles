set -e

function PlistBuddy-Add {
    local key=$1
    local type=$2
    local plist=$3

    /usr/libexec/PlistBuddy -c "Print $key" "$plist" > /dev/null 2>&1 || \
        /usr/libexec/PlistBuddy -c "Add $key $type" "$plist"
}
function PlistBuddy-Set {
    local key=$1
    local type=$2
    local value=$3
    local plist=$4

    /usr/libexec/PlistBuddy -c "Print $key" "$plist" > /dev/null 2>&1 || \
        /usr/libexec/PlistBuddy -c "Add $key $type" "$plist"
    /usr/libexec/PlistBuddy -c "Set $key $value" "$plist"
}

echo "Applying OSX defaults..."

# Enable volume change feedback beep
defaults write NSGlobalDomain com.apple.sound.beep.feedback -int 1

# Disable auto correct and other substitutions
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

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

# iTerm arrow key navigation
# PlistBuddy-Add ":'New Bookmarks'" array "$HOME/Library/Preferences/com.googlecode.iterm2.plist"
# PlistBuddy-Add ":'New Bookmarks':0" dict "$HOME/Library/Preferences/com.googlecode.iterm2.plist"
# PlistBuddy-Add ":'New Bookmarks':0:'Keyboard Map'" dict "$HOME/Library/Preferences/com.googlecode.iterm2.plist"
# PlistBuddy-Add ":'New Bookmarks':0:'Keyboard Map':'0xf702-0x280000'" dict "$HOME/Library/Preferences/com.googlecode.iterm2.plist"
# PlistBuddy-Set ":'New Bookmarks':0:'Keyboard Map':'0xf702-0x280000':Action" integer 10 "$HOME/Library/Preferences/com.googlecode.iterm2.plist"
# PlistBuddy-Set ":'New Bookmarks':0:'Keyboard Map':'0xf702-0x280000':Text" string "'b'" "$HOME/Library/Preferences/com.googlecode.iterm2.plist"
# PlistBuddy-Add ":'New Bookmarks':0:'Keyboard Map':'0xf703-0x280000'" dict "$HOME/Library/Preferences/com.googlecode.iterm2.plist"
# PlistBuddy-Set ":'New Bookmarks':0:'Keyboard Map':'0xf703-0x280000':Action" integer 10 "$HOME/Library/Preferences/com.googlecode.iterm2.plist"
# PlistBuddy-Set ":'New Bookmarks':0:'Keyboard Map':'0xf703-0x280000':Text" string "'f'" "$HOME/Library/Preferences/com.googlecode.iterm2.plist"

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
