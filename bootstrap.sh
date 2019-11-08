#!/usr/bin/env bash

current_dir="$( pwd )/$( dirname "${BASH_SOURCE[0]}" )"
destination_dir=~
build_dir=$current_dir/build

cd "$current_dir" || exit;

function doIt() {
    mkdir -p "$destination_dir"
    cd "$build_dir" || return

    for d in $( find . -type d )
    do
        mkdir -p "$destination_dir/$d"
    done

    for f in $( find . -type f )
    do
        ln -sf "$build_dir/$f" "$destination_dir/$( dirname "$f" )"
    done

    cd "$current_dir" || return
}

if [ "$1" == "--force" ] || [ "$1" == "-f" ]; then
	doIt;
else
	read -rp "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1;
	echo "";
	if [[ $REPLY =~ ^[Yy]$ ]]; then
		doIt;
	fi;
fi;

unset doIt;
