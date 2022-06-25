# Personal Development Setup

This repository stores my personal development environment setup. It is now largely based on the Nix ecosystem.

## Reproduce on a new machine

To reproduce this setup on a new machine, I recommend following these steps:

* Step 1: Install NixOS with a GUI image. Restart the machine.
* Step 2: Open the `/etc/nixos/configuration.nix` file and add some crucial packages (for the next steps): a text editor (e.g. `vim`), a browser (e.g. `google-chrome`) and `git`.
* Step 3: Rebuild & switch to the new config.
```
sudo nixos-rebuild switch --flake .#<machine-id>
```
* Step 4: Clone this repo.
* Step 5: Create a new directory in the `./nix` directory for this new machine. Copy the `.nix` files from `/etc/nixos` to this directory.
* Step 6: Add a new attribute in the `nixConfigurations` set in the `flake.nix` file corresponding to the new machine.
* Step 7: Rebuild & switch to the new config with flake.
```
sudo nixos-rebuild switch --flake .#<machine-id>
```
* Step 8: Further configure the new machine with the nix files, rebuild, and switch.
* Step 9: Symlink other dotfiles with stow.
* Step 10: Restart the machine.

## Useful Nix Commands

### List generations

```sh
sudo nix-env --list-generations --profile /nix/var/nix/profiles/system
```

### Delete generations

```sh
sudo nix-env --delete-generations --profile /nix/var/nix/profiles/system
```

### Formatting all nix files

```sh
find . -name "*.nix" | xargs nixfmt
```
