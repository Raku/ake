use v6.c;
use lib <lib/ t/lib>;
use Ake;
use AkeTester;
use Test;

plan 1;

given make-ake-directory ｢
task ‘foo’, { put ‘foo!’ }
task ‘bar’, { put ‘bar!’ }
task ‘baz’, { put ‘baz!’ }
｣ {
    test-run ‘multiple’,
             <ake foo bar baz>, :out(“foo!\nbar!\nbaz!\n”)
}

# TODO test and fix tasks in different order
