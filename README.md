# CS460Novotny

A C compiler project made for CS 460 at UNR in conjunction with [Rowan Gudmundsson](https://github.com/Rowan-Gudmundsson/) and Emily G

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


