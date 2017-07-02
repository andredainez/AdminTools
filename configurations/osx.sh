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

rbenv rehash

rbenv versions
rbenv version

# NODE
brew install node
chown -R $USER /usr/local/share/systemtap
brew link node

# SUBLIME TEXT

gem install byebug

curl https://packagecontrol.io/Package%20Control.sublime-package -o ~/Library/Application\ Support/Sublime\ Text 3/Installed\ Packages/Package\ Control.sublime-package

# Glue
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

# To Test

# Ruby Debugger
# Colorcoder

# FINDER
killall SystemUIServer
killall -HUP Finder
killall Dock
