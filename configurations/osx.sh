# sudo chmod -R 0700 ~/.ssh
# sudo chmod -R 0700 ~/.gnupg
# sudo chmod -R 0700 ~/.dropbox

#=====================================================
#=====================================================
# FILES:
defaults write com.apple.dock itunes-notifications -bool YES # itunes-notifications
defaults write -g ApplePressAndHoldEnabled -bool NO # don't have accent on HOLD key
defaults write com.apple.finder AppleShowAllFiles YES # Show all files in finder
defaults write com.apple.screencapture location ~/Dropbox/Photos/screenshots # Set Downloads folder
defaults write com.apple.NetworkBrowser BrowseAllInterfaces 1

defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

defaults write com.apple.Finder FXPreferredViewStyle clmv

# icnv: Icon View
# Nlsv: List View
# clmv: Column View
# Flwv: Cover Flow View

# Sort list view by kind in ascending order (Windows style)
/usr/libexec/PlistBuddy -c "Set :StandardViewSettings:ExtendedListViewSettings:sortColumn kind" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :StandardViewSettings:ExtendedListViewSettings:columns:4:ascending true" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :StandardViewSettings:ListViewSettings:sortColumn kind" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :StandardViewSettings:ListViewSettings:columns:kind:ascending true" ~/Library/Preferences/com.apple.finder.plist

# Sort Folders before files hack (Windows style)
FILE=/System/Library/CoreServices/Finder.app/Contents/Resources/English.lproj/InfoPlist.strings
# Backup InfoPlist.strings first if no backup exists
[ -f $FILE.bak ] || sudo ditto $FILE $FILE.bak
# Convert InfoPlist.strings to XML
sudo plutil -convert xml1 $FILE
# Add a space in front of 'Folder' string
sudo sed -i '' 's/g\>Folder/g\> Folder/' $FILE > /dev/null
# Convert InfoPlist.strings back to binary
sudo plutil -convert binary1 $FILE

# Browse all
chflags nohidden ~/Library # See Librairy in finder

# Restart
killall SystemUIServer
killall Finder
killall cfprefsd
killall Dock

#=====================================================
#=====================================================
# HOMEBREW
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# PG
brew install postgres

# CREATE USER example;
# ALTER USER example WITH PASSWORD 'mypassword';
# ALTER USER example WITH SUPERUSER;

# REDIS
brew install redis

# MEMCACHED
brew install memcached

# IMAGEMAGICK
brew install imagemagick

# COREUTILS for "ls"
brew install coreutils

#=====================================================
#=====================================================
# RUBY
brew upgrade rbenv ruby-build
brew install ruby-build
git clone https://github.com/rbenv/rbenv.git ~/.rbenv
cd ~/.rbenv && src/configure && make -C src
rbenv install 2.4.1
echo "2.4.1" > ~/.rbenv/version

gem update --system

gem install bundler
gem install rails
gem install rb-fsevent
gem install byebug
gem install rubocop
gem install htmlbeautifier

rbenv rehash

#=====================================================
#=====================================================
# NODE
brew install node
chown -R $USER /usr/local/share/systemtap
brew link node
brew install yarn

export PATH="$PATH:`yarn global bin`"
yarn global add prettier eslint-plugin-prettier eslint-config-prettier gulp node-sass

#=====================================================
#=====================================================
# SUBLIME TEXT
curl https://packagecontrol.io/Package%20Control.sublime-package -o ~/Library/Application\ Support/Sublime\ Text 3/Installed\ Packages/Package\ Control.sublime-package

#=====================================================
#=====================================================
# TODO

# Sass
# Side​Bar​Enhancements
# Git​Gutter
# Bracket​Highlighter
# Sublime​Linter
# Sublime​Code​Intel
# Emmet
# j​Query
# Color Highlighter
# AllAutocomplete
# Material Theme
# MarkdownEditing

# JsPrettier
# IN $HOME/Library/Application Support/Sublime Text 3/Packages/User/JsPrettier.sublime-settings
# {
#   "prettier_cli_path": "/usr/local/Cellar/node/8.1.3/bin/prettier",
#   "auto_format_on_save": true,
# }

# BeautifyRuby
# IN $HOME/Library/Application Support/Sublime Text 3/Packages/User/BeautifyRuby.sublime-settings
# {
#   "ruby": "/Users/damln/.rbenv/shims/ruby"
# }


#=====================================================
#=====================================================
# (ZSH et ST3 config)
curl https://raw.githubusercontent.com/damln/AdminTools/master/configurations/zshrc.sh -o "$HOME/.zshrc"
curl https://raw.githubusercontent.com/damln/AdminTools/master/configurations/rubocop.yml -o "$HOME/.rubocop.yml"
curl https://raw.githubusercontent.com/damln/AdminTools/master/configurations/sublime-text-3.json -o "$HOME/Library/Application Support/Sublime Text 3/Packages/User/Preferences.sublime-settings"
