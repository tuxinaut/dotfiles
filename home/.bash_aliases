#!/bin/bash

WORKSPACE="~/workspace"

alias GOTO_WORKSPACE="cd ${WORKSPACE}";

alias GOTO_CHEF_KITCHEN="cd ${WORKSPACE}/chef-kitchen"

alias GOTO_DU_LIVE="cd /media/live-server/home/httpdocs/http/CEVO_/cccv/DU";

alias knife_solo="bundle exec knife solo"
alias knife_databag="knife solo data bag"

####################################################
#			System			   #
####################################################
alias ll='ls -l';
alias hgrep='history | grep -i';
alias cpr='rsync --progress';

####################################################
#			Apt-get			   #
####################################################
alias ags='apt-cache search';
alias agpi='apt-cache show';
alias agi='sudo apt-get install';
alias agr='sudo apt-get remove';
alias agu='sudo apt-get update';
alias agg='sudo apt-get upgrade';

alias addr='sudo add-apt-repository';

####################################################
#			dpkg			   #
####################################################
alias dpkgpi='dpkg --get-selections | grep -i';

alias gem_clean='sudo gem install --no-rdoc --no-ri';
