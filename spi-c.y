%{
	#include <cstdio>
	#include <iostream>
	#include <string>
	#include "errors.h"

	#define YYDEBUG 1

	int yyerror(char *s);
	int yylex(void);

	extern Symbol table;
	void throwWarning(const std::string& warning);
%}

%code top {
	#include "symbol.h"
	#include "node.h"
}

%union {
	Symbol::SymbolType* sval;
	long int ival;
	double fval;
	char cval;
	std::string* strval;
	EvalType eval;
	SyntaxNode* nval;
	OperatorNode::OpType oval;
}

%token DEBUG_SYMBOL_TABLE
%token DEBUG_PARSER
%token DEBUG_TOKENS
%token IDENTIFIER
%token INTEGER_CONSTANT FLOATING_CONSTANT CHARACTER_CONSTANT ENUMERATION_CONSTANT
%token STRING_LITERAL
%token SIZEOF
%token PTR_OP
%token INC_OP DEC_OP
%token LEFT_OP RIGHT_OP
%token LE_OP GE_OP EQ_OP NE_OP
%token AND_OP OR_OP LNOT
%token MUL_ASSIGN DIV_ASSIGN MOD_ASSIGN ADD_ASSIGN SUB_ASSIGN
%token LEFT_ASSIGN RIGHT_ASSIGN AND_ASSIGN XOR_ASSIGN OR_ASSIGN
%token TYPEDEF_NAME
%token SEMI
%token LBRACE RBRACE
%token LPAREN RPAREN
%token LBRACKET RBRACKET
%token COMMA
%token ASSIGN
%token COLON
%left MULT DIV ADD SUB MOD
%left BAND BOR BXOR BNOT
%left HUH
%token PERIOD
%token GTHAN LTHAN
%token TYPEDEF EXTERN STATIC AUTO REGISTER
%token CHAR SHORT INT LONG SIGNED UNSIGNED FLOAT DOUBLE CONST VOLATILE VOID
%token STRUCT UNION ENUM ELIPSIS RANGE
%token ERROR

%token CASE DEFAULT IF ELSE SWITCH WHILE DO FOR GOTO CONTINUE BREAK RETURN

%type <eval> type_specifier declaration_specifiers storage_class_specifier type_qualifier
%type <eval> specifier_qualifier_list type_name
%type <nval> direct_declarator constant primary_expression string expression identifier
%type <nval> postfix_expression unary_expression cast_expression
%type <oval> unary_operator

%start translation_unit
%%

translation_unit
	: external_declaration
	| translation_unit external_declaration
	;

external_declaration
	: function_definition { table.mode = Symbol::Mode::READ; }
	| declaration
	;

function_definition
	: declarator compound_statement
	| declarator declaration_list compound_statement
	| declaration_specifiers declarator compound_statement
	| declaration_specifiers declarator declaration_list compound_statement
	;

declaration
	: declaration_specifiers SEMI
	| declaration_specifiers init_declarator_list SEMI
	;

declaration_list
	: declaration { table.mode = Symbol::Mode::READ; }
	| declaration_list declaration
	;

declaration_specifiers
	: storage_class_specifier { $$ = $1; }
	| storage_class_specifier declaration_specifiers { $$ = $1 | $2; }
	| type_specifier { $$ = $1; }
	| type_specifier declaration_specifiers { $$ = $1 | $2; }
	| type_qualifier { $$ = $1; }
	| type_qualifier declaration_specifiers { $$ = $1 | $2; }
	;

storage_class_specifier
	: AUTO
	| REGISTER
	| STATIC
	| EXTERN
	| TYPEDEF
	;

type_specifier
	: VOID { table.mode = Symbol::Mode::WRITE; $$ = EVOID; }
	| CHAR { table.mode = Symbol::Mode::WRITE; $$ = ECHAR; }
	| SHORT { table.mode = Symbol::Mode::WRITE; $$ = ESHORT; }
	| INT { table.mode = Symbol::Mode::WRITE; $$ = EINT; }
	| LONG { table.mode = Symbol::Mode::WRITE; $$ = ELONG; }
	| FLOAT { table.mode = Symbol::Mode::WRITE; $$ = EFLOAT; }
	| DOUBLE { table.mode = Symbol::Mode::WRITE; $$ = EDOUBLE; }
	| SIGNED { table.mode = Symbol::Mode::WRITE; $$ = ESIGNED; }
	| UNSIGNED { table.mode = Symbol::Mode::WRITE; $$ = EUNSIGNED; }
	| struct_or_union_specifier { /* TODO Acutally do this */ $$ = EVOID; }
	| enum_specifier { /* TODO Acutally do this */ $$ = EVOID; }
	| TYPEDEF_NAME { table.mode = Symbol::Mode::WRITE; /* TODO Acutally do this */ $$ = EVOID; }
	;

type_qualifier
	: CONST
	| VOLATILE
	;

struct_or_union_specifier
	: struct_or_union identifier LBRACE struct_declaration_list RBRACE
	| struct_or_union LBRACE struct_declaration_list RBRACE
	| struct_or_union identifier
	;

struct_or_union
	: STRUCT
	| UNION
	;

struct_declaration_list
	: struct_declaration
	| struct_declaration_list struct_declaration
	;

init_declarator_list
	: init_declarator
	| init_declarator_list COMMA init_declarator
	;

init_declarator
	: declarator
	| declarator ASSIGN initializer
	;

struct_declaration
	: specifier_qualifier_list struct_declarator_list SEMI
	;

specifier_qualifier_list
	: type_specifier
	| type_specifier specifier_qualifier_list
	| type_qualifier
	| type_qualifier specifier_qualifier_list
	;

struct_declarator_list
	: struct_declarator
	| struct_declarator_list COMMA struct_declarator
	;

struct_declarator
	: declarator
	| COLON constant_expression
	| declarator COLON constant_expression
	;

enum_specifier
	: ENUM LBRACE enumerator_list RBRACE
	| ENUM identifier LBRACE enumerator_list RBRACE
	| ENUM identifier
	;

enumerator_list
	: enumerator
	| enumerator_list COMMA enumerator
	;

enumerator
	: identifier
	| identifier ASSIGN constant_expression
	;

declarator
	: direct_declarator
	| pointer direct_declarator
	;

direct_declarator
	: identifier { $$ = $1; }
	| LPAREN declarator RPAREN { /* TODO LATER*/ $$ = nullptr; }
	| direct_declarator LBRACKET RBRACKET
	| direct_declarator LBRACKET constant_expression RBRACKET
	| direct_declarator LPAREN RPAREN
	| direct_declarator LPAREN parameter_type_list RPAREN
	| direct_declarator LPAREN identifier_list RPAREN { /* TODO: WHAT IS THIS? */ $$ = nullptr; }
	;

pointer
	: MULT
	| MULT type_qualifier_list
	| MULT pointer
	| MULT type_qualifier_list pointer
	;

type_qualifier_list
	: type_qualifier
	| type_qualifier_list type_qualifier
	;

parameter_type_list
	: parameter_list { table.mode = Symbol::Mode::READ; }
	| parameter_list COMMA ELIPSIS { table.mode = Symbol::Mode::READ; }
	;

parameter_list
	: parameter_declaration
	| parameter_list COMMA parameter_declaration
	;

parameter_declaration
	: declaration_specifiers declarator
	| declaration_specifiers
	| declaration_specifiers abstract_declarator
	;

identifier_list
	: identifier
	| identifier_list COMMA identifier
	;

initializer
	: assignment_expression
	| LBRACE initializer_list RBRACE
	| LBRACE initializer_list COMMA RBRACE
	;

initializer_list
	: initializer
	| initializer_list COMMA initializer
	;

type_name
	: specifier_qualifier_list
	| specifier_qualifier_list abstract_declarator
	;

abstract_declarator
	: pointer
	| direct_abstract_declarator
	| pointer direct_abstract_declarator
	;

direct_abstract_declarator
	: LPAREN abstract_declarator RPAREN
	| LBRACKET RBRACKET
	| LBRACKET constant_expression RBRACKET
	| direct_abstract_declarator LBRACKET RBRACKET
	| direct_abstract_declarator LBRACKET constant_expression RBRACKET
	| LPAREN RPAREN
	| LPAREN parameter_type_list RPAREN
	| direct_abstract_declarator LPAREN RPAREN
	| direct_abstract_declarator LPAREN parameter_type_list RPAREN
	;

statement
	: labeled_statement
	| compound_statement
	| expression_statement
	| selection_statement
	| iteration_statement
	| jump_statement
	;

labeled_statement
	: identifier COLON statement
	| CASE constant_expression COLON statement
	| DEFAULT COLON statement
	;

expression_statement
	: SEMI
	| expression SEMI
	;

compound_statement
	: LBRACE RBRACE
	| LBRACE statement_list RBRACE
	| LBRACE declaration_list RBRACE
	| LBRACE declaration_list statement_list RBRACE
	;

statement_list
	: statement
	| statement_list statement
	;

selection_statement
	: IF LPAREN expression RPAREN statement
	| IF LPAREN expression RPAREN statement ELSE statement
	| SWITCH LPAREN expression RPAREN statement
	;

iteration_statement
	: WHILE LPAREN expression RPAREN statement
	| DO statement WHILE LPAREN expression RPAREN SEMI
	| FOR LPAREN SEMI SEMI RPAREN statement
	| FOR LPAREN SEMI SEMI expression RPAREN statement
	| FOR LPAREN SEMI expression SEMI RPAREN statement
	| FOR LPAREN SEMI expression SEMI expression RPAREN statement
	| FOR LPAREN expression SEMI SEMI RPAREN statement
	| FOR LPAREN expression SEMI SEMI expression RPAREN statement
	| FOR LPAREN expression SEMI expression SEMI RPAREN statement
	| FOR LPAREN expression SEMI expression SEMI expression RPAREN statement
	;

jump_statement
	: GOTO identifier SEMI
	| CONTINUE SEMI
	| BREAK SEMI
	| RETURN SEMI
	| RETURN expression SEMI
	;

expression
	: assignment_expression
	| expression COMMA assignment_expression
	;

assignment_expression
	: conditional_expression
	| unary_expression assignment_operator assignment_expression
	;

assignment_operator
	: ASSIGN
	| MUL_ASSIGN
	| DIV_ASSIGN
	| MOD_ASSIGN
	| ADD_ASSIGN
	| SUB_ASSIGN
	| LEFT_ASSIGN
	| RIGHT_ASSIGN
	| AND_ASSIGN
	| XOR_ASSIGN
	| OR_ASSIGN
	;

conditional_expression
	: logical_or_expression
	| logical_or_expression HUH expression COLON conditional_expression
	;

constant_expression
	: conditional_expression
	;

logical_or_expression
	: logical_and_expression
	| logical_or_expression OR_OP logical_and_expression
	;

logical_and_expression
	: inclusive_or_expression
	| logical_and_expression AND_OP inclusive_or_expression
	;

inclusive_or_expression
	: exclusive_or_expression
	| inclusive_or_expression BOR exclusive_or_expression
	;

exclusive_or_expression
	: and_expression
	| exclusive_or_expression BXOR and_expression
	;

and_expression
	: equality_expression
	| and_expression BAND equality_expression
	;

equality_expression
	: relational_expression
	| equality_expression EQ_OP relational_expression
	| equality_expression NE_OP relational_expression
	;

relational_expression
	: shift_expression
	| relational_expression LTHAN shift_expression
	| relational_expression GTHAN shift_expression
	| relational_expression LE_OP shift_expression
	| relational_expression GE_OP shift_expression
	;

shift_expression
	: additive_expression
	| shift_expression LEFT_OP additive_expression
	| shift_expression RIGHT_OP additive_expression
	;

additive_expression
	: multiplicative_expression
	| additive_expression ADD multiplicative_expression
	| additive_expression SUB multiplicative_expression
	;

multiplicative_expression
	: cast_expression
	| multiplicative_expression MULT cast_expression
	| multiplicative_expression DIV cast_expression
	| multiplicative_expression MOD cast_expression
	;

cast_expression
	: unary_expression
	| LPAREN type_name RPAREN cast_expression
	;

unary_expression
	: postfix_expression { $$ = $1; }
	| INC_OP unary_expression { $$ = new OperatorNode($2->etype, OperatorNode::OINC, 1, $2); }
	| DEC_OP unary_expression { $$ = new OperatorNode($2->etype, OperatorNode::ODEC, 1, $2); }
	| unary_operator cast_expression {
		EvalType _type;
		switch($1) {
			case OperatorNode::OBAND:
				_type = EINT;
				break;
			case OperatorNode::OMULT:
				_type = $2->etype & ~EPOINTER;
				break;
			case OperatorNode::OADD:
				throw ParserError("Not handling the unary '+' operator");
				break;
			case OperatorNode::OSUB:
				if ($2->etype & EUNSIGNED) {
					throwWarning("Taking 2's complement of unsigned type.");
				}
			case OperatorNode::OBNOT:
			case OperatorNode::OLNOT:
				_type = $2->etype;
		}
		$$ = new OperatorNode(_type, $1, 1, $2);
	}
	| SIZEOF unary_expression { $$ = new OperatorNode(EINT | EUNSIGNED, OperatorNode::OSIZE, 1, $2); }
	| SIZEOF LPAREN type_name RPAREN { $$ = new OperatorNode(EINT | EUNSIGNED, OperatorNode::OSIZE, 1, $3); }
	;

unary_operator
	: BAND { $$ = OperatorNode::OBAND; }
	| MULT { $$ = OperatorNode::OMULT; }
	| ADD { /* https://docs.microsoft.com/en-us/cpp/c-language/unary-arithmetic-operators?view=vs-2017 */ $$ = OperatorNode::OADD; }
	| SUB { $$ = OperatorNode::OSUB; }
	| BNOT { $$ = OperatorNode::OBNOT; }
	| LNOT { $$ = OperatorNode::OLNOT; }
	;

postfix_expression
	: primary_expression { $$ = $1; }
	| postfix_expression LBRACKET expression RBRACKET { /* TODO(Rowan) -- Fix later */ $$ = nullptr; }
	| postfix_expression LPAREN RPAREN { /* TODO(Rowan) -- Fix later */ $$ = nullptr; }
	| postfix_expression LPAREN argument_expression_list RPAREN { /* TODO(Rowan) -- Fix later */ $$ = nullptr; }
	| postfix_expression PERIOD identifier { /* TODO(Rowan) -- Fix later */ $$ = nullptr; }
	| postfix_expression PTR_OP identifier { /* TODO(Rowan) -- Fix later */ $$ = nullptr; }
	| postfix_expression INC_OP { /* TODO(Rowan) -- Fix later */ $$ = nullptr; }
	| postfix_expression DEC_OP { /* TODO(Rowan) -- Fix later */ $$ = nullptr; }
	;

primary_expression
	: identifier { $$ = $1; }
	| constant { $$ = $1; }
	| string { $$ = $1; }
	| LPAREN expression RPAREN { $$ = $2; }
	;

argument_expression_list
	: assignment_expression
	| argument_expression_list COMMA assignment_expression
	;

constant
	: INTEGER_CONSTANT { $$ = new ConstantNode(EINT, yylval.ival); }
	| CHARACTER_CONSTANT { $$ = new ConstantNode(ECHAR, (long int)(yylval.cval)); }
	| FLOATING_CONSTANT { $$ = new ConstantNode(EFLOAT, yylval.fval); }
	| ENUMERATION_CONSTANT { /* TODO(Rowan) -- Fix later. */ $$ = nullptr; }
	;

string
	: STRING_LITERAL { $$ = new ConstantNode(ECHAR | EPOINTER, yylval.strval); }
	;

identifier
	: IDENTIFIER { $$ = new IdentifierNode(yylval.sval); }
	;

%%
