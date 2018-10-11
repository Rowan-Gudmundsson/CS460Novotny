#include "main.h"

int yyerror(char* s) {
	column -= yyleng - 1;
	std::cout << "Error: " << s << " on line " << lineno << " on column " << column << std::endl;
	return 1;
}

int main(int argc, char** argv) {
	system(""); // DON'T REMOVE THIS - SUPER IMPORTANT FOR CONSOLE COLORS ON WINDOWS POWERSHELL
	doCmdArgs(argc, argv);
	try {
		yyparse();
	} catch (int error) {
		switch (error) {
			case SPIC_REDECLARATION: {
				std::cout << "Redeclaration of variable." << std::endl;
				break;
			}
			case SPIC_UNDEFINED_REFERENCE: {
				std::cout << "Undefined reference to variable." << std::endl;
				break;
			}
		}
	}
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
		if(match[IN_FILE_GROUP].matched) {
			inputFile = match[IN_FILE_GROUP].str();
		}
		args = match.suffix().str();
	}

	if(lexDLevel > 0 || symDLevel > 0 || parseDLevel > 0) {
		std::cout << "Debug mode: lexer (" << lexDLevel << "), symbol table (" << symDLevel << "), parser (" << parseDLevel << ")" << std::endl;
	}

	std::cout << "Input file: \"" << inputFile << "\"" << std::endl
	          << "Output file: \"" << outputFile << "\"" << std::endl;
}
