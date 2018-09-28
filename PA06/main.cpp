#include "main.h"

extern int yyparse();

int yyerror(char* s) {
	std::cout << s << std::endl;
	return 1;
}

int main() {
	//BinaryTree<std::string, int> table;
	yyparse();
	/*Symbol table;
	Symbol::SymbolType newVar;
	Symbol::SymbolType* symbolPtr;
	std::string input;
	bool inputMode = true;
	unsigned lineNumber = 1;
	unsigned tabs = 0;
	while(true) {
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
		} else if(inputMode) {
			newVar.name = input;
			newVar.lineNumber = lineNumber;
			if(!table.insert(newVar)) {
				symbolPtr = table.find(input);
				std::cout << "Variable " << input << " was already declared on line " << symbolPtr->lineNumber << std::endl;
			}
		} else if((symbolPtr = table.find(input)) != nullptr) {
			std::cout << symbolPtr->name << " declared on " << symbolPtr->lineNumber << std::endl;
		} else {
			std::cout << input << " not found " << std::endl;
		}
		lineNumber++;
	}*/
	return 0;
}
