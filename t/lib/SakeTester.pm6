unit module SakeTester;

use File::Temp;
use Test;

sub make-sake-directory($contents, :$filename = ‘Sakefile’) is export {
    my $dir = tempdir.IO;
    $dir.add($filename).spurt: $contents;
    $dir
}

sub test-run($description, *@args,
             :$out = ‘’, :$err = ‘’,
             :$exitcode = 0,
             :$cwd is copy,
             :$env is copy = %*ENV,
             *%rest) is export {

    $cwd //= CALLERS::(‘$_’);
    # TODO ↓ any better way ?
    $env = %(|$env,
             PATH     => “{$*CWD.add: ‘bin’}:{$env<PATH>     // ‘’}”,
             PERL6LIB => “{$*CWD.add: ‘lib’},{$env<PERL6LIB> // ‘’}”,
            );

    subtest $description, {
        plan 4;
        my $proc = run @args, :$env, :$cwd, :out, :err, |%rest;
        cmp-ok $proc.out.slurp, &[~~],      $out,   ‘stdout is correct’;
        cmp-ok $proc.err.slurp, &[~~],      $err,   ‘stderr is correct’;
        cmp-ok $proc.exitcode,  &[~~], $exitcode, ‘exitcode is correct’;
        cmp-ok $proc.signal,    &[==],         0,   ‘signal is 0’;
    }
}
