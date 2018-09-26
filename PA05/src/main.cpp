#include "main.h"

int main() {
	//BinaryTree<std::string, int> table;
	Symbol table;
	Symbol::VarType newVar;
	Symbol::VarType* varPtr;
	std::string input;
	bool inputMode = true;
	unsigned lineNumber = 1;
	unsigned tabs = 0;
	while(true) {
		std::cout << lineNumber << " ";
		for(int i = 0; i < tabs; i++) std::cout << "\t";
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
				varPtr = table.find(input);
				std::cout << "Variable " << input << " was already declared on line " << varPtr->lineNumber << std::endl;
			}
		} else if((varPtr = table.find(input)) != nullptr) {
			std::cout << varPtr->name << " declared on " << varPtr->lineNumber << std::endl;
		} else {
			std::cout << input << " not found " << std::endl;
		}
		lineNumber++;
	}
	return 0;
}
