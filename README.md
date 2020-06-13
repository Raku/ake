## sake

`sake` is a make-a-like implemented in Raku. It was inspired by
[rake](https://github.com/ruby/rake).


### Installation

Sake is easily installable with [`zef`](https://github.com/ugexe/zef):

```sh
zef install sake
```

If you are using `rakubrew` in `shim` mode you will need to run
`rakubrew rehash` to make the `sake` executable available.


### Current status

Sake is fully-functional but may lack some advanced features. Feature
requests and PRs are welcome!


### Example

Create a file named `Sakefile` with these contents:

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

Then you will be able to run `sake` from the same directory
(e.g. `sake morning`).


### License

Sake is available under Artistic License 2.0.
