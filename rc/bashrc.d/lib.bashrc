##  ~/.bashrc.d/ library  ############################################

##  setpath - turn a list into $PATH
#
function setpath {
    local old_ifs="$IFS"
    IFS=":"
    export PATH="$*"
    IFS="$old_ifs"
}

##  prpath - echo the $PATH \n delineated
#
function prpath {
    echo "${PATH//:/$'\n'}"
}

## Local Variables:
## mode: shell-script
## sh-shell: bash
## End:
