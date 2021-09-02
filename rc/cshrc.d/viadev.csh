# I am a C-Shell -*- shell-script -*-

if ( ${?VIALAP} ) then # short circuit && doesn't appear to work

    # setenv GO111MODULE on
    setenv GOPRIVATE 'git.viasat.com/*'

    alias code '/mnt/c/Users/egustafson/AppData/Local/Programs/Microsoft\ VS\ Code/bin/code'

    ## KV Stuff.
    setenv VIASATIO_CA_PATH ~/ca/viasatio.crt

    if ( $?loginsh && ! $?KVD_VICE_USER && -d ~/.password-store ) then
        ## --  Initialize Credentials in ENV VARS  -----------------
        setenv KVD_VICE_USER "egustafson"
        setenv KVD_VICE_PASS `pass viasatio/egustafson`

        setenv KVCTL_USER "egustafson"
        setenv KVCTL_PASS `pass viasatio/egustafson`
    endif

    ## Orbit stuff.
    ssh-add -q ~/.ssh/orbitnp.key
    ssh-add -q ~/.ssh/orbitprod.key
    #ssh-add -q ~/.ssh/orbit-jenkins-pp-slave.key

endif
