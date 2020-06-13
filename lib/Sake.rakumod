use Ake;

sub EXPORT {
    %(
        Ake::Task::EXPORT::DEFAULT::,
        Ake::Task::IO::EXPORT::DEFAULT::,
    )
}

unit module Sake;

sub execute(*@tasks) is export {
    execute |@tasks;
}

sub sake-precheck(:$force = False) is export {
    ake-precheck :$force;
}

