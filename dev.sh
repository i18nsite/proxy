#!/usr/bin/env bash

DIR=$(realpath $0) && DIR=${DIR%/*}
cd $DIR
if [ ! -d conf ]; then
	ln -s conf.example conf
fi
set -e
set -a
. conf/r.env
set +a
set -x

watchexec -w src -e v -- v run .
