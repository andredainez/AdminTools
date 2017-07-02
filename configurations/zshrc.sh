# When you chenge something in this file, do : source ~/.zshrc
# Or open a new shell.

#=====================================================
#=====================================================
# SET UTF-8 for everything
export LC_CTYPE=en_US.UTF-8
export LANG=en_US.UTF-8

#=====================================================
#=====================================================
# ZSH
ZSH=$HOME/.oh-my-zsh

ZSH_THEME="robbyrussell"
NOMATCH=1
DISABLE_CORRECTION=true
DISABLE_UPDATE_PROMPT=true

# ZSH Plugin: zsh-syntax-highlighting --------------
# Install:
# cd ~/.oh-my-zsh/custom/plugins
# git clone git://github.com/zsh-users/zsh-syntax-highlighting.git

# ZSH Plugin: zsh-autosuggestions --------------
# Install:
# git clone git://github.com/tarruda/zsh-autosuggestions ~/.zsh-autosuggestions

# Load oh-my-zsh plugins:
plugins=(
         git
         rails
         heroku
         brew
         bundler
         npm
         sublime
         wd
         zsh-syntax-highlighting
         # history-substring-search
         grep
         )

# Load autosuggestions:
export AUTOSUGGESTION_HIGHLIGHT_COLOR=fg=246
source ~/.zsh-autosuggestions/autosuggestions.zsh
# Enable autosuggestions automatically:
zle-line-init() {
    zle autosuggest-start
}

zle -N zle-line-init
# / Load autosuggestions:

# load all oh-my-zsh plugins:
source $ZSH/oh-my-zsh.sh


#=====================================================
#=====================================================
# PATH and Others

# -----------------
# OSX
export PATH=/usr/local/bin:$PATH:$HOME/.rvm/bin:/usr/local/heroku/bin:/usr/bin:/bin:/usr/sbin:/sbin:/Library/Java/Home/bin:/usr/local/heroku/bin:/usr/local/share/npm/bin:$HOME/bin:/usr/local/sbin:/opt/local/bin:/opt/local/sbin:/bin:/usr/sbin:/sbin:/opt/X11/bin

# -----------------
# PYTHON:
export PYTHONPATH=$PYTHONPATH:/usr/local/lib/python2.7/site-packages

# -----------------
# Android SDK path for binaries (sdk/platform-tools and sdk/tools)
export JAVA_HOME=/Library/Java/Home

# -----------------
# GO LANG
export GOPATH=$HOME/Go
export GOROOT=/usr/local/opt/go/libexec
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:$GOROOT/bin

# -----------------
# RVM
# export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
# [[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

# -----------------
# RBENV
export PATH=$HOME/.rbenv/shims:$HOME/.rbenv/bin:$PATH


# -----------------
# NVM
# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"

# -----------------
# CARGO
export PATH="$PATH:$HOME/.cargo/bin"

# -----------------
# YARN
export PATH="$PATH:`yarn global bin`"




#=====================================================
#=====================================================
# Alias

# change WORK_PATH with your main Work folder
WORK_PATH=~/Work
alias clean_log='find $WORK_PATH -type f -iwholename "*/log/*.log" -exec rm "{}" +'
alias clean_tmp='find $WORK_PATH -type d -iwholename "*/tmp/cache" -exec rm -rf "{}" +'

#=====================================================
#=====================================================
# Ruby process

kruby () {
    echo "* Killing Ruby process"
    for i in `ps aux | grep -i ruby | grep -v grep | awk '{print $2}'`; do
        kill -9 $i
        echo "  - Kill ruby process: $i"
    done
    echo "* Done"

    echo "* Killing Spring process"
    for i in `ps aux | grep -i spring | grep -v grep | awk '{print $2}'`; do
        kill -9 $i
        echo "  - Kill Spring process: $i"
    done
    echo "* Done"

    echo "* Killing Zeus"
    for i in `ps aux | grep 'zeus' | grep -v grep | awk '{print $2}'`; do
        kill -9 $i
        echo "  - Kill ruby process: $i"
    done

    kserver
    ksidekiq
    kdelayed
    kphantomjs

    return 0;
}

kserver () {
    echo "* Killing Rails servers (rails s)"
    for i in `ps aux | grep -i ruby | grep -i 'rails s' | grep -v grep | awk '{print $2}'`; do
        kill -9 $i
        echo "  - Kill ruby process: $i"
    done
    echo "* Done"

    echo "* Killing Zeus servers"
    for i in `ps aux | grep -i ruby | grep -i server | grep -i zeus | grep '/build/' | grep -v grep | awk '{print $2}'`; do
        kill -9 $i
        echo "  - Kill ruby process: $i"
    done

    echo "* Done"

    echo "* Killing Puma servers"
    for i in `ps aux | grep -i puma | grep -v grep | awk '{print $2}'`; do
        kill -9 $i
        echo "  - Kill puma process: $i"
    done
    echo "* Done"

    echo "* Killing Unicorn servers"
    for i in `ps aux | grep -i unicorn | grep -v grep | awk '{print $2}'`; do
        kill -9 $i
        echo "  - Kill unicorn process: $i"
    done
    echo "* Done"

    echo "* Killing Thin servers"
    for i in `ps aux | grep -i thin | grep -v grep | awk '{print $2}'`; do
        kill -9 $i
        echo "  - Kill thin process: $i"
    done
    echo "* Done"

    return 0;
}

ksidekiq () {
    echo "* Killing Sidekiq process"
    for i in `ps aux | grep -i sidekiq | grep -v grep | awk '{print $2}'`; do
        kill -9 $i
        echo "  - Kill sidekiq process: $i"
    done

    echo "* Done"
    return 0;
}

kdelayed () {
    echo "* Killing Delayed Job process"
    for i in `ps aux | grep -i delayed_job | grep -v grep | awk '{print $2}'`; do
        kill -9 $i
        echo "  - Kill Delayed Job process: $i"
    done
    echo "* Done"

    return 0;
}

# -----

knode () {
    echo "* Killing node process"
    for i in `ps aux | grep -i node | grep -v grep | awk '{print $2}'`; do
        kill -9 $i
        echo "  - Kill node process: $i"
    done
    echo "* Done"
}

kphantomjs () {
    echo "* Killing chromedriver process"
    for i in `ps aux | grep -i chromedriver | grep -v grep | awk '{print $2}'`; do
        kill -9 $i
        echo "  - Kill chromedriver process: $i"
    done
    echo "* Done"

    echo "* Killing phantomjs process"
    for i in `ps aux | grep -i phantomjs | grep -v grep | awk '{print $2}'`; do
        kill -9 $i
        echo "  - Kill phantomjs process: $i"
    done
    echo "* Done"
}

kreact () {
    echo "* Killing React Native process"
    for i in `ps aux | grep -i react-native | grep -v grep | awk '{print $2}'`; do
        kill -9 $i
        echo "  - Kill react process: $i"
    done

    for i in `ps aux | grep -i xcode | grep -v grep | awk '{print $2}'`; do
        kill -9 $i
        echo "  - Kill xcode process: $i"
    done

    echo "* Done"
    return 0;
}

kgulp () {
    echo "* Killing GULP process"
    for i in `ps aux | grep -i gulp | grep -v grep | awk '{print $2}'`; do
        kill -9 $i
        echo "  - Kill Gulp process: $i"
    done
}

kgrunt () {
    echo "* Killing GRUNT process"
    for i in `ps aux | grep -i grunt | grep -v grep | awk '{print $2}'`; do
        kill -9 $i
        echo "  - Kill GRUNT process: $i"
    done
}

kgg () {
  kgulp
  kgrunt
}

kall () {
  kgg
  kruby
  kreact
  kphantomjs
  knode
}

#=====================================================
#=====================================================
# Shortcut for runing Ruby server, kill other servers before
bes () {
    str=""
    # This is the hack:
    # $@ is the list of arguments of the functions. Each word is an argument
    # usefull for passing options like -p 4000
    for i in "$@"; do
        str+=" $i"
    done
    str=${str%% } # trim

    echo "--- kserver"
    kserver

    echo "bundle exec rails server -b 0.0.0.0 $str"
    echo "exec rails server -b 0.0.0.0 $str" | xargs bundle
}


start_pg () {
  rm /usr/local/var/postgres/postmaster.pid
  pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log start
}

# Commit in one line
# example:
# $ boom this is my commit content without quotes
boom () {
    str=""
    # This is the hack:
    # $@ is the list of arguments of the functions. Each word is an argument
    for i in "$@"; do
        str+="$i "
    done

    git commit -m "$str"
}


pidfor () {
    str=""
    # This is the hack:
    # $@ is the list of arguments of the functions. Each word is an argument
    # usefull for passing options like -p 4000
    for i in "$@"; do
        str+=" $i"
    done
    str=${str%% } # trim
    str=${str## } # trim

    echo "ps aux | grep -i \"$str\""

    ps aux | grep -i "$str"
}
