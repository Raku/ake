use Sake::Task;
use Sake::TaskStore;
use Sake::Task::IO;

sub EXPORT {
    %(
        Sake::Task::EXPORT::DEFAULT::,
        Sake::Task::IO::EXPORT::DEFAULT::,
    )
}

unit module Sake;

INIT {
    task 'help', {
        say "Registered tasks:";
        for %TASKS.keys.sort {
            say "\t✓ ", $_;
        }
    }
}

multi execute(Str $task) {
    if %TASKS{$task}:!exists {
        note “Task “$task” does not exist”;
        note did-you-mean;
        exit 2
    }
    execute %TASKS{$task}
}

multi execute(Sake::Task $task) {
    my $result = $task.execute;
    $result ~~ Promise
    ?? await $result
    !! $result
}

multi execute(*@tasks) is export {
    my @non-existent = @tasks.grep: { %TASKS{$_}:!exists };
    if @non-existent {
        note “Task “$_” does not exist” for @non-existent;
        note did-you-mean;
        exit 2
    }
    (execute $_ for @tasks)
}

sub sake-precheck(:$force = False) is export {
    my @errors = gather resolve-deps;
    if @errors {
        .note for @errors;

        if $force {
            note ‘’;
            note ‘Continuing with errors because of the --force flag’;
        } else {
            note ‘Exiting. Use --force flag if you want to ignore these errors’;
            exit 1
        }
    }
}
