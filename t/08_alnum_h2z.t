use Test::Base;
use utf8;
use Lingua::JA::Regular::Unicode;

plan tests => 1*blocks;

run {
    my $block = shift;
    is alnum_h2z($block->input), $block->expected;
}

__END__

===
--- input: およよABCDEFGbfe123123
--- expected:    およよＡＢＣＤＥＦＧｂｆｅ１２３１２３

