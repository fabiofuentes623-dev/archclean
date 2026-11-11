# archclean

A lightweight, modular cache cleaner for Arch Linux written in Bash.

## Features
- `-sp`: Safe pacman cache cleanup (keeps latest 3 versions)
- `-up`: Unsafe pacman cache cleanup (removes all cached packages)
- `-sc`: System cache cleanup (vacuums systemd journal logs older than 2 weeks)
- `-uc`: User cache cleanup (cleans thumbnails)
- `-ac`: AUR helper cache cleanup (`yay` / `paru`)
- `-all`: Runs all safe cleanups at once

## Installation

```bash
git clone https://github.com
cd archclean
makepkg -si
```

## Usage
```bash
archclean -h
```
