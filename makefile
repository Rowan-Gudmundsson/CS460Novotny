OBS = parser.o scanner.o main.o symbol.o node.o RegisterTable.o

CC = g++
UNAME = $(shell uname)

ifeq ($(UNAME), Darwin)
CFLAGS = -g -Wall -std=c++14 -ferror-limit=5 -DYYDEBUG=1
else
CFLAGS = -g -Wall -std=c++14 -fmax-errors=5 -DYYDEBUG=1
endif

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

node.o: node.h node.cpp symbol.h
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
test: tests/compiler.c tests/bubble.c tests/factorial_it.c tests/factorial.c tests/matrix.c
ifeq ($(OS),Windows_NT)
	-.\spi-c tests/compiler.c -o out/compiler.asm > NUL
	-.\spi-c tests/bubble.c -o out/bubble.asm > NUL
	-.\spi-c tests/factorial_it.c -o out/factorial_it.asm > NUL
	-.\spi-c tests/factorial.c -o out/factorial.asm > NUL
	-.\spi-c tests/matrix.c -o out/matrix.asm > NUL
	-.\symboTest < "symbol_table_tests/test1" > "symbol_table_tests/test1.out"
else
	-./spi-c tests/compiler.c -o out/compiler.asm > /dev/null
	-./spi-c tests/bubble.c -o out/bubble.asm > /dev/null
	-./spi-c tests/factorial_it.c -o out/factorial_it.asm > /dev/null
	-./spi-c tests/factorial.c -o out/factorial.asm > /dev/null
	-./spi-c tests/matrix.c -o out/matrix.asm > /dev/null
	-./symboTest < "symbol_table_tests/test1" > "symbol_table_tests/test1.out"
endif

.PHONY: clean
clean:
	rm -f *.o *.aux *.log *.pdf *.tex *.synctex.gz *.out *~ lex.yy.c spi-c.tab.c spi-c.tab.h
