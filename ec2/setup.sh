# Oh-my-bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh)"

# Dotfiles
ls -d */ | tr : '\n' | sed 's/.$//' | xargs -n 1 ./link.sh
