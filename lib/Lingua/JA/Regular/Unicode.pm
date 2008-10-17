package Lingua::JA::Regular::Unicode;
use strict;
use warnings;
use 5.00800;
our $VERSION = '0.01';
use Exporter 'import';

our @EXPORT = qw/ hira2kata alnum_z2h space_z2h /;

1;
__END__

=encoding utf8

=head1 NAME

Lingua::JA::Regular::Unicode -

=head1 SYNOPSIS

    use Lingua::JA::Regular::Unicode qw/regular/;
    alnum_z2h("Ａ１");                                        # => "A1"
    hira2kata("ほげ");                                        # => "ホゲ"
    space_z2h("\x{FULL WIDTH WHITESPACE}");                   # => \x{HALF WIDTH WHITESPACE}

=head1 DESCRIPTION

Lingua::JA::Regular::Unicode is

=head1 AUTHOR

Tokuhiro Matsuno E<lt>tokuhirom AAJKLFJEF GMAIL COME<gt>

=head1 SEE ALSO

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
