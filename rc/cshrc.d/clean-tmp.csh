# I am a C-Shell -*- shell-script -*-

# WSL targeted script, although, it's helpful on other environments

find /tmp -maxdepth 1 -user ${USER} -mtime +1 -print | xargs -r rm -r
