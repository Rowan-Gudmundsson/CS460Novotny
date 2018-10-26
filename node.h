#include <cstdarg>
#include "symbol.h"

class SyntaxNode {
	public:
		const enum Type {
			CONSTANT
		} type;

		EvalType etype;

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
