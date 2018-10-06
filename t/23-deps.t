use v6;
use lib <lib/ t/lib>;
use Sake;
use SakeTester;
use Test;

plan 4;

given make-sake-directory ｢
task ‘A’,        { say ‘A!’ }
task ‘B’ => ‘A’, { say ‘B!’ }
｣ {
    test-run ‘one basic dep’, <sake B>, :out(“A!\nB!\n”);
}

given make-sake-directory ｢
task ‘A’,        { say ‘A!’ }
task ‘B’ => ‘A’, { say ‘B!’ }
task ‘C’ => ‘B’, { say ‘C!’ }
task ‘D’ => ‘C’, { say ‘D!’ }
｣ {
    test-run ‘dependecy chain’, <sake D>, :out(“A!\nB!\nC!\nD!\n”);
}

given make-sake-directory ｢
task ‘A’,          { say ‘A!’ }
task ‘B’,          { say ‘B!’ }
task ‘C’ => <A B>, { say ‘C!’ }
｣ {
    test-run ‘multiple dependencies’, <sake C>, :out(“A!\nB!\nC!\n”);
}

given make-sake-directory ｢
task ‘F’ => <D E>, { say ‘F!’ }
task ‘B’,          { say ‘B!’ }
task ‘D’ => <A C>, { say ‘D!’ }
task ‘A’,          { say ‘A!’ }
task ‘E’,          { say ‘E!’ }
task ‘C’ => <A B>, { say ‘C!’ }
｣ {
    test-run ‘shuffled dep tree’, <sake F>, :out(“A!\nB!\nC!\nD!\nE!\nF!\n”);
}

# TODO IO tasks?
