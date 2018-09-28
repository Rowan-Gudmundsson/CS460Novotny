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

%%

\n   { lineno++; column = 0; }
{DELIM}+ {}

{INTEGER} {
	/* printf("I saw an integer: ");
	for(int i = 0; i < yyleng; i++)
		printf("%c", *(yytext + i));
	printf("\n"); */
	char* dummy;
	long long num = strtoll(yytext, &dummy, 10);
	if(num >= INT_MAX) {
		return ERROR;
	}
	yylval.ival = num;
	return INTEGER_CONSTANT;
}

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
"{"         { return LBRACE; }
"}"         { return RBRACE; }
"("         { return LPAREN; }
")"         { return RPAREN; }
"["         { return LBRACKET; }
"]"         { return RBRACKET; }
"+"         { return ADD; }
"-"         { return SUB; }
"*"         { return MULT; }
"/"         { return DIV; }
";"         { return SEMI; }
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
"char"      { return CHAR; }
"short"     { return SHORT; }
"int"       { return INT; }
"long"      { return LONG; }
"signed"    { return SIGNED; }
"unsigned"  { return UNSIGNED; }
"float"     { return FLOAT; }
"double"    { return DOUBLE; }
"const"     { return CONST; }
"volatile"  { return VOLATILE; }
"void"      { return VOID; }
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
	std::string varName = yytext;
	Symbol::SymbolType* idPtr = table.find(varName);
	if(idPtr == nullptr) {
		Symbol::SymbolType newSym(varName);
		newSym.lineNumber = lineno;
		idPtr = table.insert(newSym);
	}

	yylval.sval = idPtr;

	return IDENTIFIER;
}

.           { return(ERROR); }
%%

int yywrap(void) {
	return 1;
}
