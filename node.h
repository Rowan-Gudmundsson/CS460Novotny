#pragma once

#include <cstdarg>
#include <iostream>
#include <iomanip>
#include "symbol.h"
#include "errors.h"

extern unsigned lineno;
extern unsigned column;

struct PointerNode {
	PointerNode() { level = 0; qualifier = TNONE; }
	unsigned level;
	TypeQualifier qualifier;
};

struct Operand {
	std::string type;
	std::string value;

	Operand() {}
	Operand(const std::string& typ) : type(typ) {}
	Operand(const std::string& typ, const std::string& valu) : type(typ), value(valu) {}
	Operand(const std::string& typ, int valu) : type(typ), value(std::to_string(valu)) {}
	Operand(const std::string& typ, unsigned valu) : type(typ), value(std::to_string(valu)) {}
	Operand(const std::string& typ, double valu) : type(typ), value(std::to_string(valu)) {}
};

struct ThreeAddress {
	std::string op;
	Operand op1;
	Operand op2;
	Operand dest;
	std::string source;

	ThreeAddress(const std::string& src) : source(src) {}
	ThreeAddress(const std::string& src, const std::string& o) : op(o), source(src) {}
	ThreeAddress(const std::string& src, const std::string& o, const Operand& o1) : op(o), op1(o1), source(src) {}
	ThreeAddress(const std::string& src, const std::string& o, const Operand& o1, const Operand& d) : op(o), op1(o1), dest(d), source(src) {}
	ThreeAddress(const std::string& src, const std::string& o, const Operand& o1, const Operand& o2, const Operand& d) : op(o), op1(o1), op2(o2), dest(d), source(src) {}
};

std::ostream& operator<<(std::ostream& out, const ThreeAddress& ins);
std::ostream& operator<<(std::ostream& out, const Operand& op);

struct Source {
	unsigned line;
	const std::string& source;

	Source(unsigned l, const std::string& s) : line(l), source(s) {}
};

class SyntaxNode {
	public:
		const enum Type {
			GENERIC, // For a node which only holds other nodes
			IDENTIFIER,
			CONSTANT,
			OPERATOR,
			DECLARE_AND_INIT,
			FUNCTION, // Function definition/declaration ONLY - not call
			FUNCTION_CALL,
			ASSIGN,
			CONDITIONAL,
			ARRAY,
			ACCESS,
			LOOP,
			COERCION
		} type;
		EvalType etype;
		const unsigned line;
		const std::string source;

		// TODO: Consider boolean 'constant' which checks whether or not this node can be evaluated at compile time ?
		bool isConst = false;
		std::vector<SyntaxNode*> children;

		SyntaxNode(const Source& s, Type type, EvalType etype, unsigned numChildren...);

		// Semanticly check the node
		// Make certain data types line up, smash unneeded nodes, etc.
		virtual void semanticCheck();
		virtual Operand gen3AC(std::vector<ThreeAddress>& instructions, unsigned& tempTicker, unsigned& labelTicker);

		virtual void clear();

		virtual ~SyntaxNode() {}
};

class CoercionNode : public SyntaxNode {
	public:
		CoercionNode(const Source& s, EvalType _from, EvalType _to, SyntaxNode* child) : SyntaxNode(s, COERCION, _to, 1, child), from(_from), to(_to) {}
		EvalType from, to;

		Operand gen3AC(std::vector<ThreeAddress>& instructions, unsigned& tempTicker, unsigned& labelTicker);
};

class ConstantNode : public SyntaxNode {
	public:
		ConstantNode(const Source& s, EvalType _type, double _f) : SyntaxNode(s, CONSTANT, _type, 0), f(_f) { isConst = true; }
		ConstantNode(const Source& s, EvalType _type, long int _i) : SyntaxNode(s, CONSTANT, _type, 0), i(_i) { isConst = true; }
		ConstantNode(const Source& s, EvalType _type, std::string* _s) : SyntaxNode(s, CONSTANT, _type, 0), s(_s) { isConst = true; }
		union {
			double f;
			long int i;
			std::string* s;
		};
		~ConstantNode() {
			if (etype & EPOINTER && s != nullptr) {
				delete s;
			}
			for(SyntaxNode* c : children){ delete c; }
		}

		Operand gen3AC(std::vector<ThreeAddress>& instructions, unsigned& tempTicker, unsigned& labelTicker);
};

class OperatorNode : public SyntaxNode {
	public:
		const enum OpType {
			// Binary Operators
			OBAND,
			OBOR,
			OBXOR,
			OBNOT,
			OLSHIFT,
			ORSHIFT,
			// Arithmetic
			OMOD,
			ODIV,
			OMULT,
			OADD,
			OSUB,
			OINC,
			ODEC,
			OINCPOST,
			ODECPOST,
			// Logic
			OLNOT,
			OLAND,
			OLOR,
			// Comparison
			OLESS,
			OGREAT,
			OLEQ,
			OGEQ,
			OEQUAL,
			ONEQ,
			// Other
			OSIZE,
			OTERNARY
		} opType;
		OperatorNode(const Source& s, EvalType _type, OpType _opType, unsigned numChildren...);
		ConstantNode* evalNode();
		Operand gen3AC(std::vector<ThreeAddress>& instructions, unsigned& tempTicker, unsigned& labelTicker);
};

class IdentifierNode : public SyntaxNode {
	public:
		Symbol::SymbolType* const sym;
		IdentifierNode(const Source& s, Symbol::SymbolType* sPtr) : SyntaxNode(s, IDENTIFIER, sPtr->etype, 0), sym(sPtr) {}

		Operand gen3AC(std::vector<ThreeAddress>& instructions, unsigned& tempTicker, unsigned& labelTicker);
	private:
		IdentifierNode(const Source& s, Symbol::SymbolType* sPtr, SyntaxNode* child) : SyntaxNode(s, FUNCTION, sPtr->etype, 1, child), sym(sPtr) {}
		friend class FunctionNode;
};

class FunctionNode : public IdentifierNode {
	public:
		Symbol::FunctionType* const func;
		FunctionNode(const Source& s, Symbol::SymbolType* sPtr, Symbol::FunctionType* f) : IdentifierNode(s, sPtr, nullptr), func(f) {}
		FunctionNode(const Source& s, IdentifierNode* id, Symbol::FunctionType* f) : IdentifierNode(s, id->sym, nullptr), func(f) {}
		FunctionNode(const Source& s, FunctionNode* f, SyntaxNode* child) : IdentifierNode(s, f->sym, child), func(f->func) {}

		Operand gen3AC(std::vector<ThreeAddress>& instructions, unsigned& tempTicker, unsigned& labelTicker);
};

class FunctionCallNode : public SyntaxNode {
	public:
		FunctionCallNode(const Source& s, Symbol::SymbolType* sPtr, Symbol::FunctionType* fPtr) : SyntaxNode(s, FUNCTION_CALL, fPtr->returnType, 0), func(fPtr), sym(sPtr) {}
		Symbol::FunctionType* const func;
		Symbol::SymbolType* const sym;
		std::vector<SyntaxNode*> callParameters;
		Operand gen3AC(std::vector<ThreeAddress>& instructions, unsigned& tempTicker, unsigned& labelTicker);
};

class LoopNode : public SyntaxNode {
	public:
		LoopNode(const Source& s, SyntaxNode* pre, SyntaxNode* check, SyntaxNode* post, SyntaxNode* stmt, bool _pre_check = true)
			: SyntaxNode(s, LOOP, EVOID, 4, pre, check, post, stmt),
			  pre_check(_pre_check) {}
		LoopNode(const Source& s, SyntaxNode* check, SyntaxNode* stmt, bool _pre_check = true)
			: LoopNode(s, nullptr, check, nullptr, stmt, _pre_check) {}
		bool pre_check;
		Operand gen3AC(std::vector<ThreeAddress>& instructions, unsigned& tempTicker, unsigned& labelTicker);
};

std::ostream& operator<<(std::ostream& out, SyntaxNode::Type t);
std::ostream& operator<<(std::ostream& out, const SyntaxNode * n);
std::ostream& operator<<(std::ostream& out, const SyntaxNode& n);
std::ostream& operator<<(std::ostream& out, const ConstantNode& n);
std::ostream& operator<<(std::ostream& out, const OperatorNode& n);
std::ostream& operator<<(std::ostream& out, const IdentifierNode& n);
std::ostream& operator<<(std::ostream& out, const FunctionNode& n);
std::ostream& operator<<(std::ostream& out, const FunctionCallNode& n);
std::ostream& operator<<(std::ostream& out, const LoopNode& n);
std::ostream& operator<<(std::ostream& out, const CoercionNode& n);

ConstantNode* evalConst(SyntaxNode*);
