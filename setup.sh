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
  brew update && brew upgrade
fi


formulas=(
  # GNU core utilities
  coreutils 
  moreutils 
  findutils
  bash 
  zsh 
  vim --override-system-vi
  wget --with-iri
  git 
  heroku-toolbelt
  pyenv
  python 
  python3
  octave
  rbenv
  ruby
  # C/C++
  cmake 
  gcc
  go
  # MEAN Stack
  mongodb
  node
  mysql
  sqlite
  tree # recursive directory listing
  wifi-password
)

print 'Intalling brew formulas'
print ${formulas[@]}
brew install ${formulas[@]}


apps=(
  iterm2
  alfred
  atom sublime-text
  intellij-idea pycharm clion webstorm
  google-chrome slack
  java
  xquartz
  vagrant virtualbox
  docker boot2docker docker-toolbox
  macdown
  vlc spotify
  android-file-transfer
  # QuickLook
  qlcolorcode qlstephen qlmarkdown quicklook-json qlprettypatch
  quicklook-csv betterzipql qlimagesize webpquicklook suspicious-package
  launchrocket # manage homebrew formulas
)

print 'Intalling my Apps'
print ${apps[@]}
brew cask install  --appdir="/Applications" ${apps[@]}

brew update && brew upgrade brew-cask && brew cleanup && brew cask cleanup


print "#--- macOS ---#"

# Disable the “Are you sure you want to open this application?” dialog
defaults write com.apple.LaunchServices LSQuarantine -bool false

# Extra Zooming: Use scroll gesture + Ctrl (^)
defaults write com.apple.universalaccess closeViewScrollWheelToggle -bool true
defaults write com.apple.universalaccess HIDScrollZoomModifierMask -int 262144

# Save screenshots to the Desktop/Screenshots
mkdir ${HOME}/Desktop/Screenshots
defaults write com.apple.screencapture location -string "${HOME}/Desktop/Screenshots"

# Enable repeating keys
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false


print "#--- Finder ---#"

print "Show hidden and dotfiles files"
defaults write com.apple.Finder AppleShowAllFiles -bool true
defaults write com.apple.finder AppleShowAllFiles TRUE

print "Show files extensions"
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

print "Use list view"
defaults write com.apple.finder FXPreferredViewStyle Nlsv


print "Stop creating .DS_Store"
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

print "Enable Text selection in Quick View"
defaults write com.apple.finder QLEnableTextSelection -bool true

print "Disable the warning when changing a file extension"
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

print "Show the ~/Library folder"
chflags nohidden ~/Library


print "#--- Dock ---#"
# Enable highlight hover effect for the grid view of a stack (Dock)
defaults write com.apple.dock mouse-over-hilite-stack -bool true

# Set the icon size of Dock items to 37 pixels
defaults write com.apple.dock tilesize -int 37

# Make Dock icons of hidden applications translucent
defaults write com.apple.dock showhidden -bool true

# Remove workspace auto-switching
defaults write com.apple.dock workspaces-auto-swoosh -bool NO


print "#--- Terminal & iTerm2 ---#"

# Only use UTF-8 in Terminal.app
defaults write com.apple.terminal StringEncodings -array 4

# Use a modified version of the Solarized Dark theme by default in Terminal.app
osascript <<EOD
tell application "Terminal"
    local allOpenedWindows
    local initialOpenedWindows
    local windowID
    set themeName to "Solarized Dark xterm-256color"
    (* Store the IDs of all the open terminal windows. *)
    set initialOpenedWindows to id of every window
    (* Open the custom theme so that it gets added to the list
       of available terminal themes (note: this will open two
       additional terminal windows). *)
    do shell script "open '$HOME/init/" & themeName & ".terminal'"
    (* Wait a little bit to ensure that the custom theme is added. *)
    delay 1
    (* Set the custom theme as the default terminal theme. *)
    set default settings to settings set themeName
    (* Get the IDs of all the currently opened terminal windows. *)
    set allOpenedWindows to id of every window
    repeat with windowID in allOpenedWindows
        (* Close the additional windows that were opened in order
           to add the custom theme to the list of terminal themes. *)
        if initialOpenedWindows does not contain windowID then
            close (every window whose id is windowID)
        (* Change the theme for the initial opened terminal windows
           to remove the need to close them in order for the custom
           theme to be applied. *)
        else
            set current settings of tabs of (every window whose id is windowID) to settings set themeName
        end if
    end repeat
end tell
EOD

# Enable “focus follows mouse” for Terminal.app and all X11 apps
# i.e. hover over a window and start typing in it without clicking first
#defaults write com.apple.terminal FocusFollowsMouse -bool true
#defaults write org.x.X11 wm_ffm -bool true

start_if_needed() {
  local grep_name="[${1:0:1}]${1:1}"

  if [[ -z $(ps aux | grep -e "${grep_name}") ]]; then
    if [ -e ~/Applications/$1.app ]; then
      open ~/Applications/$1.app
    else
      if [ -e /Applications/$1.app ]; then
        open /Applications/$1.app
      fi
    fi
  fi

  true
}

# Install the Solarized Dark theme for iTerm
start_if_needed iTerm
open "${HOME}/init/Solarized Dark.itermcolors"

# Don’t display the annoying prompt when quitting iTerm
defaults write com.googlecode.iterm2 PromptOnQuit -bool false


for app in "Finder" "Dock" "Activity Monitor" "Address Book" "Calendar" "Contacts" "cfprefsd" \
    "Google Chrome" "Google Chrome Canary" "Mail" "Messages" \
    "Opera" "Safari" "SizeUp" "Spectacle" "SystemUIServer" \
    "Transmission" "Twitter" "iCal"; do
    killall "${app}" > /dev/null 2>&1
done


print "#--- Oh my Zsh ---#"

if test ! $(which zsh); then
  print 'Installing oh-my-zsh...'
  curl -L http://install.ohmyz.sh | sh
else
  print 'Zsh is already installed!'
  echo "Do you want to re-install zsh? (y/n)"
  read -r response
  case $response in
    [yY])
      print 'Removing old zsh'
      uninstall_oh_my_zsh
      sudo rm -rf /Users/amrmkayid/.oh-my-zsh
      print 'Re-Installing oh-my-zsh...'
      curl -L http://install.ohmyz.sh | sh
      break;;
    *) break;;
  esac
fi

ln -sf "$(pwd)/.zshrc" ~/.zshrc
cp "$(pwd)/kayid.zsh-theme" ~/.oh-my-zsh/themes/
