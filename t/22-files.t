use v6;
use lib <lib/ t/lib>;
use Sake;
use SakeTester;
use Test;

plan 6;

given make-sake-directory ｢task ‘foo’.IO, { put ‘hello’ }｣ {
    test-run ‘simple IO task’,
             <sake foo>, :out(“hello\n”);
    ok .add(‘foo’).e, ‘file was touched’;
}

given make-sake-directory ｢file ‘foo’, { put ‘hello’ }｣ {
    test-run ‘simple IO task (file sub)’,
             <sake foo>, :out(“hello\n”);
    ok .add(‘foo’).e, ‘file was touched (file sub)’;
}

# TODO test modification time

# Issue #12
given make-sake-directory ｢task ‘foo’.IO, { run ‘false’ }｣ {
    test-run ‘failed Proc’,
             <sake foo>, :out(‘’), :1exitcode,
             :err(/‘The spawned command 'false' exited unsuccessfully’/);

    ok .add(‘foo’).e.not, ‘file not touched with failed Procs’;
}
