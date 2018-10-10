#pragma once

#include <iostream>
#include <regex>
#include "symbol.h"
#include "spi-c.tab.h"

// https://regex101.com/r/SizYZH/3
//                                  v group 1     v group 2     v group 3           v group 4
const std::regex rArgs("(?:(?:-d(?:l([1-9]?))?(?:s([1-9]?))?(?:p([1-9]?))?) ?|(?:-o ([a-zA-Z\\.-_0-9]*) ?))*");
// Which group is which - since named groups aren't supported in c++
#define LEX_LEVEL_GROUP 1
#define SYM_LEVEL_GROUP 2
#define PAR_LEVEL_GROUP 3
#define OUT_FILE_GROUP  4

unsigned lexDLevel = 0;
unsigned symDLevel = 0;
unsigned parseDLevel = 0;
std::string outputFile = "";

void doCmdArgs(int argc, char** argv);