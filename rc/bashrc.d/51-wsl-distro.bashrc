##  ~/.bashrc.d/ module  #############################################

if [ -n "$WSL_DISTRO_NAME" ]; then
    distro=$(echo $WSL_DISTRO_NAME | tr '[:upper:]' '[:lower:]')

    case $distro in
        "ubuntuwsl2")
            distro="ub2"
            ;;
        "ubuntu")
            distro="ub"
            ;;
        "debian")
            distro="deb"
            ;;
        *)
            ;;
    esac

    export PS1="\h($distro)\$> "
    alias code="/mnt/c/Users/${USER}/AppData/Local/Programs/Microsoft\ VS\ Code/bin/code"
fi

## Local Variables:
## mode: shell-script
## sh-shell: bash
## End:
