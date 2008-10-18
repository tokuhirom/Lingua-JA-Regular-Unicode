use Test::Base;
use utf8;
use Lingua::JA::Regular::Unicode;

plan tests => 1*blocks;

run {
    my $block = shift;
    is katakana_z2h($block->input), $block->expected;
}

__END__

===
--- input:    およよＡＢＣＤＥＦＧｂｆｅge１２３123オヨヨｵﾖﾖ
--- expected: およよＡＢＣＤＥＦＧｂｆｅge１２３123ｵﾖﾖｵﾖﾖ

===
--- input:    ガ
--- expected: ｶﾞ

