use v6;
use lib <lib/ t/lib>;
use Sake;
use SakeTester;
use Test;

plan 6 × 3;

my $t;


# Normal tasks

subtest ‘task with no deps and no block’, {
    plan 4;
    lives-ok { $t = task ‘no-dep-no-block’         }, ‘lives’;
    is-deeply $t.deps,     [],            ‘correct deps’;
    nok $t.body.defined,                  ‘correct body’;
    is $t.^name, ‘Sake::Task’,            ‘correct task type’;
}
subtest ‘task with no deps and a block’, {
    plan 4;
    lives-ok { $t = task ‘no-dep-block’,   { 111 } }, ‘lives’;
    is-deeply $t.deps,     [],            ‘correct deps’;
    is-deeply $t.body.(), 111,            ‘correct body’;
    is $t.^name, ‘Sake::Task’,            ‘correct task type’;
}


subtest ‘task with one dep and no block’, {
    plan 4;
    lives-ok { $t = task ‘str-dep-no-block’ => ‘one’          }, ‘lives’;
    is-deeply $t.deps,   [‘one’,],        ‘correct deps’;
    nok $t.body.defined,                  ‘correct body’;
    is $t.^name, ‘Sake::Task’,            ‘correct task type’;
}
subtest ‘task with one dep and a block’, {
    plan 4;
    lives-ok { $t = task ‘str-dep-block’    => ‘two’, { 222 } }, ‘lives’;
    is-deeply $t.deps,    [‘two’,],       ‘correct deps’;
    is-deeply $t.body.(),      222,       ‘correct body’;
    is $t.^name, ‘Sake::Task’,            ‘correct task type’;
}


subtest ‘task with deps and no block’, {
    plan 4;
    lives-ok { $t = task ‘list-dep-no-block’ => <foo bar>      }, ‘lives’;
    is-deeply $t.deps,   [‘foo’, ‘bar’],  ‘correct deps’;
    nok $t.body.defined,                  ‘correct body’;
    is $t.^name, ‘Sake::Task’,            ‘correct task type’;
}
subtest ‘task with deps and a block’, {
    plan 4;
    lives-ok { $t = task ‘list-dep-block’    => <foo bar>, {9} }, ‘lives’;
    is-deeply $t.deps,    [‘foo’, ‘bar’], ‘correct deps’;
    is-deeply $t.body.(),              9, ‘correct body’;
    is $t.^name, ‘Sake::Task’,            ‘correct task type’;
}


# IO tasks

subtest ‘IO task with no deps and no block’, {
    plan 4;
    lives-ok { $t = task ‘no-dep-no-blockIO’.IO         }, ‘lives’;
    is-deeply $t.deps,    [],             ‘correct deps’;
    nok $t.body.defined,                  ‘correct body’;
    is $t.^name, ‘Sake::Task::IO’,        ‘correct task type’;
}
subtest ‘IO task with no deps and a block’, {
    plan 4;
    lives-ok { $t = task ‘no-dep-blockIO’.IO,   { 111 } }, ‘lives’;
    is-deeply $t.deps,     [],            ‘correct deps’;
    is-deeply $t.body.(), 111,            ‘correct body’;
    is $t.^name, ‘Sake::Task::IO’,        ‘correct task type’;
}


subtest ‘IO task with one dep and no block’, {
    plan 4;
    lives-ok { $t = task ‘str-dep-no-blockIO’.IO => ‘one’          }, ‘lives’;
    is-deeply $t.deps,   [‘one’,],        ‘correct deps’;
    nok $t.body.defined,                  ‘correct body’;
    is $t.^name, ‘Sake::Task::IO’,        ‘correct task type’;
}
subtest ‘IO task with one dep and a block’, {
    plan 4;
    lives-ok { $t = task ‘str-dep-blockIO’.IO    => ‘two’, { 222 } }, ‘lives’;
    is-deeply $t.deps,    [‘two’,],       ‘correct deps’;
    is-deeply $t.body.(),      222,       ‘correct body’;
    is $t.^name, ‘Sake::Task::IO’,        ‘correct task type’;
}


subtest ‘IO task with deps and no block’, {
    plan 4;
    lives-ok { $t = task ‘list-dep-no-blockIO’.IO => <foo bar>      }, ‘lives’;
    is-deeply $t.deps,   [‘foo’, ‘bar’],  ‘correct deps’;
    nok $t.body.defined,                  ‘correct body’;
    is $t.^name, ‘Sake::Task::IO’,        ‘correct task type’;
}
subtest ‘IO task with deps and a block’, {
    plan 4;
    lives-ok { $t = task ‘list-dep-blockIO’.IO    => <foo bar>, {9} }, ‘lives’;
    is-deeply $t.deps,    [‘foo’, ‘bar’], ‘correct deps’;
    is-deeply $t.body.(),              9, ‘correct body’;
    is $t.^name, ‘Sake::Task::IO’,        ‘correct task type’;
}


# `file` IO tasks

subtest ‘`file` IO task with no deps and no block’, {
    plan 4;
    lives-ok { $t = file ‘no-dep-no-block-file’         }, ‘lives’;
    is-deeply $t.deps,    [],             ‘correct deps’;
    nok $t.body.defined,                  ‘correct body’;
    is $t.^name, ‘Sake::Task::IO’,        ‘correct task type’;
}
subtest ‘`file` IO task with no deps and a block’, {
    plan 4;
    lives-ok { $t = file ‘no-dep-block-file’,   { 111 } }, ‘lives’;
    is-deeply $t.deps,     [],            ‘correct deps’;
    is-deeply $t.body.(), 111,            ‘correct body’;
    is $t.^name, ‘Sake::Task::IO’,        ‘correct task type’;
}


subtest ‘`file` IO task with one dep and no block’, {
    plan 4;
    lives-ok { $t = file ‘str-dep-no-block-file’ => ‘one’          }, ‘lives’;
    is-deeply $t.deps,   [‘one’,],        ‘correct deps’;
    nok $t.body.defined,                  ‘correct body’;
    is $t.^name, ‘Sake::Task::IO’,        ‘correct task type’;
}
subtest ‘`file` IO task with one dep and a block’, {
    plan 4;
    lives-ok { $t = file ‘str-dep-block-file’    => ‘two’, { 222 } }, ‘lives’;
    is-deeply $t.deps,    [‘two’,],       ‘correct deps’;
    is-deeply $t.body.(),      222,       ‘correct body’;
    is $t.^name, ‘Sake::Task::IO’,        ‘correct task type’;
}


subtest ‘`file` IO task with deps and no block’, {
    plan 4;
    lives-ok { $t = file ‘list-dep-no-block-file’ => <foo bar>      }, ‘lives’;
    is-deeply $t.deps,   [‘foo’, ‘bar’],  ‘correct deps’;
    nok $t.body.defined,                  ‘correct body’;
    is $t.^name, ‘Sake::Task::IO’,        ‘correct task type’;
}
subtest ‘`file` IO task with deps and a block’, {
    plan 4;
    lives-ok { $t = file ‘list-dep-block-file’    => <foo bar>, {9} }, ‘lives’;
    is-deeply $t.deps,    [‘foo’, ‘bar’], ‘correct deps’;
    is-deeply $t.body.(),              9, ‘correct body’;
    is $t.^name, ‘Sake::Task::IO’,        ‘correct task type’;
}
