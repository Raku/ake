use v6;
use Test;
use Sake;

plan 5;

#eval_lives_ok("use Sake;", "module can be used without error");

my $x = "";

my $t = task "fred", { $x = "meth"; }
$t.execute;
is($x,"meth", "can execute task via method");

$x = "";
execute("fred");
is($x,"meth", "can execute task by name");

(task "dino" => "fred", { $x = "sd"; }).execute;
is($x,"sd", "single dependency works fine");

(task "bedrock" => <fred dino>, { $x = "md"; }).execute;
is($x,"md", "multiple dependencies work fine");

(task "wilma" => <fred>).execute;
is($x,"meth", "body is optional");
