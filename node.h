#pragma once

#include <cstdarg>
#include "symbol.h"

extern unsigned lineno;
extern unsigned column;

class SyntaxNode {
	public:
		const enum Type {
			IDENTIFIER,
			CONSTANT,
			OPERATOR
		} type;

		EvalType etype;
		const unsigned line;
		const unsigned columnno;

		const unsigned& numChildren;
		SyntaxNode** children;

		SyntaxNode(Type type, EvalType etype, unsigned numChildren...);

		virtual void semanticCheck();
	private:
	protected:
		unsigned _numChildren;
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
		enum OpType {
			OBAND = 1 << 0,
			OMULT = 1 << 1,
			OADD =  1 << 2,
			OSUB =  1 << 3,
			OBNOT = 1 << 4,
			OLNOT = 1 << 5,
			OINC =  1 << 6,
			ODEC =  1 << 7,
			OSIZE = 1 << 8
		} opType;
		OperatorNode(EvalType _type, OpType _opType, unsigned numChildren...);

};

class IdentifierNode : public SyntaxNode {
	public:
		const Symbol::SymbolType* sym;
		IdentifierNode(Symbol::SymbolType* sPtr) : SyntaxNode(IDENTIFIER, EVOID, 0), sym(sPtr) {}
};
