%{
	#include "symbol.h"
	#include "spi-c.tab.h"
	#include "errors.h"
	#include <cstdlib>
	#include <climits>
	#include <fstream>
	#include <string>
	#include <stdexcept>

	#define RETURN_TOKEN(token) column += yyleng; return token;
	#define COLUMN column += yyleng
	int yyerror(char *s);

	extern std::ifstream inFile;
	extern std::string currentLine;

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
	do {
		lastPos = position;
		position = comment.find('\n', lastPos);
		if (position != std::string::npos) {
			lineno++;
			column = 1;
			std::getline(inFile,currentLine);
		};
	} while (position != std::string::npos);

	column += comment.size() - lastPos;
}
{SCOMMENT}   {
	lineno++;
	column = 0;
}

{DELIM}+     { column += yyleng; }

{FLOAT}      { RETURN_TOKEN(FLOATING_CONSTANT); }
{INTEGER} {
	/* printf("I saw an integer: ");
	for(int i = 0; i < yyleng; i++)
		printf("%c", *(yytext + i));
	printf("\n"); */
	std::cout << "Int: " << yytext << std::endl;
	char* dummy;
	long long num = strtoll(yytext, &dummy, 10);
	if(num >= INT_MAX) {
		throw scannerError("Integer too large");
	}
	yylval.ival = num;
	RETURN_TOKEN(INTEGER_CONSTANT);
}

{STRING}    { RETURN_TOKEN(STRING_LITERAL); }
{CHAR}      { RETURN_TOKEN(CHARACTER_CONSTANT); }

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
"{"         { table.mode = Symbol::Mode::READ; table.pushScope(); RETURN_TOKEN(LBRACE); }
"}"         { table.popScope(); RETURN_TOKEN(RBRACE); }
"("         { RETURN_TOKEN(LPAREN); }
")"         { RETURN_TOKEN(RPAREN); }
"["         { RETURN_TOKEN(LBRACKET); }
"]"         { RETURN_TOKEN(RBRACKET); }
"+"         { RETURN_TOKEN(ADD); }
"-"         { RETURN_TOKEN(SUB); }
"*"         { RETURN_TOKEN(MULT); }
"/"         { RETURN_TOKEN(DIV); }
";"         { table.mode = Symbol::Mode::READ; RETURN_TOKEN(SEMI); }
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
"char"      { table.mode = Symbol::Mode::WRITE; RETURN_TOKEN(CHAR); }
"short"     { table.mode = Symbol::Mode::WRITE; RETURN_TOKEN(SHORT); }
"int"       { table.mode = Symbol::Mode::WRITE; RETURN_TOKEN(INT); }
"long"      { table.mode = Symbol::Mode::WRITE; RETURN_TOKEN(LONG); }
"signed"    { table.mode = Symbol::Mode::WRITE; RETURN_TOKEN(SIGNED); }
"unsigned"  { table.mode = Symbol::Mode::WRITE; RETURN_TOKEN(UNSIGNED); }
"float"     { table.mode = Symbol::Mode::WRITE; RETURN_TOKEN(FLOAT); }
"double"    { table.mode = Symbol::Mode::WRITE; RETURN_TOKEN(DOUBLE); }
"const"     { table.mode = Symbol::Mode::WRITE; RETURN_TOKEN(CONST); }
"volatile"  { table.mode = Symbol::Mode::WRITE; RETURN_TOKEN(VOLATILE); }
"void"      { table.mode = Symbol::Mode::WRITE; RETURN_TOKEN(VOID); }
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
"#DUMP"		{ table.dumpSymbolTable(); }
"#PAR"		{ table.toggleDebug_parse_enabled(); }
"#TOK"		{ table.toggleDebug_token_enabled(); }
"#REDUCE" { table.toggleDebug_reduce_enabled(); COLUMN; }

{ID}   {
	std::cout << "ID: " << yytext << std::endl;
	std::string varName = yytext;
	Symbol::SymbolType* idPtr;
	if (table.mode == Symbol::Mode::READ) {
		idPtr = table.find(varName);
		if (idPtr == nullptr) {
			throw scannerError("Undeclared Reference");
		}

	} else if (table.mode == Symbol::Mode::WRITE) {
		idPtr = table.findInCurrentScope(varName);
		Symbol::SymbolType* shadowIdPtr = table.find(varName);
		if (idPtr != nullptr) {
			throw scannerError("Variable redeclaration");
		} else {
			if (shadowIdPtr != nullptr) {
				std::cout << "WARNING! Shadowing" << std::endl
					<< "On line " << lineno << ", column " << column << std::endl;
			}
			Symbol::SymbolType newSym(varName, lineno);
			idPtr = table.insert(newSym);
		}
	}

	yylval.sval = idPtr;

	RETURN_TOKEN(IDENTIFIER);
}

.           { RETURN_TOKEN(ERROR); }
%%

int yywrap(void) {
	return 1;
}
