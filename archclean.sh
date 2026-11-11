#!/bin/bash

# State variables
SAFE_PACMAN=false
UNSAFE_PACMAN=false
SYS_CACHE=false
USER_CACHE=false
AUR_CACHE=false

show_help() {
    echo "Usage: archclean [OPTIONS]"
    echo "Modular cache cleaner for Arch Linux."
    echo ""
    echo "Options:"
    echo "  -sp          Safe pacman cache (keeps the latest 3 versions)"
    echo "  -up          Unsafe pacman cache (deletes all pacman cache)"
    echo "  -sc          System cache (cleans systemd logs older than 2 weeks)"
    echo "  -uc          User cache (cleans thumbnails and temporary cache in ~/.cache)"
    echo "  -ac          AUR cache (cleans yay or paru cache if installed)"
    echo "  -all         Runs all safe cleanups (-sp -sc -uc -ac)"
    echo "  -h, --help   Shows this help message"
}

# Show help if no arguments are passed
if [[ $# -eq 0 ]]; then
    show_help
    exit 1
fi

# Parse arguments
while [[ $# -gt 0 ]]; do
    case "$1" in
        -sp)
            SAFE_PACMAN=true
            shift
            ;;
        -up)
            UNSAFE_PACMAN=true
            shift
            ;;
        -sc)
            SYS_CACHE=true
            shift
            ;;
        -uc)
            USER_CACHE=true
            shift
            ;;
        -ac)
            AUR_CACHE=true
            shift
            ;;
        -all)
            SAFE_PACMAN=true
            SYS_CACHE=true
            USER_CACHE=true
            AUR_CACHE=true
            shift
            ;;
        -h|--help)
            show_help
            exit 0
            ;;
        *)
            echo "Error: Unknown option '$1'"
            echo "Run 'archclean -h' to see available options."
            exit 1
            ;;
    esac
done

# --- Execute tasks ---

if [ "$SAFE_PACMAN" = true ]; then
    echo ":: [sp] Cleaning pacman cache (keeping 3 versions)..."
    sudo paccache -r
    sudo paccache -ruk0
fi

if [ "$UNSAFE_PACMAN" = true ]; then
    echo ":: [up] Removing ALL pacman cache..."
    sudo paccache -rk0
fi

if [ "$SYS_CACHE" = true ]; then
    echo ":: [sc] Cleaning system logs (journald > 2 weeks)..."
    sudo journalctl --vacuum-time=2weeks
fi

if [ "$USER_CACHE" = true ]; then
    echo ":: [uc] Cleaning user thumbnail cache..."
    rm -rf ~/.cache/thumbnails/*
    echo "Thumbnails removed."
fi

if [ "$AUR_CACHE" = true ]; then
    echo ":: [ac] Checking for AUR helpers..."
    if command -v yay &> /dev/null; then
        echo "Cleaning yay cache..."
        yay -Sc --noconfirm
    elif command -v paru &> /dev/null; then
        echo "Cleaning paru cache..."
        paru -Sc --noconfirm
    else
        echo "Neither yay nor paru was found."
    fi
fi

echo "Cleanup complete!"
