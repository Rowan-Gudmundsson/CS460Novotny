#include "node.h"

template<typename T>
T evalConst(SyntaxNode* node) {
	if (!node->isConst) {
		throw ParserError("Trying to evaluate non-constant expression.");
	}
	if (node->type == SyntaxNode::CONSTANT) {
		ConstantNode* tmp = (ConstantNode*)node;
		if (node->etype & EPOINTER) {
			return tmp->s;
		}
		if (node->etype & EINT || node->etype & ECHAR) {
			return tmp->i;
		}
		if (node->etype & EFLOAT || node->etype & EDOUBLE) {
			return tmp->f;
		}
	} else if (node->type == SyntaxNode::OPERATOR) {
		OperatorNode* tmp = (OperatorNode*)node;
		switch (tmp->opType) {
			case OperatorNode::OBAND:
				if (node->etype & EPOINTER || node->etype & EFLOAT || node->etype & EDOUBLE) {
					throw ParserError("Cannot perform operation on these operand types");
				}
				return evalConst<long int>(tmp->children[0]) & evalConst<long int>(tmp->children[1]);
			case OperatorNode::OBOR:
				if (node->etype & EPOINTER || node->etype & EFLOAT || node->etype & EDOUBLE) {
					throw ParserError("Cannot perform operation on these operand types");
				}
				return evalConst<long int>(tmp->children[0]) | evalConst<long int>(tmp->children[1]);
			case OperatorNode::OBXOR:
				if (node->etype & EPOINTER || node->etype & EFLOAT || node->etype & EDOUBLE) {
					throw ParserError("Cannot perform operation on these operand types");
				}
				return evalConst<long int>(tmp->children[0]) ^ evalConst<long int>(tmp->children[1]);
			case OperatorNode::OBNOT:
				if (node->etype & EPOINTER || node->etype & EFLOAT || node->etype & EDOUBLE) {
					throw ParserError("Cannot perform operation on these operand types");
				}
				return ~evalConst<long int>(tmp->children[0]);
			case OperatorNode::ORSHIFT:
				if (node->etype & EPOINTER || node->etype & EFLOAT || node->etype & EDOUBLE) {
					throw ParserError("Cannot perform operation on these operand types");
				}
				return evalConst<long int>(tmp->children[0]) >> evalConst<long int>(tmp->children[1]);
			case OperatorNode::OLSHIFT:
				if (node->etype & EPOINTER || node->etype & EFLOAT || node->etype & EDOUBLE) {
					throw ParserError("Cannot perform operation on these operand types");
				}
				return evalConst<long int>(tmp->children[0]) << evalConst<long int>(tmp->children[1]);
			case OperatorNode::OMOD:
				if (node->etype & EPOINTER || node->etype & EFLOAT || node->etype & EDOUBLE) {
					throw ParserError("Cannot perform operation on these operand types");
				}
				return evalConst<long int>(tmp->children[0]) % evalConst<long int>(tmp->children[1]);
			case OperatorNode::ODIV:
				if (node->etype & EPOINTER) {
					throw ParserError("Cannot perform operation on these operand types");
				}
				if (node->etype & EINT || node->etype & ECHAR) {
					return evalConst<long int>(tmp->children[0]) / evalConst<long int>(tmp->children[1]);
				}
				return evalConst<double>(tmp->children[0]) / evalConst<double>(tmp->children[1]);
			case OperatorNode::OMULT:
				if (node->etype & EPOINTER) {
					throw ParserError("Cannot perform operation on these operand types");
				}
				if (node->etype & EINT || node->etype & ECHAR) {
					return evalConst<long int>(tmp->children[0]) * evalConst<long int>(tmp->children[1]);
				}
				return evalConst<double>(tmp->children[0]) * evalConst<double>(tmp->children[1]);
			case OperatorNode::OADD:
				if (node->etype & EINT || node->etype & ECHAR) {
					return evalConst<long int>(tmp->children[0]) + evalConst<long int>(tmp->children[1]);
				}
				if (node->etype & EPOINTER) {
					return evalConst<long int>(tmp->children[0]) + sizeof(char) * evalConst<long int>(tmp->children[1]);
				}
				return evalConst<double>(tmp->children[0]) + evalConst<double>(tmp->children[1]);
			case OperatorNode::OSUB:
				if (node->etype & EINT || node->etype & ECHAR) {
					return evalConst<long int>(tmp->children[0]) - evalConst<long int>(tmp->children[1]);
				}
				if (node->etype & EPOINTER) {
					return evalConst<long int>(tmp->children[0]) - sizeof(char) * evalConst<long int>(tmp->children[1]);
				}
				return evalConst<double>(tmp->children[0]) - evalConst<double>(tmp->children[1]);
			case OperatorNode::OINC:
			case OperatorNode::OINCPOST:
				if (node->etype & EINT || node->etype & ECHAR) {
					return evalConst<long int>(tmp->children[0]) + 1;
				}
				if (node->etype & EPOINTER) {
					return evalConst<long int>(tmp->children[0]) + sizeof(char);
				}
				return evalConst<double>(tmp->children[0]) + 1;
			case OperatorNode::ODEC:
			case OperatorNode::ODECPOST:
				if (node->etype & EINT || node->etype & ECHAR) {
					return evalConst<long int>(tmp->children[0]) - 1;
				}
				if (node->etype & EPOINTER) {
					return evalConst<long int>(tmp->children[0]) - sizeof(char);
				}
				return evalConst<double>(tmp->children[0]) - 1;
			case OperatorNode::OLNOT:
				if (node->etype & EINT || node->etype & ECHAR) {
					return !evalConst<long int>(tmp->children[0]);
				}
				if (node->etype & EPOINTER) {
					return 0;
				}
				return !evalConst<double>(tmp->children[0]);
			case OperatorNode::OLAND:
				if (node->etype & EINT || node->etype & ECHAR || node->etype & EPOINTER) {
					return evalConst<long int>(tmp->children[0]) && evalConst<long int>(tmp->children[1]);
				}
				return evalConst<double>(tmp->children[0]) && evalConst<double>(tmp->children[1]);
			case OperatorNode::OLOR:
				if (node->etype & EINT || node->etype & ECHAR || node->etype & EPOINTER) {
					return evalConst<long int>(tmp->children[0]) || evalConst<long int>(tmp->children[1]);
				}
				return evalConst<double>(tmp->children[0]) || evalConst<double>(tmp->children[1]);
		}
	} else {
		throw ParserError("Node cannot be evaluated.");
	}
}

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
		if(children[i] == nullptr) {
			if(type == GENERIC) {
				children.erase(children.begin() + i);
				i--;
			}
		} else if(children[i]->type == GENERIC) {
			unsigned size = children[i]->children.size();
			children.insert(children.begin() + i, children[i]->children.begin(), children[i]->children.end());
			delete children[i + size];
			children.erase(children.begin() + i + size);
			i--;
		} else if(children[i]->type == IDENTIFIER && type == GENERIC) {
			delete children[i];
			children.erase(children.begin() + i);
			i--;
		}
	}
}

ArrayNode::ArrayNode(EvalType _type, int _size, void* _values) : SyntaxNode(ARRAY, _type, 0), arraySize(_size)
{
	switch(_type)
	{

		case ESIGNED:

			arrayValues = new signed[_size];
			break;
		case EUNSIGNED:
			arrayValues = new unsigned[_size];
			break;
		case ECHAR:
			arrayValues = new char[_size];
			break;
		case ESHORT:
			arrayValues = new short[_size];
			break;
		case EINT:
			arrayValues = new int[_size];
			break;
		case ELONG:
			arrayValues = new long[_size];
			break;
		case EFLOAT:
			arrayValues = new float[_size];
			break;
		case EDOUBLE:
			arrayValues = new double[_size];
			break;
		case EPOINTER:
			arrayValues = new void*[_size];
			break;
		case EUNKNOWN:
		case EVOID:
		default:
			//ERROR
			arrayValues = nullptr;
	}

	memcpy(arrayValues, _values, sizeof(arrayValues));
}

OperatorNode::OperatorNode(EvalType _type, OpType _opType, unsigned n...): SyntaxNode(OPERATOR, _type, 0), opType(_opType) {
	if (n > 0) {
		va_list args;
		va_start(args, n);

		children.resize(n);

		for (unsigned i = 0; i < n; i++) {
			children[i] = va_arg(args, SyntaxNode*);
			isConst &= children[i]->isConst;
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
			PROCESS_VAL(ARRAY);
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

std::ostream& operator<<(std::ostream& out, const ArrayNode& a)
{
	// DON'T KNOW LATEX BUT HERE IS A SHOT
	out << "\\textbf{";
	out << "Array of ";
	out << a.getSize() << " ";
	switch(a.etype)
	{

		case ESIGNED:
			out << "signed";
			break;
		case EUNSIGNED:
			out << "unsigned";
			break;
		case ECHAR:
			out << "char";
			break;
		case ESHORT:
			out << "short";
			break;
		case EINT:
			out << "int";
			break;
		case ELONG:
			out << "long";
			break;
		case EFLOAT:
			out << "float";
			break;
		case EDOUBLE:
			out << "double";
			break;
		case EPOINTER:
			out << "pointer";
			break;
		case EUNKNOWN:
		case EVOID:
		default:
			break;
	}

	out << "}} ";

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
