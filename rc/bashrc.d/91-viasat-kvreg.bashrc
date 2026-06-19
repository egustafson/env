##  ~/.bashrc.d/ module  #############################################

if [ "$SHLVL" -le 1 ] && [ -n "$VIALAP" ]; then

    ## KV Regression Testing env vars
    #
    if [ -d ~/.password-store ]; then

        ## Credentials
        #
        export KVREG_USER_CLUSTER_ADMIN_KVSAPI__NONPROD_KVREG__CLUSTER__ADMIN="$(pass kvreg/kvsapi-nonprod_kvreg-cluster-admin)"
        export KVREG_USER_ADMIN_KVSAPI__NONPROD_KVREG__ADMIN="$(pass kvreg/kvsapi-nonprod_kvreg-admin)"
        export KVREG_USER_RW_KVSAPI__NONPROD_KVREG__RW="$(pass kvreg/kvsapi-nonprod_kvreg-rw)"
        export KVREG_USER_RO_KVSAPI__NONPROD_KVREG__RO="$(pass kvreg/kvsapi-nonprod_kvreg-ro)"

        ## KVS Cluster Details
        #
        export KVREG_TARGET_ENV="internal"
        export KVREG_KEYSPACE_TEMPLATE="admin_rw_ro"
        export KVREG_STORE_ID="ents-internal-etcd"
        export KVREG_CONFIG=config/config.yaml

        ## Certificates + endpoint
        #
        export KVREG_CERT="$KVCTL_CERT"
        export KVREG_KEY="$KVCTL_KEY"
        export KVREG_CA="$VIASATIO_CA_PATH"

    else
        echo "WARN: KVREG env not set."
    fi
fi

## Local Variables:
## mode: shell-script
## sh-shell: bash
## End:
