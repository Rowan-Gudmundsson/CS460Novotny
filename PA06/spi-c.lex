%{
	#include "bison_header.h"
	#include "spi-c.tab.h"
	#include <string>
	#include <unordered_map>

	// To use extended calculator operation, please use the provided .y file
	#ifdef EXTENDED_CALC
		#define EMATH(x) return(x)
	#else
		#define EMATH(x) return(ERROR)
	#endif

	int yyerror(char *s);

	std::unordered_map<std::string, VarType> varTable;

%}

%option nounput

DIGIT [0-9]
INTEGER {DIGIT}+
DELIM [ \t\n\r]
ID [a-zA-Z](_[a-zA-Z0-9]*)?

%%

{DELIM}+ {}
"("    { return(OPEN); }
")"    { return(CLOSE); }
"+"    { return(PLUS); }
"-"    { return(MINUS); }
"*"    { return(MULT); }
"/"    { return(DIV); }
";"    { return(SEMI); }

"pi"   { EMATH(PI); }
"e"    { EMATH(E_CONST); }
"sin"  { EMATH(SIN); }
"cos"  { EMATH(COS); }
"tan"  { EMATH(TAN); }
"sqrt" { EMATH(SQRT); }
"ln"   { EMATH(LN); }
"^"    { EMATH(POW); }
"=="   { EMATH(EQUALS); }
">"    { EMATH(GREATER); }
"<"    { EMATH(LESS); }
"="    { EMATH(ASSIGN); }

{ID}   {
	std::string varName = yytext;
	yylval.vval = NULL;
	std::unordered_map<std::string, VarType>::iterator iter = varTable.find(varName);
	if(iter == varTable.end()) {
		VarType newVar;
		newVar.name = varName;
		newVar.init = false;
		yylval.vval = &(*varTable.insert(std::make_pair(varName, newVar)).first).second;
	} else {
		yylval.vval = &(iter->second);
	}

	EMATH(ID);
}

{INTEGER} {
	/* printf("I saw an integer: ");
	for(int i = 0; i < yyleng; i++)
		printf("%c", *(yytext + i));
	printf("\n"); */
	yylval.ival = atoi(yytext);
	return INTEGER;
}
. {return(ERROR);}

%%

int yywrap(void) {
	return 1;
}
