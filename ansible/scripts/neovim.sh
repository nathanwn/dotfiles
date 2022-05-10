mkdir ~/install
cd ~/install
gh release download --repo neovim/neovim v0.7.0 --pattern 'nvim-linux64.deb'
sudo dpkg -i nvim-linux64.deb
