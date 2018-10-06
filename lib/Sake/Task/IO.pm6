use Sake::Task;
use Sake::TaskStore;

unit class Sake::Task::IO is Sake::Task;

method modification-time {
    $.name.IO.e
    ?? $.name.IO.modified
    !! -∞
}

method execute {
    resolve-deps self, :live; # in case the task was added later
    await @.deps».readify;

    if $.cond() {
        with self.body {
            my $last-dep = @.deps».modification-time.max;
            $last-dep = now if $last-dep == -∞;
            sink .(self) if $.modification-time < $last-dep;
        }

        my &touch = -> $filename { run <touch -->, $filename };
        touch $.name.IO;
    }
    $.ready.keep: $.modification-time unless $.ready;
}



multi sub task(IO $path, &body?) is export {
    make-task $path, &body, type => Sake::Task::IO
}

multi sub task(Pair (IO :key($path), :value($deps)), &body?) is export {
    make-task $path, &body, deps => $deps.list, type => Sake::Task::IO
}


proto sub file(|) is export {*}

multi sub file(IO() $path, &body?) {
    task $path, &body
}

multi sub file(Pair (IO() :key($path), :value($deps)), &body?) {
    task $path => $deps, &body
}
