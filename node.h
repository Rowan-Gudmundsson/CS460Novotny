#pragma once

#include <cstdarg>
#include <iostream>
#include "symbol.h"

extern unsigned lineno;
extern unsigned column;

class SyntaxNode {
	public:
		const enum Type {
			GENERIC, // For a node which only holds other nodes
			IDENTIFIER,
			CONSTANT,
			OPERATOR,
			DECLARE_AND_INIT,
			FUNCTION,
			ASSIGN,
			CONDITIONAL,
			ARRAY,
			LOOP
		} type;

		EvalType etype;
		const unsigned line;
		const unsigned columnno;

		std::vector<SyntaxNode*> children;

		// TODO: Consider boolean 'constant' which checks whether or not this node can be evaluated at compile time ?

		SyntaxNode(Type type, EvalType etype, unsigned numChildren...);

		// Semanticly check the node
		// Make certain data types line up, smash unneeded nodes, etc.
		virtual void semanticCheck();
};

class ConstantNode : public SyntaxNode {
	public:
		ConstantNode(EvalType _type, double _f) : SyntaxNode(CONSTANT, _type, 0), f(_f) {}
		ConstantNode(EvalType _type, long int _i) : SyntaxNode(CONSTANT, _type, 0), i(_i) {}
		ConstantNode(EvalType _type, std::string* _s) : SyntaxNode(CONSTANT, _type, 0), s(_s) {}
		union {
			double f;
			long int i;
			std::string* s;
		};
		~ConstantNode() {
			if (type & EPOINTER) {
				delete s;
			}
		}
};

class ArrayNode	: public SyntaxNode 
{
	public:
		ArrayNode(EvalType _type, int _size) : SyntaxNode(ARRAY, _type, 0), arraySize(_size), arrayValues(nullptr) {}
		ArrayNode(EvalType _type, int _size, void* _values); 

		int getSize() const
		{
			return arraySize;
		}

		 ~ArrayNode();

	private:
		int arraySize;  
		void* arrayValues; 

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

};

class IdentifierNode : public SyntaxNode {
	public:
		Symbol::SymbolType * const sym;
		IdentifierNode(Symbol::SymbolType* sPtr) : SyntaxNode(IDENTIFIER, EUNKNOWN, 0), sym(sPtr) {}
	private:
		IdentifierNode(Symbol::SymbolType* sPtr, SyntaxNode* child) : SyntaxNode(FUNCTION, EUNKNOWN, 1, child), sym(sPtr) {}
		friend class FunctionNode;
};

class FunctionNode : public IdentifierNode {
	public:
		FunctionNode(Symbol::SymbolType* sPtr, SyntaxNode* child) : IdentifierNode(sPtr, child) {}
		FunctionNode(IdentifierNode* id, SyntaxNode* child) : IdentifierNode(id->sym, child) {}
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
std::ostream& operator<<(std::ostream& out, const ArrayNode& a);
std::ostream& operator<<(std::ostream& out, const LoopNode& n);
