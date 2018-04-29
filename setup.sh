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