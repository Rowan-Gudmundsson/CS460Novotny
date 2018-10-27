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

void SyntaxNode::semanticCheck() {}

void SyntaxNode::pushChild(SyntaxNode* child) {
	_numChildren++;
	SyntaxNode** temp = new SyntaxNode*[_numChildren];
	temp[_numChildren - 1] = child;
	for(unsigned i = 0; i < _numChildren - 1; i++) {
		temp[i] = children[i];
	}
	delete [] children;
	children = temp;
}

OperatorNode::OperatorNode(EvalType _type, OpType _opType, unsigned n...): SyntaxNode(OPERATOR, _type, 0), opType(_opType) {
	_numChildren = n;
	if (n > 0) {
		va_list args;
		va_start(args, n);

		children = new SyntaxNode*[n];

		for (unsigned i = 0; i < n; i++) {
			children[i] = va_arg(args, SyntaxNode*);
		}

		va_end(args);
	} else {
		children = nullptr;
	}
}

std::ostream& operator<<(std::ostream& out, SyntaxNode::Type t) {
	#define PROCESS_VAL(p) case(SyntaxNode::Type::p): out << #p; break;
		switch(t){
			PROCESS_VAL(GENERIC);     
			PROCESS_VAL(IDENTIFIER);
			PROCESS_VAL(CONSTANT);
			PROCESS_VAL(OPERATOR);
			PROCESS_VAL(DECLARE_AND_INIT);
			PROCESS_VAL(FUNCTION);
		}
	#undef PROCESS_VAL

	return out;
}

std::ostream& operator<<(std::ostream& out, const SyntaxNode * n) {
	if(n == nullptr) return out;
	switch(n->type) {
		case SyntaxNode::Type::IDENTIFIER:
			out << *((IdentifierNode*) n);
			break;
		case SyntaxNode::Type::CONSTANT:
			out << *((ConstantNode*) n);
			break;
		case SyntaxNode::Type::OPERATOR:
			out << *((OperatorNode*) n);
			break;
		default:
			out << *n;
			break;
	}

	return out;
}

std::ostream& operator<<(std::ostream& out, const SyntaxNode& n) {
	out << "[.{" << n.type << "} ";

	for(unsigned i = 0; i < n.numChildren; i++) {
		out << n.children[i];
	}

	out << ']';

	return out;
}

std::ostream& operator<<(std::ostream& out, const ConstantNode& n) {
	out << "[.{";
	if(n.etype & ECHAR) {
		if(n.etype & EPOINTER) {
			out << '\"' << *n.s << '\"';
		} else {
			out << '\'' << (char)(n.i) << '\'';
		}
	} else if(n.etype & ESHORT || n.etype & EINT || n.etype & ELONG) {
		out << n.i;
	} else if(n.etype & EFLOAT || n.etype & EDOUBLE) {
		out << n.f;
	}
	out << "} ]";

	return out;
}

std::ostream& operator<<(std::ostream& out, const OperatorNode& n) {
	// TODO: Actually do this output
	out << "[.{\\textbf{test} ";

	for(unsigned i = 0; i < n.numChildren; i++) {
		out << n.children[i];
	}

	out << ']';

	return out;
}

std::ostream& operator<<(std::ostream& out, const IdentifierNode& n) {
	out << "[.{" << *n.sym << "} ]";
	return out;
}