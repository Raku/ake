use v6.c;
use lib <lib/ t/lib>;
use Ake;
use AkeTester;
use Test;

plan 6;

given make-ake-directory ｢task ‘foo’.IO, { put ‘hello’ }｣ {
    test-run ‘simple IO task’,
             <ake foo>, :out(“hello\n”);
    ok .add(‘foo’).e, ‘file was touched’;
}

given make-ake-directory ｢file ‘foo’, { put ‘hello’ }｣ {
    test-run ‘simple IO task (file sub)’,
             <ake foo>, :out(“hello\n”);
    ok .add(‘foo’).e, ‘file was touched (file sub)’;
}

# TODO test modification time

# Issue #12
given make-ake-directory ｢task ‘foo’.IO, { run ‘false’ }｣ {
    test-run ‘failed Proc’,
             <ake foo>, :out(‘’), :1exitcode,
             :err(/‘The spawned command 'false' exited unsuccessfully’/);

    ok .add(‘foo’).e.not, ‘file not touched with failed Procs’;
}
