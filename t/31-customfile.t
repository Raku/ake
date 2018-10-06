use v6;
use lib <lib/ t/lib>;
use Sake;
use SakeTester;
use Test;

plan 1;

given make-sake-directory :filename(‘customfile’),
                          ｢task ‘foo’, { put ‘hello’ }｣ {
    test-run ‘custom sakefile name’,
             <sake --file=customfile foo>, :out(“hello\n”)
}
