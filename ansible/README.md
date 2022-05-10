# Development Machine Setup

* Install core packages:

```sh
$ ansible-playbook -K -t"core" local.yml
```

* Install apps that requires manually adding the apt repo:

```sh
$ ./install.sh
```

* Authenticate github cli

```sh
gh auth login
```
