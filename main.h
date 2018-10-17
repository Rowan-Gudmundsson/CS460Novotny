#pragma once

#define YYDEBUG 1

#include <cstdio>
#include <fstream>
#include <iostream>
#include <regex>
#include "symbol.h"
#include "spi-c.tab.h"

/*
*	REGULAR EXPRESSIONS DO NOT WORK WHEN INPUTTING A DEBUG LEVEL AND A FILE NAME
*/


// https://regex101.com/r/SizYZH/5
//                                  v group 1     v group 2     v group 3           v group 4                                v group 5
const std::regex rArgs("(?:(?:-d(?:l([1-9]?))?(?:s([1-9]?))?(?:p([1-9]?))?) ?|(?:-o ([a-zA-Z\\./\\-_0-9]+)) ?|([a-zA-Z\\./\\-_0-9]+) ?)");
// Which group is which - since named groups aren't supported in c++
#define LEX_LEVEL_GROUP 1
#define SYM_LEVEL_GROUP 2
#define PAR_LEVEL_GROUP 3
#define OUT_FILE_GROUP  4
#define IN_FILE_GROUP   5

extern unsigned int lexDLevel;
extern unsigned int symDLevel;
extern unsigned int parseDLevel;

std::string outputFile = "out/a.out";
std::string inputFile = "";
std::ifstream inFile;
std::string currentLine;

void doCmdArgs(int argc, char** argv);
void doArrowErrThing();
void replaceInString(std::string& str, char init, char replace);

extern int yyparse();
extern unsigned lineno;
extern unsigned column;
extern unsigned yyleng;
extern int yydebug;
extern FILE* yyin;