%{
	#include <cstdio>
	#include <iostream>
	#include <string>
	#include "errors.h"

	#define YYDEBUG 1

	int yyerror(SyntaxNode*& root, char *s);
	int yylex(void);

	extern Symbol table;
	extern unsigned int parseDLevel;
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

%type <eval> type_specifier declaration_specifiers storage_class_specifier type_qualifier specifier_qualifier_list type_name
%type <oval> unary_operator
%type <nval> declarator multiplicative_expression additive_expression shift_expression relational_expression
%type <nval> equality_expression and_expression exclusive_or_expression inclusive_or_expression logical_and_expression logical_or_expression conditional_expression assignment_expression
%type <nval> direct_declarator constant primary_expression string expression identifier declaration declaration_list
%type <nval> postfix_expression unary_expression cast_expression pointer initializer init_declarator init_declarator_list
%type <nval> compound_statement function_definition external_declaration translation_unit constant_expression

%parse-param {SyntaxNode*& root}

%start translation_unit
%%

translation_unit // Node*
	: external_declaration {
		$$ = root = new SyntaxNode(SyntaxNode::Type::GENERIC, EUNKNOWN, 1, $1);
		if(parseDLevel) {
			std::cout << "Found: " << $1 << '\n';
		}
	}
	| translation_unit external_declaration {
		$$ = root = $1; $$->pushChild($2);
		if(parseDLevel) {
			std::cout << "Found: " << $2 << '\n';
		}
	}
	;

external_declaration // Node*
	: function_definition { table.mode = Symbol::Mode::READ;  $$ = $1; }
	| declaration { $$ = $1; }
	;

function_definition // Node*
	: declarator compound_statement
	| declarator declaration_list compound_statement
	| declaration_specifiers declarator compound_statement {
		/*
		  TODO: Apply declaration specifiers
		  Should be easy, just need to traverse tree and find identifier
		  Also need to find the eval type of the function
		*/
		$$ = new SyntaxNode(SyntaxNode::Type::FUNCTION, EUNKNOWN, 2, $2, $3);
		if(parseDLevel) {
			std::cout << "Found function: \n"
			          << $2 << '\n' << $3 << '\n';
		}
	}
	| declaration_specifiers declarator declaration_list compound_statement
	;

declaration // Node*
	: declaration_specifiers SEMI
	| declaration_specifiers init_declarator_list SEMI {
		/*
		  TODO: Apply declaration specifiers
		  This should be fairly easy, we just need to traverse the tree until we find identifiers
		*/
		$$ = $2;
	}
	;

declaration_list // Node*
	: declaration {
		table.mode = Symbol::Mode::READ;
		$$ = new SyntaxNode(SyntaxNode::Type::GENERIC, EUNKNOWN, 1, $1);
	}
	| declaration_list declaration {
		$$ = $1;
		$1->pushChild($2);
	}
	;

declaration_specifiers // EvalType
	: storage_class_specifier { $$ = $1; }
	| storage_class_specifier declaration_specifiers { $$ = $1 | $2; }
	| type_specifier { $$ = $1; }
	| type_specifier declaration_specifiers { $$ = $1 | $2; }
	| type_qualifier { $$ = $1; }
	| type_qualifier declaration_specifiers { $$ = $1 | $2; }
	;

storage_class_specifier // EvalType
	: AUTO
	| REGISTER
	| STATIC
	| EXTERN
	| TYPEDEF
	;

type_specifier // EvalType
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

type_qualifier // EvalType
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

init_declarator_list // Node*
	: init_declarator {
		$$ = new SyntaxNode(SyntaxNode::Type::GENERIC, EUNKNOWN, 1, $1);
		if(parseDLevel){
			std::cout << "GENERIC:\n"
			          << $1 << std::endl;
		}
	}
	| init_declarator_list COMMA init_declarator {
		$$ = $1;
		$1->pushChild($3);
	}
	;

init_declarator // Node*
	: declarator
	| declarator ASSIGN initializer {
		$$ = new SyntaxNode(SyntaxNode::Type::DECLARE_AND_INIT, EUNKNOWN, 2, $1, $3);
		if(parseDLevel){
			std::cout << "DECLARE_AND_INIT:\n"
			          << $1 << '\n'
			          << $3 << std::endl;
		}
	}
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

declarator // Node*
	: direct_declarator { $$ = $1; }
	| pointer direct_declarator { /* TODO: Pointer stuff */ $$ = $1; }
	;

direct_declarator // Node*
	: identifier { $$ = $1; }
	| LPAREN declarator RPAREN { /* Parentheses don't do anything...? */ $$ = $2; }
	| direct_declarator LBRACKET RBRACKET {
		$$ = $1;
		if($$->type == SyntaxNode::Type::IDENTIFIER) {
			IdentifierNode* node = (IdentifierNode*) $$;
			node->sym->itype = Symbol::SymbolType::VARIABLE;
			node->sym->isArray = true;
		} else {
			throw "Error 1";
		}
	}
	| direct_declarator LBRACKET constant_expression RBRACKET {
		$$ = $1;
		if($$->type == SyntaxNode::Type::IDENTIFIER) {
			IdentifierNode* node = (IdentifierNode*) $$;
			node->sym->itype = Symbol::SymbolType::VARIABLE;
			node->sym->isArray = true;
			// TODO - set size
		} else {
			throw "Error 2";
		}
	}
	| direct_declarator LPAREN RPAREN {
		$$ = $1;
		if($$->type == SyntaxNode::Type::IDENTIFIER) {
			IdentifierNode* node = (IdentifierNode*) $$;
			node->sym->itype = Symbol::SymbolType::FUNCTION;
			// TODO - set paramaters
		} else {
			throw "Error 3";
		}
	}
	| direct_declarator LPAREN parameter_type_list RPAREN {
		$$ = $1;
		if($$->type == SyntaxNode::Type::IDENTIFIER) {
			IdentifierNode* node = (IdentifierNode*) $$;
			node->sym->itype = Symbol::SymbolType::FUNCTION;
			// TODO - set paramters
		} else {
			throw "Error 4";
		}
	}
	| direct_declarator LPAREN identifier_list RPAREN { /* Ignore this, it won't be a feature of our language */ $$ = nullptr; }
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

initializer // Node*
	: assignment_expression { $$ = $1; }
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

compound_statement // Node*
	: LBRACE RBRACE { $$ = nullptr; }
	| LBRACE statement_list RBRACE
	| LBRACE declaration_list RBRACE { $$ = $2; }
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

expression // Node*
	: assignment_expression
	| expression COMMA assignment_expression
	;

assignment_expression // Node*
	: conditional_expression { $$ = $1; }
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

conditional_expression // Node*
	: logical_or_expression { $$ = $1; }
	| logical_or_expression HUH expression COLON conditional_expression
	;

constant_expression // Node*
	: conditional_expression { $$ = $1; }
	;

logical_or_expression // Node*
	: logical_and_expression { $$ = $1; }
	| logical_or_expression OR_OP logical_and_expression
	;

logical_and_expression // Node*
	: inclusive_or_expression { $$ = $1; }
	| logical_and_expression AND_OP inclusive_or_expression
	;

inclusive_or_expression // Node*
	: exclusive_or_expression { $$ = $1; }
	| inclusive_or_expression BOR exclusive_or_expression
	;

exclusive_or_expression // Node*
	: and_expression { $$ = $1; }
	| exclusive_or_expression BXOR and_expression
	;

and_expression // Node*
	: equality_expression { $$ = $1; }
	| and_expression BAND equality_expression
	;

equality_expression // Node*
	: relational_expression { $$ = $1; }
	| equality_expression EQ_OP relational_expression
	| equality_expression NE_OP relational_expression
	;

relational_expression // Node*
	: shift_expression { $$ = $1; }
	| relational_expression LTHAN shift_expression
	| relational_expression GTHAN shift_expression
	| relational_expression LE_OP shift_expression
	| relational_expression GE_OP shift_expression
	;

shift_expression // Node*
	: additive_expression { $$ = $1; }
	| shift_expression LEFT_OP additive_expression
	| shift_expression RIGHT_OP additive_expression
	;

additive_expression // Node*
	: multiplicative_expression { $$ = $1; }
	| additive_expression ADD multiplicative_expression
	| additive_expression SUB multiplicative_expression
	;

multiplicative_expression // Node*
	: cast_expression { $$ = $1; }
	| multiplicative_expression MULT cast_expression
	| multiplicative_expression DIV cast_expression
	| multiplicative_expression MOD cast_expression
	;

cast_expression // Node*
	: unary_expression { $$ = $1; }
	| LPAREN type_name RPAREN cast_expression
	;

unary_expression // Node*
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
	: IDENTIFIER {
		$$ = new IdentifierNode(yylval.sval);
		if(parseDLevel) {
			std::cout << "Found new identifier node: " << yylval.sval->name << std::endl;
		}
	}
	;

%%
