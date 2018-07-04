use v6;
use Test;

plan 1;

my $output = "";
my $proc = Proc::Async.new('bin/sake', '--file=t/01-default.sake');
$proc.stdout.tap(-> $buf { $output ~= $buf });
await $proc.start;

is $output, "default ok\n", "no task implies default";
