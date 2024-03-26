# Home

Home sweet home.

# TODO
- [ ] Setup an install target in Makefile which automatically calls the correct install script corresponding to OS (example: for macbook -> macos/Brewfile, for ubuntu -> linux/_something_)
    - [ ] Find a way to determine OS and ask user for confirmation
- [ ] Create an install script for Ubuntu using apt-get

# First time setup

- Macos

```shell
make setup
```

## Plugins etc.

- tmux: run tmux and install plugins using `Ctrl+<space>` + `Shift+I`
- nvim: run nvim, Lazy will auto-install plugins

# Troubleshoot

**Check speed of shell startup**

```shell
for i in $(seq 1 10); do time $SHELL -i -c exit; done
```
