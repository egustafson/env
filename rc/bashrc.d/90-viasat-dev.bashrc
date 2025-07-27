##  ~/.bashrc.d/ module  #############################################

if [[ -n "$VIALAP" && "$0" == -* ]]; then

    # Alohomora -> SAML Profile
    export AWS_DEFAULT_PROFILE="saml"

    # reset Kubernetes configuration(s)
    if [[ "$(type -t kubectl)" == "alias" ]]; then
        unalias kubectl
    fi
    unset KUBECONFIG

    # GOPRIVATE for Viasat GitHub Enterprise
    export GOPRIVATE="git.viasat.com/*"

    # KV stuff
    export ETCDCTL_ENDPOINTS="http://localhost:2379"

    export VIASATIO_CA_PATH=~/ca/viasatio.crt

    export KVCTL_CERT=~/pki/egustafson-client/kvs-client-chain.pem
    export KVCTL_KEY=~/pki/egustafson-client/kvs-client-key.pem

    ## KV Regression Testing
    export KVREG_CERT="$KVCTL_CERT"
    export KVREG_KEY="$KVCTL_KEY"
    export KVREG_CA="$VIASATIO_CA_PATH"
    export KVREG_TARGET="internal"

    if [[ -d ~/.password-store ]]; then

        # VICE / KV tools
        #
        export VICECLI_USER="egustafson"
        export VICECLI_PASS="$(pass viasatio/egustafson)"

        export KVD_VICE_USER="$VICECLI_USER"
        export KVD_VICE_PASS="$VICECLI_PASS"

        export KVCTL_USER="$VICECLI_USER"
        export KVCTL_PASS="$VICECLI_PASS"

        export KVREG_USER_egustafson="$VICECLI_PASS"

        # Artifactory for KVS
        #
        export ARTIFACTORY_USER="svc_ents-kvs-artifac"
        export ARTIFACTORY_PASS="$(pass ents/artifactory/svc_ents-kvs-artifac-password)"
        export ARTIFACTORY_TOKEN="$(pass ents/artifactory/svc_ents-kvs-artifac-token)"

    else
        echo "WARN: no ~/.password-store, secrets not set."
    fi
fi

## Local Variables:
## mode: shell-script
## sh-shell: bash
## End:
