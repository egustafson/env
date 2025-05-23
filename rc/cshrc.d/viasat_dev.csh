# I am a C-Shell -*- shell-script -*-

if ( ${?VIALAP} && $?loginsh ) then

    # Alohomora -> SAML Profile
    setenv AWS_DEFAULT_PROFILE saml

    # reset Kubernetes configuration(s)
    unalias kubectl
    unsetenv KUBECONFIG

    # setenv GO111MODULE on
    setenv GOPRIVATE 'git.viasat.com/*'

    if ( $?WSL_DISTRO_NAME ) then
        # only inject this alias on WSL hosts (probably should be more restrictive)
        alias code '/mnt/c/Users/egustafson/AppData/Local/Programs/Microsoft\ VS\ Code/bin/code'
    endif

    ## KV Stuff.
    setenv VIASATIO_CA_PATH ~/ca/viasatio.crt

    setenv KVCTL_CERT ~/pki/egustafson-client/kvs-client-chain.pem
    setenv KVCTL_KEY  ~/pki/egustafson-client/kvs-client-key.pem

    if ( -d ~/.password-store ) then
        ## --  Initialize Credentials in ENV VARS  -----------------
        setenv KVD_VICE_USER "egustafson"
        setenv KVD_VICE_PASS `pass viasatio/egustafson`

        setenv KVCTL_USER "egustafson"
        setenv KVCTL_PASS `pass viasatio/egustafson`

        setenv VICECLI_USER "egustafson"
        setenv VICECLI_PWD `pass viasatio/egustafson`

        setenv ETCDCTL_ENDPOINTS 'http://localhost:2379'
    endif

    ## Orbit stuff.
    #ssh-add -q ~/.ssh/orbitnp.key
    #ssh-add -q ~/.ssh/orbitprod.key
    #ssh-add -q ~/.ssh/orbit-jenkins-pp-slave.key

    ## IDS Drone Stuff
    if ( -d ~/.password-store) then
        setenv DRONE_SERVER https://drone-dev.interactivedatastore.viasat.io/
        setenv DRONE_TOKEN `pass ents/drone/token`
    endif

endif
