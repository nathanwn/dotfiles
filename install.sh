#!/usr/bin/env bash

set -euo pipefail

cp ./stow/.* ~/
stow home
