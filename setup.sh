#!/bin/sh

print() {
  printf "\n%b\n" "$1"
}

print "\n#---------------------------------------------#"
print "|          Kayid's Environment Setup          |"
print "#---------------------------------------------#\n\n"


# Root Access

print "Root Access"
sudo -v
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &


print "#--- Xcode Dev Tools ---#"
if test ! $(which xcode-select); then
    print 'Installing Xcode Dev Tools' ;
    xcode-select --install
else
    print 'Xcode Dev Tools is already installed!';
fi


print "#--- Homebrew ---#"
if test ! $(which brew); then
  print 'Installing homebrew...'
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
else
  print 'Homebrew is already installed!';
  print 'Updating homebrew && upgrading all formulas'
  brew update
  brew upgrade --all
fi
