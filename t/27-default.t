use v6.c;
use lib <lib/ t/lib>;
use Ake;
use AkeTester;
use Test;

plan 2;

given make-ake-directory ｢
  task ‘first’,   { put ‘first’      }
  task ‘default’, { put ‘default ok’ }
｣ {
    test-run ‘no task implies default’,
             <ake>, :out(“default ok\n”)
}

given make-ake-directory ｢
  task ‘first’,   { put ‘first’      }
｣ {
    test-run ‘no task implies default’,
             <ake>, :out(‘’),
             :err(*), # TODO check & fix the error message
             :2exitcode
}
