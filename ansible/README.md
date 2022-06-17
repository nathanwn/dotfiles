# Development Machine Setup

## Steps

### Add ssh key to github

```sh
$ ansible-playbook -K -t"ssh" local.yml
```


### Change remote from HTTPS to SSH

```
$ git remote set-url origin git@github.com:nathan-wien/dotfiles.git
```

* Install core packages:

```sh
$ ansible-playbook -K -t"core" local.yml
```

## Ubuntu only

* Install apps that requires manually adding the apt repo:

```sh
$ ./install.sh
```
