##  ~/.bashrc.d/  -  a directory for .bashrc extras  #################

This directory (~/.bashrc.d/) is intended to hold script modules that
support my ~/.bashrc.

* "[0-9]*.bashrc"   <--  only files automatically run
* "lib.bashrc"      <--  library funcs loaded early
* "template.bashrc" <--  a template, NOT run

* everything else  <-- currently ignored by the .bashrc

## Auto-run Classifications

The files that begin (i.e. `[0-9]*.bashrc`) are sorted gramatically.
The current practice is to use two digits allowing ordering within
each category.  In the future, files can and should extend the
numbered ordering by adding more digits.  [Note, '-' sorts before '0']

* 0n- <reserved> must be first settings
* 1n- "local" home directory set-up
* 2n- personalizations
* 3n- <reserved>
* 4n- app/tool initializations (per app, ..)
* 5n- <reserved>
* 6n- <reserved>
* 7n- Viasat Customizations (gated)
* 8n- <reserved>
* 9n- <reserved> must be last settings

