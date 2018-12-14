OBS = parser.o scanner.o main.o symbol.o node.o RegisterTable.o

CC = g++
CFLAGS = -g -Wall -std=c++14 -DYYDEBUG=1

.DELETE_ON_ERROR:
.PHONY: all

all: spi-c symboTest test

# COMPILE PROGRAM

spi-c: $(OBS)
	$(CC) $(CFLAGS) $(OBS) -o spi-c

scanner.o: lex.yy.c
	$(CC) $(CFLAGS) -c lex.yy.c -o scanner.o

lex.yy.c: spi-c.lex
	flex spi-c.lex

parser.o: spi-c.tab.c
	$(CC) $(CFLAGS) -c spi-c.tab.c -o parser.o

spi-c.tab.c: spi-c.y node.h symbol.h
	bison -d -v spi-c.y

main.o: main.cpp main.h spi-c.tab.h symbol.h node.h errors.h RegisterTable.h
	$(CC) $(CFLAGS) -c main.cpp -o main.o

symbol.o: symbol.cpp symbol.h
	$(CC) $(CFLAGS) -c symbol.cpp -o symbol.o

node.o: node.h node.cpp
	$(CC) $(CFLAGS) -c node.cpp -o node.o

RegisterTable.o: RegisterTable.h RegisterTable.cpp node.h
	$(CC) $(CFLAGS) -c RegisterTable.cpp -o RegisterTable.o

scanner.o parser.o main.o : spi-c.tab.h

symboTest: symboTest.o symbol.o
	$(CC) $(CFLAGS) symboTest.o symbol.o -o symboTest

symboTest.o: symboTest.cpp symboTest.h
	$(CC) $(CFLAGS) -c symboTest.cpp -o symboTest.o

# CLEAN

.PHONY:
test: tests/compiler.test tests/redeclaration.test tests/shadowing.test tests/undefined_reference.test spi-c
ifeq ($(OS),Windows_NT)
	-.\spi-c tests/compiler.test > tests/compiler.out
	-.\spi-c tests/redeclaration.test > tests/redeclaration.out
	-.\spi-c tests/shadowing.test > tests/shadowing.out
	-.\spi-c tests/undefined_reference.test > tests/undefined_reference.out
	-.\symboTest < "symbol table tests/test1" > "symbol table tests/test1.out"
else
	-./spi-c tests/compiler.test > tests/compiler.out
	-./spi-c tests/redeclaration.test > tests/redeclaration.out
	-./spi-c tests/shadowing.test > tests/shadowing.out
	-./spi-c tests/undefined_reference.test > tests/undefined_reference.out
endif

.PHONY: clean
clean:
	rm -f *.o *.aux *.log *.pdf *.tex *.synctex.gz *.out *~ lex.yy.c spi-c.tab.c spi-c.tab.h
