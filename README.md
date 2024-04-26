# Home

Home sweet home.

# First time setup

- Macos
```shell
make setup
```

## Plugins etc.

- **tmux**: run tmux and install plugins using `Ctrl+<space>` + `Shift+I`
- **nvim**: run nvim, Lazy will auto-install plugins

# Troubleshoot

**Check speed of shell startup**

```shell
for i in $(seq 1 10); do time $SHELL -i -c exit; done
```
