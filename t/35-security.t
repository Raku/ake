use v6.c;
use lib <lib/ t/lib>;
use Ake;
use AkeTester;
use Test;

plan 4;

# Issue #13
given make-ake-directory ｢task ｢`echo foo`｣.IO, { put ‘hello’ }｣ {
    test-run ‘shell injection does not work’,
             (‘ake’, ｢`echo foo`｣), :out(“hello\n”);
    ok .add(｢`echo foo`｣).e, ‘file was touched’;
}

given make-ake-directory ｢task ｢--foo｣.IO, { put ‘hello’ }｣ {
    test-run ‘filenames are not interpreted as parameters’,
             (<ake -->, ｢--foo｣), :out(“hello\n”);
    ok .add(｢--foo｣).e, ‘file was touched’;
}
