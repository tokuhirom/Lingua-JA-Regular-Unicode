use inc::Module::Install;
name 'Lingua-JA-Regular-Unicode';
all_from 'lib/Lingua/JA/Regular/Unicode.pm';

requires 'Exporter' => 5.58;

tests 't/*.t t/*/*.t t/*/*/*.t t/*/*/*/*.t';
test_requires 'Test::More';
test_requires 'YAML';
author_tests 'xt';
use_test_base;
auto_include;
WriteAll;
