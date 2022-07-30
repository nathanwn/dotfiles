# Regolith 2

## Change default terminal emulator

```
update-alternatives --install /usr/bin/x-terminal-emulator x-terminal-emulator <path to your emulator> 50
update-alternatives --config x-terminal-emulator
```

(may need to run with `sudo`, I have to recheck)
