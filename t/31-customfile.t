use v6.c;
use lib <lib/ t/lib>;
use Ake;
use AkeTester;
use Test;

plan 1;

given make-ake-directory :filename(‘customfile’),
                          ｢task ‘foo’, { put ‘hello’ }｣ {
    test-run ‘custom akefile name’,
             <ake --file=customfile foo>, :out(“hello\n”)
}
