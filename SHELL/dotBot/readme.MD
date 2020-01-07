# The DotBot
The Linux dotfiles and personalizations syncronizer.

## Features

- Store dotfiles for all distros in one place
- No hassle - automatic OS detection
- Can selectively restore some of the dotfiles
- Can install your regular packages for you
- Version maintenance for your dotfiles
- Lightweight - stores only changes in files across different distros

## `.dotfiles`
- Put the absolute address to the files which you want to back up using dotBot in this file.
    - Accessible as `~/.dotfiles`.

## `.packages`
- Fill the `.packages` file with the packages you'd like to install everytime your configs on a particular distro are restored.
- Accessible as `~/.packages`.

## `custom.sh`
- Put any custom script that you would like to run in this file.