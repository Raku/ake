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
        .(self) with self.body;
    }

}

sub execute($task) is export {
    if %TASKS{$task}:exists {
        sink %TASKS{$task}.execute;
    } else {
        # TODO something more awesome here
        $*ERR.say("No task named $task...skipping");
    }
}

proto sub task(|) is export { * }

my sub make-task($name, &body, :@deps=[], :&cond={True}) {
    return if %TASKS{~$name};
    %TASKS{~$name} = Sake-Task.new(:$name, :&body, :@deps, :&cond);
}

multi sub task(Str $name, &body) {
    make-task($name, &body);
}

multi sub task(Pair $name-deps, &body?) {
    my ($name,$deps) := $name-deps.kv;      # unpack name and dependencies
    my @deps = $deps.list;                  # so that A => B and A => <B C D> both work
    return make-task($name, &body, :@deps);
}


proto sub file(|) is export { * }

my sub touch (Str $filename) {
    run ‘touch’, ‘--’, $filename;
}

multi sub file(Str $name, &body) {
    return make-task(
        $name,
        { &body($_); touch $name },
        :cond(sub { $name.IO !~~ :e; })
    )
}

multi sub file(Pair $name-deps, &body) {
    my ($name,$deps) := $name-deps.kv;      # unpack name and dependencies
    my @deps = $deps.list;                  # so that A => B and A => <B C D> both work
    my $cond = {
        my $f = $name.path;
        !($f ~~ :e) || $f.modified < all(map { $_.modified }, grep { $_ ~~ IO::Path }, @deps);
    };
    return make-task(
        $name,
        { &body($_); touch $name },
        :@deps,
        :cond($cond)
    )
}

sub look-for-sakefiles(IO::Path $path) is export {
    if $path.e {
        EVALFILE $path.absolute;
    }

    my $path-to-check = $*CWD;
    # Use repeat otherwise 'ne /' would end the loop before the sake file would be searched in '/'
    repeat {
        $path-to-check = $path-to-check.parent;
        my $file-to-check = $path-to-check.add('Sakefile');
        if $file-to-check.e {
            EVALFILE $file-to-check.absolute;
        }

    } while $path-to-check ne "/";

    if not %TASKS.elems > 0 {
        die "No Sakefiles found";
    }
}
