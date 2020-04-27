# java 11
sudo apt install openjdk-11-jdk
# this also works
sudo apt install default-jdk

# java 8
sudo apt update
sudo apt install apt-transport-https ca-certificates wget dirmngr gnupg software-properties-common
wget -qO - https://adoptopenjdk.jfrog.io/adoptopenjdk/api/gpg/key/public | sudo apt-key add -
sudo add-apt-repository --yes https://adoptopenjdk.jfrog.io/adoptopenjdk/deb/
sudo apt update
sudo apt install adoptopenjdk-8-hotspot

# to select default java version: sudo update-alternatives --config java
