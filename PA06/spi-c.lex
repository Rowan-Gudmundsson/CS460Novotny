%{
	#include "symbol.h"
	#include "spi-c.tab.h"

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
"("    { return(LPAREN); }
")"    { return(RPAREN); }
"+"    { return(ADD); }
"-"    { return(SUB); }
"*"    { return(MULT); }
"/"    { return(DIV); }
";"    { return(SEMI); }

{ID}   {
	std::string varName = yytext;
	Symbol::SymbolType* idPtr = table.find(varName);
	if(idPtr == nullptr) {
		Symbol::SymbolType newSym(varName);
		newSym.lineNumber = lineno;
		idPtr = table.insert(newSym);
	}

	yylval.sval = idPtr;

	return(IDENTIFIER);
}

{INTEGER} {
	/* printf("I saw an integer: ");
	for(int i = 0; i < yyleng; i++)
		printf("%c", *(yytext + i));
	printf("\n"); */
	// yylval.ival = atoi(yytext);
	return INTEGER_CONSTANT;
}
. {return(ERROR);}

%%

int yywrap(void) {
	return 1;
}
