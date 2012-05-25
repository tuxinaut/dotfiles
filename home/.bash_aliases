#!/bin/bash

WORKSPACE="~/workspace"

alias GOTO_WORKSPACE="cd ${WORKSPACE}";

alias GOTO_DU_GIT="cd ${WORKSPACE}/Du\ Kasse";
alias GOTO_DU_LIVE="cd /media/live-server/home/httpdocs/http/CEVO_/cccv/DU";

alias GOTO_FPB="cd ${WORKSPACE}/FPB_Onlinerechner";
alias GOTO_VERMOEGENSSCHADEN_GIT="cd ${WORKSPACE}/Vermoegensschaden/";
alias GOTO_VERMOEGENSSCHADEN_TESTS="cd ${WORKSPACE}/Vermoegensschaden/tests/";

alias GOTO_ADMIN_GIT="cd ${WORKSPACE}/administration";
alias GOTO_PYT3UPDATER_GIT="cd ${WORKSPACE}/pyt3updater";

alias REDMINE_LOG="ssh cevo_amsterdam tail -F /srv/www/redmine.cevo.de/log/production.log";

####################################################
#			System			   #
####################################################
alias ll='ls -l';
alias hgrep='history | grep -i';
alias cpr='rsync --progress';
alias ssh-gitolite='ssh -T';

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

alias du_copy_dev='cp -rv * /media/test-server/home/httpdocs/http/CEVO_/cccv/dev.formulare-ssl.de';
alias du_copy_test='cp -rv * /media/test-server/home/httpdocs/http/CEVO_/cccv/DU/';
alias du_copy_live='cp -rv * /media/live-server/home/httpdocs/http/CEVO_/cccv/DU/';

alias gem_clean='sudo gem install --no-rdoc --no-ri';
