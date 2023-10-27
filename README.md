# Home

Home sweet home.

# TODO
- [ ] Setup an install target in Makefile which automatically calls the correct install script corresponding to OS (example: for macbook -> macos/Brewfile, for ubuntu -> linux/_something_)
    - [ ] Find a way to determine OS and ask user for confirmation
- [ ] Create an install script for Ubuntu using apt-get

# Setup

## Macos

Run the script to install `homebrew` and all brew packages:

```shell
./workspace/macos/setup-homebrew.sh
```

## Plugins etc.

After running the scripts, open TMUX and install plugins using `Ctrl+A+I`.
