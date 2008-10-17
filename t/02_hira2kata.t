use Test::Base;
use utf8;
use Lingua::JA::Regular::Unicode;

plan tests => 1*blocks;

run {
    my $block = shift;
    is hiragana2katakana($block->input), $block->expected;
}

__END__

===
--- input:    およよＡＢＣＤＥＦＧｂｆｅge１２３123オヨヨｵﾖﾖ
--- expected: オヨヨＡＢＣＤＥＦＧｂｆｅge１２３123オヨヨｵﾖﾖ

