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

say "-- alnum_z2h";
say alnum_z2h();

say "-- hiragana2katakana";
say hiragana2katakana();

