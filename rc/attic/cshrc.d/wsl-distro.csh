# I am a C-Shell -*- shell-script -*-

if (${?WSL_DISTRO_NAME}) then
    set distro = `echo $WSL_DISTRO_NAME | tr '[:upper:]' '[:lower:]'`
    switch ($distro)
    case 'ubuntuwsl2':
        set distro = 'ub2'
        breaksw
    case 'ubuntu':
        set distro = 'ub'
        breaksw
    case 'debian':
        set distro = 'deb'
        breaksw
    default:
        breaksw
    endsw
    set prompt = "`hostname -s`($distro)> "

    alias code "/mnt/c/Users/${USER}/AppData/Local/Programs/Microsoft\ VS\ Code/bin/code"
endif
