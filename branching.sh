#!/bin/bash

function branching(){
    cd $(mktemp -d) &&
	git clone git clone git@github.com:desertedscorpion/abandonnedsmoke.git &&
	git checkout -b branch-$(printf %04d $((${RANDOM}%10000)))-$(echo "${@}" | tr [" "] [_]) &&
	ln -sf ${HOME}/working/desertedscorpion/abandonnedsmoke/private private &&
	true
} &&
    true
