#pragma once

#define YYDEBUG 1

#include <cstdio>
#include <fstream>
#include <iostream>
#include <regex>
#include <sstream>
#include "symbol.h"
#include "node.h"
#include "spi-c.tab.h"
#include "errors.h"

// https://regex101.com/r/SizYZH/8
//                                  v group 1     v group 2     v group 3           v group 4                                     v group 5                                    v group 6           v group 7                                            v group 8                                     v group 9
const std::regex rArgs("(?:(?:-d(?:l([1-9]?))?(?:s([1-9]?))?(?:p([1-9]?))?) ?|(?:-o ([a-zA-Z\\.\\/_0-9][a-zA-Z\\.\\/\\-_0-9]*)) ?|([a-zA-Z\\.\\/_0-9][a-zA-Z\\.\\/\\-_0-9]*) ?|(-h|--help) ?|(?:-t ([a-zA-Z\\.\\/_0-9][a-zA-Z\\.\\/\\-_0-9]*)) ?|(?:-ts ([a-zA-Z\\.\\/_0-9][a-zA-Z\\.\\/\\-_0-9]*)) ?|(-s|--semantic-check) ?)");
// Which group is which - since named groups aren't supported in c++
#define LEX_LEVEL_GROUP 1
#define SYM_LEVEL_GROUP 2
#define PAR_LEVEL_GROUP 3
#define OUT_FILE_GROUP  4
#define IN_FILE_GROUP   5
#define HELP_GROUP      6
#define TREE_GROUP      7
#define SEM_TREE_GROUP  8
#define SEM_CHECK_GROUP 9

unsigned int lexDLevel;
unsigned int symDLevel;
unsigned int parseDLevel;

bool semanticCheck = false; 

std::ofstream debug_symbol_stream;
std::ofstream debug_token_stream;
std::ofstream debug_parse_stream;

std::string outputFile = "out/a.out";
std::string inputFile = "";
std::string treeFileName = "";
std::string semTreeFileName = "";
std::ifstream inFile;
std::string currentLine;

void doCmdArgs(int argc, char** argv);
void throwWarning(const std::string& warning);
void doArrowErrThing();
void replaceInString(std::string& str, char init, char replace);
void helpMenu();

extern int yyparse(SyntaxNode*& root);
extern unsigned lineno;
extern unsigned column;
extern unsigned yyleng;
extern int yydebug;
extern FILE* yyin;
