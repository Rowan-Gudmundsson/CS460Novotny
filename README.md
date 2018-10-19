# CS460Novotny

A C compiler project made for CS 460 at UNR in conjunction with Alexander  Novotny, [Rowan Gudmundsson](https://github.com/Rowan-Gudmundsson/), and Emily Gentry

## Build instructions
Navigate to the PA then execute:
```shell
make
```
## Symbol Table Test Driver
To run:
```shell
./symboTest
```

Then there are several valid commands:
```
  quit - Quit the program
  {    - Push a new scope
  }    - Pop current scope
  >>   - Change from variable declarations to variable usage
  <<   - Change from variable usage to variable declarations (default mode)
  DUMP - Output current symbol table to screen and symboTest.out
  [id] - Declare or reference variable (depending on current mode)
```

As well, when you run make, a test is run in the `symbol table tests/` directory. The outputs can be checked in the `.out` files.

## Running the compiler
To run:

```shell
./spi-c [flags] <input file>
```

with the currently supported flags:
```
  -h, --help       - Display help menu
  -o <output file> - Output to the given file
  -d[debug levels] - Enable debug flags for various different stages of the compiler.
                     Allowable flags include: s#, l#, p#
                     for symbol table, lexer, and parser
                     (examples: "-dl", "-dl1s4", "-dlps")
```

## Extra Credit
The binary tree used (found in [binary_tree.hpp](https://github.com/alexander-novo/CS460Novotny/blob/master/binary_tree.hpp)) is a red-black tree. This can be seen by using the `DUMP` command in `symboTest`.
