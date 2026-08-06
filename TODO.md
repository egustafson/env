# Things to do
_(in no particular order)_

### Gates and Enabled flags

* refactor VIALAP and "ELF" -->  "VIA" | "ELF" | future-TLA
* refactor all _gates_ into "ENABLE_"
* rewrite ENABLE_ flags.
  * _AITOOLS flag that is disjoint from VIA and ELF
* "ENABLE_ELF_AWS" --> and rename `bashrc.d` file
* refactor `VIALAP_AI_TOKENS_SET` into an enabled flag
  * invent a convention that scales.

### Refactor the `$SHLVL` Gate

* `$SHLVL` is used to prevent resourcing parts of the rc script.  Factor out the U-C's and identify better solutions.  The problem this is starting to cause is when I have a shell started inside an editor (Zed or VSCode) and some of my environment is not present.

### Misc Housekeeping

* gpg-agent forwarding (enables AITOOLS use more broadly)

* is `git-subrepo` deprecated?  (remove)

### `tools` folder re-write

Refactor `tools` to hold individual (mostly Python?) tools that evolve beyond shell scripts placed in `bin`

* consider if `tools` or `scripts` is more appropriate.
