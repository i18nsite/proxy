#!/usr/bin/env bash

case $(uname -s) in
  Linux*)
    compose=podman-compose
    ;;
  *)
    compose="docker-compose"
    ;;
esac
