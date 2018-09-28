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
"("					{ return LPAREN; }
")"					{ return RPAREN; }
"{"					{ return LBRACE; }
"}"					{ return RBRACE; }
"["					{ return LBRACKET; }
"]"					{ return RBRACKET; }
"+"					{ return ADD; }
"-"					{ return SUB; }
"*"					{ return MULT; }
"/"					{ return DIV; }
";"					{ return SEMI; }
","					{ return COMMA; }
"="					{ return ASSIGN; }
":"					{ return COLON; }
"%"					{ return MOD; }
"&"					{ return BAND; }
"|"					{ return BOR; }
"^"					{ return BXOR; }
"~"					{ return BNOT; }
"?"					{ return HUH; }
"."					{ return PERIOD; }
">"					{ return GTHAN; }
"<"					{ return LTHAN; }
"typedef"		{ return TYPEDEF; }
"extern"		{ return EXTERN; }
"static"		{ return STATIC; }
"auto"			{ return AUTO; }
"register"	{ return REGISTER; }
"char"			{ return CHAR; }
"short"			{ return SHORT; }
"int"				{ return INT; }
"long"			{ return LONG; }
"signed"		{ return SIGNED; }
"unsigned"	{ return UNSIGNED; }
"float"			{ return FLOAT; }
"double"		{ return DOUBLE; }
"const"			{ return CONST; }
"volatile"	{ return VOLATILE; }
"void"			{ return VOID; }
"struct"		{ return STRUCT; }
"union"			{ return UNION; }
"enum"			{ return ENUM; }
"..."				{ return ELIPSIS; }
".."				{ return RANGE; }
"case"  		{ return CASE; }
"default" 	{ return DEFAULT; }
"if"				{ return IF; }
"else"			{ return ELSE; }
"switch"		{ return SWITCH; }
"while"			{ return WHILE; }
"do"				{ return DO; }
"for"				{ return FOR; }
"goto"			{ return GOTO; }
"continue"	{ return CONTINUE; }
"break"			{ return BREAK; }
"return"		{ return RETURN; }

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
