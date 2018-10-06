use v6;
use lib <lib/ t/lib>;
use Sake;
use SakeTester;
use Test;

plan 2;

given make-sake-directory ｢task ‘foo’, { put ‘hello’ }｣ {
    test-run ‘simple task’,
             <sake foo>, :out(“hello\n”)
}

# Issue #12
given make-sake-directory ｢task ‘foo’, { run ‘false’ }｣ {
    test-run ‘failed Proc’,
             <sake foo>, :out(‘’), :1exitcode,
             :err(/‘The spawned command 'false' exited unsuccessfully’/)
}
