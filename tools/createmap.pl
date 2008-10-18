use warnings;
use strict;
use Perl6::Say;

my @d = split /\n/, do "unicore/Name.pl";
my %n2h;
my %h2n;
for my $l (@d) {
    if ($l =~ /^(\S+)\s+(.+)$/) {
        my ($hex, $name) = ($1, $2);
        $h2n{$hex} = $name;
        $n2h{$name} = $hex;
    }
}

sub alnum_z2h {
    my @alnum_z2h_z;
    my @alnum_z2h_h;
    while (my ($name, $hex) = each %n2h) {
        if ($name =~ /^FULLWIDTH (.+)/) {
            push @alnum_z2h_z, "\\x{$hex}";
            push @alnum_z2h_h, "\\x{$n2h{$1}}";
        }
    }
    return "tr/", join('', @alnum_z2h_z), "/", join('', @alnum_z2h_h), "/";
}

sub hiragana2katakana {
    my @hiragana2katakana_h;
    my @hiragana2katakana_k;
    while (my ($name, $hex) = each %n2h) {
        next if $name eq 'HIRAGANA DIGRAPH YORI'; # HIRAGANA DIGRAPH YORI doesn't exists in katakana form
        if ($name =~ /^HIRAGANA (.+)/) {
            push @hiragana2katakana_h, "\\x{$hex}";
            my $katakananame = "KATAKANA $1";
            warn "$katakananame" unless $n2h{$katakananame};
            push @hiragana2katakana_k, "\\x{$n2h{$katakananame}}";
        }
    }
    return "tr/", join('', @hiragana2katakana_h), "/", join('', @hiragana2katakana_k), "/";
}

sub katakana2hiragana {
    my @katakana2hiragana_h;
    my @katakana2hiragana_k;
    while (my ($name, $hex) = each %n2h) {
        next if $name eq 'KATAKANA LETTER VA';
        next if $name eq 'KATAKANA LETTER SMALL RE';
        next if $name eq 'KATAKANA LETTER SMALL HU';
        next if $name eq 'KATAKANA LETTER SMALL HI';
        next if $name eq 'KATAKANA LETTER SMALL HE';
        next if $name eq 'KATAKANA DIGRAPH KOTO';
        next if $name eq 'KATAKANA LETTER SMALL SU';
        next if $name eq 'KATAKANA LETTER SMALL HO';
        next if $name eq 'KATAKANA LETTER SMALL SI';
        next if $name eq 'KATAKANA LETTER SMALL RI';
        next if $name eq 'KATAKANA LETTER VE';
        next if $name eq 'KATAKANA LETTER SMALL TO';
        next if $name eq 'KATAKANA LETTER SMALL KU';
        next if $name eq 'KATAKANA LETTER VO';
        next if $name eq 'KATAKANA LETTER SMALL RO';
        next if $name eq 'KATAKANA LETTER SMALL RA';
        next if $name eq 'KATAKANA LETTER SMALL MU';
        next if $name eq 'KATAKANA LETTER SMALL HA';
        next if $name eq 'KATAKANA LETTER VI';
        next if $name eq 'KATAKANA LETTER SMALL RU';
        next if $name eq 'KATAKANA LETTER SMALL NU';
        next if $name eq 'KATAKANA MIDDLE DOT';
        next if $name eq 'HALFWIDTH KATAKANA SEMI-VOICED SOUND MARK';
        next if $name eq 'HALFWIDTH KATAKANA VOICED SOUND MARK';
        next if $name eq 'HALFWIDTH KATAKANA MIDDLE DOT';
        if ($name =~ /^(?:HALFWIDTH )?KATAKANA (.+)/) {
            push @katakana2hiragana_k, "\\x{$hex}";
            my $hiragananame = "HIRAGANA $1";
            unless ($n2h{$hiragananame}) {
                warn "$hiragananame\n";
                next;
            }
            push @katakana2hiragana_h, "\\x{$n2h{$hiragananame}}";
        }
    }
    return "tr/", join('', @katakana2hiragana_k), "/", join('', @katakana2hiragana_h), "/";
}

for my $meth (qw/alnum_z2h hiragana2katakana katakana2hiragana/) {
    say "-- $meth";
    say sub { goto &{$meth} }->();
}

