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
gem install byebug
gem install rubocop

rbenv rehash

# NODE
brew install node
chown -R $USER /usr/local/share/systemtap
brew link node
brew install yarn

export PATH="$PATH:`yarn global bin`"
yarn global add prettier eslint-plugin-prettier eslint-config-prettier gulp node-sass


# SUBLIME TEXT
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

# JsPrettier
# IN $HOME/Library/Application Support/Sublime Text 3/Packages/User/JsPrettier.sublime-settings
# {
#   "prettier_cli_path": "/usr/local/Cellar/node/8.1.3/bin/prettier",
#   "auto_format_on_save": true,
# }


# (ZSH et ST3 config)
curl https://raw.githubusercontent.com/damln/AdminTools/master/configurations/zshrc.sh -o "$HOME/.zshrc"
curl https://raw.githubusercontent.com/damln/AdminTools/master/configurations/rubocop.yml -o "$HOME/.rubocop.yml"
curl https://raw.githubusercontent.com/damln/AdminTools/master/configurations/sublime-text-3.json -o "$HOME/Library/Application Support/Sublime Text 3/Packages/User/Preferences.sublime-settings"
