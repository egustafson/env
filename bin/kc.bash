##  ~/bin/kc.bash  -- kubeconfig helper  #############################

if ! [ -x "$(type -P kubectl)" ]; then
    echo "ERR: kubectl not found in PATH"
    return 1
fi

if [ "$#" -eq 0 ]; then
    if [ -n "$KUBECONFIG" ]; then
        echo "KUBECONFIG = $KUBECONFIG"
    else
        echo "KUBECONFIG = <unset>"
    fi
    kubectl config current-context &> /dev/null
    if [ "$?" -eq 0 ]; then
        echo "current-context: $(kubectl config current-context)"
    fi
    return 0
fi

if [ "$1" = "-l" ] || [ "$1" = "--list" ]; then
    kconfigs=( $(cd ~/.kube; /usr/bin/ls | grep '\.config$' | sed 's/\.config//') )
    if [ "${#kconfigs[@]}" -eq 0 ]; then
        echo "kube envs:  <none>"
    else
        echo "kube envs:"
        for cfg in "${kconfigs[@]}"; do
            echo "  - $cfg"
        done
    fi
    unset kconfigs
    return 0
fi

clean_ps1=$(echo "$PS1" | sed 's/\({\([A-Za-z0-9_-]*\)}[ ]*\)*//')

if [ "$1" = "-" ]; then
    unset KUBECONFIG
    export PS1="$clean_ps1"
    unset clean_ps1
    return 0
fi

kconfig=~/.kube/$1.config
if ! [ -r $kconfig ]; then
    echo "ERR:  $kconfig missing"
    unset kconfig
    unset clean_ps1
    return 1
fi

export KUBECONFIG=$kconfig
export PS1="{$1} $clean_ps1"
unset kconfig
unset cleanprompt

return 0

## Local Variables:
## mode: shell-script
## sh-shell: bash
## End:
