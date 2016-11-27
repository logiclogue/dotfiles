#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE}")" || exit;

function doIt() {
    for F in `ls -A build`; do
        ln -sf $( pwd )/build/$F ~/
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
