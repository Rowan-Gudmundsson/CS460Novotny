OBS = parser.o scanner.o main.o symbol.o

CC = g++
CFLAGS = -g -Wall -std=c++11

.DELETE_ON_ERROR:
.PHONY: all

all: spi-c test

# COMPILE PROGRAM

spi-c: parser.o scanner.o main.o symbol.o
	$(CC) $(CFLAGS) $(OBS) -o spi-c

scanner.o: lex.yy.c
	$(CC) $(CFLAGS) -c lex.yy.c -o scanner.o

lex.yy.c: spi-c.lex
	flex spi-c.lex

parser.o: spi-c.tab.c
	$(CC) $(CFLAGS) -c spi-c.tab.c -o parser.o

spi-c.tab.c: spi-c.y
	bison -d -v spi-c.y

main.o: main.cpp main.h spi-c.tab.h
	$(CC) $(CFLAGS) -c main.cpp -o main.o

symbol.o: symbol.cpp symbol.h binary_tree.o
	$(CC) $(CFLAGS) -c symbol.cpp -o symbol.o

binary_tree.o: binary_tree.hpp
	$(CC) $(CFLAGS) -c binary_tree.hpp -o binary_tree.o

scanner.o parser.o main.o : spi-c.tab.h

# CLEAN

.PHONY:
test: compiler.test spi-c
	cat compiler.test | ./spi-c > compiler.out
	diff compiler.out master.out

.PHONY: clean
clean:
	rm -f *.o *~ lex.yy.c spi-c.tab.c spi-c.tab.h
