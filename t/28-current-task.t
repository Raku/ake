use v6;
use lib <lib/ t/lib>;
use Sake;
use SakeTester;
use Test;

plan 2;

# Issue #7
given make-sake-directory ｢task ‘foo’, { say .name }｣ {
    test-run ‘current task is passed to the block’,
             <sake foo>, :out(“foo\n”)
}
skip ‘What should be done with IO task names?’, 1;
#given make-sake-directory ｢task ‘foo’.IO, { say .name }｣ {
#    test-run ‘current IO task is passed to the block’,
#             <sake foo>, :out(“foo\n”)
#}
