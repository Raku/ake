## ake [![Tests on source](https://github.com/Raku/ake/actions/workflows/test.yaml/badge.svg)](https://github.com/Raku/ake/actions/workflows/test.yaml)

`ake` is a make-a-like implemented in Raku. It was inspired by
[rake](https://github.com/ruby/rake).


### Installation

Ake is easily installable with [`zef`](https://github.com/ugexe/zef):

```sh
zef install ake
```

If you are using `rakubrew` in `shim` mode you will need to run
`rakubrew rehash` to make the `ake` executable available.


### Current status

Ake is fully-functional but may lack some advanced features. Feature
requests and PRs are welcome!


### Example

Create a file named `Akefile` with these contents:

```raku
task 'buy-food', {
    say 'Bought a salad.'
}

task 'shower', {
    say 'Showered.'
}

task 'morning' => <shower buy-food>;

task 'dinner' => <buy-food>, {
    say 'Yummy!'
}
```

Then you will be able to run `ake` from the same directory
(e.g. `ake morning`).


### License

Ake is available under Artistic License 2.0.
