##  ~/.bashrc.d/ module  #############################################

if [ "$SHLVL" -le 1 ] && [ -n "$VIALAP" ]; then

    # VICE
    export VICE_USERNAME="egustafson"
    export VICECLI_USER="$VICE_USERNAME"

    # Alohomora -> SAML Profile
    export AWS_DEFAULT_PROFILE="saml"

    # reset Kubernetes configuration(s)
    if [ "$(type -t kubectl)" == "alias" ]; then
        unalias kubectl
    fi
    unset KUBECONFIG

    # GOPRIVATE for Viasat GitHub Enterprise
    export GOPRIVATE="git.viasat.com/*"

    if [ -d ~/.password-store ]; then
        export VICE_PASSWORD="$(pass viasatio/egustafson)"

        export VICECLI_PASS="$VICE_PASSWORD"
        export VICECLI_PWD="$VICE_PASSWORD"
        # Artifactory for KVS
        export ARTIFACTORY_USER="svc_ents-kvs-artifac"
        export ARTIFACTORY_PASS="$(pass ents/artifactory/svc_ents-kvs-artifac-password)"
        export ARTIFACTORY_TOKEN="$(pass ents/artifactory/svc_ents-kvs-artifac-token)"
    else
        echo "WARN: no ~/.password-store, secrets not set."
    fi

    ## KV tooling
    #
    export ETCDCTL_ENDPOINTS="http://localhost:2379"

    export VIASATIO_CA_PATH=~/ca/viasatio.crt
    export KVCTL_CERT=~/pki/egustafson-client/kvs-client-chain.pem
    export KVCTL_KEY=~/pki/egustafson-client/kvs-client-key.pem

    export KVD_VICE_USER="$VICE_USERNAME"
    export KVD_VICE_PASS="$VICE_PASSWORD"

    export KVCTL_USER="$VICE_USERNAME"
    export KVCTL_PASS="$VICE_PASSWORD"

fi

## Local Variables:
## mode: shell-script
## sh-shell: bash
## End:
