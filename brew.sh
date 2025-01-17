#!/usr/bin/env bash

# Install command-line tools using Homebrew.

# Ask for the administrator password upfront.
sudo -v

# Keep-alive: update existing `sudo` time stamp until the script has finished.
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Install Homebrew.
if [[ ! "$(type -P brew)" ]]; then
  true | ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Exit if, for some reason, Homebrew is not installed.
[[ ! "$(type -P brew)" ]] && e_error "Homebrew failed to install." && return 1

#homebrew now includes cask, so let's get rid of the old version
brew uninstall --force brew-cask

# Make sure we’re using the latest Homebrew.
brew update

# Upgrade any already-installed formulae.
brew upgrade


# Uninstall ALL php related Packages (most of them homebrew/php related)
brew list | grep php | xargs brew uninstall --force
# Remove deprecated tap
brew untap homebrew/php
# Clean cache
brew cleanup
# Ensure latest brew repo HEAD
brew update
# Install latest php (php 7.2)
brew install php
pecl install xdebug

# Install GNU core utilities (those that come with OS X are outdated).
# Don’t forget to add `$(brew --prefix coreutils)/libexec/gnubin` to `$PATH`.
brew install coreutils

# Install some other useful utilities like `sponge`.
brew install moreutils
# Install GNU `find`, `locate`, `updatedb`, and `xargs`, `g`-prefixed.
brew install findutils
# Install GNU `sed`, overwriting the built-in `sed`.
brew install gnu-sed --with-default-names
# Install Bash 4.
# Note: don’t forget to add `/usr/local/bin/bash` to `/etc/shells` before
# running `chsh`.
brew install bash
brew install bash-completion2

# Switch to using brew-installed bash as default shell
if ! fgrep -q '/usr/local/bin/bash' /etc/shells; then
  echo '/usr/local/bin/bash' | sudo tee -a /etc/shells;
  chsh -s /usr/local/bin/bash;
fi;

brew install curl

# Install `wget` with IRI support.
brew install wget --with-iri

# Install more recent versions of some OS X tools.
brew install vim --override-system-vi
brew install grep
brew install openssh
brew install screen

# Install font tools.
brew tap bramstein/webfonttools
brew install sfnt2woff
brew install sfnt2woff-zopfli
brew install woff2

#tap services - see: https://github.com/Homebrew/homebrew-services
brew tap homebrew/services

#install current dev/vm version of php
brew install php@7.1
brew install php@7.2

brew install brew-php-switcher


#install php mods / composer
brew install composer
brew install phpmd
brew install php-code-sniffer
brew install php-cs-fixer

#install some http benchmarking tools
brew install wrk
brew install siege
brew install vegeta
brew install httpie

#install some network benchmarking/testing tools
brew install iperf3
brew install nuttcp
brew install mtr
brew install owamp
brew install scamper
brew install whatmask
brew install testssl

#ssh stuff
brew install ssh-copy-id
brew install stormssh

# dev env deps
brew install dnsmasq
brew install mkcert


# Install some more CTF tools; see https://github.com/ctfs/write-ups.
brew install aircrack-ng
brew install bfg
brew install binutils
brew install binwalk
brew install cifer
brew install cowpatty
brew install dex2jar
brew install dns2tcp
brew install fcrackzip
brew install foremost
brew install hashpump
brew install homebrew/python/pyrit
brew install hydra
brew install john
brew install knock
brew install netpbm
brew install nmap
brew install mitmproxy
brew install pngcheck
brew install reaver
brew install snort
brew install socat
brew install sqlmap
brew install tcpflow
brew install tcpreplay
brew install tcptrace
brew install tcpdump
brew install trafshow
brew install dhcpdump
brew install ucspi-tcp # `tcpserver` etc.
brew install whois
brew install wireshark
brew install homebrew/x11/xpdf
brew install xz

# Install other useful binaries.
brew install ack
brew install autojump
brew install bat
brew install dark-mode
brew install diff-so-fancy
brew install exiv2
brew install git
brew install git-lfs
brew install hub
brew install htop
brew install imagemagick --with-webp
brew install lua
brew install lynx
brew install ngrep
brew install p7zip
brew install pigz
brew install pv
brew install rename
brew install rhino
brew install speedtest_cli
brew install the_silver_searcher
brew install tree
brew install trash
brew install unzip
brew install webkit2png
brew install youtube-dl
brew install zopfli
brew install z

# even more additional utils, only listed here bc i added them so much later
brew install android-platform-tools

# Install Node Version Manager - because we are going to need to run multiple versions of node
brew install nvm
# install phantomjs for el capitan
brew install phantomjs
brew link --overwrite phantomjs

#install rbenv and ruby build
brew install rbenv
brew install ruby-build
brew install rbenv-default-gems

#use brewed git
brew link git --overwrite

#config git
curl -s -O \
https://github-media-downloads.s3.amazonaws.com/osx/git-credential-osxkeychain

chmod u+x git-credential-osxkeychain

sudo mv git-credential-osxkeychain "$(dirname $(which git))/git-credential-osxkeychain"

git config --global credential.helper osxkeychain

#dat private repo access
pub=$HOME/.ssh/id_rsa.pub
echo 'Checking for SSH key, generating one if it does not exist...'
if
  [ ! -f $pub ] ; then
  ssh-keygen -t rsa
  echo 'Copying public key to clipboard. Paste it into your Github account...'
  cat $pub | pbcopy
  open 'https://github.com/account/ssh'
fi

#import anti-gravity
brew install python
brew linkapps python
pip install Pygments
pip install requests
brew install python@2
brew install pyenv


#gowithit
brew install go

#java
brew install jenv

#mopidy
brew tap troyxmccall/mopidy
brew install mopidy
brew install mopidy-spotify

#thefuck: https://github.com/nvbn/thefuck
brew install thefuck

#vm builder tools
brew install packer
brew install ansible

#sharp
brew install homebrew/science/vips --with-webp --with-graphicsmagick

#yarn - smell ya later npm
brew install yarn

# Remove outdated versions from the cellar.
brew cleanup
