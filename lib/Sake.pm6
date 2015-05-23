unit module Sake;

our %TASKS;

class Sake-Task {
    has $.name = !!! 'name required';     
    has @.deps;                         # dependencies
    has &.body = !!! 'body required';   # code to execute for this task
    has &.cond = { True };              # only execute when True

    method execute { 
        return unless self.cond.();
        for self.deps -> $d { execute($d); }
        self.body.(); 
    }

}

sub execute($task) is export {
    if %TASKS{$task}:exists {
        %TASKS{$task}.execute;
    } else {
        # TODO something more awesome here
        $*ERR.say("No task named $task...skipping");
    }
}

proto sub task(|) is export { * }

my sub make_task($name, &body, :@deps=[], :&cond={True}) {
    die "Duplicate task $name!" if %TASKS{~$name};
    %TASKS{~$name} = Sake-Task.new(:$name, :&body, :@deps, :&cond);
}

multi sub task(Str $name, &body) {
    make_task($name, &body);
}

multi sub task(Pair $name-deps, &body) {
    my ($name,$deps) := $name-deps.kv;      # unpack name and dependencies
    my @deps = $deps.list;                  # so that A => B and A => <B C D> both work
    return make_task($name, &body, :@deps);
}


proto sub file(|) is export { * }

my sub touch (Str $filename) {
    shell("touch $filename");
}

multi sub file(Str $name, &body) {
    return make_task($name, sub { &body.(); touch($name) }, :cond(sub { $name.path !~~ :e; }) );
}

multi sub file(Pair $name-deps, &body) {
    my ($name,$deps) := $name-deps.kv;      # unpack name and dependencies
    my @deps = $deps.list;                  # so that A => B and A => <B C D> both work
    my $cond = {
        my $f = $name.path;
        !($f ~~ :e) || $f.modified < all(map { $_.modified }, grep { $_ ~~ IO::Path }, @deps);
    };
    return make_task($name, sub { &body.(); touch($name) }, :@deps, :cond($cond));
}


