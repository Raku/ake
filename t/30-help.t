use v6;
use lib <lib/ t/lib>;
use Sake;
use SakeTester;
use Test;

plan 1;

# TODO this file is a placeholder, see Issue #22

#given make-sake-directory ｢task ‘foo’, { put ‘hello’ }｣ {
#    test-run ‘simple task’,
#             <sake foo>, :out(“hello\n”)
#}

given make-sake-directory ｢task ‘foo’, { put ‘hello’ }｣ {
    test-run ‘help ’,
             <sake help>, :out("Registered tasks:\n\t✓ foo\n\t✓ help\n");
}
