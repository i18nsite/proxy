#!/usr/bin/env bash

DIR=$(realpath $0) && DIR=${DIR%/*}
cd $DIR
set -ex
. env.sh
dc="mise exec -- $compose"
$dc -p $(basename $(dirname $DIR)) down $@
