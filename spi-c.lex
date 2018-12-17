%{
	#include "symbol.h"
	#include "node.h"
	#include "spi-c.tab.h"
	#include "errors.h"
	#include <cstdlib>
	#include <climits>
	#include <fstream>
	#include <string>
	#include <stdexcept>

	using namespace std::string_literals;

	#define RETURN_TOKEN(token) column += yyleng; return token;
	#define COLUMN column += yyleng
	int yyerror(SyntaxNode*& root, char *s);
	extern int yydebug;

	extern unsigned int lexDLevel;
	extern std::ifstream inFile;
	extern std::string currentLine;
	extern std::ofstream debug_symbol_stream;
	extern std::ofstream debug_token_stream;

	void throwWarning(const std::string& warning);

	Symbol table;
	unsigned lineno = 1;
	unsigned column = 1;
%}

%option nounput

DIGIT [0-9]
INTEGER {DIGIT}+
DELIM [ \t\r]
ID [_a-zA-Z][_a-zA-Z0-9]*
FLOAT {DIGIT}*\.{DIGIT}+f?
CHAR \'((.)|(\\0[xX][0-9ABCDEF]{1,2})|(\\.))\'
STRING \"[^\"]*\"
COMMENT \/\*[^(/\*)]*\*\/
SCOMMENT \/\/.*\n
%%

\n   { lineno++; column = 1; std::getline(inFile,currentLine); }
{COMMENT}    {
	std::string comment = yytext;
	std::size_t lastPos;
	std::size_t position = 0;
	if(lexDLevel > 0) {
		std::cout << "Found a comment:\n" << comment << std::endl << std::endl;
	}
	do {
		lastPos = position;
		position = comment.find('\n', lastPos + 1);
		if (position != std::string::npos) {
			lineno++;
			column = 1;
			std::getline(inFile,currentLine);
		};
	} while (position != std::string::npos);

	column += comment.size() - lastPos - 1;
}
{SCOMMENT}   {
	if(lexDLevel > 0) {
		std::cout << "Found a comment:\n" << yytext << std::endl << std::endl;
	}
	lineno++;
	column = 0;
	std::getline(inFile,currentLine);
}

{DELIM}+     { column += yyleng; }

{FLOAT}      {
	if (lexDLevel) std::cout << "Float: " << yytext << std::endl;
	char* dummy;
	double num = strtod(yytext, &dummy);
	if(num != float(num)) {
		throw ScannerError("Floating point constant too large");
	}
	yylval.fval = num;
	RETURN_TOKEN(FLOATING_CONSTANT);
}
{INTEGER} {
	if(lexDLevel) std::cout << "Int: " << yytext << std::endl;
	char* dummy;
	long long num = strtoll(yytext, &dummy, 10);
	if(num >= INT_MAX) {
		throw ScannerError("Integer too large");
	}
	yylval.ival = num;
	RETURN_TOKEN(INTEGER_CONSTANT);
}

{STRING}    {
	std::string temp = std::string(yytext).substr(1, yyleng - 2);
	yylval.strval = new std::string(temp);
	RETURN_TOKEN(STRING_LITERAL);
}
{CHAR}      {
	yylval.cval = yytext[1];
	RETURN_TOKEN(CHARACTER_CONSTANT);
}

"sizeof"    { RETURN_TOKEN(SIZEOF); }
"->"        { RETURN_TOKEN(PTR_OP); }
"++"        { RETURN_TOKEN(INC_OP); }
"--"        { RETURN_TOKEN(DEC_OP); }
"<<"        { RETURN_TOKEN(LEFT_OP); }
">>"        { RETURN_TOKEN(RIGHT_OP); }
"<="        { RETURN_TOKEN(LE_OP); }
">="        { RETURN_TOKEN(GE_OP); }
"=="        { RETURN_TOKEN(EQ_OP); }
"!="        { RETURN_TOKEN(NE_OP); }
"&&"        { RETURN_TOKEN(AND_OP); }
"||"        { RETURN_TOKEN(OR_OP); }
"!"         { RETURN_TOKEN(LNOT); }
"*="        { RETURN_TOKEN(MUL_ASSIGN); }
"/="        { RETURN_TOKEN(DIV_ASSIGN); }
"%="        { RETURN_TOKEN(MOD_ASSIGN); }
"+="        { RETURN_TOKEN(ADD_ASSIGN); }
"-="        { RETURN_TOKEN(SUB_ASSIGN); }
"<<="       { RETURN_TOKEN(LEFT_ASSIGN); }
">>="       { RETURN_TOKEN(RIGHT_ASSIGN); }
"&="        { RETURN_TOKEN(AND_ASSIGN); }
"^="        { RETURN_TOKEN(XOR_ASSIGN); }
"|="        { RETURN_TOKEN(OR_ASSIGN); }
"{"         { table.pushScope(); RETURN_TOKEN(LBRACE); }
"}"         { table.popScope(); RETURN_TOKEN(RBRACE); }
"("         { table.pushScope(); RETURN_TOKEN(LPAREN); }
")"         { table.popScope(); RETURN_TOKEN(RPAREN); }
"["         { RETURN_TOKEN(LBRACKET); }
"]"         { RETURN_TOKEN(RBRACKET); }
"+"         { RETURN_TOKEN(ADD); }
"-"         { RETURN_TOKEN(SUB); }
"*"         { RETURN_TOKEN(MULT); }
"/"         { RETURN_TOKEN(DIV); }
";"         { RETURN_TOKEN(SEMI); }
","         { RETURN_TOKEN(COMMA); }
"="         { RETURN_TOKEN(ASSIGN); }
":"         { RETURN_TOKEN(COLON); }
"%"         { RETURN_TOKEN(MOD); }
"&"         { RETURN_TOKEN(BAND); }
"|"         { RETURN_TOKEN(BOR); }
"^"         { RETURN_TOKEN(BXOR); }
"~"         { RETURN_TOKEN(BNOT); }
"?"         { RETURN_TOKEN(HUH); }
"."         { RETURN_TOKEN(PERIOD); }
">"         { RETURN_TOKEN(GTHAN); }
"<"         { RETURN_TOKEN(LTHAN); }
"typedef"   { RETURN_TOKEN(TYPEDEF); }
"extern"    { RETURN_TOKEN(EXTERN); }
"static"    { RETURN_TOKEN(STATIC); }
"auto"      { RETURN_TOKEN(AUTO); }
"register"  { RETURN_TOKEN(REGISTER); }
"char"      { RETURN_TOKEN(CHAR); }
"short"     { RETURN_TOKEN(SHORT); }
"int"       { RETURN_TOKEN(INT); }
"long"      { RETURN_TOKEN(LONG); }
"signed"    { RETURN_TOKEN(SIGNED); }
"unsigned"  { RETURN_TOKEN(UNSIGNED); }
"float"     { RETURN_TOKEN(FLOAT); }
"double"    { RETURN_TOKEN(DOUBLE); }
"const"     { RETURN_TOKEN(CONST); }
"volatile"  { RETURN_TOKEN(VOLATILE); }
"void"      { RETURN_TOKEN(VOID); }
"struct"    { RETURN_TOKEN(STRUCT); }
"union"     { RETURN_TOKEN(UNION); }
"enum"      { RETURN_TOKEN(ENUM); }
"..."       { RETURN_TOKEN(ELIPSIS); }
".."        { RETURN_TOKEN(RANGE); }
"case"      { RETURN_TOKEN(CASE); }
"default"   { RETURN_TOKEN(DEFAULT); }
"if"        { RETURN_TOKEN(IF); }
"else"      { RETURN_TOKEN(ELSE); }
"switch"    { RETURN_TOKEN(SWITCH); }
"while"     { RETURN_TOKEN(WHILE); }
"do"        { RETURN_TOKEN(DO); }
"for"       { RETURN_TOKEN(FOR); }
"goto"      { RETURN_TOKEN(GOTO); }
"continue"  { RETURN_TOKEN(CONTINUE); }
"break"     { RETURN_TOKEN(BREAK); }
"return"    { RETURN_TOKEN(RETURN); }
"#DUMP"     { if(debug_symbol_stream.is_open()) debug_symbol_stream << table; }
"#REDUCE"   { yydebug = 1; }
"#NOREDUCE" { yydebug = 0; }

{ID}   {
	if(lexDLevel) std::cout << "ID: " << yytext << std::endl;
	std::string varName = yytext;
	Symbol::SymbolType* idPtr;
	if (table.mode == Symbol::Mode::OBJECT) {
		idPtr = table.find(varName);
		if (idPtr == nullptr) {
			idPtr = table.insert(varName, lineno);
		}
	} else if (table.mode == Symbol::Mode::READ) {
		idPtr = table.find(varName);
		if (idPtr == nullptr) {
			throw ScannerError("Undeclared Reference");
		}

	} else if (table.mode == Symbol::Mode::WRITE) {
		idPtr = table.findInCurrentScope(varName);
		Symbol::SymbolType* shadowIdPtr = table.find(varName);
		if (idPtr != nullptr) {
			if(idPtr->itype == Symbol::SymbolType::FUNCTION) {
				// We can't do much until we know about the parameters
				// TODO - figure out what to put here, if anything
				// idPtr->functionDefLine = lineno;
				// idPtr->functionDefCol = column;
			} else {
				throw ScannerError("Variable redeclaration");
			}
		} else if(shadowIdPtr != nullptr && shadowIdPtr->itype == Symbol::SymbolType::STRUCT) {
			idPtr = shadowIdPtr;
		} else {
			if (shadowIdPtr != nullptr) {
				throwWarning("Variable \""s + varName + "\" shadows variable declared on line "s + std::to_string(shadowIdPtr->lineNumber));
			}
			idPtr = table.insert(varName, lineno);
		}
	}

	yylval.sval = idPtr;

	RETURN_TOKEN(IDENTIFIER);
}

.           { throw ScannerError("Unexpected Token: "s + yytext); }
%%

int yywrap(void) {
	return 1;
}
