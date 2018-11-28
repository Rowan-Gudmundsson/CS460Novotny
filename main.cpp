#include "main.h"

int yyerror(SyntaxNode*& root, char* s) {
	column -= yyleng;
	std::cout << "Error: " << s << " on line " << lineno << ", column " << column << std::endl;
	doArrowErrThing();
	return 1;
}

int main(int argc, char** argv) {
	SyntaxNode* root = nullptr;
	system(""); // DON'T REMOVE THIS - SUPER IMPORTANT FOR CONSOLE COLORS ON WINDOWS POWERSHELL
	doCmdArgs(argc, argv);

	// Potentially add command line arguments for these later
	debug_symbol_stream.open("debug_symbol.txt", std::ofstream::out);
	debug_token_stream.open("debug_tokens.txt", std::ofstream::out);
	freopen ("debug_parser.txt","w",stderr);

	if(inFile.is_open()) {
		yyin = fopen(inputFile.c_str(), "r");
		try {
			yyparse(root);
		} catch (const ScannerError& error) {
			std::cout << "ERROR! " << error.what() << std::endl;
			std::cout << "On line " << lineno << ", column " << column << std::endl;
			doArrowErrThing();
			return 1;
		} catch(const ParserError& error) {
			std::cout << "ERROR! " << error.what() << std::endl;
			std::cout << "On line " << lineno << ", column " << column << std::endl;
			doArrowErrThing();
			return 1;
		} catch (const std::exception& error) {
			std::cout << "------------------------\n"
			          << "IMPORTANT COMPILER ERROR\n"
			          << "------------------------\n";
			std::cout << "ERROR! " << error.what() << std::endl;
			std::cout << "On line " << lineno << ", column " << column << std::endl;
			doArrowErrThing();
			return 1;
		} catch (const char* s) {
			std::cout << "------------------------\n"
			          << "IMPORTANT COMPILER ERROR\n"
			          << "------------------------\n";
			std::cout << "ERROR! " << s << std::endl;
			std::cout << "On line " << lineno << ", column " << column << std::endl;
			doArrowErrThing();
			return 1;
		}
	} else {
		std::cerr << "Input file not found!" << std::endl;
		return 1;
	}

	if(treeFileName != "") {
		std::ofstream treeFile(treeFileName);
		treeFile << "\\documentclass{standalone}\n\\usepackage{tikz}\n\\usepackage{tikz-qtree}\n\\usepackage[T1]{fontenc}\n\\begin{document}\n\\begin{tikzpicture}[sibling distance=20pt]\n\t\\tikzset{level 1/.style={level distance=36pt}}\n\t\\tikzset{level 2/.style={level distance=34pt}}\n\t\\tikzset{level 3+/.style={level distance=32pt}}\n\t\\Tree ";
		std::stringstream ss;
		ss << root;
		// Sanitize underscores
		std::string s = std::regex_replace(ss.str(), std::regex("_|%"), "\\$&");
		treeFile << s << "\n\\end{tikzpicture}\n\\end{document}";

		treeFile.close();
	}

	root->semanticCheck();

	if(semTreeFileName != "") {
		std::ofstream treeFile(semTreeFileName);
		treeFile << "\\documentclass{standalone}\n\\usepackage{tikz}\n\\usepackage{tikz-qtree}\n\\usepackage[T1]{fontenc}\n\\begin{document}\n\\begin{tikzpicture}[sibling distance=20pt]\n\t\\tikzset{level 1/.style={level distance=36pt}}\n\t\\tikzset{level 2/.style={level distance=34pt}}\n\t\\tikzset{level 3+/.style={level distance=32pt}}\n\t\\Tree ";
		std::stringstream ss;
		ss << root;
		// Sanitize underscores
		std::string s = std::regex_replace(ss.str(), std::regex("_|%"), "\\$&");
		treeFile << s << "\n\\end{tikzpicture}\n\\end{document}";

		treeFile.close();
	}

	gen3AC(root);

	if(root != nullptr) {
		root->clear();
		delete root;
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
		// std::cout << match.size() << " matches found." << std::endl;
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
		if(match[HELP_GROUP].matched) {
			helpMenu();
		}
		if(match[TREE_GROUP].matched) {
			treeFileName = match[TREE_GROUP].str();
		}
		if(match[SEM_TREE_GROUP].matched) {
			semTreeFileName = match[SEM_TREE_GROUP].str();
		}
		if(match[SEM_CHECK_GROUP].matched){

			semanticCheck = true;
		}
		args = match.suffix().str();
	}

	if(lexDLevel > 0 || symDLevel > 0 || parseDLevel > 0) {
		std::cout << "Debug mode: lexer (" << lexDLevel << "), symbol table (" << symDLevel << "), parser (" << parseDLevel << ")" << std::endl;
	}

	inFile.open(inputFile);
	std::getline(inFile, currentLine);

	std::cout << "Input file: \"" << inputFile << "\"" << std::endl
	          << "Output file: \"" << outputFile << "\"" << std::endl;
}

void throwWarning(const std::string& warning) {
	std::cout << "WARNING! " << warning << '\n'
	          << "On line " << lineno << ", column " << column << std::endl;
	doArrowErrThing();
}

void doArrowErrThing() {
	unsigned i;
	replaceInString(currentLine, '\t', ' ');
	std::cout << currentLine << std::endl;
	for(i = 1; i < column; i++) {
		std::cout << " ";
	}
	std::cout << "^";
	for(i = 1; i < yyleng; i++) {
		std::cout << "~";
	}
	std::cout << std::endl;
}

void replaceInString(std::string& str, char init, char replace) {
	for(unsigned i = 0; i < str.length(); i++) {
		if(str[i] == init) {
			str[i] = replace;
		}
	}
}

void helpMenu() {
	std::cout << "USAGE\n"
	          << "  ./spi-c [flags] <input file>\n\n"
	          << "FLAGS\n";
	std::cout << "  -h, --help       - Display help menu.\n"
              << "  -o <output file> - Output to the given file.\n"
              << "  -t <tree file>   - Output Abstract Syntax Tree representation to given file in latex.\n"
              << "  -ts <tree file>  - Output Abstract Syntax Tree to given file post semantic-checking.\n"
              << "	-s               - Turn on semantic-checking.\n"
              << "  -d[debug levels] - Enable debug flags for various different stages of the compiler.\n"
              << "                     Allowable flags include: s#, l#, p#\n"
              << "                     for symbol table, lexer, and parser\n"
              << "                     (examples: \"-dl\", \"-dl1s4\", \"-dlps\")" << std::endl;
}

void gen3AC(SyntaxNode* root) {
	std::vector<ThreeAddress> instructions;
	instructions.reserve(100);

	unsigned tempTicker = 0;

	table.calcOffsets();

	instructions.emplace_back();
	instructions.back().op = "BR";
	instructions.back().dest = "(LABEL main1)";

	root->gen3AC(instructions, tempTicker);

	for(const ThreeAddress& i : instructions) {
		std::cout << std::left << std::setw(16) << i.op << std::setw(16) << i.op1 << std::setw(16) << i.op2 << std::setw(16) << i.dest << "    " << i.source << std::endl; 
	}
}