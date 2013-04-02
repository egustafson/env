#!/usr/bin/env perl

$sshadd_inc = "$ENV{'HOME'}/.ssh/pem_include";
$sshadd_exc = "$ENV{'HOME'}/.ssh/pem_exclude";

if ( -r $sshadd_inc ) {
    open(SSHADD_INC, $sshadd_inc);
    @filelist = <SSHADD_INC>;
} else {
    open(FIND,"find $ENV{'HOME'}/.ssh -name '*.pem' -print|");
    @filelist = <FIND>;
    if ( -r $sshadd_exc ) {
        open(SSHADD_EXC, $sshadd_exc);
        while ($filen = <SSHADD_EXC>) {
            chomp $filen;
            $filen =~ s/^~(.*)/$ENV{'HOME'}$1/;
            $excfiles{"$filen"} = 1;
        }
    }
}
foreach $filen (@filelist) {
    chomp $filen;
    $filen =~ s/^~(.*)/$ENV{'HOME'}$1/;
    if ( !$excfiles{"$filen"} && -r $filen && sshperms($filen) ) {
        push(@pemfiles, $filen);
    }
}

print join("\n", @pemfiles);
print "\n";

##### Subroutines #####

sub sshperms {
    local($filename) = @_;
    ($d,$i,$mode,$nlink,$uid) = stat($filename);
    $readable = ( 0077 & $mode );
    print STDERR "WARN: $filename permissions too open, skipping.\n" if $readable;
    return !$readable
}
