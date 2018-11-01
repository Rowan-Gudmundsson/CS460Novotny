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

	// Compress generic nodes
	// If a node has generic children, then just grab all of the grandchildren
	for(unsigned i = 0; i < children.size(); i++) {
		if(children[i]->type == GENERIC) {
			unsigned size = children[i]->children.size();
			children.insert(children.begin() + i, children[i]->children.begin(), children[i]->children.end());
			delete children[i + size];
			children.erase(children.begin() + i + size);
		}
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
			PROCESS_VAL(ASSIGN);
			PROCESS_VAL(FUNCTION);
			PROCESS_VAL(CONDITIONAL);
			PROCESS_VAL(LOOP);
		}
	#undef PROCESS_VAL

	return out;
}

std::ostream& operator<<(std::ostream& out, const SyntaxNode * n) {
	out << "[.{";

	if(n == nullptr) {
		out << "\\textbf{nullptr}} ]";
		return out;
	}

	switch(n->type) {
		case SyntaxNode::Type::IDENTIFIER:
		case SyntaxNode::Type::FUNCTION:
			out << *((IdentifierNode*) n);
			break;
		case SyntaxNode::Type::CONSTANT:
			out << *((ConstantNode*) n);
			break;
		case SyntaxNode::Type::OPERATOR:
			out << *((OperatorNode*) n);
			break;
		case SyntaxNode::Type::LOOP:
			out << *((LoopNode*) n);
			break;
		default:
			out << *n;
			break;
	}
	out << ']';

	return out;
}

std::ostream& operator<<(std::ostream& out, const SyntaxNode& n) {
	out << n.type << "} ";

	for(unsigned i = 0; i < n.children.size(); i++) {
		out << n.children[i];
	}

	return out;
}

std::ostream& operator<<(std::ostream& out, const ConstantNode& n) {
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
	out << "} ";

	return out;
}

std::ostream& operator<<(std::ostream& out, const OperatorNode& n) {
	// TODO: Actually do this output
	out << "\\textbf{";

	switch(n.opType) {
		case OperatorNode::OpType::OBAND:
			out << '&';
			break;
		case OperatorNode::OpType::OBOR:
			out << '|';
			break;
		case OperatorNode::OpType::OBXOR:
			out << '^';
			break;
		case OperatorNode::OpType::OBNOT:
			out << '~';
			break;
		case OperatorNode::OpType::OLSHIFT:
			out << "<<";
			break;
		case OperatorNode::OpType::ORSHIFT:
			out << ">>";
			break;

		// Arithmetic
		case OperatorNode::OpType::OMOD:
			out << '%';
			break;
		case OperatorNode::OpType::ODIV:
			out << '/';
			break;
		case OperatorNode::OpType::OMULT:
			out << '*';
			break;
		case OperatorNode::OpType::OADD:
			out << '+';
			break;
		case OperatorNode::OpType::OSUB:
			out << '-';
			break;
		case OperatorNode::OpType::OINCPOST:
			out << "POST++";
			break;
		case OperatorNode::OpType::OINC:
			out << "++PRE";
			break;
		case OperatorNode::OpType::ODECPOST:
			out << "POST--";
			break;
		case OperatorNode::OpType::ODEC:
			out << "--PRE";
			break;
		// Logic
		case OperatorNode::OpType::OLNOT:
			out << '!';
			break;
		case OperatorNode::OpType::OLAND:
			out << "&&";
			break;
		case OperatorNode::OpType::OLOR:
			out << "||";
			break;

		// Comparison
		case OperatorNode::OpType::OLESS:
			out << '<';
			break;
		case OperatorNode::OpType::OGREAT:
			out << '>';
			break;
		case OperatorNode::OpType::OLEQ:
			out << "\\leq";
			break;
		case OperatorNode::OpType::OGEQ:
			out << "\\geq";
			break;
		case OperatorNode::OpType::OEQUAL:
			out << "==";
			break;
		case OperatorNode::OpType::ONEQ:
			out << "!=";
			break;

		// Other
		case OperatorNode::OpType::OSIZE:
			out << "sizeof";
			break;
		case OperatorNode::OpType::OTERNARY:
			out << "? :";
			break;
	}

	out << "}} ";

	for(unsigned i = 0; i < n.children.size(); i++) {
		out << n.children[i];
	}
	return out;
}

std::ostream& operator<<(std::ostream& out, const IdentifierNode& n) {
	out << *n.sym << "} ";

	for(unsigned i = 0; i < n.children.size(); i++) {
		out << n.children[i];
	}
	return out;
}

std::ostream& operator<<(std::ostream& out, const LoopNode& n) {
	out << (n.pre_check ? "PRE_CHECK_LOOP" : "POST_CHECK_LOOP") << "} ";

	for (unsigned i = 0; i < n.children.size(); i++) {
		out << n.children[i];
	}
	return out;
}
