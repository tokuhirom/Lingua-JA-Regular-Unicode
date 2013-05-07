requires 'Exporter', '5.58';
requires 'Filter::Util::Call';
requires 'perl', '5.008001';

on build => sub {
    requires 'Data::Section::TestBase';
    requires 'Test::More', '0.98';
};
