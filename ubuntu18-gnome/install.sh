#!/bin/bash

apps=(
  'clang-format'
  'curl'
  'ibus-bamboo'
  'fonts-firacode'
  "fonts-inconsolata"
  'geany'
  'neovim'
  'npm'
  'papirus-icon-theme'
  'stow'
  'subversion'
  'tmux'
  'valgrind'
  'vim'
  'vlc'
  'wget'
  'zathura'
  'zeal'
  'zsh'
)

dots=(
  'bash'
  'nvim'
  'tmux'
  'vim'
  'zsh'
)

function apt_update() {
  sudo apt update
}

function apt_install() {
  sudo apt install $* -y
}

function install_clang-format() {
  apt_install clang-format
}

function install_curl() {
  apt_install curl
}

function install_ibus-bamboo() {
  sudo add-apt-repository ppa:bamboo-engine/ibus-bamboo
  apt_update
  apt_install ibus-bamboo
  ibus-daemon &
  ibus restart
}

function install_fonts-firacode() {
  apt_install fonts-firacode
}

function install_fonts-inconsolata() {
  apt_install fonts-inconsolata
}


function install_geany() {
  apt_install geany libvte9
}

function install_neovim() {
  sudo apt install python-software-properties
  sudo add-apt-repository ppa:neovim-ppa/stable
  sudo apt update
  sudo apt install neovim -y
  sudo apt install python-dev python-pip python3-dev python3-pip -y
}

function install_npm() {
  apt_install npm
}

function install_papirus-icon-theme() {
  apt_install papirus-icon-theme
}

function install_stow() {
  apt_install stow
}

function install_subversion() {
  apt_install subversion
}

function install_tmux() {
  apt_install tmux
}

function install_valgrind() {
  apt_install valgrind
}

function install_vim() {
  apt_install vim vim-gtk3
  curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  vim +PlugInstall +qall
}

function install_vlc() {
  apt_install vlc
}

function install_wget() {
  apt_install wget
}

function install_zathura() {
  apt_install zathura
}

function install_zeal() {
  apt_install zeal
}

function install_zsh() {
  apt_install zsh
}

echo "Actions:"
echo "  [1] Install packages"
echo "  [2] Create symlinks for dotfiles"
read -p " -> " action

case $action in
  [1])
    apt_update
    echo "Options:"
    echo "  [1] Install all packages"
    echo "  [2] Install single packages"
    read -p " -> " option

    case $option in
      [1])
        for ((i = 0; i < ${#apps[@]}; i++));
        do
          echo "Installing "${apps}
          install_cmd=install_${apps[$i]}
          $install_cmd
        done
        echo
      ;;
      [2])
        for ((i = 0; i < ${#apps[@]}; i++));
        do
          echo -n $i: ${apps[$i]}"; "
        done
        echo

        read -p "  -> " inp
        IFS=' ' read -ra chosen_indices <<< "$inp"

        for chosen_index in "${chosen_indices[@]}"; do
          install_cmd=install_${apps[$chosen_index]}
          $install_cmd
        done
      ;;
      *)
        echo "Invalid input!"
        exit
      ;;
    esac
  ;;
  [2])
    for ((i = 0; i < ${#dots[@]}; i++));
    do
      echo -n $i: ${dots[$i]}"; "
    done
    echo

    read -p "  -> " chosen_app_index
    # cmd=stow ${dots[$chosen_app_index]}
    cmd="stow -t$HOME -v ${dots[$chosen_app_index]}"
    echo $cmd
    $cmd
  ;;
  *)
    exit
  ;;
esac
