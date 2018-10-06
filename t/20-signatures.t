use v6;
use lib <lib/ t/lib>;
use Sake;
use SakeTester;
use Test;

plan 7;

given make-sake-directory ｢task ‘foo’, { put 42 }｣ {
    test-run ‘just a block’,
             <sake foo>, :out(“42\n”)
}

given make-sake-directory ｢task ‘foo’, -> $ { put 43 }｣ {
    test-run ‘one param’,
             <sake foo>, :out(“43\n”)
}
given make-sake-directory ｢task ‘foo’, sub ($) { put 44 }｣ {
    test-run ‘one param (sub)’,
             <sake foo>, :out(“44\n”)
}

given make-sake-directory ｢task ‘foo’, -> { put 45 }｣ {
    test-run ‘no params’,
             <sake foo>, :out(“45\n”)
}
given make-sake-directory ｢task ‘foo’, sub { put 46 }｣ {
    test-run ‘no params (sub)’,
             <sake foo>, :out(“46\n”)
}

# Issue #7
given make-sake-directory ｢task ‘foo’, -> $task { put $task.name }｣ {
    test-run ‘task is passed’,
             <sake foo>, :out(“foo\n”)
}
given make-sake-directory ｢task ‘foo’, sub ($task) { put $task.name }｣ {
    test-run ‘task is passed (sub)’,
             <sake foo>, :out(“foo\n”)
}
