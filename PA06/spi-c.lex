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
DELIM [ \t\r\n]
ID [_a-zA-Z][_a-zA-Z0-9]*

%%

"\n"   { lineno++; column = 0; }
{DELIM}+ {}

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

"sizeof" { return SIZEOF; }
"->"   { return PTR_OP; }
"++"   { return INC_OP; }
"--"   { return DEC_OP; }
"<<"   { return LEFT_OP; }
">>"   { return RIGHT_OP; }
"<="   { return LE_OP; }
">="   { return GE_OP; }
"=="   { return EQ_OP; }
"!="   { return NE_OP; }
"&&"   { return AND_OP; }
"||"   { return OR_OP; }
"!"    { return LNOT; }
"*="   { return MUL_ASSIGN; }
"/="   { return DIV_ASSIGN; }
"%="   { return MOD_ASSIGN; }
"+="   { return ADD_ASSIGN; }
"-="   { return SUB_ASSIGN; }
"<<="  { return LEFT_ASSIGN; }
">>="  { return RIGHT_ASSIGN; }
"&="   { return AND_ASSIGN; }
"^="   { return XOR_ASSIGN; }
"|="   { return OR_ASSIGN; }


"("    { return(LPAREN); }
")"    { return(RPAREN); }
"+"    { return(ADD); }
"-"    { return(SUB); }
"*"    { return(MULT); }
"/"    { return(DIV); }
";"    { return(SEMI); }
.      { return(ERROR); }

%%

int yywrap(void) {
	return 1;
}
