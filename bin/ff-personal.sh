#!/usr/bin/env zsh
firejail --ignore=private-dev --ignore=nodbus --private="$HOME/.firejail/personal" firefox -no-remote
