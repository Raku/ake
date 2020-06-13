use v6.c;
use lib <lib/ t/lib>;
use Ake;
use AkeTester;
use Test;

plan 2;

given make-ake-directory ｢task ‘foo’, { put ‘hello’ }｣ {
    test-run ‘help ’,
             <ake help>, :out(“Registered tasks:\n\t✓ foo\n\t✓ help\n”);
}

given make-ake-directory ｢task ‘help’, { put ‘very helpful message’ }｣ {
    test-run ‘help ’,
             <ake help>, :out(“very helpful message\n”);
}
