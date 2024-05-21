#!/bin/bash

# Màu cho text
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m' # No Color

# Ignore all file listing in gitignoretracked
ignore_tracked() {
    while IFS="" read -r p || [ -n "$p" ]
    do
        echo "$p"
        git update-index --assume-unchanged $p
    done < .gitignoretracked

    echo -e "${GREEN}Files ignored${NC}"
}

# Revert all file ignored listing in gitignoretracked
revert_ignore_tracked() {
    while IFS="" read -r p || [ -n "$p" ]
    do
        echo "$p"
        git update-index --no-assume-unchanged $p
    done < .gitignoretracked

    echo -e "${GREEN}Files Reverted${NC}"
}

# List `assume unchanged` files under current directory
show_files_ignored() {
    echo -e "${GREEN}List File Ignore${NC}"
    git ls-files -v | grep -E "^[a-z]"
}

# Tạo menu prompt
PS3="Select option (press Ctrl+C to exit): "
options=("Ignore files tracked(git)" "Revert files ignored(git)" "Show files ignored(git)" "Exit")

while true; do
    select opt in "${options[@]}"; do
        case $opt in
            "Ignore files tracked(git)")
                ignore_tracked
                break
                ;;
            "Revert files ignored(git)")
                revert_ignore_tracked
                break
                ;;
            "Show files ignored(git)")
                show_files_ignored
                break
                ;;
            "Exit")
                exit 0
                break
                ;;
            *) echo "Option not found";;
        esac
    done
    echo "-----------------------------------------"
done
