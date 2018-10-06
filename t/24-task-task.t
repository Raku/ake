use v6;
use lib <lib/ t/lib>;
use Sake;
use SakeTester;
use Test;

plan 1;

given make-sake-directory ｢
task ‘foo’, { put ‘foo!’ }
task ‘bar’, { put ‘bar!’ }
task ‘baz’, { put ‘baz!’ }
｣ {
    test-run ‘multiple’,
             <sake foo bar baz>, :out(“foo!\nbar!\nbaz!\n”)
}

# TODO test and fix tasks in different order
