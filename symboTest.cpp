#include "symboTest.h"

#ifdef YYDEBUG
int yydebug = 0;
#endif

int main(int argc, char** argv) {
	std::cout << "----------------------------------------------------------------------------\n"
	          << "                          Symbol Table Test Driver                          \n"
	          << "----------------------------------------------------------------------------\n"
	          << "Commands:\n"
	          << "  quit - Quit the program\n"
	          << "  {    - Push a new scope\n"
	          << "  }    - Pop current scope\n"
	          << "  >>   - Change from variable declarations to variable usage\n"
	          << "  <<   - Change from variable usage to variable declarations (default mode)\n"
	          << "  DUMP - Output current symbol table to screen and symboTest.out\n"
	          << "  [id] - Declare or reference variable (depending on curent mode)" << std::endl;

	Symbol table;
	Symbol::SymbolType newVar;
	Symbol::SymbolType* symbolPtr;
	std::string input;
	bool inputMode = true;
	unsigned lineNumber = 1;
	unsigned tabs = 0;
	std::ofstream outFile("symboTest.out");

	while(input != "quit") {
		std::cout << lineNumber << " ";
		for(unsigned i = 0; i < tabs; i++) std::cout << "\t";
		std::cin >> input;

		if(input == "{") {
			table.pushScope();
			inputMode = true;
			tabs++;
		} else if(input == "}") {
			table.popScope();
			tabs--;
		} else if(input == ">>") {
			inputMode = false;
		} else if(input == "<<") {
			inputMode = true;
		} else if(input == "DUMP") {
			std::cout << table << std::endl;
			outFile << table << std::endl;
		} else if(inputMode) {
			symbolPtr = table.find(input);
			if(symbolPtr != nullptr && symbolPtr->scopeLevel == table.scopeLevel) {
				std::cout << "ERROR: Variable " << input << " was already declared on line " << symbolPtr->lineNumber << std::endl;
			} else {
				if(symbolPtr != nullptr && symbolPtr->scopeLevel < table.scopeLevel) {
					std::cout << "WARNING: Variable " << input << " shadowing variable declared on line " << symbolPtr->lineNumber << std::endl;
				}
				newVar.name = input;
				newVar.lineNumber = lineNumber;
				table.insert(newVar);
			}
		} else if((symbolPtr = table.find(input)) != nullptr) {
			std::cout << symbolPtr->name << " declared on " << symbolPtr->lineNumber << std::endl;
		} else {
			std::cout << input << " not found " << std::endl;
		}
		lineNumber++;
	}
	return 0;
}

// ~ab+a = (~a+a)(b+a)