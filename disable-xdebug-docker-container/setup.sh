#!/bin/bash

script_name="./xdebug.sh"

new_file_paths=(
    "/xdebug.sh"
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

curl -s "https://raw.githubusercontent.com/shishima123/bash-script/master/disable-xdebug-docker-container/script.sh" >> ${script_name}

chmod -x ${script_name}

add_local_git_ignore


