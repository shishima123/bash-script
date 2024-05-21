# Git Ignore tracked files

💡 Purpose: To ignore files that are already tracked by Git

- Sometimes you may need to modify a file but don't want these changes pushed to Git. Since the file is already tracked, adding it to .gitignore the usual way won't work.

- Use this script to automatically hide or reveal these files as needed.

## Setup

- Run command in root project

    ```bash
    curl -s "https://raw.githubusercontent.com/shishima123/bash-script/master/git-ignore-files-tracked/setup.sh" | bash
    ```

- Edit file `.gitignoretracked`. Add paths need to ignore

    Eg:
    ```
    docker/app.docker
    docker/docker-compose.yml
    ```

## Usage

- Run script in terminal on root project -> Select options in terminal

    ```bash
    bash git_ignore.sh
    ```