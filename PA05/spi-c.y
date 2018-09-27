
%{
	#include <cstdio>
	#include <cmath>
	#include "bison_header.h"

	int yyerror(char *s);
	int yylex(void);

	const double eps = 0.00001;
%}

%code provides {
	#define EXTENDED_CALC
}

%union {
	int ival;
	double fval;
	VarType* vval;
}

%left PLUS MINUS MULT DIV POW
%token OPEN CLOSE SEMI PI SIN COS TAN SQRT E_CONST LN EQUALS GREATER LESS ASSIGN

%token <ival> INTEGER
%token <vval> ID

%token ERROR

%type <fval> ANS E Q T R F FP FP2

%start MANS

%%

MANS : ANS MANS
     |
     ;

ANS : E SEMI           { printf("%.2f\n", $1); }
    | E EQUALS E SEMI  { fabs($1 - $3) < eps ? printf("True\n") : printf("False\n"); }
    | E GREATER E SEMI { $1 >  $3 + eps ? printf("True\n") : printf("False\n"); }
    | E LESS E SEMI    { $1 <  $3 - eps ? printf("True\n") : printf("False\n"); }
    | ID ASSIGN E SEMI { $1->init = true; $1->value = $3; printf("%.2f\n", $3); }
    ;

E : T Q                { $$ = $1 + $2; }
  ;

Q : PLUS T Q           { $$ = $2 + $3; }
  | MINUS T Q          { $$ = $3 - $2; }
  |                    { $$ = 0.0f; }
  ;

T : FP R               { $$ = $1 * $2; }
  ;

R : MULT FP R          { $$ = $2 * $3; }
  | DIV FP R           { $$ = $3 / $2; }
  |                    { $$ = 1.0f; }
  ;

FP : F FP2             { $$ = pow($1, $2); }
   ;

FP2 : POW F            { $$ = $2; }
    |                  { $$ = 1.0f; }
    ;

F : OPEN E CLOSE       { $$ = $2; }
  | INTEGER            { $$ = yylval.ival; }
  | ID                 { $$ = $1->value; }
  | PI                 { $$ = M_PI; }
  | E_CONST            { $$ = M_E; }
  | SIN F              { $$ = sin($2); }
  | COS F              { $$ = cos($2); }
  | TAN F              { $$ = tan($2); }
  | SQRT F             { $$ = sqrt($2); }
  | LN F               { $$ = log($2); }
  ;

%%

#define EXTENDED_CALC