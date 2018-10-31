#include "node.h"

SyntaxNode::SyntaxNode(Type t, EvalType e, unsigned n...) : type(t), etype(e), line(lineno), columnno(column) {
	if(n > 0) {
		va_list args;
		va_start(args, n);

		children.resize(n);

		for(unsigned i = 0; i < n; i++) {
			children[i] = va_arg(args, SyntaxNode*);
		}

		va_end(args);
	}
}

void SyntaxNode::semanticCheck() {
	for(SyntaxNode* child : children) {
		if(child != nullptr) child->semanticCheck();
	}
	
	switch(type) {
		case GENERIC:
			// Compress generic nodes
			// If a generic node has generic children, then just gab all of the grandchildren
			for(unsigned i = 0; i < children.size(); i++) {
				if(children[i]->type == GENERIC) {
					unsigned size = children[i]->children.size();
					children.insert(children.begin() + i, children[i]->children.begin(), children[i]->children.end());
					delete children[i + size];
					children.erase(children.begin() + i + size);
				}
			}
		default:
			break;
	}
}

OperatorNode::OperatorNode(EvalType _type, OpType _opType, unsigned n...): SyntaxNode(OPERATOR, _type, 0), opType(_opType) {
	if (n > 0) {
		va_list args;
		va_start(args, n);

		children.resize(n);

		for (unsigned i = 0; i < n; i++) {
			children[i] = va_arg(args, SyntaxNode*);
		}

		va_end(args);
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

	for(unsigned i = 0; i < n.children.size(); i++) {
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

	for(unsigned i = 0; i < n.children.size(); i++) {
		out << n.children[i];
	}

	out << ']';

	return out;
}

std::ostream& operator<<(std::ostream& out, const IdentifierNode& n) {
	out << "[.{" << *n.sym << "} ]";
	return out;
}