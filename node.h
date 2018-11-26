#pragma once

#include <cstdarg>
#include <iostream>
#include "symbol.h"
#include "errors.h"

extern unsigned lineno;
extern unsigned column;

struct PointerNode {
	PointerNode() { level = 0; qualifier = TNONE; }
	unsigned level;
	TypeQualifier qualifier;
};

struct ThreeAddress {
	std::string op;
	std::string op1;
	std::string op2;
	std::string dest;
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
		const unsigned columnno;
		// TODO: Consider boolean 'constant' which checks whether or not this node can be evaluated at compile time ?
		bool isConst = false;
		std::vector<SyntaxNode*> children;

		SyntaxNode(Type type, EvalType etype, unsigned numChildren...);

		// Semanticly check the node
		// Make certain data types line up, smash unneeded nodes, etc.
		virtual void semanticCheck();
		virtual void gen3AC(std::vector<ThreeAddress>& instructions);

		virtual void clear();

		virtual ~SyntaxNode() {}
};

class CoercionNode : public SyntaxNode {
	public:
		CoercionNode(EvalType _from, EvalType _to, SyntaxNode* child) : SyntaxNode(COERCION, _to, 1, child), from(_from), to(_to) {}
		EvalType from, to;
};

class ConstantNode : public SyntaxNode {
	public:
		ConstantNode(EvalType _type, double _f) : SyntaxNode(CONSTANT, _type, 0), f(_f) { isConst = true; }
		ConstantNode(EvalType _type, long int _i) : SyntaxNode(CONSTANT, _type, 0), i(_i) { isConst = true; }
		ConstantNode(EvalType _type, std::string* _s) : SyntaxNode(CONSTANT, _type, 0), s(_s) { isConst = true; }
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
		friend ConstantNode* evalConst(SyntaxNode*);
};

class StringLiteralNode : public SyntaxNode {
};

class ArrayNode	: public SyntaxNode
{
	public:
		ArrayNode(EvalType _type, SyntaxNode* _size) : SyntaxNode(ARRAY, _type, 0), arraySize(_size) {}

		SyntaxNode* getSize() const
		{
			return arraySize;
		}
	private:
		SyntaxNode* arraySize;


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
		OperatorNode(EvalType _type, OpType _opType, unsigned numChildren...);
		ConstantNode* evalNode();
};

class IdentifierNode : public SyntaxNode {
	public:
		Symbol::SymbolType* const sym;
		IdentifierNode(Symbol::SymbolType* sPtr) : SyntaxNode(IDENTIFIER, sPtr->etype, 0), sym(sPtr) {}
	private:
		IdentifierNode(Symbol::SymbolType* sPtr, SyntaxNode* child) : SyntaxNode(FUNCTION, sPtr->etype, 1, child), sym(sPtr) {}
		friend class FunctionNode;
};

class FunctionNode : public IdentifierNode {
	public:
		Symbol::FunctionType* const func;
		FunctionNode(Symbol::SymbolType* sPtr, Symbol::FunctionType* f) : IdentifierNode(sPtr, nullptr), func(f) {}
		FunctionNode(IdentifierNode* id, Symbol::FunctionType* f) : IdentifierNode(id->sym, nullptr), func(f) {}
		FunctionNode(FunctionNode* f, SyntaxNode* child) : IdentifierNode(f->sym, child), func(f->func) {}

		void gen3AC(std::vector<ThreeAddress>& instructions);
};

class FunctionCallNode : public SyntaxNode {
	public:
		FunctionCallNode(Symbol::SymbolType* sPtr, Symbol::FunctionType* fPtr) : SyntaxNode(FUNCTION_CALL, fPtr->returnType, 0), func(fPtr), sym(sPtr) {}
		Symbol::FunctionType* const func;
		Symbol::SymbolType* const sym;
		std::vector<SyntaxNode*> callParameters;
};

class LoopNode : public SyntaxNode {
	public:
		LoopNode(SyntaxNode* pre, SyntaxNode* check, SyntaxNode* post, SyntaxNode* stmt, bool _pre_check = true)
			: SyntaxNode(LOOP, EVOID, 4, pre, check, post, stmt),
			  pre_check(_pre_check) {}
		LoopNode(SyntaxNode* check, SyntaxNode* stmt, bool _pre_check = true)
			: LoopNode(nullptr, check, nullptr, stmt, _pre_check) {}
		bool pre_check;
};

std::ostream& operator<<(std::ostream& out, SyntaxNode::Type t);
std::ostream& operator<<(std::ostream& out, const SyntaxNode * n);
std::ostream& operator<<(std::ostream& out, const SyntaxNode& n);
std::ostream& operator<<(std::ostream& out, const ConstantNode& n);
std::ostream& operator<<(std::ostream& out, const OperatorNode& n);
std::ostream& operator<<(std::ostream& out, const IdentifierNode& n);
std::ostream& operator<<(std::ostream& out, const FunctionNode& n);
std::ostream& operator<<(std::ostream& out, const FunctionCallNode& n);
std::ostream& operator<<(std::ostream& out, const ArrayNode& a);
std::ostream& operator<<(std::ostream& out, const LoopNode& n);
std::ostream& operator<<(std::ostream& out, const CoercionNode& n);

ConstantNode* evalConst(SyntaxNode*);
