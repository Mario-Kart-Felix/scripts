# The DotBot
The Linux dotfiles and personalizations syncronizer.

## Features

- Store dotfiles for all distros in one place
- No hassle - automatic OS detection
- Can selectively restore some of the dotfiles
- Can install your regular packages for you
- Version maintenance for your dotfiles
- Lightweight - stores only changes in files across different distros

## How to populate `.dotfiles`?
- Put the addresses relative to the `$HOME/` directory.
    - Also accessible as `~/` usually.

## How to populate `.packages`?
- Fill the `.packages` in `~/.dotfiles/$YOUR_DISTRO/.packages` with the packages you'd like installed as the setup process.