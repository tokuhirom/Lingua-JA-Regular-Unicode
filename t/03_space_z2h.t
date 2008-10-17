use Test::Base;
use utf8;
use Lingua::JA::Regular::Unicode;

plan tests => 1*blocks;

run {
    my $block = shift;
    is space_z2h(eval $block->input), eval $block->expected;
}

__END__

===
--- input:    "\x{3000}eee"
--- expected: "\x{0020}eee"

