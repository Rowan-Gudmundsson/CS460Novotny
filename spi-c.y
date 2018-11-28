%{
	#include <cstdio>
	#include <iostream>
	#include <string>
	#include "errors.h"
	#include <cstdlib>

	#define YYDEBUG 1

	int yyerror(SyntaxNode*& root, char *s);
	int yylex(void);

	extern Symbol table;
	extern unsigned int parseDLevel;
	extern unsigned lineno;
	extern std::string currentLine;
	void throwWarning(const std::string& warning);
	using namespace std::string_literals;
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
	PointerNode* pval;
	TypeQualifier qval;
	std::vector<EvalType>* eList;
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

%type <eval> type_specifier declaration_specifiers storage_class_specifier specifier_qualifier_list type_name parameter_declaration
%type <oval> unary_operator assignment_operator
%type <nval> declarator multiplicative_expression additive_expression shift_expression relational_expression
%type <nval> equality_expression and_expression exclusive_or_expression inclusive_or_expression logical_and_expression logical_or_expression conditional_expression assignment_expression
%type <nval> direct_declarator constant primary_expression string expression identifier declaration declaration_list
%type <nval> postfix_expression unary_expression cast_expression initializer init_declarator init_declarator_list
%type <nval> compound_statement function_definition external_declaration translation_unit constant_expression expression_statement
%type <nval> statement statement_list labeled_statement selection_statement iteration_statement jump_statement argument_expression_list
%type <pval> pointer
%type <qval> type_qualifier_list type_qualifier
%type <eList> parameter_list parameter_type_list

%parse-param {SyntaxNode*& root}

%start translation_unit
%%

translation_unit // Node*
	: external_declaration {
		$$ = root = new SyntaxNode({0, ""}, SyntaxNode::Type::GENERIC, EUNKNOWN, 1, $1);
		if(parseDLevel) {
			std::cout << "Found Root Node: " << $1 << '\n';
		}
	}
	| translation_unit external_declaration {
		$$ = root = $1; $$->children.push_back($2);
		if(parseDLevel) {
			std::cout << "Found Root Node: " << $2 << '\n';
		}
	}
	;

external_declaration // Node*
	: function_definition { table.mode = Symbol::Mode::READ;  $$ = $1; }
	| declaration {
		// Actually there shouldn't be any code generated for a declaration
		$$ = nullptr;
		if($1 != nullptr) delete $1;
	}
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
		//$$ = new SyntaxNode(SyntaxNode::Type::FUNCTION, EUNKNOWN, 2, $2, $3);
		if($2->type == SyntaxNode::Type::FUNCTION) {
			$$ = new FunctionNode({$2->line, $2->source}, ((FunctionNode*) $2), $3);
			delete $2;
			((FunctionNode*)$$)->func->defined = true;
			((FunctionNode*)$$)->func->functionDefLine =  lineno;
		} else {
			std::cout << $2->type << " " << $2 << std::endl;
			throw std::logic_error("Function not found where it should be");
		}

		table.popBackToGlobal();

		if(parseDLevel) {
			std::cout << "Found function: \n"
			          << $2 << '\n' << $3 << '\n';
		}
	}
	| declaration_specifiers declarator declaration_list compound_statement
	;

declaration // Node*
	: declaration_specifiers SEMI {
		// Ignore this
		// TODO - come back to this maybe? No use AFAIK...
		$$ = nullptr;
	}
	| declaration_specifiers init_declarator_list SEMI {
		/*
		  TODO: Apply declaration specifiers
		  This should be fairly easy, we just need to traverse the tree until we find identifiers
		*/
		EvalType tmp_type = $1;
		if ((tmp_type & ELONG) && !(tmp_type & ECHAR || tmp_type & EDOUBLE)) {
			tmp_type = tmp_type | EINT;
		}
		if (tmp_type & ESHORT) {
			tmp_type = tmp_type | EINT;
		}
		for (auto i : $2->children) {
			if (i->type == SyntaxNode::Type::IDENTIFIER) {
				IdentifierNode* tmp = (IdentifierNode*)i;
				tmp->etype = tmp_type;
				tmp->sym->etype = tmp_type;
			} else if (i->type == SyntaxNode::Type::DECLARE_AND_INIT) {
				IdentifierNode* tmp = (IdentifierNode*)i->children[0];
				tmp->etype = tmp_type;
				tmp->sym->etype = tmp_type;
			} else if (i->type == SyntaxNode::Type::FUNCTION) {
				FunctionNode* tmp = (FunctionNode*)i;
				tmp->etype = tmp_type;
				tmp->func->returnType = tmp_type;
			} else {
				std::cout << "Found type: " << i->type << std::endl;
				throw ParserError("001: Expected type IDENTIFIER, FUNCTION, or DECLARE_AND_INIT");
			}
		}
		$$ = $2;
	}
	;

declaration_list // Node*
	: declaration {
		table.mode = Symbol::Mode::READ;
		$$ = new SyntaxNode({0, ""}, SyntaxNode::Type::GENERIC, EUNKNOWN, 1, $1);
		if(parseDLevel){
			std::cout << "declaration_list\n";
			std::cout << "GENERIC:\n"
			          << $1 << std::endl << std::endl;
		}
	}
	| declaration_list declaration {
		table.mode = Symbol::Mode::READ;
		$$ = $1;
		$1->children.push_back($2);
	}
	;

declaration_specifiers // EvalType
	: storage_class_specifier { $$ = $1; }
	| storage_class_specifier declaration_specifiers { $$ = $1 | $2; }
	| type_specifier { $$ = $1; }
	| type_specifier declaration_specifiers { $$ = $1 | $2; }
	| type_qualifier { $$ = EUNKNOWN; }
	| type_qualifier declaration_specifiers { $$ = EUNKNOWN; }
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
	| SIGNED { table.mode = Symbol::Mode::WRITE; $$ = EvalType(0); }
	| UNSIGNED { table.mode = Symbol::Mode::WRITE; $$ = EUNSIGNED; }
	| struct_or_union_specifier { /* TODO Acutally do this */ $$ = EVOID; }
	| enum_specifier { /* TODO Acutally do this */ $$ = EVOID; }
	| TYPEDEF_NAME { table.mode = Symbol::Mode::WRITE; /* TODO Acutally do this */ $$ = EVOID; }
	;

type_qualifier // TypeQualifier
	: CONST { $$ = TCONST; }
	| VOLATILE { $$ = TVOLATILE; }
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
		$$ = new SyntaxNode({0, ""}, SyntaxNode::Type::GENERIC, EUNKNOWN, 1, $1);
		if(parseDLevel){
			std::cout << "init_declarator_list\n"
			          << "GENERIC:\n"
			          << $1 << std::endl;
		}
	}
	| init_declarator_list COMMA init_declarator {
		$$ = $1;
		$1->children.push_back($3);
	}
	;

init_declarator // Node*
	: declarator {
		$$ = $1;
	}
	| declarator ASSIGN initializer {
		$$ = new SyntaxNode({lineno, currentLine}, SyntaxNode::Type::DECLARE_AND_INIT, EUNKNOWN, 2, $1, $3);
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
	| pointer direct_declarator {
		$$ = $2;
		if ($$->type == SyntaxNode::IDENTIFIER) {
			IdentifierNode* tmp = (IdentifierNode*)$$;
			tmp->sym->v.pointerLevel += $1->level;
		} else {
			throw "Error pointer";
		}
	}
	;

direct_declarator // IdentifierNode* (or FunctionNode*)
	: identifier { $$ = $1; }
	| LPAREN declarator RPAREN { /* Parentheses don't do anything...? */ $$ = $2; }
	| direct_declarator LBRACKET RBRACKET {
		$$ = $1;
		if($$->type == SyntaxNode::Type::IDENTIFIER) {
			IdentifierNode* node = (IdentifierNode*) $$;
			node->sym->itype = Symbol::SymbolType::VARIABLE;
			node->sym->v.isArray = true;
			node->sym->v.arrayDimensions.push_back(-1);

			// TODO Figure this shit out
			// node->children.push_back(new ArrayNode({lineno, currentLine}, EUNKNOWN, $1));


		} else {
			throw "Error 1";
		}
	}
	| direct_declarator LBRACKET constant_expression RBRACKET {
		$$ = $1;
		if($$->type == SyntaxNode::Type::IDENTIFIER) {
			IdentifierNode* node = (IdentifierNode*) $$;
			node->sym->itype = Symbol::SymbolType::VARIABLE;
			node->sym->v.isArray = true;
			try {
				node->sym->v.arrayDimensions.push_back(evalConst($3)->i);
			} catch(ParserError e) {
				std::cout << "Error in constant evaluation: " << e.what() << std::endl;
			}

			// TODO Figure this shit out
			// node->children.push_back(new ArrayNode({lineno, currentLine}, EUNKNOWN, $3));
		} else {
			throw "Error 2";
		}
	}
	| direct_declarator LPAREN RPAREN {
		if($$->type == SyntaxNode::Type::IDENTIFIER) {
			IdentifierNode* inode = (IdentifierNode*) $1;
			inode->sym->itype = Symbol::SymbolType::FUNCTION;

			FunctionNode* fnode = nullptr;

			// See if this function already exists
			for(auto& f : inode->sym->functions) {
				if(f.parameters.empty()) {
					fnode = new FunctionNode({lineno, currentLine}, inode, &f);
					break;
				}
			}

			if(fnode == nullptr) {
				// Found a new function
				Symbol::FunctionType f;
				inode->sym->functions.push_back(f);
				fnode = new FunctionNode({lineno, currentLine}, inode, &inode->sym->functions.back());
			}

			$$ = fnode;
			// TODO - set paramters
		} else {
			throw "Error 3";
		}
	}
	// Passing up a FunctionNode* here, but since it inherits from IdentifierNode, we're good
	// Probably
	| direct_declarator LPAREN parameter_type_list RPAREN {
		if($$->type == SyntaxNode::Type::IDENTIFIER) {
			table.unPopScope();
			IdentifierNode* inode = (IdentifierNode*) $1;
			inode->sym->itype = Symbol::SymbolType::FUNCTION;

			FunctionNode* fnode = nullptr;

			// See if this function already exists
			for(auto& f : inode->sym->functions) {
				if(f.parameters == *$3) {
					fnode = new FunctionNode({lineno, currentLine}, inode, &f);
					break;
				}
			}

			if(fnode == nullptr) {
				// Found a new function
				Symbol::FunctionType f;
				f.parameters = *$3;
				inode->sym->functions.push_back(f);
				fnode = new FunctionNode({lineno, currentLine}, inode, &inode->sym->functions.back());
			}

			$$ = fnode;
			// TODO - set paramters
		} else {
			throw "Error 4";
		}
	}
	| direct_declarator LPAREN identifier_list RPAREN {
		/* Ignore this, it won't be a feature of our language */
		$$ = nullptr;
	}
	;

pointer // PointerNode
	: MULT { $$ = new PointerNode(); $$->level++; }
	| MULT type_qualifier_list { $$ = new PointerNode(); $$->level++; $$->qualifier = $2; }
	| MULT pointer { $$ = $2; $$->level++; }
	| MULT type_qualifier_list pointer { $$ = $3; $$->level++; $$->qualifier = $2; }
	;

type_qualifier_list // TypeQualifier
	: type_qualifier { $$ = $1; }
	| type_qualifier_list type_qualifier { $$ = $1 | $2; }
	;

parameter_type_list // std::vector<EvalType>*
	: parameter_list { $$ = $1; table.mode = Symbol::Mode::READ; }
	| parameter_list COMMA ELIPSIS { throw "We ain't dealing with this shit"; table.mode = Symbol::Mode::READ; }
	;

parameter_list // std::vector<EvalType>*
	: parameter_declaration {
		// std::cout << "The thing happened" << std::endl;
		$$ = new std::vector<EvalType>();
		$$->push_back($1);
	}
	| parameter_list COMMA parameter_declaration {
		$$ = $1;
		$$->push_back($3);
	}
	;

// We only need to pass the types up the tree, for prototype matching
parameter_declaration // EvalType
	: declaration_specifiers declarator {
		((IdentifierNode*) $2)->sym->etype = $1;
		$$ = $1;
	}
	| declaration_specifiers {
		$$ = $1;
	}
	| declaration_specifiers abstract_declarator {/* TODO: WTF is abstract */ throw "ahhhhhhhh"; }
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

statement // Node*
	: labeled_statement { $$ = nullptr; /* TODO */ }
	| compound_statement { $$ = $1; }
	| expression_statement { $$ = $1; }
	| selection_statement { $$ = $1; }
	| iteration_statement { $$ = $1; }
	| jump_statement { $$ = nullptr; /* TODO */ }
	;

labeled_statement // Node*
	: identifier COLON statement
	| CASE constant_expression COLON statement
	| DEFAULT COLON statement
	;

expression_statement // Node*
	: SEMI { $$ = nullptr; }
	| expression SEMI { $$ = $1; }
	;

compound_statement // Node*
	: LBRACE RBRACE { $$ = nullptr; }
	| LBRACE statement_list RBRACE { $$ = $2; }
	| LBRACE declaration_list RBRACE { $$ = $2; }
	| LBRACE declaration_list statement_list RBRACE { $$ = new SyntaxNode({0, ""}, SyntaxNode::Type::GENERIC, EUNKNOWN, 2, $2, $3); }
	;

statement_list // Node*
	: statement { $$ = new SyntaxNode({0, ""}, SyntaxNode::Type::GENERIC, EUNKNOWN, 1, $1); }
	| statement_list statement { $$ = $1; $$->children.push_back($2); }
	;

selection_statement // Node*
	: IF LPAREN expression RPAREN statement { $$ = new SyntaxNode({lineno, currentLine}, SyntaxNode::Type::CONDITIONAL, EVOID, 2, $3, $5); }
	| IF LPAREN expression RPAREN statement ELSE statement { $$ = new SyntaxNode({lineno, currentLine}, SyntaxNode::Type::CONDITIONAL, EVOID, 3, $3, $5, $7); }
	| SWITCH LPAREN expression RPAREN statement { $$ = nullptr; /* TODO: Switch Statements */ }
	;

iteration_statement // Node*
	: WHILE LPAREN expression RPAREN statement { $$ = new LoopNode({lineno, currentLine}, $3, $5); }
	| DO statement WHILE LPAREN expression RPAREN SEMI { $$ = new LoopNode({lineno, currentLine}, $5, $2, false); }
	| FOR LPAREN SEMI SEMI RPAREN statement { $$ = new LoopNode({lineno, currentLine}, nullptr, nullptr, nullptr, $6); }
	| FOR LPAREN SEMI SEMI expression RPAREN statement { $$ = new LoopNode({lineno, currentLine}, nullptr, nullptr, $5, $7); }
	| FOR LPAREN SEMI expression SEMI RPAREN statement { $$ = new LoopNode({lineno, currentLine}, nullptr, $4, nullptr, $7); }
	| FOR LPAREN SEMI expression SEMI expression RPAREN statement { $$ = new LoopNode({lineno, currentLine}, nullptr, $4, $6, $8); }
	| FOR LPAREN expression SEMI SEMI RPAREN statement { $$ = new LoopNode({lineno, currentLine}, $3, nullptr, nullptr, $7); }
	| FOR LPAREN expression SEMI SEMI expression RPAREN statement { $$ = new LoopNode({lineno, currentLine}, $3, nullptr, $6, $8); }
	| FOR LPAREN expression SEMI expression SEMI RPAREN statement { $$ = new LoopNode({lineno, currentLine}, $3, $5, nullptr, $8); }
	| FOR LPAREN expression SEMI expression SEMI expression RPAREN statement { $$ = new LoopNode({lineno, currentLine}, $3, $5, $7, $9); }
	;

jump_statement // Node*
	: GOTO identifier SEMI
	| CONTINUE SEMI
	| BREAK SEMI
	| RETURN SEMI
	| RETURN expression SEMI
	;

expression // Node*
	: assignment_expression {
		/*$$ = new SyntaxNode(SyntaxNode::Type::GENERIC, EUNKNOWN, 1, $1);
		if(parseDLevel > 0) {
			std::cout << "expression\n"
			          << "GENERIC\n"
			          << $1 << std::endl;
		}*/
		$$ = $1;
	}
	| expression COMMA assignment_expression { $$ = $1; $$->children.push_back($3); }
	;

assignment_expression // Node*
	: conditional_expression { $$ = $1; }
	| unary_expression assignment_operator assignment_expression {
		bool shouldCoerce = $1->etype != $3->etype;
		EvalType from, to;
		if (shouldCoerce) {
			from = $3->etype;
			to = $1->etype;
		}
		if($2 == OperatorNode::OpType::OTERNARY) {
			if (shouldCoerce) {
				CoercionNode* coerce = new CoercionNode({lineno, currentLine}, from, to, $3);
				$$ = new SyntaxNode({lineno, currentLine}, SyntaxNode::Type::ASSIGN, $1->etype, 2, $1, coerce);
			} else {
				$$ = new SyntaxNode({lineno, currentLine}, SyntaxNode::Type::ASSIGN, $1->etype, 2, $1, $3);
			}
		} else {
			// TODO - the left side might not be strictly an IdentifierNode?
			if($1->type == SyntaxNode::Type::IDENTIFIER) {
				OperatorNode* temp = new OperatorNode({lineno, currentLine}, to, $2, 2, new IdentifierNode({lineno, currentLine}, ((IdentifierNode*) $1)->sym), $3);
				if (shouldCoerce) {
					CoercionNode* coerce = new CoercionNode({lineno, currentLine}, from, to, temp);
					$$ = new SyntaxNode({lineno, currentLine}, SyntaxNode::Type::ASSIGN, to, 2, $1, coerce);
				} else {
					$$ = new SyntaxNode({lineno, currentLine}, SyntaxNode::Type::ASSIGN, to, 2, $1, temp);
				}
			} else {
				throw "Gotta get that working";
			}
		}
	}
	;

assignment_operator // OperatorNode::OpType
	: ASSIGN { $$ = OperatorNode::OpType::OTERNARY; }
	| MUL_ASSIGN { $$ = OperatorNode::OpType::OMULT; }
	| DIV_ASSIGN { $$ = OperatorNode::OpType::ODIV; }
	| MOD_ASSIGN { $$ = OperatorNode::OpType::OMOD; }
	| ADD_ASSIGN { $$ = OperatorNode::OpType::OADD; }
	| SUB_ASSIGN { $$ = OperatorNode::OpType::OSUB; }
	| LEFT_ASSIGN { $$ = OperatorNode::OpType::OLSHIFT; }
	| RIGHT_ASSIGN { $$ = OperatorNode::OpType::ORSHIFT; }
	| AND_ASSIGN { $$ = OperatorNode::OpType::OBAND; }
	| XOR_ASSIGN { $$ = OperatorNode::OpType::OBXOR; }
	| OR_ASSIGN { $$ = OperatorNode::OpType::OBOR; }
	;

conditional_expression // Node*
	: logical_or_expression { $$ = $1; }
	| logical_or_expression HUH expression COLON conditional_expression {
		$$ = new OperatorNode({lineno, currentLine}, EINT, OperatorNode::OpType::OTERNARY, 3, $1, $3, $5);
	}
	;

constant_expression // Node*
	: conditional_expression { $$ = $1; }
	;

logical_or_expression // Node*
	: logical_and_expression { $$ = $1; }
	| logical_or_expression OR_OP logical_and_expression {
		if ($1->etype != $3->etype) {
			auto a = precedence.find($1->etype);
			auto b = precedence.find($3->etype);
			if (a == precedence.end() || b == precedence.end()) {
				throw ParserError("Cannot perform operation '||' on non primative types.");
			}
			if (a->second > b->second) {
				$$ = new OperatorNode({lineno, currentLine}, EINT, OperatorNode::OpType::OLOR, 2, $1, new CoercionNode({lineno, currentLine}, b->first, a->first, $3));
			} else {
				$$ = new OperatorNode({lineno, currentLine}, EINT, OperatorNode::OpType::OLOR, 2, new CoercionNode({lineno, currentLine}, a->first, b->first, $1), $3);
			}
		} else {
			$$ = new OperatorNode({lineno, currentLine}, EINT, OperatorNode::OpType::OLOR, 2, $1, $3);
		}
	}
	;

logical_and_expression // Node*
	: inclusive_or_expression { $$ = $1; }
	| logical_and_expression AND_OP inclusive_or_expression {
		if ($1->etype != $3->etype) {
			auto a = precedence.find($1->etype);
			auto b = precedence.find($3->etype);
			if (a == precedence.end() || b == precedence.end()) {
				throw ParserError("Cannot perform operation '&&' on non primative types.");
			}
			if (a->second > b->second) {
				$$ = new OperatorNode({lineno, currentLine}, EINT, OperatorNode::OpType::OLAND, 2, $1, new CoercionNode({lineno, currentLine}, b->first, a->first, $3));
			} else {
				$$ = new OperatorNode({lineno, currentLine}, EINT, OperatorNode::OpType::OLAND, 2, new CoercionNode({lineno, currentLine}, a->first, b->first, $1), $3);
			}
		} else {
			$$ = new OperatorNode({lineno, currentLine}, EINT, OperatorNode::OpType::OLAND, 2, $1, $3);
		}
	}
	;

inclusive_or_expression // Node*
	: exclusive_or_expression { $$ = $1; }
	| inclusive_or_expression BOR exclusive_or_expression {
		if (!($1->etype & EINT) || !($3->etype & EINT)) {
			throw ParserError("Cannot perform operation '|' on non integral types.");
		}
		if ($1->etype != $3->etype) {
			auto a = precedence.find($1->etype);
			auto b = precedence.find($3->etype);
			if (a == precedence.end() || b == precedence.end()) {
				throw ParserError("Cannot perform operation '|' on non primative types.");
			}
			if (a->second > b->second) {
				$$ = new OperatorNode({lineno, currentLine}, a->first, OperatorNode::OpType::OBOR, 2, $1, new CoercionNode({lineno, currentLine}, b->first, a->first, $3));
			} else {
				$$ = new OperatorNode({lineno, currentLine}, b->first, OperatorNode::OpType::OBOR, 2, new CoercionNode({lineno, currentLine}, a->first, b->first, $1), $3);
			}
		} else {
			$$ = new OperatorNode({lineno, currentLine}, $1->etype, OperatorNode::OpType::OBOR, 2, $1, $3);
		}
	}
	;

exclusive_or_expression // Node*
	: and_expression { $$ = $1; }
	| exclusive_or_expression BXOR and_expression {
		if (!($1->etype & EINT) || !($3->etype & EINT)) {
			throw ParserError("Cannot perform operation '^' on non integral types.");
		}
		if ($1->etype != $3->etype) {
			auto a = precedence.find($1->etype);
			auto b = precedence.find($3->etype);
			if (a == precedence.end() || b == precedence.end()) {
				throw ParserError("Cannot perform operation '^' on non primative types.");
			}
			if (a->second > b->second) {
				$$ = new OperatorNode({lineno, currentLine}, a->first, OperatorNode::OpType::OBXOR, 2, $1, new CoercionNode({lineno, currentLine}, b->first, a->first, $3));
			} else {
				$$ = new OperatorNode({lineno, currentLine}, b->first, OperatorNode::OpType::OBXOR, 2, new CoercionNode({lineno, currentLine}, a->first, b->first, $1), $3);
			}
		} else {
			$$ = new OperatorNode({lineno, currentLine}, $1->etype, OperatorNode::OpType::OBXOR, 2, $1, $3);
		}
	}
	;

and_expression // Node*
	: equality_expression { $$ = $1; }
	| and_expression BAND equality_expression {
		if (!($1->etype & EINT) || !($3->etype & EINT)) {
			throw ParserError("Cannot perform operation '&' on non integral types.");
		}
		if ($1->etype != $3->etype) {
			auto a = precedence.find($1->etype);
			auto b = precedence.find($3->etype);
			if (a == precedence.end() || b == precedence.end()) {
				throw ParserError("Cannot perform operation '&' on non primative types.");
			}
			if (a->second > b->second) {
				$$ = new OperatorNode({lineno, currentLine}, a->first, OperatorNode::OpType::OBAND, 2, $1, new CoercionNode({lineno, currentLine}, b->first, a->first, $3));
			} else {
				$$ = new OperatorNode({lineno, currentLine}, b->first, OperatorNode::OpType::OBAND, 2, new CoercionNode({lineno, currentLine}, a->first, b->first, $1), $3);
			}
		} else {
			$$ = new OperatorNode({lineno, currentLine}, $1->etype, OperatorNode::OpType::OBAND, 2, $1, $3);
		}
	}
	;

equality_expression // Node*
	: relational_expression { $$ = $1; }
	| equality_expression EQ_OP relational_expression {
		if ($1->etype != $3->etype) {
			auto a = precedence.find($1->etype);
			auto b = precedence.find($3->etype);
			if (a == precedence.end() || b == precedence.end()) {
				throw ParserError("Cannot perform operation '==' on non primative types.");
			}
			if (a->second > b->second) {
				$$ = new OperatorNode({lineno, currentLine}, EINT, OperatorNode::OpType::OEQUAL, 2, $1, new CoercionNode({lineno, currentLine}, b->first, a->first, $3));
			} else {
				$$ = new OperatorNode({lineno, currentLine}, EINT, OperatorNode::OpType::OEQUAL, 2, new CoercionNode({lineno, currentLine}, a->first, b->first, $1), $3);
			}
		} else {
			$$ = new OperatorNode({lineno, currentLine}, EINT, OperatorNode::OpType::OEQUAL, 2, $1, $3);
		}
	}
	| equality_expression NE_OP relational_expression {
		if ($1->etype != $3->etype) {
			auto a = precedence.find($1->etype);
			auto b = precedence.find($3->etype);
			if (a == precedence.end() || b == precedence.end()) {
				throw ParserError("Cannot perform operation '!=' on non primative types.");
			}
			if (a->second > b->second) {
				$$ = new OperatorNode({lineno, currentLine}, EINT, OperatorNode::OpType::ONEQ, 2, $1, new CoercionNode({lineno, currentLine}, b->first, a->first, $3));
			} else {
				$$ = new OperatorNode({lineno, currentLine}, EINT, OperatorNode::OpType::ONEQ, 2, new CoercionNode({lineno, currentLine}, a->first, b->first, $1), $3);
			}
		} else {
			$$ = new OperatorNode({lineno, currentLine}, EINT, OperatorNode::OpType::ONEQ, 2, $1, $3);
		}
	}
	;

relational_expression // Node*
	: shift_expression { $$ = $1; }
	| relational_expression LTHAN shift_expression {
		if ($1->etype != $3->etype) {
			auto a = precedence.find($1->etype);
			auto b = precedence.find($3->etype);
			if (a == precedence.end() || b == precedence.end()) {
				throw ParserError("Cannot perform operation '<' on non primative types.");
			}
			if (a->second > b->second) {
				$$ = new OperatorNode({lineno, currentLine}, EINT, OperatorNode::OpType::OLESS, 2, $1, new CoercionNode({lineno, currentLine}, b->first, a->first, $3));
			} else {
				$$ = new OperatorNode({lineno, currentLine}, EINT, OperatorNode::OpType::OLESS, 2, new CoercionNode({lineno, currentLine}, a->first, b->first, $1), $3);
			}
		} else {
			$$ = new OperatorNode({lineno, currentLine}, EINT, OperatorNode::OpType::OLESS, 2, $1, $3);
		}
	}
	| relational_expression GTHAN shift_expression {
		if ($1->etype != $3->etype) {
			auto a = precedence.find($1->etype);
			auto b = precedence.find($3->etype);
			if (a == precedence.end() || b == precedence.end()) {
				throw ParserError("Cannot perform operation '>' on non primative types.");
			}
			if (a->second > b->second) {
				$$ = new OperatorNode({lineno, currentLine}, a->first, OperatorNode::OpType::OGREAT, 2, $1, new CoercionNode({lineno, currentLine}, b->first, a->first, $3));
			} else {
				$$ = new OperatorNode({lineno, currentLine}, b->first, OperatorNode::OpType::OGREAT, 2, new CoercionNode({lineno, currentLine}, a->first, b->first, $1), $3);
			}
		} else {
			$$ = new OperatorNode({lineno, currentLine}, $1->etype, OperatorNode::OpType::OGREAT, 2, $1, $3);
		}
	}
	| relational_expression LE_OP shift_expression {
		if ($1->etype != $3->etype) {
			auto a = precedence.find($1->etype);
			auto b = precedence.find($3->etype);
			if (a == precedence.end() || b == precedence.end()) {
				throw ParserError("Cannot perform operation '<=' on non primative types.");
			}
			if (a->second > b->second) {
				$$ = new OperatorNode({lineno, currentLine}, a->first, OperatorNode::OpType::OLEQ, 2, $1, new CoercionNode({lineno, currentLine}, b->first, a->first, $3));
			} else {
				$$ = new OperatorNode({lineno, currentLine}, b->first, OperatorNode::OpType::OLEQ, 2, new CoercionNode({lineno, currentLine}, a->first, b->first, $1), $3);
			}
		} else {
			$$ = new OperatorNode({lineno, currentLine}, $1->etype, OperatorNode::OpType::OLEQ, 2, $1, $3);
		}
	}
	| relational_expression GE_OP shift_expression {
		if ($1->etype != $3->etype) {
			auto a = precedence.find($1->etype);
			auto b = precedence.find($3->etype);
			if (a == precedence.end() || b == precedence.end()) {
				throw ParserError("Cannot perform operation '>=' on non primative types.");
			}
			if (a->second > b->second) {
				$$ = new OperatorNode({lineno, currentLine}, a->first, OperatorNode::OpType::OGEQ, 2, $1, new CoercionNode({lineno, currentLine}, b->first, a->first, $3));
			} else {
				$$ = new OperatorNode({lineno, currentLine}, b->first, OperatorNode::OpType::OGEQ, 2, new CoercionNode({lineno, currentLine}, a->first, b->first, $1), $3);
			}
		} else {
			$$ = new OperatorNode({lineno, currentLine}, $1->etype, OperatorNode::OpType::OGEQ, 2, $1, $3);
		}
	}
	;

shift_expression // Node*
	: additive_expression { $$ = $1; }
	| shift_expression LEFT_OP additive_expression {
		if (!($1->etype & EINT) || !($3->etype & EINT)) {
			throw ParserError("Operator '<<' not valid on non integral types.");
		}
		if ($1->etype != $3->etype) {
			auto a = precedence.find($1->etype);
			auto b = precedence.find($3->etype);
			if (a == precedence.end() || b == precedence.end()) {
				throw ParserError("Cannot perform operation '<<' on non primative types.");
			}
			if (a->second > b->second) {
				$$ = new OperatorNode({lineno, currentLine}, a->first, OperatorNode::OpType::OLSHIFT, 2, $1, new CoercionNode({lineno, currentLine}, b->first, a->first, $3));
			} else {
				$$ = new OperatorNode({lineno, currentLine}, b->first, OperatorNode::OpType::OLSHIFT, 2, new CoercionNode({lineno, currentLine}, a->first, b->first, $1), $3);
			}
		} else {
			$$ = new OperatorNode({lineno, currentLine}, $1->etype, OperatorNode::OpType::OLSHIFT, 2, $1, $3);
		}
	}
	| shift_expression RIGHT_OP additive_expression {
		if (!($1->etype & EINT) || !($3->etype & EINT)) {
			throw ParserError("Operator '>>' not valid on non integral types.");
		}
		if ($1->etype != $3->etype) {
			auto a = precedence.find($1->etype);
			auto b = precedence.find($3->etype);
			if (a == precedence.end() || b == precedence.end()) {
				throw ParserError("Cannot perform operation '>>' on non primative types.");
			}
			if (a->second > b->second) {
				$$ = new OperatorNode({lineno, currentLine}, a->first, OperatorNode::OpType::ORSHIFT, 2, $1, new CoercionNode({lineno, currentLine}, b->first, a->first, $3));
			} else {
				$$ = new OperatorNode({lineno, currentLine}, b->first, OperatorNode::OpType::ORSHIFT, 2, new CoercionNode({lineno, currentLine}, a->first, b->first, $1), $3);
			}
		} else {
			$$ = new OperatorNode({lineno, currentLine}, $1->etype, OperatorNode::OpType::ORSHIFT, 2, $1, $3);
		}
	}
	;

additive_expression // Node*
	: multiplicative_expression { $$ = $1; }
	| additive_expression ADD multiplicative_expression {
		if ($1->etype != $3->etype) {
			auto a = precedence.find($1->etype);
			auto b = precedence.find($3->etype);
			if (a == precedence.end() || b == precedence.end()) {
				throw ParserError("Cannot perform operation '+' on non primative types.");
			}
			if (a->second > b->second) {
				$$ = new OperatorNode({lineno, currentLine}, a->first, OperatorNode::OpType::OADD, 2, $1, new CoercionNode({lineno, currentLine}, b->first, a->first, $3));
			} else {
				$$ = new OperatorNode({lineno, currentLine}, b->first, OperatorNode::OpType::OADD, 2, new CoercionNode({lineno, currentLine}, a->first, b->first, $1), $3);
			}
		} else {
			$$ = new OperatorNode({lineno, currentLine}, $1->etype, OperatorNode::OpType::OADD, 2, $1, $3);
		}
	}
	| additive_expression SUB multiplicative_expression {
		if ($1->etype != $3->etype) {
			auto a = precedence.find($1->etype);
			auto b = precedence.find($3->etype);
			if (a == precedence.end() || b == precedence.end()) {
				throw ParserError("Cannot perform operation '-' on non primative types.");
			}
			if (a->second > b->second) {
				$$ = new OperatorNode({lineno, currentLine}, a->first, OperatorNode::OpType::OSUB, 2, $1, new CoercionNode({lineno, currentLine}, b->first, a->first, $3));
			} else {
				$$ = new OperatorNode({lineno, currentLine}, b->first, OperatorNode::OpType::OSUB, 2, new CoercionNode({lineno, currentLine}, a->first, b->first, $1), $3);
			}
		} else {
			$$ = new OperatorNode({lineno, currentLine}, $1->etype, OperatorNode::OpType::OSUB, 2, $1, $3);
		}
	}
	;

multiplicative_expression // Node*
	: cast_expression { $$ = $1; }
	| multiplicative_expression MULT cast_expression {
		if ($1->etype != $3->etype) {
			auto a = precedence.find($1->etype);
			auto b = precedence.find($3->etype);
			if (a == precedence.end() || b == precedence.end()) {
				throw ParserError("Cannot perform operation '*' on non primative types.");
			}
			if (a->second > b->second) {
				$$ = new OperatorNode({lineno, currentLine}, a->first, OperatorNode::OpType::OMULT, 2, $1, new CoercionNode({lineno, currentLine}, b->first, a->first, $3));
			} else {
				$$ = new OperatorNode({lineno, currentLine}, b->first, OperatorNode::OpType::OMULT, 2, new CoercionNode({lineno, currentLine}, a->first, b->first, $1), $3);
			}
		} else {
			$$ = new OperatorNode({lineno, currentLine}, $1->etype, OperatorNode::OpType::OMULT, 2, $1, $3);
		}
	}
	| multiplicative_expression DIV cast_expression {
		if ($1->etype != $3->etype) {
			auto a = precedence.find($1->etype);
			auto b = precedence.find($3->etype);
			if (a == precedence.end() || b == precedence.end()) {
				throw ParserError("Cannot perform operation '/' on non primative types.");
			}
			if (a->second > b->second) {
				$$ = new OperatorNode({lineno, currentLine}, a->first, OperatorNode::OpType::ODIV, 2, $1, new CoercionNode({lineno, currentLine}, b->first, a->first, $3));
			} else {
				$$ = new OperatorNode({lineno, currentLine}, b->first, OperatorNode::OpType::ODIV, 2, new CoercionNode({lineno, currentLine}, a->first, b->first, $1), $3);
			}
		} else {
			$$ = new OperatorNode({lineno, currentLine}, $1->etype, OperatorNode::OpType::ODIV, 2, $1, $3);
		}
	}
	| multiplicative_expression MOD cast_expression {
		if (!($1->etype & EINT || $1->etype & ECHAR) || !($3->etype & EINT || $3->etype & ECHAR)) {
			throw ParserError("Operator '%' not valid on non integral types.");
		}
		if ($1->etype != $3->etype) {
			auto a = precedence.find($1->etype);
			auto b = precedence.find($3->etype);
			if (a == precedence.end() || b == precedence.end()) {
				throw ParserError("Cannot perform operation '%' on non primative types.");
			}
			if (a->second > b->second) {
				$$ = new OperatorNode({lineno, currentLine}, a->first, OperatorNode::OpType::OMOD, 2, $1, new CoercionNode({lineno, currentLine}, b->first, a->first, $3));
			} else {
				$$ = new OperatorNode({lineno, currentLine}, b->first, OperatorNode::OpType::OMOD, 2, new CoercionNode({lineno, currentLine}, a->first, b->first, $1), $3);
			}
		} else {
			$$ = new OperatorNode({lineno, currentLine}, $1->etype, OperatorNode::OpType::OMOD, 2, $1, $3);
		}
	}
	;

cast_expression // Node*
	: unary_expression { $$ = $1; }
	| LPAREN type_name RPAREN cast_expression { $$ = new CoercionNode({lineno, currentLine}, $4->etype, $2, $4); }
	;

unary_expression // Node*
	: postfix_expression { $$ = $1; }
	| INC_OP unary_expression { $$ = new OperatorNode({lineno, currentLine}, $2->etype, OperatorNode::OINC, 1, $2); }
	| DEC_OP unary_expression { $$ = new OperatorNode({lineno, currentLine}, $2->etype, OperatorNode::ODEC, 1, $2); }
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
				break;
			default:
				break;
		}
		$$ = new OperatorNode({lineno, currentLine}, _type, $1, 1, $2);
	}
	| SIZEOF unary_expression { $$ = new OperatorNode({lineno, currentLine}, EINT | EUNSIGNED, OperatorNode::OSIZE, 1, $2); }
	| SIZEOF LPAREN type_name RPAREN { $$ = new OperatorNode({lineno, currentLine}, EINT | EUNSIGNED, OperatorNode::OSIZE, 1, $3); }
	;

unary_operator // OperatorNode::OpType
	: BAND { $$ = OperatorNode::OBAND; }
	| MULT { $$ = OperatorNode::OMULT; }
	| ADD { /* https://docs.microsoft.com/en-us/cpp/c-language/unary-arithmetic-operators?view=vs-2017 */ $$ = OperatorNode::OADD; }
	| SUB { $$ = OperatorNode::OSUB; }
	| BNOT { $$ = OperatorNode::OBNOT; }
	| LNOT { $$ = OperatorNode::OLNOT; }
	;

postfix_expression // Node*
	: primary_expression { $$ = $1; }
	| postfix_expression LBRACKET expression RBRACKET { $$ = new SyntaxNode({lineno, currentLine}, SyntaxNode::ACCESS, EUNKNOWN, 2, $1, $3); }
	| postfix_expression LPAREN RPAREN {
		if ($1->type != SyntaxNode::Type::IDENTIFIER) {
			throw ParserError("002: Expected type IDENTIFIER.");
		}
		IdentifierNode* tmp = (IdentifierNode*)$1;
		$$ = nullptr;
		for (auto& f : tmp->sym->functions) {
			if (f.parameters.empty()) {
				$$ = new FunctionCallNode({lineno, currentLine}, tmp->sym, &f);
				((FunctionCallNode*)$$)->callParameters.clear();
			}
		}
		if ($$ == nullptr) {
			throw ParserError("No matching function to call.");
		}
	}
	| postfix_expression LPAREN argument_expression_list RPAREN {
		if ($1->type != SyntaxNode::Type::IDENTIFIER) {
			throw ParserError("003: Expected type IDENTIFIER.");
		}
		IdentifierNode* tmp = (IdentifierNode*)$1;
		$$ = nullptr;
		std::vector<EvalType> paramTypes;
		for (auto i : $3->children) {
			paramTypes.push_back(i->etype);
		}
		
		for (auto& f : tmp->sym->functions) {
			if (f.parameters == paramTypes) {
				$$ = new FunctionCallNode({lineno, currentLine}, tmp->sym, &f);
			}
		}
		if ($$ == nullptr) {
			throw ParserError("No matching function to call.");
		}
		FunctionCallNode* function = (FunctionCallNode*)$$;
		for (auto i : $3->children) {
			function->callParameters.push_back(i);
		}
	}
	| postfix_expression PERIOD identifier { /* TODO(Rowan) -- Fix later */ $$ = nullptr; }
	| postfix_expression PTR_OP identifier { /* TODO(Rowan) -- Fix later */ $$ = nullptr; }
	| postfix_expression INC_OP { $$ = new OperatorNode({lineno, currentLine}, $1->etype, OperatorNode::OINCPOST, 1, $1); }
	| postfix_expression DEC_OP { $$ = new OperatorNode({lineno, currentLine}, $1->etype, OperatorNode::ODECPOST, 1, $1); }
	;

primary_expression // Node*
	: identifier { $$ = $1; }
	| constant { $$ = $1; }
	| string { $$ = $1; }
	| LPAREN expression RPAREN { $$ = $2; }
	;

argument_expression_list // Node*
	: assignment_expression { $$ = new SyntaxNode({0, ""}, SyntaxNode::Type::GENERIC, EUNKNOWN, 1, $1); }
	| argument_expression_list COMMA assignment_expression { $$ = $1; $$->children.push_back($3); }
	;

constant
	: INTEGER_CONSTANT { $$ = new ConstantNode({lineno, currentLine}, EINT, yylval.ival); }
	| CHARACTER_CONSTANT { $$ = new ConstantNode({lineno, currentLine}, ECHAR, (long int)(yylval.cval)); }
	| FLOATING_CONSTANT { $$ = new ConstantNode({lineno, currentLine}, EFLOAT, yylval.fval); }
	| ENUMERATION_CONSTANT { /* TODO(Rowan) -- Fix later. */ $$ = nullptr; }
	;

string
	: STRING_LITERAL { $$ = new ConstantNode({lineno, currentLine}, ECHAR | EPOINTER, yylval.strval); }
	;

identifier
	: IDENTIFIER {
		$$ = new IdentifierNode({lineno, currentLine}, yylval.sval);
		if(parseDLevel) {
			std::cout << "Found new identifier node: " << yylval.sval->name << std::endl;
		}
	}
	;

%%
