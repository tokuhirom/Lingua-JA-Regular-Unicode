package Lingua::JA::Regular::Unicode;
use strict;
use warnings;
use utf8;
use 5.008001; # dankogai-san says "tr/// on 5.8.0 is buggy!"
our $VERSION = '0.10';
use Exporter 'import';

our @EXPORT = qw/ hiragana2katakana alnum_z2h alnum_h2z space_z2h katakana2hiragana katakana_h2z katakana_z2h space_h2z/;

# regexp is generated by tools/createmap.pl

my %katakana_h2z_map = (
    "\x{FF8E}\x{FF9F}" => "\x{30DD}",
    "\x{FF7E}\x{FF9E}" => "\x{30BC}",
    "\x{FF73}\x{FF9E}" => "\x{30F4}",
    "\x{FF8B}\x{FF9F}" => "\x{30D4}",
    "\x{FF8E}\x{FF9E}" => "\x{30DC}",
    "\x{FF78}\x{FF9E}" => "\x{30B0}",
    "\x{FF8D}\x{FF9F}" => "\x{30DA}",
    "\x{FF8B}\x{FF9E}" => "\x{30D3}",
    "\x{FF8A}\x{FF9F}" => "\x{30D1}",
    "\x{FF8C}\x{FF9E}" => "\x{30D6}",
    "\x{FF8D}\x{FF9E}" => "\x{30D9}",
    "\x{FF82}\x{FF9E}" => "\x{30C5}",
    "\x{FF7A}\x{FF9E}" => "\x{30B4}",
    "\x{FF77}\x{FF9E}" => "\x{30AE}",
    "\x{FF7C}\x{FF9E}" => "\x{30B8}",
    "\x{FF7B}\x{FF9E}" => "\x{30B6}",
    "\x{FF83}\x{FF9E}" => "\x{30C7}",
    "\x{FF84}\x{FF9E}" => "\x{30C9}",
    "\x{FF8A}\x{FF9E}" => "\x{30D0}",
    "\x{FF80}\x{FF9E}" => "\x{30C0}",
    "\x{FF8C}\x{FF9F}" => "\x{30D7}",
    "\x{FF76}\x{FF9E}" => "\x{30AC}",
    "\x{FF81}\x{FF9E}" => "\x{30C2}",
    "\x{FF7D}\x{FF9E}" => "\x{30BA}",
    "\x{FF7F}\x{FF9E}" => "\x{30BE}",
    "\x{FF79}\x{FF9E}" => "\x{30B2}"
);

my %katakana_z2h_map = (
    "\x{30B6}" => "\x{FF7B}\x{FF9E}",
    "\x{30D1}" => "\x{FF8A}\x{FF9F}",
    "\x{30C7}" => "\x{FF83}\x{FF9E}",
    "\x{30D4}" => "\x{FF8B}\x{FF9F}",
    "\x{30BE}" => "\x{FF7F}\x{FF9E}",
    "\x{30BC}" => "\x{FF7E}\x{FF9E}",
    "\x{30AE}" => "\x{FF77}\x{FF9E}",
    "\x{30D6}" => "\x{FF8C}\x{FF9E}",
    "\x{30C0}" => "\x{FF80}\x{FF9E}",
    "\x{30DA}" => "\x{FF8D}\x{FF9F}",
    "\x{30D0}" => "\x{FF8A}\x{FF9E}",
    "\x{30D3}" => "\x{FF8B}\x{FF9E}",
    "\x{30C5}" => "\x{FF82}\x{FF9E}",
    "\x{30F4}" => "\x{FF73}\x{FF9E}",
    "\x{30B0}" => "\x{FF78}\x{FF9E}",
    "\x{30B8}" => "\x{FF7C}\x{FF9E}",
    "\x{30B4}" => "\x{FF7A}\x{FF9E}",
    "\x{30D7}" => "\x{FF8C}\x{FF9F}",
    "\x{30D9}" => "\x{FF8D}\x{FF9E}",
    "\x{30C2}" => "\x{FF81}\x{FF9E}",
    "\x{30BA}" => "\x{FF7D}\x{FF9E}",
    "\x{30DD}" => "\x{FF8E}\x{FF9F}",
    "\x{30DC}" => "\x{FF8E}\x{FF9E}",
    "\x{30B2}" => "\x{FF79}\x{FF9E}",
    "\x{30AC}" => "\x{FF76}\x{FF9E}",
    "\x{30C9}" => "\x{FF84}\x{FF9E}"
);

sub alnum_z2h {
    local $_ = shift;
    tr/\x{FF07}\x{FF3B}\x{FF56}\x{FF4F}\x{FF0C}\x{FF5E}\x{FF14}\x{FF43}\x{FF19}\x{FF26}\x{FF55}\x{FF3F}\x{FF2D}\x{FF27}\x{FF34}\x{FF37}\x{FF30}\x{FF51}\x{FFE3}\x{FF60}\x{FF36}\x{FF49}\x{FF29}\x{FF52}\x{FF1A}\x{FF3A}\x{FF38}\x{FF3D}\x{FF4C}\x{FF1E}\x{FF5D}\x{FFE6}\x{FF01}\x{FF5C}\x{FF58}\x{FF16}\x{FF05}\x{FF54}\x{FF3E}\x{FF18}\x{FF45}\x{FF24}\x{FF2B}\x{FF15}\x{FF4A}\x{FF0D}\x{FFE0}\x{FF48}\x{FF11}\x{FF5B}\x{FF35}\x{FF12}\x{FF2E}\x{FF28}\x{FF06}\x{FF10}\x{FF03}\x{FF2F}\x{FF4E}\x{FFE2}\x{FF20}\x{FF5F}\x{FF46}\x{FF13}\x{FF31}\x{FF41}\x{FF50}\x{FF2A}\x{FFE5}\x{FF1F}\x{FF21}\x{FF57}\x{FF3C}\x{FF04}\x{FF02}\x{FF22}\x{FF4D}\x{FF23}\x{FF17}\x{FF1B}\x{FFE4}\x{FF1D}\x{FF59}\x{FF0B}\x{FF47}\x{FF39}\x{FF32}\x{FF42}\x{FF2C}\x{FF4B}\x{FF09}\x{FF33}\x{FF40}\x{FF25}\x{FF08}\x{FFE1}\x{FF0A}\x{FF0E}\x{FF5A}\x{FF53}\x{FF0F}\x{FF1C}\x{FF44}/\x{0027}\x{005B}\x{0076}\x{006F}\x{002C}\x{007E}\x{0034}\x{0063}\x{0039}\x{0046}\x{0075}\x{005F}\x{004D}\x{0047}\x{0054}\x{0057}\x{0050}\x{0071}\x{00AF}\x{2986}\x{0056}\x{0069}\x{0049}\x{0072}\x{003A}\x{005A}\x{0058}\x{005D}\x{006C}\x{003E}\x{007D}\x{20A9}\x{0021}\x{007C}\x{0078}\x{0036}\x{0025}\x{0074}\x{005E}\x{0038}\x{0065}\x{0044}\x{004B}\x{0035}\x{006A}\x{002D}\x{00A2}\x{0068}\x{0031}\x{007B}\x{0055}\x{0032}\x{004E}\x{0048}\x{0026}\x{0030}\x{0023}\x{004F}\x{006E}\x{00AC}\x{0040}\x{2985}\x{0066}\x{0033}\x{0051}\x{0061}\x{0070}\x{004A}\x{00A5}\x{003F}\x{0041}\x{0077}\x{005C}\x{0024}\x{0022}\x{0042}\x{006D}\x{0043}\x{0037}\x{003B}\x{00A6}\x{003D}\x{0079}\x{002B}\x{0067}\x{0059}\x{0052}\x{0062}\x{004C}\x{006B}\x{0029}\x{0053}\x{0060}\x{0045}\x{0028}\x{00A3}\x{002A}\x{002E}\x{007A}\x{0073}\x{002F}\x{003C}\x{0064}/;
    $_;
}

sub alnum_h2z {
    local $_ = shift;
    tr/\x{0027}\x{005B}\x{0076}\x{006F}\x{002C}\x{007E}\x{0034}\x{0063}\x{0039}\x{0046}\x{0075}\x{005F}\x{004D}\x{0047}\x{0054}\x{0057}\x{0050}\x{0071}\x{00AF}\x{2986}\x{0056}\x{0069}\x{0049}\x{0072}\x{003A}\x{005A}\x{0058}\x{005D}\x{006C}\x{003E}\x{007D}\x{20A9}\x{0021}\x{007C}\x{0078}\x{0036}\x{0025}\x{0074}\x{005E}\x{0038}\x{0065}\x{0044}\x{004B}\x{0035}\x{006A}\x{002D}\x{00A2}\x{0068}\x{0031}\x{007B}\x{0055}\x{0032}\x{004E}\x{0048}\x{0026}\x{0030}\x{0023}\x{004F}\x{006E}\x{00AC}\x{0040}\x{2985}\x{0066}\x{0033}\x{0051}\x{0061}\x{0070}\x{004A}\x{00A5}\x{003F}\x{0041}\x{0077}\x{005C}\x{0024}\x{0022}\x{0042}\x{006D}\x{0043}\x{0037}\x{003B}\x{00A6}\x{003D}\x{0079}\x{002B}\x{0067}\x{0059}\x{0052}\x{0062}\x{004C}\x{006B}\x{0029}\x{0053}\x{0060}\x{0045}\x{0028}\x{00A3}\x{002A}\x{002E}\x{007A}\x{0073}\x{002F}\x{003C}\x{0064}/\x{FF07}\x{FF3B}\x{FF56}\x{FF4F}\x{FF0C}\x{FF5E}\x{FF14}\x{FF43}\x{FF19}\x{FF26}\x{FF55}\x{FF3F}\x{FF2D}\x{FF27}\x{FF34}\x{FF37}\x{FF30}\x{FF51}\x{FFE3}\x{FF60}\x{FF36}\x{FF49}\x{FF29}\x{FF52}\x{FF1A}\x{FF3A}\x{FF38}\x{FF3D}\x{FF4C}\x{FF1E}\x{FF5D}\x{FFE6}\x{FF01}\x{FF5C}\x{FF58}\x{FF16}\x{FF05}\x{FF54}\x{FF3E}\x{FF18}\x{FF45}\x{FF24}\x{FF2B}\x{FF15}\x{FF4A}\x{FF0D}\x{FFE0}\x{FF48}\x{FF11}\x{FF5B}\x{FF35}\x{FF12}\x{FF2E}\x{FF28}\x{FF06}\x{FF10}\x{FF03}\x{FF2F}\x{FF4E}\x{FFE2}\x{FF20}\x{FF5F}\x{FF46}\x{FF13}\x{FF31}\x{FF41}\x{FF50}\x{FF2A}\x{FFE5}\x{FF1F}\x{FF21}\x{FF57}\x{FF3C}\x{FF04}\x{FF02}\x{FF22}\x{FF4D}\x{FF23}\x{FF17}\x{FF1B}\x{FFE4}\x{FF1D}\x{FF59}\x{FF0B}\x{FF47}\x{FF39}\x{FF32}\x{FF42}\x{FF2C}\x{FF4B}\x{FF09}\x{FF33}\x{FF40}\x{FF25}\x{FF08}\x{FFE1}\x{FF0A}\x{FF0E}\x{FF5A}\x{FF53}\x{FF0F}\x{FF1C}\x{FF44}/;
    $_;
}

sub hiragana2katakana {
    local $_ = shift;
    tr/\x{3077}\x{3094}\x{306B}\x{3080}\x{3066}\x{3044}\x{3067}\x{3079}\x{309E}\x{3090}\x{3075}\x{3068}\x{304A}\x{308A}\x{3052}\x{305D}\x{3065}\x{3088}\x{306F}\x{3064}\x{3056}\x{3057}\x{3083}\x{306E}\x{3063}\x{306D}\x{3072}\x{3043}\x{305F}\x{3087}\x{3051}\x{307E}\x{308C}\x{3073}\x{3084}\x{304C}\x{307D}\x{306C}\x{307A}\x{304F}\x{305E}\x{3071}\x{3054}\x{3092}\x{3078}\x{305A}\x{304B}\x{3074}\x{3085}\x{308E}\x{3042}\x{304D}\x{3096}\x{3047}\x{3069}\x{3060}\x{308D}\x{3082}\x{3048}\x{308F}\x{3093}\x{3076}\x{305C}\x{3081}\x{306A}\x{3061}\x{3070}\x{3062}\x{308B}\x{3059}\x{3041}\x{3095}\x{307C}\x{3089}\x{3049}\x{309D}\x{3050}\x{307B}\x{3055}\x{3091}\x{304E}\x{307F}\x{305B}\x{3058}\x{3053}\x{3045}\x{3086}\x{3046}/\x{30D7}\x{30F4}\x{30CB}\x{30E0}\x{30C6}\x{30A4}\x{30C7}\x{30D9}\x{30FE}\x{30F0}\x{30D5}\x{30C8}\x{30AA}\x{30EA}\x{30B2}\x{30BD}\x{30C5}\x{30E8}\x{30CF}\x{30C4}\x{30B6}\x{30B7}\x{30E3}\x{30CE}\x{30C3}\x{30CD}\x{30D2}\x{30A3}\x{30BF}\x{30E7}\x{30B1}\x{30DE}\x{30EC}\x{30D3}\x{30E4}\x{30AC}\x{30DD}\x{30CC}\x{30DA}\x{30AF}\x{30BE}\x{30D1}\x{30B4}\x{30F2}\x{30D8}\x{30BA}\x{30AB}\x{30D4}\x{30E5}\x{30EE}\x{30A2}\x{30AD}\x{30F6}\x{30A7}\x{30C9}\x{30C0}\x{30ED}\x{30E2}\x{30A8}\x{30EF}\x{30F3}\x{30D6}\x{30BC}\x{30E1}\x{30CA}\x{30C1}\x{30D0}\x{30C2}\x{30EB}\x{30B9}\x{30A1}\x{30F5}\x{30DC}\x{30E9}\x{30A9}\x{30FD}\x{30B0}\x{30DB}\x{30B5}\x{30F1}\x{30AE}\x{30DF}\x{30BB}\x{30B8}\x{30B3}\x{30A5}\x{30E6}\x{30A6}/;
    $_;
}

sub katakana2hiragana {
    local $_ = shift;
    tr/\x{FF98}\x{30DC}\x{30BA}\x{30B7}\x{FF77}\x{FF6D}\x{FF99}\x{FF88}\x{30B0}\x{30CD}\x{30AD}\x{FF6A}\x{30F1}\x{30C6}\x{FF78}\x{30CB}\x{FF84}\x{FF9B}\x{30C9}\x{30A7}\x{30B3}\x{30FD}\x{FF81}\x{30AC}\x{FF8D}\x{30C8}\x{FF69}\x{30C0}\x{30E4}\x{30EC}\x{FF86}\x{30C1}\x{30BD}\x{30CE}\x{FF7F}\x{FF7B}\x{30D1}\x{30E8}\x{FF67}\x{FF89}\x{FF8A}\x{30B4}\x{30B2}\x{FF6B}\x{30EE}\x{30E2}\x{30F0}\x{30EB}\x{30F2}\x{30E0}\x{FF71}\x{FF83}\x{30BC}\x{30DD}\x{30D5}\x{30CF}\x{30E3}\x{30B5}\x{30C3}\x{30E9}\x{FF8F}\x{30A2}\x{30A3}\x{30E7}\x{FF73}\x{FF75}\x{30AA}\x{30AF}\x{30E1}\x{FF95}\x{30A5}\x{30C2}\x{30AE}\x{FF92}\x{30A6}\x{FF85}\x{30B9}\x{FF7D}\x{FF97}\x{FF7E}\x{30B6}\x{30D6}\x{FF8C}\x{30D8}\x{FF7A}\x{FF76}\x{30DA}\x{30AB}\x{FF72}\x{30FE}\x{30A8}\x{FF9C}\x{30F4}\x{30F3}\x{FF80}\x{FF6C}\x{FF8E}\x{FF6E}\x{FF96}\x{30C4}\x{30BE}\x{30D0}\x{30D7}\x{FF93}\x{30BB}\x{FF91}\x{FF79}\x{30EA}\x{30C7}\x{FF90}\x{30DF}\x{30DB}\x{30B1}\x{30A4}\x{30D2}\x{FF6F}\x{30E6}\x{FF82}\x{30DE}\x{30F5}\x{30BF}\x{FF9A}\x{30D4}\x{30B8}\x{FF7C}\x{FF87}\x{30D3}\x{30C5}\x{30CC}\x{FF68}\x{FF9D}\x{FF74}\x{30A1}\x{30A9}\x{30F6}\x{30CA}\x{FF66}\x{30E5}\x{FF94}\x{30ED}\x{FF8B}\x{30D9}\x{30EF}/\x{308A}\x{307C}\x{305A}\x{3057}\x{304D}\x{3085}\x{308B}\x{306D}\x{3050}\x{306D}\x{304D}\x{3047}\x{3091}\x{3066}\x{304F}\x{306B}\x{3068}\x{308D}\x{3069}\x{3047}\x{3053}\x{309D}\x{3061}\x{304C}\x{3078}\x{3068}\x{3045}\x{3060}\x{3084}\x{308C}\x{306B}\x{3061}\x{305D}\x{306E}\x{305D}\x{3055}\x{3071}\x{3088}\x{3041}\x{306E}\x{306F}\x{3054}\x{3052}\x{3049}\x{308E}\x{3082}\x{3090}\x{308B}\x{3092}\x{3080}\x{3042}\x{3066}\x{305C}\x{307D}\x{3075}\x{306F}\x{3083}\x{3055}\x{3063}\x{3089}\x{307E}\x{3042}\x{3043}\x{3087}\x{3046}\x{304A}\x{304A}\x{304F}\x{3081}\x{3086}\x{3045}\x{3062}\x{304E}\x{3081}\x{3046}\x{306A}\x{3059}\x{3059}\x{3089}\x{305B}\x{3056}\x{3076}\x{3075}\x{3078}\x{3053}\x{304B}\x{307A}\x{304B}\x{3044}\x{309E}\x{3048}\x{308F}\x{3094}\x{3093}\x{305F}\x{3083}\x{307B}\x{3087}\x{3088}\x{3064}\x{305E}\x{3070}\x{3077}\x{3082}\x{305B}\x{3080}\x{3051}\x{308A}\x{3067}\x{307F}\x{307F}\x{307B}\x{3051}\x{3044}\x{3072}\x{3063}\x{3086}\x{3064}\x{307E}\x{3095}\x{305F}\x{308C}\x{3074}\x{3058}\x{3057}\x{306C}\x{3073}\x{3065}\x{306C}\x{3043}\x{3093}\x{3048}\x{3041}\x{3049}\x{3096}\x{306A}\x{3092}\x{3085}\x{3084}\x{308D}\x{3072}\x{3079}\x{308F}/;
    $_;
}

sub space_z2h {
    local $_ = shift;
    tr/\x{3000}/\x{0020}/; # convert \N{IDEOGRAPHIC SPACE} to \N{SPACE}
    $_;
}

sub space_h2z {
    local $_ = shift;
    tr/\x{0020}/\x{3000}/; # convert \N{SPACE} to \N{IDEOGRAPHIC SPACE}
    $_;
}

sub katakana_h2z {
    local $_ = shift;
    # dakuten
    s/(\x{FF7E}\x{FF9E}|\x{FF84}\x{FF9E}|\x{FF80}\x{FF9E}|\x{FF76}\x{FF9E}|\x{FF8B}\x{FF9E}|\x{FF7D}\x{FF9E}|\x{FF8B}\x{FF9F}|\x{FF73}\x{FF9E}|\x{FF79}\x{FF9E}|\x{FF7B}\x{FF9E}|\x{FF8D}\x{FF9F}|\x{FF8A}\x{FF9F}|\x{FF8A}\x{FF9E}|\x{FF83}\x{FF9E}|\x{FF7A}\x{FF9E}|\x{FF8C}\x{FF9F}|\x{FF8D}\x{FF9E}|\x{FF82}\x{FF9E}|\x{FF8E}\x{FF9F}|\x{FF8C}\x{FF9E}|\x{FF77}\x{FF9E}|\x{FF81}\x{FF9E}|\x{FF7C}\x{FF9E}|\x{FF78}\x{FF9E}|\x{FF8E}\x{FF9E}|\x{FF7F}\x{FF9E})/$katakana_h2z_map{$1}/ge;
    # normal
    tr/\x{FF6C}\x{FF97}\x{FF7E}\x{FF8F}\x{FF83}\x{FF6A}\x{FF8E}\x{FF8B}\x{FF61}\x{FF67}\x{FF7C}\x{FF88}\x{FF80}\x{FF8C}\x{FF77}\x{FF93}\x{FF92}\x{FF9B}\x{FF86}\x{FF95}\x{FF69}\x{FF87}\x{FF6E}\x{FF94}\x{FF7A}\x{FF68}\x{FF8D}\x{FF6F}\x{FF9C}\x{FF72}\x{FF79}\x{FF85}\x{FF64}\x{FF62}\x{FF9A}\x{FF74}\x{FF9F}\x{FF71}\x{FF7F}\x{FF82}\x{FF9E}\x{FF66}\x{FF70}\x{FF9D}\x{FF73}\x{FF7D}\x{FF98}\x{FF76}\x{FF63}\x{FF91}\x{FF6B}\x{FF99}\x{FF6D}\x{FF96}\x{FF8A}\x{FF89}\x{FF78}\x{FF65}\x{FF75}\x{FF7B}\x{FF84}\x{FF90}\x{FF81}/\x{30E3}\x{30E9}\x{30BB}\x{30DE}\x{30C6}\x{30A7}\x{30DB}\x{30D2}\x{3002}\x{30A1}\x{30B7}\x{30CD}\x{30BF}\x{30D5}\x{30AD}\x{30E2}\x{30E1}\x{30ED}\x{30CB}\x{30E6}\x{30A5}\x{30CC}\x{30E7}\x{30E4}\x{30B3}\x{30A3}\x{30D8}\x{30C3}\x{30EF}\x{30A4}\x{30B1}\x{30CA}\x{3001}\x{300C}\x{30EC}\x{30A8}\x{309C}\x{30A2}\x{30BD}\x{30C4}\x{309B}\x{30F2}\x{30FC}\x{30F3}\x{30A6}\x{30B9}\x{30EA}\x{30AB}\x{300D}\x{30E0}\x{30A9}\x{30EB}\x{30E5}\x{30E8}\x{30CF}\x{30CE}\x{30AF}\x{30FB}\x{30AA}\x{30B5}\x{30C8}\x{30DF}\x{30C1}/;
    $_;
}

sub katakana_z2h {
    local $_ = shift;
    # dakuten
    s/([\x{30BC}\x{30C9}\x{30C0}\x{30AC}\x{30D3}\x{30BA}\x{30D4}\x{30F4}\x{30B2}\x{30B6}\x{30DA}\x{30D1}\x{30D0}\x{30C7}\x{30B4}\x{30D7}\x{30D9}\x{30C5}\x{30DD}\x{30D6}\x{30AE}\x{30C2}\x{30B8}\x{30B0}\x{30DC}\x{30BE}])/$katakana_z2h_map{$1}/ge;
    # normal
    tr/\x{30E3}\x{30E9}\x{30BB}\x{30DE}\x{30C6}\x{30A7}\x{30DB}\x{30D2}\x{3002}\x{30A1}\x{30B7}\x{30CD}\x{30BF}\x{30D5}\x{30AD}\x{30E2}\x{30E1}\x{30ED}\x{30CB}\x{30E6}\x{30A5}\x{30CC}\x{30E7}\x{30E4}\x{30B3}\x{30A3}\x{30D8}\x{30C3}\x{30EF}\x{30A4}\x{30B1}\x{30CA}\x{3001}\x{300C}\x{30EC}\x{30A8}\x{309C}\x{30A2}\x{30BD}\x{30C4}\x{309B}\x{30F2}\x{30FC}\x{30F3}\x{30A6}\x{30B9}\x{30EA}\x{30AB}\x{300D}\x{30E0}\x{30A9}\x{30EB}\x{30E5}\x{30E8}\x{30CF}\x{30CE}\x{30AF}\x{30FB}\x{30AA}\x{30B5}\x{30C8}\x{30DF}\x{30C1}/\x{FF6C}\x{FF97}\x{FF7E}\x{FF8F}\x{FF83}\x{FF6A}\x{FF8E}\x{FF8B}\x{FF61}\x{FF67}\x{FF7C}\x{FF88}\x{FF80}\x{FF8C}\x{FF77}\x{FF93}\x{FF92}\x{FF9B}\x{FF86}\x{FF95}\x{FF69}\x{FF87}\x{FF6E}\x{FF94}\x{FF7A}\x{FF68}\x{FF8D}\x{FF6F}\x{FF9C}\x{FF72}\x{FF79}\x{FF85}\x{FF64}\x{FF62}\x{FF9A}\x{FF74}\x{FF9F}\x{FF71}\x{FF7F}\x{FF82}\x{FF9E}\x{FF66}\x{FF70}\x{FF9D}\x{FF73}\x{FF7D}\x{FF98}\x{FF76}\x{FF63}\x{FF91}\x{FF6B}\x{FF99}\x{FF6D}\x{FF96}\x{FF8A}\x{FF89}\x{FF78}\x{FF65}\x{FF75}\x{FF7B}\x{FF84}\x{FF90}\x{FF81}/;
    $_;
}

1;
__END__

=encoding utf8

=for stopwords regularizer

=head1 NAME

Lingua::JA::Regular::Unicode - convert japanese chars.

=head1 SYNOPSIS

    use Lingua::JA::Regular::Unicode qw/alnum_z2h hiragana2katakana space_z2h/;
    alnum_z2h("Ａ１");                                        # => "A1"
    hiragana2katakana("ほげ");                                # => "ホゲ"
    space_z2h("\x{0300}");                                    # => 半角スペース

=head1 DESCRIPTION

Lingua::JA::Regular::Unicode is regularizer.

=over 4

=item alnum_z2h

Convert alphabet, numbers and B<symbols> ZENKAKU to HANKAKU.

Symbols contains B<< > >>, B<< < >>.

Yes, it's bit strange. But so, this behaviour is needed by historical reason.

=item alnum_h2z

Convert alphabet, numbers and B<symbols> HANKAKU to ZENKAKU.

=item space_z2h

convert spaces ZENKAKU to HANKAKU.

=item space_h2z

convert spaces HANKAKU to ZENKAKU.

=item katakana_z2h

convert katakanas ZENKAKU to HANKAKU.

=item katakana_h2z

convert katakanas HANKAKU to ZENKAKU.

=item katakana2hiragana

convert KATAKANA to HIRAGANA.

This method ignores following chars:

    KATAKANA LETTER VA
    KATAKANA LETTER SMALL RE
    KATAKANA LETTER SMALL HU
    KATAKANA LETTER SMALL HI
    KATAKANA LETTER SMALL HE
    KATAKANA DIGRAPH KOTO
    KATAKANA LETTER SMALL SU
    KATAKANA LETTER SMALL HO
    KATAKANA LETTER SMALL SI
    KATAKANA LETTER SMALL RI
    KATAKANA LETTER VE
    KATAKANA LETTER SMALL TO
    KATAKANA LETTER SMALL KU
    KATAKANA LETTER VO
    KATAKANA LETTER SMALL RO
    KATAKANA LETTER SMALL RA
    KATAKANA LETTER SMALL MU
    KATAKANA LETTER SMALL HA
    KATAKANA LETTER VI
    KATAKANA LETTER SMALL RU
    KATAKANA LETTER SMALL NU
    KATAKANA MIDDLE DOT
    HALFWIDTH KATAKANA SEMI-VOICED SOUND MARK
    HALFWIDTH KATAKANA VOICED SOUND MARK
    HALFWIDTH KATAKANA MIDDLE DOT

=item hiragana2katakana

convert HIRAGANA to KATAKANA.

This method ignores following chars:

    HIRAGANA DIGRAPH YORI

=back

=head1 AUTHOR

Tokuhiro Matsuno E<lt>tokuhirom AAJKLFJEF@ GMAIL COME<gt>

=head1 THANKS To

    takefumi kimura - the author of L<Lingua::JA::Regular>
    dankogai

=head1 SEE ALSO

L<Lingua::JA::Regular>

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
