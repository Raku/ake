use v6;
use lib <lib/ t/lib>;
use Sake;
use SakeTester;
use Test;

plan 4;

# Issue #13
given make-sake-directory ｢task ｢`echo foo`｣.IO, { put ‘hello’ }｣ {
    test-run ‘shell injection does not work’,
             (‘sake’, ｢`echo foo`｣), :out(“hello\n”);
    ok .add(｢`echo foo`｣).e, ‘file was touched’;
}

given make-sake-directory ｢task ｢--foo｣.IO, { put ‘hello’ }｣ {
    test-run ‘filenames are not interpreted as parameters’,
             (<sake -->, ｢--foo｣), :out(“hello\n”);
    ok .add(｢--foo｣).e, ‘file was touched’;
}
