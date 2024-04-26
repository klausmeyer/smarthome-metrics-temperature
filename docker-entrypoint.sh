#!/bin/sh

set -e

case "$1" in
  web)
    exec bundle exec puma -C config/puma.rb
  ;;

  *)
    exec $@
  ;;
esac
