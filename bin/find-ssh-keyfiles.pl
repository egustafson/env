#!/usr/bin/env perl

open(SSHCFG, "$ENV{'HOME'}/.ssh/config");

while (<SSHCFG>) {
    if ( /IdentityFile\s+(\S+)/ ) {
        $pemfiles{"$1"} = 1;
    }
}

print join("\n", keys(%pemfiles));
print "\n";

