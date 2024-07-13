# Notes

## Zotero

- [Installation instructions](https://www.zotero.org/support/installation)

## Disable suspending on xfce4+i3

```
sudo systemctl mask sleep.target suspend.target hibernate.target hybrid-sleep.target
```

To revert `systemctl mask`, do `systemctl unmask`.
