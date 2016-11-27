all: pull install build bootstrap

pull:
	git pull origin master

install:
	npm install

bootstrap:
	sh bootstrap.sh

build:
	node build.js

.PHONY: git npm bootstrap build
