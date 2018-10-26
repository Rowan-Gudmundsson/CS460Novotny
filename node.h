#pragma once

#include <cstdarg>
#include "symbol.h"

extern unsigned lineno;
extern unsigned column;

class SyntaxNode {
	public:
		const enum Type {
			IDENTIFIER
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











class IdentifierNode : public SyntaxNode {
	public:
		const Symbol::SymbolType* sym;
		IdentifierNode(Symbol::SymbolType* sPtr) : SyntaxNode(IDENTIFIER, EVOID, 0), sym(sPtr) {}
};