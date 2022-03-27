# I am a C-Shell -*- shell-script -*-

if (${?WSL_DISTRO_NAME}) then
    set distro = `echo $WSL_DISTRO_NAME | tr '[:upper:]' '[:lower:]'`
    set prompt = "`hostname -s`($distro)> "

    alias code "/mnt/c/Users/${USER}/AppData/Local/Programs/Microsoft\ VS\ Code/bin/code"
endif
