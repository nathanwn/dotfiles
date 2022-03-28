#!/usr/bin/env bash

git clone https://github.com/tldr-pages/tldr.git
ldfn tldr/pages | tee entries.txt
rm -rf tldr
