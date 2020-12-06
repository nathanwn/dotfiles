#!/bin/bash

packages=(
  'base-devel'
  'code'
  'curl'
  'discord'
  'feh'
  'font-awesome'
  'geany'
  'neovim'
  'rofi'
  'snapd'
  'spotify'
  'stow'
  'subversion'
  'texlive-most'
  'tmux'
  'valgrind'
  'vim'
  'wget'
  'zathura'
  'zsh'
)

dots=(
  'bash'
  'i3'
  'nvim'
  'rofi'
  'termite'
  'tmux'
  'vim'
  'zsh'
)

function pacman_update() {
  echo "Do something..."
}

function pacman_install() {
  sudo pacman -Sy $*
}

function snap_install() {
  sudo snap install $*
}

function yay_install() {
  yay -S $*
}

function install_code() {
  pacman_install code
}

function install_discord() {
  pacman_install discord
}

function install_feh() {
  pacman_install feh
}

function install_font-awesome() {
  pacman_install ttf-font-awesome
}

function install_geany() {
  pacman_install geany
}

function install_neovim() {
  pacman_install neovim
}

function install_rofi() {
  pacman_install rofi
}

function install_snapd() {
  yay_install snapd
  sudo systemctl enable snapd
}

function install_spotify() {
  pacman_install spotify
}

function install_stow() {
  pacman_install stow
}

function install_texlive-most() {
  pacman_install texlive-most
}

function install_tmux() {
  pacman_install tmux
}

function install_vim() {
  pacman_install vim gvim
  curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  vim +PlugInstall +qall
}

function install_wget() {
  pacman_install wget
}

function install_zathura() {
  pacman_install zathura zathura-pdf-mupdf
}

function install_zsh() {
  pacman_install zsh
}

echo "Actions:"
echo "  [1] Install packages"
echo "  [2] Create symlinks for dotfiles"
read -p " -> " action

case $action in
  [1])
    echo "Options:"
    echo "  [1] Install all packages"
    echo "  [2] Install single packages"
    read -p " -> " option

    case $option in
      [1])
        for ((i = 0; i < ${#packages[@]}; i++));
        do
          echo "Installing "${packages}
          install_cmd=install_${packages[$i]}
          $install_cmd
        done
        echo
      ;;
      [2])
        for ((i = 0; i < ${#packages[@]}; i++));
        do
          echo -n $i: ${packages[$i]}"; "
        done
        echo

        read -p "  -> " inp
        IFS=' ' read -ra chosen_indices <<< "$inp"

        for chosen_index in "${chosen_indices[@]}"; do
          install_cmd=install_${packages[$chosen_index]}
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

    read -p "  -> " chosen_package_index
    # cmd=stow ${dots[$chosen_package_index]}
    cmd="stow -t$HOME -v ${dots[$chosen_package_index]}"
    echo $cmd
    $cmd
  ;;
  *)
    exit
  ;;
esac
