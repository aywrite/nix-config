#!/usr/bin/env zsh
set_proxy

firejail --ignore=private-dev --ignore=nodbus --private="$HOME/.firejail/work" firefox -no-remote
