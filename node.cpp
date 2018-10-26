#include "node.h"

SyntaxNode::SyntaxNode(Type t, EvalType e, unsigned n...) : type(t), etype(e), line(lineno), columnno(column), numChildren(_numChildren), _numChildren(n) {
	if(numChildren > 0) {
		va_list args;
	    va_start(args, n);

	    children = new SyntaxNode*[n];

	    for(unsigned i = 0; i < n; i++) {
	    	children[i] = va_arg(args, SyntaxNode*);
	    }

	    va_end(args);
	} else {
		children = nullptr;
	}
}

void SyntaxNode::semanticCheck() {

}