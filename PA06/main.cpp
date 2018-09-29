#include "main.h"

extern int yyparse();

int yyerror(char* s) {
	std::cout << s << std::endl;
	return 1;
}

int main(int argc, char** argv) {
	//BinaryTree<std::string, int> table;

	doCmdArgs(argc, argv);

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

void doCmdArgs(int argc, char** argv) {
	std::string args = "";
	for(int i = 1; i < argc; i++) {
		args += argv[i];
		args += " ";
	}
	std::smatch match;
	while(std::regex_search(args, match, rArgs, std::regex_constants::match_not_null)) {
		//std::cout << match.size() << " matches found." << std::endl;
		if(match[LEX_LEVEL_GROUP].matched) {
			lexDLevel = atoi(match[LEX_LEVEL_GROUP].str().c_str());
			if(lexDLevel == 0) lexDLevel = 1;
		}
		if(match[SYM_LEVEL_GROUP].matched) {
			symDLevel = atoi(match[SYM_LEVEL_GROUP].str().c_str());
			if(symDLevel == 0) symDLevel = 1;
		}
		if(match[PAR_LEVEL_GROUP].matched) {
			parseDLevel = atoi(match[PAR_LEVEL_GROUP].str().c_str());
			if(parseDLevel == 0) parseDLevel = 1;
		}
		if(match[OUT_FILE_GROUP].matched) {
			outputFile = match[OUT_FILE_GROUP].str();
		}
		args = match.suffix().str();
	}
	
	if(lexDLevel > 0 || symDLevel > 0 || parseDLevel > 0) {
		std::cout << "Debug mode: lexer (" << lexDLevel << "), symbol table (" << symDLevel << "), parser (" << parseDLevel << ")" << std::endl;
	}
}