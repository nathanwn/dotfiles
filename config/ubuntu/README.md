# Ubuntu 20.04

## Gnome Terminal Themes

- Theme installer: [Gogh by Mayccoll](https://github.com/Mayccoll/Gogh)

## Keychron keyboard F keys issue

Edit/Create the file `/etc/modprobe.d/hid_apple.conf` with the following line:

```
options hid_apple fnmode=2
```

followed by:

```bash
sudo update-initramfs -u && reboot
```

Reference: [url](https://github.com/Kurgol/keychron/blob/master/k2.md#f-keys-on-ubuntu)
