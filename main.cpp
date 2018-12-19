#include "main.h"

int yyerror(SyntaxNode*& root, char* s) {
	column -= yyleng;
	std::cout << "Error: " << s << " on line " << lineno << ", column " << column << std::endl;
	doArrowErrThing();
	return 1;
}

int main(int argc, char** argv) {
	SyntaxNode* root = nullptr;
	system("");  // DON'T REMOVE THIS - SUPER IMPORTANT FOR CONSOLE COLORS ON WINDOWS POWERSHELL
	doCmdArgs(argc, argv);

	// Potentially add command line arguments for these later
	debug_symbol_stream.open("debug_symbol.txt", std::ofstream::out);
	debug_token_stream.open("debug_tokens.txt", std::ofstream::out);
	freopen("debug_parser.txt", "w", stderr);

	if (inFile.is_open()) {
		yyin = fopen(inputFile.c_str(), "r");
		try {
			yyparse(root);
		} catch (const ScannerError& error) {
			std::cout << "ERROR! " << error.what() << std::endl;
			std::cout << "On line " << lineno << ", column " << column << std::endl;
			doArrowErrThing();
			return 1;
		} catch (const ParserError& error) {
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
		std::cout << "Input file \"" << inputFile << "\" could not be opened." << std::endl;
		return 1;
	}

	if (treeFileName != "") { outputTreeToFile(root, table, treeFileName); }

	table.calcStructOffsets();
	root->semanticCheck();

	if (semTreeFileName != "") { outputTreeToFile(root, table, semTreeFileName); }

	// Generate three address code from tree
	std::vector<ThreeAddress> instructions;
	unsigned tempTicker = 0, labelTicker = 0;
	gen3AC(root, instructions, tempTicker, labelTicker);

	std::ofstream out(outputFile);
	if (!out.is_open()) {
		std::cout << "Could not open output file \"" << outputFile << "\"." << std::endl;
		return 1;
	}

	// Generate assembly from three address code
	outputAssembly(instructions, out, tempTicker, labelTicker);

	// Add library functions onto the bottom
	outputLibraryFuncs(out);

	if (root != nullptr) {
		root->clear();
		delete root;
	}
	return 0;
}

void doCmdArgs(int argc, char** argv) {
	std::string args = "";
	for (int i = 1; i < argc; i++) {
		args += argv[i];
		args += " ";
	}
	std::smatch match;
	while (std::regex_search(args, match, rArgs, std::regex_constants::match_not_null)) {
		// std::cout << match.size() << " matches found." << std::endl;
		if (match[LEX_LEVEL_GROUP].matched) {
			lexDLevel = atoi(match[LEX_LEVEL_GROUP].str().c_str());
			if (lexDLevel == 0) lexDLevel = 1;
		}
		if (match[SYM_LEVEL_GROUP].matched) {
			symDLevel = atoi(match[SYM_LEVEL_GROUP].str().c_str());
			if (symDLevel == 0) symDLevel = 1;
		}
		if (match[PAR_LEVEL_GROUP].matched) {
			parseDLevel = atoi(match[PAR_LEVEL_GROUP].str().c_str());
			if (parseDLevel == 0) parseDLevel = 1;
		}
		if (match[OUT_FILE_GROUP].matched) { outputFile = match[OUT_FILE_GROUP].str(); }
		if (match[IN_FILE_GROUP].matched) { inputFile = match[IN_FILE_GROUP].str(); }
		if (match[HELP_GROUP].matched) { helpMenu(); }
		if (match[TREE_GROUP].matched) { treeFileName = match[TREE_GROUP].str(); }
		if (match[SEM_TREE_GROUP].matched) { semTreeFileName = match[SEM_TREE_GROUP].str(); }
		if (match[SEM_CHECK_GROUP].matched) { semanticCheck = true; }
		args = match.suffix().str();
	}

	if (lexDLevel > 0 || symDLevel > 0 || parseDLevel > 0) {
		std::cout << "Debug mode: lexer (" << lexDLevel << "), symbol table (" << symDLevel
		          << "), parser (" << parseDLevel << ")" << std::endl;
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
	for (i = 1; i < column; i++) { std::cout << " "; }
	std::cout << "^";
	for (i = 1; i < yyleng; i++) { std::cout << "~"; }
	std::cout << std::endl;
}

void replaceInString(std::string& str, char init, char replace) {
	for (unsigned i = 0; i < str.length(); i++) {
		if (str[i] == init) { str[i] = replace; }
	}
}

void helpMenu() {
	std::cout << "USAGE\n"
	          << "  ./spi-c [flags] <input file>\n\n"
	          << "FLAGS\n";
	std::cout
	    << "  -h, --help       - Display help menu.\n"
	    << "  -o <output file> - Output to the given file.\n"
	    << "  -t <tree file>   - Output Abstract Syntax Tree representation to given file in "
	       "latex.\n"
	    << "  -ts <tree file>  - Output Abstract Syntax Tree to given file post "
	       "semantic-checking.\n"
	    << "	-s               - Turn on semantic-checking.\n"
	    << "  -d[debug levels] - Enable debug flags for various different stages of the compiler.\n"
	    << "                     Allowable flags include: s#, l#, p#\n"
	    << "                     for symbol table, lexer, and parser\n"
	    << "                     (examples: \"-dl\", \"-dl1s4\", \"-dlps\")" << std::endl;
}

void outputTreeToFile(SyntaxNode* root, Symbol& table, const std::string& filename) {
	std::ofstream treeFile(filename);
	if (treeFile.is_open()) {
		treeFile << "\\documentclass[varwidth=\\maxdimen]{standalone}\n"
		         << "\\usepackage{tikz}\n"
		         << "\\usepackage{tikz-qtree}\n"
		         << "\\usepackage{pgf-umlcd}\n"
		         << "\\usepackage[T1]{fontenc}\n"
		         << "\\begin{document}\n"
		         << "% AST\n"
		         << "\\[\n"
		         << "\\begin{tikzpicture}[sibling distance=20pt]\n"
		         << "\t\\tikzset{level 1/.style={level distance=36pt}}\n"
		         << "\t\\tikzset{level 2/.style={level distance=34pt}}\n"
		         << "\t\\tikzset{level 3+/.style={level distance=32pt}}\n"
		         << "\t\\Tree ";
		std::stringstream ss;
		ss << root;
		// Sanitize underscores
		std::string s = std::regex_replace(ss.str(), std::regex("_|%"), "\\$&");
		treeFile << s << std::endl;
		treeFile << "\n\\end{tikzpicture}\n"
		         << "\\]\n"
		         << "% Structs\n"
		         << "\\[\n"
		         << "\\begin{tikzpicture}\n";
		ss.str("");
		table.printStructs(ss);
		s = std::regex_replace(ss.str(), std::regex("_|%"), "\\$&");
		treeFile << s << std::endl;
		treeFile << "\\end{tikzpicture}\n"
		         << "\\]\n"
		         << "\\end{document}";

		treeFile.close();
	} else {
		std::cout << "Could not open tree file \"" << filename << "\"." << std::endl;
	}
}

void gen3AC(SyntaxNode* root, std::vector<ThreeAddress>& instructions, unsigned& tempTicker,
            unsigned& labelTicker) {
	instructions.reserve(100);

	table.calcOffsets();
	std::cout << std::endl;

	for (const Symbol::SymbolType& s : table.getGlobals()) {
		if (s.itype == Symbol::SymbolType::VARIABLE) {
			// This should do a lot more logic like check if array, load the actual data in not the
			// size etc..
			instructions.emplace_back("", "GLOBAL", Operand{"GLOBAL", s.name},
			                          Operand{"ICONS", s.etype.size()});
		}
	}

	instructions.emplace_back("", "CALL", Operand{"", ""}, Operand{"LABEL", "main1"});
	instructions.emplace_back("", "END");

	try {
		root->gen3AC(instructions, tempTicker, labelTicker);
	} catch (const std::exception& e) { std::cout << e.what() << std::endl; }

	std::string lastSource = "";

	std::cout << std::left << std::setw(20) << "OPCODE" << std::setw(20) << "OPERAND 1"
	          << std::setw(20) << "OPERAND 2" << std::setw(20) << "DESTINATION"
	          << " ; "
	          << "SOURCE CODE" << std::endl;
	std::cout << std::setw(81) << std::setfill('-') << '-' << ";" << std::setw(20) << '-'
	          << std::setfill(' ') << std::endl;
	for (const ThreeAddress& i : instructions) {
		std::cout << i << " ; ";
		if (i.source.size() > 0 && i.source != lastSource) {
			lastSource = i.source;
			std::cout << i.source;
		}
		std::cout << std::endl;
	}
}

void outputAssembly(std::vector<ThreeAddress>& instructions, std::ostream& out,
                    unsigned& tempTicker, unsigned& labelTicker) {
	RegisterTable registers = RegisterTable::getMIPSRegisters();

	try {
		// DATA section (for global/static variables)
		unsigned floatTicker  = 0;
		unsigned stringTicker = 0;

		out << "\t.data\n";
		for (ThreeAddress& instruct : instructions) {
			if (instruct.op == "GLOBAL") {
				out << instruct.op1.value << ":\t";
				if (instruct.op2.isFloat()) {
					out << ".float " << instruct.op2.value << std::endl;
				} else if (instruct.op2.isString()) {
					out << ".asciiz " << instruct.op2.value << std::endl;
				}
			}
		}

		std::string prev_source;
		// TEXT section (for actual code)
		out << "\t.text\n";
		for (const ThreeAddress& instruct : instructions) {
			if (instruct.op == "GLOBAL") continue;

			if (instruct.source != prev_source) {
				out << "# ----------------------------\n"
				    << "# | Original source          |\n"
				    << "# ----------------------------\n"
				    << "# * " << instruct.source << std::endl;

				out << "# ----------------------------\n"
				    << "# | 3 Address Code           |\n"
				    << "# ----------------------------\n"
				    << "# | op                op1               op2               dest\n"
				    << "# | ----------------- ----------------- ----------------- "
				       "------------------\n"
				    << std::flush;
				prev_source = instruct.source;
			}

			out << "# * " << std::left << std::setw(18) << instruct.op << std::setw(18)
			    << instruct.op1 << std::setw(18) << instruct.op2 << std::setw(18) << instruct.dest
			    << std::endl;

			if (instruct.op == "PROCENTRY") {
				out << "subi\t$sp, $sp, " << instruct.op1.value << std::endl;
				out << "sw\t$ra, " << std::stoi(instruct.op1.value) - 8 << "($sp)\n";
				continue;
			} else if (instruct.op == "CALL") {
				registers.saveSavedRegisters(out);
				out << "jal\t " << instruct.dest.value << '\n';
				registers.invalidateRegisters(true);
				continue;
			} else if (instruct.op == "LABEL") {
				out << instruct.op1.value << ":\n";
				registers.invalidateRegisters(true);
				continue;
			} else if (instruct.op == "END") {
				out << "li\t $v0, 10\n"
				    << "syscall\n";
				continue;
			} else if (instruct.op == "RETURN") {
				out << "lw\t $ra, " << instruct.op1.value << "($sp)\n"
				    << "add\t $sp, $sp, " << instruct.op2.value << '\n'
				    << "jr\t $ra\n";
				continue;
			} else if (instruct.op == "STRUCT_OUT") {
				RegisterTable::RegisterEntry* size =
				    registers.getUnusedRegister(Operand{"ITemp", "struct_size"});
				RegisterTable::RegisterEntry* counter =
				    registers.getUnusedRegister(Operand{"ITemp", "struct_counter"});
				RegisterTable::RegisterEntry* src =
				    registers.getUnusedRegister(Operand{"ITemp", "struct_src_temp"});
				RegisterTable::RegisterEntry* dest =
				    registers.getUnusedRegister(Operand{"ITemp", "struct_dest_temp"});
				RegisterTable::RegisterEntry* tmp =
				    registers.getUnusedRegister(Operand{"ITemp", "struct_tmp"});

				size->inUse = false;
				tmp->inUse  = false;
				src->inUse  = false;
				dest->inUse = false;

				std::string beginLabel = "loopl" + std::to_string(labelTicker);
				std::string endLabel   = "loopl" + std::to_string(labelTicker + 1);
				labelTicker += 2;
				if (instruct.op1.isLocal()) {
					out << "li\t " << *src << ", " << instruct.op1.value << std::endl
					    << "add\t " << *src << ", " << *src << ", $sp\n";
				} else if (instruct.op1.isPtr()) {
					out << "lw\t " << *src << ", " << instruct.op1.value << "($sp)\n";
				}

				if (instruct.dest.isLocal()) {
					out << "li\t " << *dest << ", " << instruct.dest.value << std::endl
					    << "add\t " << *dest << ", " << *dest << ", $sp\n";
				} else if (instruct.dest.isPtr()) {
					out << "lw\t " << *src << ", " << instruct.dest.value << "($sp)\n";
				}

				out << "li\t " << *counter << ", 0\n"
				    << "li\t " << *size << ", " << instruct.op2.value << std::endl
				    << beginLabel << ":\n"
				    << "bge\t " << *counter << ", " << *size << ", " << endLabel << std::endl
				    << "lw\t " << *tmp << ", "
				    << "(" << *src << ")\n"
				    << "sw\t " << *tmp << ", "
				    << "(" << *dest << ")\n"
				    << "addi\t " << *src << ", " << *src << ", 4\n"
				    << "addi\t " << *dest << ", " << *dest << ", 4\n"
				    << "addi\t " << *counter << ", " << *counter << ", 4\n"
				    << "b\t " << beginLabel << std::endl
				    << endLabel << ":\n";
				continue;
			}

			RegisterTable::RegisterEntry* op1Reg = findRegister(instruct.op1, registers, out);
			RegisterTable::RegisterEntry* op2Reg = findRegister(instruct.op2, registers, out);

			if (op1Reg != nullptr && op1Reg->usedAsTemp) op1Reg->inUse = false;
			if (op2Reg != nullptr && op2Reg->usedAsTemp) op2Reg->inUse = false;

			if (op1Reg != nullptr && op1Reg->indirect != nullptr) op1Reg->indirect->inUse = false;
			if (op2Reg != nullptr && op2Reg->indirect != nullptr) op2Reg->indirect->inUse = false;

			RegisterTable::RegisterEntry* destReg =
			    findRegister(instruct.dest, registers, out, true);

			RegisterTable::RegisterEntry* indrDestReg;
			if (instruct.dest.isIndr()) {
				indrDestReg                  = destReg;
				destReg                      = registers.getUnusedRegister(instruct.dest);
				indrDestReg->indirect->inUse = false;
				destReg->inUse               = false;
			}

			if (instruct.op == "OFFSET") {
				out << "add\t " << *op1Reg << ", " << *op1Reg << ", $sp";
				op1Reg->inUse = true;
			} else if (instruct.op == "ASSIGN") {
				if (instruct.dest.isLocal()) {
					destReg->inUse = false;
					destReg        = op1Reg;
					destReg->inUse = false;
				} else {
					if (instruct.dest.isFloat() == instruct.op1.isFloat()) {
						out << "move\t " << *destReg << ", " << *op1Reg;
					} else if (instruct.dest.isFloat()) {
						out << "mtc1\t " << *op1Reg << ", " << *destReg;
					} else {
						out << "mfc1\t " << *destReg << ", " << *op1Reg;
					}
				}
			} else if (instruct.op == "ADD") {
				if (instruct.op1.isFloat())
					out << "add.s\t ";
				else
					out << "add\t ";

				out << *destReg << ", " << *op1Reg << ", " << *op2Reg;
			} else if (instruct.op == "SUB") {
				if (instruct.op1.isFloat())
					out << "sub.s\t ";
				else
					out << "sub\t ";

				out << *destReg << ", " << *op1Reg << ", " << *op2Reg;
			} else if (instruct.op == "MULT") {
				if (instruct.op1.isFloat())
					out << "mul.s\t ";
				else
					out << "mul\t ";

				out << *destReg << ", " << *op1Reg << ", " << *op2Reg;
			} else if (instruct.op == "DIV") {
				if (instruct.op1.isFloat())
					out << "div.s\t ";
				else
					out << "div\t ";

				out << *destReg << ", " << *op1Reg << ", " << *op2Reg;
			} else if (instruct.op == "MOD") {
				out << "rem\t " << *destReg << ", " << *op1Reg << ", " << *op2Reg;
			} else if (instruct.op == "EQ") {
				out << "seq\t " << *destReg << ", " << *op1Reg << ", " << *op2Reg;
			} else if (instruct.op == "NE") {
				out << "sne\t " << *destReg << ", " << *op1Reg << ", " << *op2Reg;
			} else if (instruct.op == "LT") {
				out << "slt\t " << *destReg << ", " << *op1Reg << ", " << *op2Reg;
			} else if (instruct.op == "GT") {
				out << "sgt\t " << *destReg << ", " << *op1Reg << ", " << *op2Reg;
			} else if (instruct.op == "LE") {
				out << "sle\t " << *destReg << ", " << *op1Reg << ", " << *op2Reg;
			} else if (instruct.op == "GE") {
				out << "sge\t " << *destReg << ", " << *op1Reg << ", " << *op2Reg;
			} else if (instruct.op == "LOR") {
				out << "or\t " << *destReg << ", " << *op1Reg << ", " << *op2Reg;
			} else if (instruct.op == "LAND") {
				out << "and\t " << *destReg << ", " << *op1Reg << ", " << *op2Reg;
			} else if (instruct.op == "NOT") {
				out << "not\t " << *destReg << ", " << *op1Reg;
			} else if (instruct.op == "BR") {
				out << "b\t " << instruct.dest.value;
			} else if (instruct.op == "BREQ") {
				out << "beq\t " << *op1Reg << ", " << *op2Reg << ", " << instruct.dest.value;
			} else if (instruct.op == "BRNE") {
				out << "bne\t " << *op1Reg << ", " << *op2Reg << ", " << instruct.dest.value;
			} else if (instruct.op == "BRLT") {
				out << "blt\t " << *op1Reg << ", " << *op2Reg << ", " << instruct.dest.value;
			} else if (instruct.op == "BRGT") {
				out << "bgt\t " << *op1Reg << ", " << *op2Reg << ", " << instruct.dest.value;
			} else if (instruct.op == "BRLE") {
				out << "ble\t " << *op1Reg << ", " << *op2Reg << ", " << instruct.dest.value;
			} else if (instruct.op == "BRGE") {
				out << "bge\t " << *op1Reg << ", " << *op2Reg << ", " << instruct.dest.value;
			} else if (instruct.op != "GLOBAL") {
				out << "# NOT HANDLING " << instruct.op << std::endl;
			}

			out << std::endl;

			if (!instruct.dest.type.empty() && instruct.dest.isLocal()) {
				if (instruct.dest.isFloat())
					out << "s.s\t ";
				else
					out << "sw\t ";

				out << *destReg << ", " << instruct.dest.value << "($sp)\n";

				destReg->inUse = false;
			} else if (!instruct.dest.type.empty() && instruct.dest.isIndr()) {
				if (instruct.dest.isFloat())
					out << "s.s\t ";
				else
					out << "sw\t ";

				out << *destReg << ", " << *indrDestReg << '\n';
			}
		}
	} catch (const std::exception& e) {
		std::cout << e.what() << std::endl << registers << std::endl;
	}
}

RegisterTable::RegisterEntry* findRegister(const Operand& op, RegisterTable& registers,
                                           std::ostream& out, bool isDest) {
	if (op.type.empty() || op.type == "LABEL") return nullptr;

	RegisterTable::RegisterEntry* opReg = registers.findLocation(op);
	if (opReg == nullptr) {
		opReg = registers.getUnusedRegister(op);
		if (opReg == nullptr) return nullptr;

		if (op.isLocal() && !isDest) {
			if (op.isFloat())
				out << "l.s\t ";
			else
				out << "lw\t ";
			out << *opReg << ", " << op.value << "($sp)\n";
		} else if (op.isConst()) {
			if (op.isString())
				out << "la\t ";
			else if (op.isFloat())
				out << "l.s\t ";
			else
				out << "li\t ";
			out << *opReg << ", " << op.value << '\n';
		} else if (op.isPtr()) {
			out << "lw\t " << *opReg << ", " << op.value << "($sp)\n"
			    << "lw\t " << *opReg << ", (" << *opReg << ")\n";
		}
	} else if (opReg->indirect != nullptr && !isDest) {
		RegisterTable::RegisterEntry* temp = registers.getUnusedRegister(op);

		if (op.isFloat())
			out << "l.s\t ";
		else
			out << "lw\t ";
		out << *temp << ", " << *opReg << '\n';

		opReg = temp;
	}

	return opReg;
}

void outputLibraryFuncs(std::ostream& out) {
	std::ifstream in(libraryFile);

	while (in.good()) { in >> out.rdbuf(); }
}
