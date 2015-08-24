if ( ! $?BASE_PROMPT ) then
   set BASE_PROMPT = $prompt
endif

alias osself 'source ~/.cshrc-os-self'
alias osatg  'source ~/.cshrc-os-atg'

osself  ## always set our openstack creds to myself
