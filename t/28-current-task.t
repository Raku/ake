use v6.c;
use lib <lib/ t/lib>;
use Ake;
use AkeTester;
use Test;

plan 2;

# Issue #7
given make-ake-directory ｢task ‘foo’, { say .name }｣ {
    test-run ‘current task is passed to the block’,
             <ake foo>, :out(“foo\n”)
}
skip ‘What should be done with IO task names?’, 1;
#given make-ake-directory ｢task ‘foo’.IO, { say .name }｣ {
#    test-run ‘current IO task is passed to the block’,
#             <ake foo>, :out(“foo\n”)
#}
