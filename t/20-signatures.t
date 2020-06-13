use v6.c;
use lib <lib/ t/lib>;
use Ake;
use AkeTester;
use Test;

plan 7;

given make-ake-directory ｢task ‘foo’, { put 42 }｣ {
    test-run ‘just a block’,
             <ake foo>, :out(“42\n”)
}

given make-ake-directory ｢task ‘foo’, -> $ { put 43 }｣ {
    test-run ‘one param’,
             <ake foo>, :out(“43\n”)
}
given make-ake-directory ｢task ‘foo’, sub ($) { put 44 }｣ {
    test-run ‘one param (sub)’,
             <ake foo>, :out(“44\n”)
}

given make-ake-directory ｢task ‘foo’, -> { put 45 }｣ {
    test-run ‘no params’,
             <ake foo>, :out(“45\n”)
}
given make-ake-directory ｢task ‘foo’, sub { put 46 }｣ {
    test-run ‘no params (sub)’,
             <ake foo>, :out(“46\n”)
}

# Issue #7
given make-ake-directory ｢task ‘foo’, -> $task { put $task.name }｣ {
    test-run ‘task is passed’,
             <ake foo>, :out(“foo\n”)
}
given make-ake-directory ｢task ‘foo’, sub ($task) { put $task.name }｣ {
    test-run ‘task is passed (sub)’,
             <ake foo>, :out(“foo\n”)
}
