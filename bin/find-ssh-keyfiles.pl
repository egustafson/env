#!/usr/bin/env perl

open(SSHCFG, "$ENV{'HOME'}/.ssh/config");

while (<SSHCFG>) {
    if ( /IdentityFile\s+(\S+)/ ) {
        $filen = $1;
        $filen =~ s/^~(.*)/$ENV{'HOME'}$1/;
        if ( -e $filen ) {
            $pemfiles{"$filen"} = 1 if sshperms($filen);
        }
    }
}

print join("\n", keys(%pemfiles));
print "\n";

##### Subroutines #####

sub sshperms {
    local($filename) = @_;
    ($d,$i,$mode,$nlink,$uid) = stat($filename);
    $readable = ( 0077 & $mode );
    print STDERR "WARN: $filename permissions too open, skipping.\n" if $readable;
    return !$readable
}
