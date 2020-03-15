"""
    @author Nhat M. Nguyen
    @update 15-03-2020
"""


import os
import subprocess


def apt_update():
    os.system("sudo apt update")


def apt_install(package):
    print(">>>>>>>> Installing {0}".format(package))
    os.system("sudo apt install {0} -y".format(package))


def install_vim():
    print(">>>>>>>> Installing vim packages")
    os.system("curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim")
    os.system("vim +PlugInstall +qall")


def install_vscode():
    print(">>>>>>>> Installing vscode")
    os.system("curl -o ~/install/code/code.deb -L --create-dirs http://go.microsoft.com/fwlink/?LinkID=760868")
    os.system("sudo dpkg -i ~/install/code/code.deb")


apt_packages = [
    # c/c++
    "build-essential"           ,
    "gdb"                       ,
    "valgrind"                  ,
    # text editors
    "vim"                       ,
    "vim-gtk"                   ,
    "geany"                     ,
    # tmux
    "tmux"                      ,
    # downloaders
    "curl"                      ,
    "wget"                      ,
    # fonts
    "ttf-ubuntu-font-family"    ,
    "ttf-mscorefonts-installer" ,
    # pdf
    "zathura"                   ,
    # svn
    "subversion"                ,
    # other
    "software-properties-common"
]


apt_update()


for package in packages:
    apt_install(package)
