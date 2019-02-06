#!/bin/bash

#	System
alias ll='ls -l';
alias hgrep='history | grep -i';
alias cpr='rsync --progress';

# Apt
alias ags='apt search';
alias agpi='apt show';
alias agi='sudo apt install';
alias agr='sudo apt remove';
alias agu='sudo apt update';
alias agg='sudo apt upgrade';
alias agd="apt depends"
alias agr="sudo apt remove"
alias agrp="sudo apt purge"

alias addr='sudo add-apt-repository';

# dpkg
alias dpkgpi='dpkg --get-selections | grep -i';

alias gem_clean='gem install --no-rdoc --no-ri';

# Nix
alias update_home='nix-channel --update && home-manager -f ~/.config/nixpkgs/work.nix switch'
