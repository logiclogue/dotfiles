#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE}")" || exit;

git pull origin master;

function doIt() {
    for D in `ls -d */`; do
        for F in `ls -A $D`; do
            ln -sf $( pwd )/$D$F ~/
        done
    done
}

if [ "$1" == "--force" ] || [ "$1" == "-f" ]; then
	doIt;
else
	read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1;
	echo "";
	if [[ $REPLY =~ ^[Yy]$ ]]; then
		doIt;
	fi;
fi;

unset doIt;
