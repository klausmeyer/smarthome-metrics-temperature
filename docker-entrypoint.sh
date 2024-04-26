#!/bin/sh

set -e

case "$1" in
  web)
    exec bundle exec puma -p $PORT
  ;;

  *)
    exec $@
  ;;
esac
