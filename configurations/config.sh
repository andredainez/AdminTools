# sudo chmod -R 0700 ~/.ssh
# sudo chmod -R 0700 ~/.gnupg
# sudo chmod -R 0700 ~/.dropbox

# FILES:
defaults write com.apple.dock itunes-notifications -bool YES # itunes-notifications
defaults write -g ApplePressAndHoldEnabled -bool NO # don't have accent on HOLD key
defaults write com.apple.finder AppleShowAllFiles YES # Show all files in finder
defaults write com.apple.screencapture location ~/Dropbox/Photos/screenshots # Set Downloads folder
defaults write com.apple.NetworkBrowser BrowseAllInterfaces 1 # Browse all
chflags nohidden ~/Library # See Librairy in finder

cp ./configurations/zshrc.sh "$HOME/.zshrc"
cp ./configurations/rubocop.yml "$HOME/.rubocop.yml"
cp ./configurations/Zenburnesque.tmTheme "$HOME/Library/Application Support/Sublime Text 3/Packages/User/Zenburnesque.tmTheme"
cp ./configurations/sublime-text-3.json "$HOME/Library/Application Support/Sublime Text 3/Packages/User/Preferences.sublime-settings"

# FINDER
killall SystemUIServer
killall -HUP Finder
killall Dock
