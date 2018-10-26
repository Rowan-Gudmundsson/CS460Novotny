#include <cstdarg>
#include "symbol.h"

class SyntaxNode {
	public:
		const enum Type {
			TYPE
		} type;

		EvalType etype;

		const unsigned& numChildren;
		SyntaxNode** children;

		SyntaxNode(Type type, EvalType etype, unsigned numChildren...);

		virtual void semanticCheck();
	private:
		unsigned _numChildren;
};

// class TypeNode : public SyntaxNode {
// 	public:
// 		TypeNode(EvalType eType) : SyntaxNode(TYPE, eType, 0) {}

// };