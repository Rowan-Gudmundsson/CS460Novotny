#pragma once

#include <cstdarg>
#include "symbol.h"

extern unsigned lineno;
extern unsigned column;

class SyntaxNode {
	public:
		const enum Type {
			IDENTIFIER,
			CONSTANT
		} type;

		EvalType etype;
		const unsigned line;
		const unsigned columnno;

		const unsigned& numChildren;
		SyntaxNode** children;

		SyntaxNode(Type type, EvalType etype, unsigned numChildren...);

		virtual void semanticCheck();
	private:
		unsigned _numChildren;
};

class ConstantNode : public SyntaxNode {
	public:
		ConstantNode(EvalType type, double _f) : SyntaxNode(CONSTANT, type, 0), f(_f) {}
		ConstantNode(EvalType type, long int _i) : SyntaxNode(CONSTANT, type, 0), i(_i) {}
		union {
			double f;
			long int i;
		};
};

class IdentifierNode : public SyntaxNode {
	public:
		const Symbol::SymbolType* sym;
		IdentifierNode(Symbol::SymbolType* sPtr) : SyntaxNode(IDENTIFIER, EVOID, 0), sym(sPtr) {}
};
