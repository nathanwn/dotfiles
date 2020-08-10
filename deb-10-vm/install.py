"""
    @author Nhat M. Nguyen
    @update 15-03-2020
"""


import os
import subprocess


CURL_DES = "~/install"


def apt_update():
    os.system("sudo apt update")


def apt_install(package):
    print(">>>>>>>> Installing {0}".format(package))
    os.system("sudo apt install {0} -y".format(package))


def apt_fix_broken():
    os.system("sudo apt install -fy")


def curl_install(app, url):
    print(">>>>>>>> Installing {0}".format(app))
    os.system("curl -o ~/install/{0}/{0}.deb -L --create-dirs {1}".format(app, url))
    os.system("sudo dpkg -i {0}/{1}/{1}.deb".format(CURL_DES, app))


def install_ibus():
    os.system("ibus restart")


def install_chrome():
    os.system("sudo apt install libxss1 libappindicator1 libindicator7")
    app = "chrome"
    url = "https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb"
    curl_install(app, url)
    apt_fix_broken()


def install_vim():
    print(">>>>>>>> Installing vim packages")
    os.system("curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim")
    os.system("vim +PlugInstall +qall")


def install_vscode():
    app = "code"
    url = "http://go.microsoft.com/fwlink/?LinkID=760868"
    curl_install(app, url)


def install_xfpanelswitch():
    app = "xfpanel-switch"
    url = "http://launchpadlibrarian.net/367095882/xfpanel-switch_1.0.7-0ubuntu2_all.deb"
    curl_install(app, url)


apt_packages = [
    # c/c++
    "build-essential"           ,
    "gdb"                       ,
    "valgrind"                  ,
    # text editors
    "vim"                       ,
    "vim-gtk"                   ,
    "neovim"                    ,
    "python3-neovim"            ,
    "geany"                     ,
    # tmux
    "tmux"                      ,
    # code formatter
    "clang-format"              ,
    # downloaders
    "curl"                      ,
    "wget"                      ,
    # fonts
    "ttf-ubuntu-font-family"    ,
    "ttf-mscorefonts-installer" ,
    "fonts-firacode"            ,
    # pdf
    "zathura"                   ,
    # svn
    "subversion"                ,
    # docsets
    "zeal"                      ,
    # unikey
    "ibus-unikey"               ,
    # guest-addition for virtualbox
    "dkms"                      ,
    # xfce4
    "papirus-icon-theme"        ,
    # zsh
    "zsh"                       ,
    # other
    "software-properties-common",
    # packages
    "snapd",
    # fpc
    "fpc-3.0.4",
    # python
    "python3-pip"
]


def main():
    apt_update()

    for package in apt_packages:
        apt_install(package)


if __name__ == "__main__":
    install_vscode()
