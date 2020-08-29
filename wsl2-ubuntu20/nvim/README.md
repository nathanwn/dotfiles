## Autocomplete

- Install `coc.nvim`
- [Extensions](`https://github.com/neoclide/coc.nvim/wiki/Using-coc-extensions`)


### Python

- `:CocInstall coc-python`
- Install & setup `jedi`:
  - `pip3 install jedi`
  - use pip3 to find jedi path `pip3 show jedi`
  - go to your coc-settings.json add the path shown by pip3 (exactly that path) and use it as the value of `"python.jediPath"`
