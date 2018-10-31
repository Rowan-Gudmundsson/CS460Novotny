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
			ASSIGN
		} type;

		EvalType etype;
		const unsigned line;
		const unsigned columnno;

		std::vector<SyntaxNode*> children;

		// TODO: Consider boolean 'constant' which checks whether or not this node can be evaluated at compile time ?

		SyntaxNode(Type type, EvalType etype, unsigned numChildren...);

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
		IdentifierNode(Symbol::SymbolType* sPtr) : SyntaxNode(IDENTIFIER, EVOID, 0), sym(sPtr) {}
};

std::ostream& operator<<(std::ostream& out, SyntaxNode::Type t);
std::ostream& operator<<(std::ostream& out, const SyntaxNode * n);
std::ostream& operator<<(std::ostream& out, const SyntaxNode& n);
std::ostream& operator<<(std::ostream& out, const ConstantNode& n);
std::ostream& operator<<(std::ostream& out, const OperatorNode& n);
std::ostream& operator<<(std::ostream& out, const IdentifierNode& n);