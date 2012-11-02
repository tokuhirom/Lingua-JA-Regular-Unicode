use Test::Base;
use utf8;
use Lingua::JA::Regular::Unicode;

plan tests => 1*blocks;

run {
    my $block = shift;
    is alnum_z2h($block->input), $block->expected;
}

__END__

===
--- input:    およよＡＢＣＤＥＦＧｂｆｅge１２３123＞＜
--- expected: およよABCDEFGbfege123123><

