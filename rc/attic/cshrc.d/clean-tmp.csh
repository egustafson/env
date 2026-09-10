# I am a C-Shell -*- shell-script -*-

# WSL targeted script, although, it's helpful on other environments

if ($?SSH_AUTH_SOCK) then
    find /tmp -maxdepth 1 \
              -mindepth 1 \
              -not -path ${SSH_AUTH_SOCK:h} \
              -user ${USER} \
              -mtime +2 \
              -print | xargs -r rm -r
endif
