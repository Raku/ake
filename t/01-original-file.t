use v6;
use lib <lib/ t/lib>;
use Sake;
use Test;

plan 11;

my $x = ‘’;

my $t = file ‘fred’, { $x = ‘meth’ }
$t.execute;
is $x, ‘meth’, ‘can execute file task via method’;
ok ‘fred’.IO.e, ‘file exists’;

$x = ‘’;
‘fred’.IO.unlink;

execute ‘fred’;
is $x, ‘meth’, ‘can execute file task by name’;
ok ‘fred’.IO.e, ‘file exists’;

(file ‘dino’ => ‘fred’, { $x = ‘sd’ }).execute;
is $x, ‘sd’, ‘single file dependency works fine’;
ok ‘dino’.IO.e, ‘file exists’;

(file ‘bedrock’ => <fred dino>, { $x = ‘md’ }).execute;
is $x, ‘md’, ‘multiple file dependencies work fine’;
ok ‘bedrock’.IO.e, ‘file exists’;

file ‘clear-headed-fred’, { $x = ‘again’ }
(file ‘wilma’ => <clear-headed-fred>).execute;
is $x, ‘again’, ‘body is optional’;
ok ‘clear-headed-fred’.IO.e, ‘file exists’;
ok ‘wilma’.IO.e, ‘file exists’;
