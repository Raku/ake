use v6;
use lib <lib/ t/lib>;
use Sake;
use SakeTester;
use Test;

plan 2;

given make-sake-directory ｢
  task ‘first’,   { put ‘first’      }
  task ‘default’, { put ‘default ok’ }
｣ {
    test-run ‘no task implies default’,
             <sake>, :out(“default ok\n”)
}

given make-sake-directory ｢
  task ‘first’,   { put ‘first’      }
｣ {
    test-run ‘no task implies default’,
             <sake>, :out(‘’),
             :err(*), # TODO check & fix the error message
             :2exitcode
}
