##  ~/.bashrc.d/ module  #############################################

# WSL targeted script, although, its helpful for other environments

if [ -z "$SSH_AUTH_SOCK" ]; then
    SSH_AUTH_DIR=$(dirname "$SSH_AUTH_SOCK")
    find /tmp -maxdepth 1 \
              -mindepth 1 \
              -not -path "$SSH_AUTH_DIR" \
              -user "$USER" \
              -mtime +2 \
              -print | xargs -r rm -r
fi

## Local Variables:
## mode: shell-script
## sh-shell: bash
## End:
