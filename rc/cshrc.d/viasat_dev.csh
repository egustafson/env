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
    setenv ETCDCTL_ENDPOINTS 'http://localhost:2379'

    setenv VIASATIO_CA_PATH ~/ca/viasatio.crt

    setenv KVCTL_CERT ~/pki/egustafson-client/kvs-client-chain.pem
    setenv KVCTL_KEY  ~/pki/egustafson-client/kvs-client-key.pem

    ## KV Regression Testing
    setenv KVREG_CERT $KVCTL_CERT
    setenv KVREG_KEY $KVCTL_KEY
    setenv KVREG_CA $VIASATIO_CA_PATH
    setenv KVREG_TARGET internal

    if ( -d ~/.password-store ) then
        ## --  Initialize Credentials in ENV VARS  -----------------
        setenv KVD_VICE_USER "egustafson"
        setenv KVD_VICE_PASS `pass viasatio/egustafson`

        setenv KVCTL_USER "egustafson"
        setenv KVCTL_PASS `pass viasatio/egustafson`

        setenv VICECLI_USER "egustafson"
        setenv VICECLI_PWD `pass viasatio/egustafson`

        setenv KVREG_USER_egustafson `pass viasatio/egustafson`
    endif

endif
