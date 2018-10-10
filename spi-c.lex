%{
	#include "symbol.h"
	#include "spi-c.tab.h"
	#include <cstdlib>
	#include <climits>

	int yyerror(char *s);

	Symbol table;
	unsigned lineno = 0;
	unsigned column = 0;
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
%%

\n   { lineno++; column = 0; }
{COMMENT}    {}
{DELIM}+     {}

{FLOAT}      { return FLOATING_CONSTANT; }
{INTEGER} {
	/* printf("I saw an integer: ");
	for(int i = 0; i < yyleng; i++)
		printf("%c", *(yytext + i));
	printf("\n"); */
	std::cout << "Int: " << yytext << std::endl;
	char* dummy;
	long long num = strtoll(yytext, &dummy, 10);
	if(num >= INT_MAX) {
		return ERROR;
	}
	yylval.ival = num;
	return INTEGER_CONSTANT;
}

{STRING}    { return STRING_LITERAL; }
{CHAR}      { return CHARACTER_CONSTANT; }

"sizeof"    { return SIZEOF; }
"->"        { return PTR_OP; }
"++"        { return INC_OP; }
"--"        { return DEC_OP; }
"<<"        { return LEFT_OP; }
">>"        { return RIGHT_OP; }
"<="        { return LE_OP; }
">="        { return GE_OP; }
"=="        { return EQ_OP; }
"!="        { return NE_OP; }
"&&"        { return AND_OP; }
"||"        { return OR_OP; }
"!"         { return LNOT; }
"*="        { return MUL_ASSIGN; }
"/="        { return DIV_ASSIGN; }
"%="        { return MOD_ASSIGN; }
"+="        { return ADD_ASSIGN; }
"-="        { return SUB_ASSIGN; }
"<<="       { return LEFT_ASSIGN; }
">>="       { return RIGHT_ASSIGN; }
"&="        { return AND_ASSIGN; }
"^="        { return XOR_ASSIGN; }
"|="        { return OR_ASSIGN; }
"{"         { table.mode = Symbol::Mode::READ; table.pushScope(); return LBRACE; }
"}"         { table.popScope(); return RBRACE; }
"("         { return LPAREN; }
")"         { return RPAREN; }
"["         { return LBRACKET; }
"]"         { return RBRACKET; }
"+"         { return ADD; }
"-"         { return SUB; }
"*"         { return MULT; }
"/"         { return DIV; }
";"         { table.mode = Symbol::Mode::READ; return SEMI; }
","         { return COMMA; }
"="         { return ASSIGN; }
":"         { return COLON; }
"%"         { return MOD; }
"&"         { return BAND; }
"|"         { return BOR; }
"^"         { return BXOR; }
"~"         { return BNOT; }
"?"         { return HUH; }
"."         { return PERIOD; }
">"         { return GTHAN; }
"<"         { return LTHAN; }
"typedef"   { return TYPEDEF; }
"extern"    { return EXTERN; }
"static"    { return STATIC; }
"auto"      { return AUTO; }
"register"  { return REGISTER; }
"char"      { table.mode = Symbol::Mode::WRITE; return CHAR; }
"short"     { table.mode = Symbol::Mode::WRITE; return SHORT; }
"int"       { table.mode = Symbol::Mode::WRITE; return INT; }
"long"      { table.mode = Symbol::Mode::WRITE; return LONG; }
"signed"    { table.mode = Symbol::Mode::WRITE; return SIGNED; }
"unsigned"  { table.mode = Symbol::Mode::WRITE; return UNSIGNED; }
"float"     { table.mode = Symbol::Mode::WRITE; return FLOAT; }
"double"    { table.mode = Symbol::Mode::WRITE; return DOUBLE; }
"const"     { table.mode = Symbol::Mode::WRITE; return CONST; }
"volatile"  { table.mode = Symbol::Mode::WRITE; return VOLATILE; }
"void"      { table.mode = Symbol::Mode::WRITE; return VOID; }
"struct"    { return STRUCT; }
"union"     { return UNION; }
"enum"      { return ENUM; }
"..."       { return ELIPSIS; }
".."        { return RANGE; }
"case"      { return CASE; }
"default"   { return DEFAULT; }
"if"        { return IF; }
"else"      { return ELSE; }
"switch"    { return SWITCH; }
"while"     { return WHILE; }
"do"        { return DO; }
"for"       { return FOR; }
"goto"      { return GOTO; }
"continue"  { return CONTINUE; }
"break"     { return BREAK; }
"return"    { return RETURN; }

{ID}   {
	std::cout << "ID: " << yytext << std::endl;
	std::string varName = yytext;
	Symbol::SymbolType* idPtr;
	if (table.mode == Symbol::Mode::READ) {
		idPtr = table.find(varName);
		if (idPtr == nullptr) {
			throw SPIC_UNDEFINED_REFERENCE;
		}
	} else if (table.mode == Symbol::Mode::WRITE) {
		idPtr = table.findInCurrentScope(varName);
		if (idPtr != nullptr) {
			throw SPIC_REDECLARATION;
		} else {
			Symbol::SymbolType newSym(varName, lineno);
			idPtr = table.insert(newSym);
		}
	}

	yylval.sval = idPtr;

	return IDENTIFIER;
}

.           { return(ERROR); }
%%

int yywrap(void) {
	return 1;
}
