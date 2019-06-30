use v6.c;
use lib <lib/ t/lib>;
use Sake;
use SakeTester;
use Test;

plan 2;

given make-sake-directory ｢task ‘foo’, { put ‘hello’ }｣ {
    test-run ‘help ’,
             <sake help>, :out(“Registered tasks:\n\t✓ foo\n\t✓ help\n”);
}

given make-sake-directory ｢task ‘help’, { put ‘very helpful message’ }｣ {
    test-run ‘help ’,
             <sake help>, :out(“very helpful message\n”);
}
