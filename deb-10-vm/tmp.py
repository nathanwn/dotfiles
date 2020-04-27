import os
import subprocess


CURL_DES = "~/install"


def curl_install(app, url):
    print(">>>>>>>> Installing {0}".format(app))
    os.system("curl -o ~/install/{0}/{0}.deb -L --create-dirs {1}".format(app, url))
    os.system("sudo dpkg -i {0}/{1}/{1}.deb".format(CURL_DES, app))

def install_vim():
    print(">>>>>>>> Installing vim packages")
    os.system("curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim")
    os.system("vim +PlugInstall +qall")


install_vim()
