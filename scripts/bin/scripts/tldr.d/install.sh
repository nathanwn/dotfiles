git clone https://github.com/tldr-pages/tldr.git

find tldr/pages | awk -F '/' '{print $4}' | awk -F '.' '{print $1}' | awk NF | sort | tee entries.txt

rm -rf tldr

