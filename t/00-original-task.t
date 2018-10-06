use v6;
use lib <lib/ t/lib>;
use Sake;
use Test;

plan 5;

my $x = ‘’;

my $t = task ‘fred’, { $x = ‘meth’ }
$t.execute;
is $x, ‘meth’, ‘can execute task via method’;

$x = ‘’;
execute ‘fred’;
is $x, ‘meth’, ‘can execute task by name’;

(task ‘dino’ => ‘fred’, { $x = ‘sd’ }).execute;
is $x, ‘sd’, ‘single dependency works fine’;

(task ‘bedrock’ => <fred dino>, { $x = ‘md’ }).execute;
is $x, ‘md’, ‘multiple dependencies work fine’;

task ‘clear-headed-fred’, { $x = ‘again’ }
(task ‘wilma’ => <clear-headed-fred>).execute;
is $x, ‘again’, ‘body is optional’;
