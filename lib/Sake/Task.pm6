use Sake::TaskStore;

unit class Sake::Task;

has $.name = !!! ‘name required’;
has @.deps;                         #= Task dependencies
has &.body = !!! ‘body required’;   #= Code to execute for this task
has &.cond = { True };              #= Condition for task execution
has $.modification-time = -∞;
has $.ready = Promise.new;
has $.callframe;

#| Executes the task, even if it was already executed.
method execute {
    if $.ready.status !~~ Planned {
        note “Warning: re-executing task “$.name” per your request”
    }
    resolve-deps self, :live; # in case the task was added later
    await @.deps».readify;

    if $.cond() {
        with self.body {
            sink .signature.ACCEPTS(\(self))
            ?? .(self)
            !! .();
        }
        $!modification-time = now;
    }

    $.ready.keep: $.modification-time unless $.ready.status ~~ Kept;
}

method readify {
    # TODO race conditions
    self.execute unless $.ready.status ~~ Kept;
    $.ready
}


multi resolve-deps($task, :$live = False) is export {
    $task.deps .= map: {
        do if $_ ~~ Sake::Task {
            $_ # already resolved
        } elsif %TASKS{$_}:exists {
            %TASKS{$_}
        } else {
            my $msg = “Task $task.name() depends on $_ but no such task was found”;
            $live ?? note $msg !! take $msg;
            Empty
        }
    }
}

multi resolve-deps is export {
    my @errors = gather { resolve-deps $_ for %TASKS.values }
    if @errors > 0 { # TODO what if it's another error
        take $_ for @errors;
        take did-you-mean
    }
}



proto sub task(|) is export {*}

multi sub task(Str $name, &body?) {
    make-task $name, &body, type => Sake::Task
}

multi sub task(Pair (Str :key($name), :value($deps)), &body?) {
    make-task $name, &body, type => Sake::Task, deps => $deps.list
}
