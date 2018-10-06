unit module Sake::TaskStore;

our %TASKS is export;

sub make-task($name, &body,
              :@deps=[], :&cond={True}, :$type) is export {
    if %TASKS{$name}:exists {
        note “Duplicate task $name”;
        exit 2
    }
    %TASKS{~$name} = $type.new: :$name, :&body, :@deps,
                                :&cond, callframe => callframe
}

sub did-you-mean is export {
    return “\nNo tasks were defined” if %TASKS == 0;
    “\nDid you mean one of these?\n”
    ~ %TASKS.keys.sort».indent(4).join: “\n”
}
