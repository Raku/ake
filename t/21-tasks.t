use v6.c;
use lib <lib/ t/lib>;
use Ake;
use AkeTester;
use Test;

plan 2;

given make-ake-directory ｢task ‘foo’, { put ‘hello’ }｣ {
    test-run ‘simple task’,
             <ake foo>, :out(“hello\n”)
}

# Issue #12
given make-ake-directory ｢task ‘foo’, { run ‘false’ }｣ {
    test-run ‘failed Proc’,
             <ake foo>, :out(‘’), :1exitcode,
             :err(/‘The spawned command 'false' exited unsuccessfully’/)
}
