#!/usr/bin/env bash

DIR=$(realpath $0) && DIR=${DIR%/*}
cd $DIR
set -e
set -a
. $DIR/../conf/r.env
. $DIR/env.sh
set +a
echo -e "R_PASSWORD=${R_PASSWORD}\nR_PORT=${R_PORT}" >.env

set -x

if [ ! -d "./mnt" ]; then
  mkdir -p ./mnt/data/kvrocks ./mnt/log/kvrocks
  sudo chown -R 999:999 ./mnt/data/kvrocks ./mnt/log/kvrocks
fi

NAME=$(basename $(dirname $DIR))

case $(uname -s) in
Linux*)
  podman-compose -p $NAME up -d
  cleanup() {
    echo "正在执行清理操作..."
    podman-compose down
    echo "所有服务已关闭。"
  }
  trap cleanup EXIT
  podman-compose logs -f

  ;;
*)
  docker-compose -p $NAME up
  ;;
esac
