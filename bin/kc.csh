# I am a csh -*- shell-script -*-

kubectl config view >& /dev/null
if ( $status > 0 ) then
    echo "\!\! kubectl is broken"
    exit 1
endif

if ( $#argv <= 0 ) then
    if ( $?KUBECONFIG ) then
        echo "KUBECONFIG = $KUBECONFIG"
    else
        echo "KUBECONFIG = <unset>"
    endif
    kubectl config current-context >& /dev/null
    if ( $status == 0 ) then
        set kctx = `kubectl config current-context`
        echo "current-context: $kctx"
        unset kctx
    endif
    exit 0
endif

if ( "$argv" == "-l" || "$argv" == "--list" ) then
    set kconfigs = `(cd ~/.kube; /usr/bin/ls | grep '\.config$' | sed 's/\.config//')`
    if ( $#kconfigs <= 0 ) then
        echo "# kube envs:  <none>"
    else
        echo "# kube envs:"
        foreach config ( $kconfigs )
            echo "  - $config"
        end
    endif
    unset kconfigs
    exit 0
endif

set cleanprompt = `echo "$prompt" | sed 's/\({\([A-Za-z0-9_-]*\)}[ ]*\)*//'`

if ( "$argv" == "-" ) then
    unsetenv KUBECONFIG
    unalias kubectl
    set prompt = "$cleanprompt "
    unset cleanprompt
    exit 0
endif

set kconfig = "~/.kube/$argv[1].config"
if ( ! ( -r $kconfig ) ) then
    echo "\!\! $kconfig missing"
    unset kconfig
    unset cleanprompt
    exit 1
endif

setenv KUBECONFIG $kconfig
set prompt = "{$argv[1]} $cleanprompt"
unset kconfig
unset cleanprompt

exit 0
