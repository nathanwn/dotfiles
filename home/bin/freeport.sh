#!/usr/bin/env bash

# Kill a process that is holding onto a port.
# Requires netstat.

set -eu

if [[ "$#" -ne 1 ]]; then
  echo "Usage: freeport.sh <port number>"
  exit 1
fi

exec netstat --tcp --udp --listening --program --numeric \
  | grep "$1" \
  | awk -F ' ' '{print $7}' \
  | awk -F '/' '{print $1}' \
  | xargs kill
