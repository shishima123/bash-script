#!/bin/bash

new_file_paths=(
    "/git_ignore.sh"
    "/.gitignoretracked"
)

# Đường dẫn đến file .git/info/exclude
exclude_file=".git/info/exclude"

remove_local_git_ignore() {
    # Kiểm tra xem file có tồn tại không
    if [ -f "$exclude_file" ]; then
        # Duyệt qua từng dòng trong mảng và xóa chúng
        for line in "${new_file_paths[@]}"; do
            sed -i "\|$line|d" "$exclude_file"
        done
    fi
}

add_local_git_ignore() {
    remove_local_git_ignore

    if [ -f "$exclude_file" ]; then
        # Duyệt qua từng dòng trong mảng và them chúng
        for line in "${new_file_paths[@]}"; do
            echo $line >> $exclude_file
        done
    fi
}

touch .gitignoretracked

curl -s "https://raw.githubusercontent.com/shishima123/bash-script/master/git-ignore-files-tracked/script.sh" >> ./git_ignore.sh

chmod -x ./git_ignore.sh

add_local_git_ignore


