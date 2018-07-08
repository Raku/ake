use v6;
use Test;
use Sake;

use File::Temp;


# Test the feature to look for the Sakefile not only in the current working directory but also in the parents until
# up to the root folder.

my $no-sakefile-dir = tempdir;
my $cwd = chdir($no-sakefile-dir);
dies-ok {look-for-sakefiles("Sakefile".IO)}, "Dies when no Sakefile was found";
chdir($cwd);

# Test that the same task in parent sakefiles does not overwrite the "nearest" one
my ($test-result-name, $test-result-fh) = tempfile();
my $parent-dir = create-dir-and-file(file-to-write => $test-result-name,
        what-to-write => "parent");

my ($file-name, $file-fh) = create-dir-and-file(parent => $parent-dir,
        file-to-write => $test-result-name,
        what-to-write => "test");

look-for-sakefiles($file-fh.IO);

execute("test");

is  $test-result-fh.slurp, "test", "Nearest task is used";

# Clean tasks hash for following tests.
%Sake::TASKS = %();

done-testing;

sub create-dir-and-file(:$parent, :$file-to-write, :$what-to-write) {
    my $dir = $parent ?? tempdir(tempdir => $parent) !! tempdir;

    my ($file-name, $file-fh) = tempfile("Sakefile", tempdir => $dir);
    my $test-task = qq:to/END/;
        task 'test', \{
    $file-to-write.IO.spurt("$what-to-write");
}
END

    $file-fh.spurt($test-task);

    return ($file-name, $file-fh);
}