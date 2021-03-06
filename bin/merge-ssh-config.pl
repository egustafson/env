#!/usr/bin/env perl

$ssh_config = "$ENV{'HOME'}/.ssh/config";
$ssh_cfg_bu = "$ssh_config.bu";
$local_cfg = "$ENV{'HOME'}/.ssh/config.local";

if ( !(-e "$ENV{'HOME'}/.ssh") ) { exit(0); }

if ( -l $ssh_config ) {
    print STDERR "WARN: ~/.ssh/config is a symbolic link, not rewritten.\n";
    exit(0);
}

# set ~/.ssh/config to prevent this script from rewriting
# the configuration file.
#
if ( -e $ssh_config ) {
    if ( !(-w $ssh_config) ) {
        print STDERR "WARN: ~/.ssh/config is read-only, not rewritten, ";
        print STDERR "consider using ~/.ssh/config.local\n";
        exit(0);
    } else {
        unlink($ssh_cfg_bu) if -e $ssh_cfg_bu;
        rename($ssh_config, $ssh_cfg_bu);
    }
}


open(CFGS, "find ~/.ssh -type f -name config |");
while (<CFGS>) {
    chomp;
    next if /\.ssh\/config/;
    next if /\.git\//;
    push(@cfgs, $_)
}

open(CFGFILE, ">$ssh_config");
print CFGFILE "# == autogenerated file -- do not edit.\n";
print CFGFILE "#\n";

if ( -r $local_cfg ) {
    open(LCFG, $local_cfg);
    print CFGFILE "# -- (config.local) --\n";
    while (<LCFG>) {
        last if /^## Postamble /;
        print CFGFILE $_;
    }
}

foreach $cfg (@cfgs) {
    print CFGFILE "\n# == $cfg =====\n";
    open(CFG, $cfg);
    print CFGFILE <CFG>;
    close(CFG)
}

if ( LCFG ) {
    print CFGFILE "\n# -- (config.local --\n";
    while (<LCFG>) {
        print CFGFILE $_;
    }
}

close(CFGFILE);
