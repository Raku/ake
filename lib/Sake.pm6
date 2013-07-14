module Sake;

our %TASKS;

class Sake-Task {
    has $.name = !!! 'name required';     
    has @.deps;     # dependencies
    has &.body = !!! 'body required';     # code to execute for this task

    method execute { 
        for self.deps -> $d { execute($d); }
        self.body.(); 
    }

}

sub execute($task) is export {
    %TASKS{$task}.execute;
}

proto sub task(|) is export { * }

multi sub task(Str $name, &body) {
    %TASKS{$name} = Sake-Task.new(:$name, :&body, :deps([]));
}

multi sub task(Pair $name-deps, &body) {
    my ($name,@deps) := $name-deps.kv;      # unpack name and dependencies
    %TASKS{$name} = Sake-Task.new(:$name, :&body, :@deps);
}
