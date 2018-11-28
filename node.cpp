#include "node.h"

ConstantNode* evalConst(SyntaxNode* node) {
	if (!node->isConst) {
		throw ParserError("Cannot evaluate non-constant expression.");
	}

	if (node->type == SyntaxNode::CONSTANT) {
		return (ConstantNode*)node;
	}

	if (node->type == SyntaxNode::OPERATOR) {
		return ((OperatorNode*)node)->evalNode();
	}

	throw ParserError("Something went horribly awry...");
}

SyntaxNode::SyntaxNode(const Source& s, Type t, EvalType e, unsigned n...) : type(t), etype(e), line(s.line), source(s.source) {
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

OperatorNode::OperatorNode(const Source& s, EvalType _type, OpType _opType, unsigned n...): SyntaxNode(s, OPERATOR, _type, 0), opType(_opType) {
	isConst = true;
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

ConstantNode* OperatorNode::evalNode() {
	if (!isConst) {
		throw ParserError("Cannot evaluate non-constant expression.");
	}

	ConstantNode* lhs = children[0]->type == SyntaxNode::CONSTANT
		? (ConstantNode*)children[0]
		: ((OperatorNode*)children[0])->evalNode();

	ConstantNode* rhs = children.size() > 1
		? children[1]->type == SyntaxNode::CONSTANT
			? (ConstantNode*)children[1]
			: ((OperatorNode*)children[1])->evalNode()
		: nullptr;

	switch (opType) {
		// Binary Operators
		case OBAND: {
			if (etype & EINT || etype & ECHAR) {
				return new ConstantNode({line, source}, etype, lhs->i & rhs->i);
			} else {
				throw ParserError("Cannot perform operation of type \"&\" on non-integral types.");
			}
		}
		case OBOR: {
			if (etype & EINT || etype & ECHAR) {
				return new ConstantNode({line, source}, etype, lhs->i | rhs->i);
			} else {
				throw ParserError("Cannot perform operation of type \"|\" on non-integral types.");
			}
		}
		case OBXOR: {
			if (etype & EINT || etype & ECHAR) {
				return new ConstantNode({line, source}, etype, lhs->i ^ rhs->i);
			} else {
				throw ParserError("Cannot perform operation of type \"^\" on non-integral types.");
			}
		}
		case OBNOT: {
			if (etype & EINT || etype & ECHAR) {
				return new ConstantNode({line, source}, etype, ~lhs->i);
			} else {
				throw ParserError("Cannot perform operation of type \"~\" on non-integral types.");
			}
		}
		case OLSHIFT: {
			if (etype & EINT || etype & ECHAR) {
				return new ConstantNode({line, source}, etype, lhs->i << rhs->i);
			} else {
				throw ParserError("Cannot perform operation of type \"<<\" on non-integral types.");
			}
		}
		case ORSHIFT: {
			if (etype & EINT || etype & ECHAR) {
				return new ConstantNode({line, source}, etype, lhs->i >> rhs->i);
			} else {
				throw ParserError("Cannot perform operation of type \">>\" on non-integral types.");
			}
		}
		// Arithmetic
		case OMOD: {
			if (etype & EINT || etype & ECHAR) {
				return new ConstantNode({line, source}, etype, lhs->i % rhs->i);
			} else {
				throw ParserError("Cannot perform operation of type \"%\" on non-integral types.");
			}
		}
		case ODIV: {
			if (etype & EINT || etype & ECHAR) {
				return new ConstantNode({line, source}, etype, lhs->i / rhs->i);
			} else {
				throw ParserError("Cannot perform operation of type \"/\" on non-integral types.");
			}
		}
		case OMULT: {
			if (etype & EINT || etype & ECHAR) {
				return new ConstantNode({line, source}, etype, lhs->i * rhs->i);
			} else {
				throw ParserError("Cannot perform operation of type \"*\" on non-integral types.");
			}
		}
		case OADD: {
			if (etype & EINT || etype & ECHAR) {
				return new ConstantNode({line, source}, etype, lhs->i + rhs->i);
			} else {
				throw ParserError("Cannot perform operation of type \"+\" on non-integral types.");
			}
		}
		case OSUB: {
			if (etype & EINT || etype & ECHAR) {
				return new ConstantNode({line, source}, etype, lhs->i - rhs->i);
			} else {
				throw ParserError("Cannot perform operation of type \"-\" on non-integral types.");
			}
		}
		case OINCPOST:
		case OINC: {
			if (etype & EINT || etype & ECHAR) {
				return new ConstantNode({line, source}, etype, ++lhs->i);
			} else {
				throw ParserError("Cannot perform operation of type \"++\" on non-integral types.");
			}
		}
		case ODECPOST:
		case ODEC: {
			if (etype & EINT || etype & ECHAR) {
				return new ConstantNode({line, source}, etype, --lhs->i);
			} else {
				throw ParserError("Cannot perform operation of type \"%\" on non-integral types.");
			}
		}
		// Logic
		case OLNOT: {
			if (etype & EINT || etype & ECHAR) {
				return new ConstantNode({line, source}, etype, (long int)(!lhs->i));
			} else {
				throw ParserError("Cannot perform operation of type \"!\" on non-integral types.");
			}
		}
		case OLAND: {
			if (etype & EINT || etype & ECHAR) {
				return new ConstantNode({line, source}, etype, (long int)(lhs->i && rhs->i));
			} else {
				throw ParserError("Cannot perform operation of type \"&&\" on non-integral types.");
			}
		}
		case OLOR: {
			if (etype & EINT || etype & ECHAR) {
				return new ConstantNode({line, source}, etype, (long int)(lhs->i || rhs->i));
			} else {
				throw ParserError("Cannot perform operation of type \"||\" on non-integral types.");
			}
		}
		// Comparison
		case OLESS: {
			if (etype & EINT || etype & ECHAR) {
				return new ConstantNode({line, source}, etype, (long int)(lhs->i < rhs->i));
			} else {
				throw ParserError("Cannot perform operation of type \"<\" on non-integral types.");
			}
		}
		case OGREAT: {
			if (etype & EINT || etype & ECHAR) {
				return new ConstantNode({line, source}, etype, (long int)(lhs->i > rhs->i));
			} else {
				throw ParserError("Cannot perform operation of type \">\" on non-integral types.");
			}
		}
		case OLEQ: {
			if (etype & EINT || etype & ECHAR) {
				return new ConstantNode({line, source}, etype, (long int)(lhs->i <= rhs->i));
			} else {
				throw ParserError("Cannot perform operation of type \"<=\" on non-integral types.");
			}
		}
		case OGEQ: {
			if (etype & EINT || etype & ECHAR) {
				return new ConstantNode({line, source}, etype, (long int)(lhs->i >= rhs->i));
			} else {
				throw ParserError("Cannot perform operation of type \">=\" on non-integral types.");
			}
		}
		case OEQUAL: {
			if (etype & EINT || etype & ECHAR) {
				return new ConstantNode({line, source}, etype, (long int)(lhs->i == rhs->i));
			} else {
				throw ParserError("Cannot perform operation of type \"==\" on non-integral types.");
			}
		}
		case ONEQ: {
			if (etype & EINT || etype & ECHAR) {
				return new ConstantNode({line, source}, etype, (long int)(lhs->i != rhs->i));
			} else {
				throw ParserError("Cannot perform operation of type \"!=\" on non-integral types.");
			}
		}
		// Other
		case OSIZE: {
			// TODO (Rowan) - This
			return nullptr;
		}
		case OTERNARY: {
			// TODO (Rowan) - This
			return nullptr;
		}
		default:
			return nullptr;
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
			PROCESS_VAL(ACCESS);
			PROCESS_VAL(COERCION);
			PROCESS_VAL(FUNCTION_CALL);
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
		case SyntaxNode::Type::FUNCTION:
			out << *((FunctionNode*) n);
			break;
		case SyntaxNode::Type::FUNCTION_CALL:
			out << *((FunctionCallNode*) n);
			break;
		case SyntaxNode::Type::IDENTIFIER:
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
		case SyntaxNode::Type::COERCION:
			out << *((CoercionNode*) n);
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
	out << *n.sym << " " << n.etype << "} ";

	for(unsigned i = 0; i < n.children.size(); i++) {
		out << n.children[i];
	}
	return out;
}

std::ostream& operator<<(std::ostream& out, const CoercionNode& n) {
	out << "COERCION from: " << n.from << "->" << n.to << "} ";

	for (auto i : n.children) {
		out << i;
	}

	return out;
}

std::ostream& operator<<(std::ostream& out, const FunctionNode& n) {
	out << n.sym->name << "(";
	// std::cout << *n.sym << std::endl;
	// std::cout << "defined: " << n.func->defined << std::endl
	//           << "line: " << n.func->functionDefLine << std::endl
	//           << "col: " << n.func->functionDefCol << std::endl
	//           << "params: " << n.func->parameters.size() << std::endl;
	// std::cout << "Address: " << ((void*) &n.func) << std::endl;

	for(unsigned i = 0; i < n.func->parameters.size(); i++) {
		// std::cout << "Doing the thing" << std::endl;
		// std::cout << "i: " << i << std::endl;
		out << n.func->parameters.at(i);
		// std::cout << n.func->parameters.at(i) << std::endl;
		if(i < n.func->parameters.size() - 1) {
			out << ", ";
		}
	}
	out << ")} ";

	for(unsigned i = 0; i < n.children.size(); i++) {
		out << n.children[i];
	}
	return out;
}

std::ostream& operator<<(std::ostream& out, const FunctionCallNode& n) {
	out << "CALL TO " << n.sym->name << "( ";

	for (unsigned i = 0; i < n.callParameters.size(); i++) {
		SyntaxNode* tmp = n.callParameters.at(i);
		switch (tmp->type) {
			case SyntaxNode::Type::CONSTANT: {
				ConstantNode* constant = (ConstantNode*)tmp;
				if (constant->etype & EINT || constant->etype & ECHAR) {
					out << constant->i;
				} else if (constant->etype & EFLOAT || constant->etype & EDOUBLE) {
					out << constant->f;
				} else if (constant->etype & EPOINTER) {
					out << *(constant->s);
				}
				break;
			}
			case SyntaxNode::Type::OPERATOR: {
				OperatorNode* op = (OperatorNode*)tmp;
				out << (*op);
				break;
			}
			case SyntaxNode::Type::IDENTIFIER: {
				IdentifierNode* id = (IdentifierNode*)tmp;
				out << (*id);
				break;
			}
			default:
				throw ParserError("Cannot call function with this parameter.");
		}
		out << " " << tmp->etype;
		if (i != n.callParameters.size() - 1) {
			out << ", ";
		}
	}
	out << ")} ";

	return out;
}

std::ostream& operator<<(std::ostream& out, const LoopNode& n) {
	out << (n.pre_check ? "PRE_CHECK_LOOP" : "POST_CHECK_LOOP") << "} ";

	for (unsigned i = 0; i < n.children.size(); i++) {
		out << n.children[i];
	}
	return out;
}

void SyntaxNode::clear() {
	for(SyntaxNode*& c : children) {
		if(c != nullptr) {
			c->clear();
			delete c;
			c = nullptr;
		}
	}
	children.clear();
}

unsigned SyntaxNode::gen3AC(std::vector<ThreeAddress>& instructions, unsigned& tempTicker) {
	for(SyntaxNode* c : children) {
		if(c != nullptr) {
			c->gen3AC(instructions, tempTicker);
		}
	}

	unsigned returnVal = -1;

	switch(type) {
		case DECLARE_AND_INIT:
			// TODO - the actual assignment part
			instructions.emplace_back();
			instructions.back().op = "ASSIGN";
			instructions.back().op1 = std::string("(") + (children[1]->etype & EINT || children[1]->etype & ECHAR
				? "ITemp"
				: "FTemp") + " " + std::to_string(children[1]->gen3AC(instructions, tempTicker)) + ")";
			instructions.back().dest = "(Local " + std::to_string(((IdentifierNode*) children[0])->sym->offset) + ")";
			instructions.back().source = source;
			break;
		case ACCESS: {
			// TODO - what is happening here
			// instructions.emplace_back();
			// instructions.back().op = "ASSIGN";
			std::string type = children[0]->etype & EINT || children[0]->etype & ECHAR
				? "ITemp"
				: "FTemp";
			unsigned offset = ((IdentifierNode*) children[0])->sym->offset;
			unsigned accessPosition = children[0]->gen3AC(instructions, tempTicker);

			instructions.emplace_back();
			instructions.back().op = "MULT";
			instructions.back().dest = "(ITemp " + std::to_string(tempTicker) + ")";
			instructions.back().op1 = "(CONS " + std::to_string(accessPosition) + ")";
			instructions.back().op2 = "(CONS " + std::to_string(size(((IdentifierNode*) children[0])->sym->etype)) + ")";
			instructions.back().source = source;
			tempTicker++;

			instructions.emplace_back();
			instructions.back().op = "ADD";
			instructions.back().dest = "(ITemp " + std::to_string(tempTicker) + ")";
			instructions.back().op1 = "(CONS " + std::to_string(offset) + ")";
			instructions.back().op2 = "(ITemp " + std::to_string(tempTicker - 1) + ")";
			instructions.back().source = source;

			instructions.emplace_back();
			instructions.back().op = "ASSIGN";
			instructions.back().op1 = "(ITemp " + std::to_string(tempTicker) + ")";
			tempTicker++;
			instructions.back().dest = "(" + type + " " + std::to_string(tempTicker) + ")";
			instructions.back().source = source;
			returnVal = tempTicker;
			tempTicker++;
		}
		default:
			break;
	}

	return returnVal;
}

unsigned OperatorNode::gen3AC(std::vector<ThreeAddress>& instructions, unsigned& tempTicker) {
	unsigned rhs, lhs = -1;
	// Get tmp register location of rhs
	rhs = children[0]->gen3AC(instructions, tempTicker);
	// If lhs exists get register location of it
	if (children.size() > 1) {
		lhs = children[0]->gen3AC(instructions, tempTicker);
	}

	instructions.emplace_back();

	// We only need one type since we already coerce
	std::string rhsType = (children[0]->etype & EINT) | (children[0]->etype & ECHAR) | (children[0]->etype & EPOINTER)
		? "ITemp"
		: "FTemp";

	instructions.back().dest = "(" + rhsType + " " + std::to_string(tempTicker) + ")";
	unsigned tmp = tempTicker;
	tempTicker++;

	switch (opType) {
		case OBAND: {
			instructions.back().op = "AND";
			instructions.back().op1 = "(" + rhsType + " " + std::to_string(rhs) + ")";
			instructions.back().op2 = "(" + rhsType + " " + std::to_string(lhs) + ")";
			instructions.back().source = source;
			break;
		}
		case OBOR: {
			instructions.back().op = "OR";
			instructions.back().op1 = "(" + rhsType + " " + std::to_string(rhs) + ")";
			instructions.back().op2 = "(" + rhsType + " " + std::to_string(lhs) + ")";
			instructions.back().source = source;
			break;
		}
		case OBXOR: {
			instructions.back().op = "XOR";
			instructions.back().op1 = "(" + rhsType + " " + std::to_string(rhs) + ")";
			instructions.back().op2 = "(" + rhsType + " " + std::to_string(lhs) + ")";
			instructions.back().source = source;
			break;
		}
		case OBNOT: {
			instructions.back().op = "NOT";
			instructions.back().op1 = "(" + rhsType + " " + std::to_string(rhs) + ")";
			instructions.back().source = source;
			break;
		}
		case OLSHIFT: {
			instructions.back().op = "SLL";
			instructions.back().op1 = "(" + rhsType + " " + std::to_string(rhs) + ")";
			instructions.back().op2 = "(" + rhsType + " " + std::to_string(lhs) + ")";
			instructions.back().source = source;
			break;
		}
		case ORSHIFT: {
			instructions.back().op = "SRL";
			instructions.back().op1 = "(" + rhsType + " " + std::to_string(rhs) + ")";
			instructions.back().op2 = "(" + rhsType + " " + std::to_string(lhs) + ")";
			instructions.back().source = source;
			break;
		}
		// Arithmetic
		case OMOD: {
			instructions.back().op = "MOD"; // Not an instruction in mips but will need to happen in 3ac->asm
			instructions.back().op1 = "(" + rhsType + " " + std::to_string(rhs) + ")";
			instructions.back().op2 = "(" + rhsType + " " + std::to_string(lhs) + ")";
			instructions.back().source = source;
			break;
		}
		case ODIV: {
			instructions.back().op = "DIV";
			instructions.back().op1 = "(" + rhsType + " " + std::to_string(rhs) + ")";
			instructions.back().op2 = "(" + rhsType + " " + std::to_string(lhs) + ")";
			instructions.back().source = source;
			break;
		}
		case OMULT: {
			instructions.back().op = "MULT";
			instructions.back().op1 = "(" + rhsType + " " + std::to_string(rhs) + ")";
			instructions.back().op2 = "(" + rhsType + " " + std::to_string(lhs) + ")";
			instructions.back().source = source;
			break;
		}
		case OADD: {
			instructions.back().op = "ADD";
			instructions.back().op1 = "(" + rhsType + " " + std::to_string(rhs) + ")";
			instructions.back().op2 = "(" + rhsType + " " + std::to_string(lhs) + ")";
			instructions.back().source = source;
			break;
		}
		case OSUB: {
			instructions.back().op = "SUB";
			instructions.back().op1 = "(" + rhsType + " " + std::to_string(rhs) + ")";
			instructions.back().op2 = "(" + rhsType + " " + std::to_string(lhs) + ")";
			instructions.back().source = source;
			break;
		}
		case OINCPOST:
		case OINC: {
			instructions.back().op = "ADDI";
			instructions.back().op1 = "(" + rhsType + " " + std::to_string(rhs) + ")";
			instructions.back().op2 = "1";
			instructions.back().source = source;
			break;
		}
		case ODECPOST:
		case ODEC: {
			instructions.back().op = "SUBI";
			instructions.back().op1 = "(" + rhsType + " " + std::to_string(rhs) + ")";
			instructions.back().op2 = "1";
			instructions.back().source = source;
			break;
		}
		// Logic
		case OLNOT: {
			instructions.back().op = "NOT";
			instructions.back().op1 = "(" + rhsType + " " + std::to_string(rhs) + ")";
			instructions.back().source = source;
			break;
		}
		case OLAND: {
			instructions.back().op = "LAND";
			instructions.back().op1 = "(" + rhsType + " " + std::to_string(rhs) + ")";
			instructions.back().op2 = "(" + rhsType + " " + std::to_string(lhs) + ")";
			instructions.back().source = source;
			break;
		}
		case OLOR: {
			instructions.back().op = "LOR";
			instructions.back().op1 = "(" + rhsType + " " + std::to_string(rhs) + ")";
			instructions.back().op2 = "(" + rhsType + " " + std::to_string(lhs) + ")";
			instructions.back().source = source;
			break;
		}
		// Comparison
		case OLESS: {
			instructions.back().op = "LT";
			instructions.back().op1 = "(" + rhsType + " " + std::to_string(rhs) + ")";
			instructions.back().op2 = "(" + rhsType + " " + std::to_string(lhs) + ")";
			instructions.back().source = source;
			break;
		}
		case OGREAT: {
			instructions.back().op = "GT";
			instructions.back().op1 = "(" + rhsType + " " + std::to_string(rhs) + ")";
			instructions.back().op2 = "(" + rhsType + " " + std::to_string(lhs) + ")";
			instructions.back().source = source;
			break;
		}
		case OLEQ: {
			instructions.back().op = "LE";
			instructions.back().op1 = "(" + rhsType + " " + std::to_string(rhs) + ")";
			instructions.back().op2 = "(" + rhsType + " " + std::to_string(lhs) + ")";
			instructions.back().source = source;
			break;
		}
		case OGEQ: {
			instructions.back().op = "GE";
			instructions.back().op1 = "(" + rhsType + " " + std::to_string(rhs) + ")";
			instructions.back().op2 = "(" + rhsType + " " + std::to_string(lhs) + ")";
			instructions.back().source = source;
			break;
		}
		case OEQUAL: {
			instructions.back().op = "EQ";
			instructions.back().op1 = "(" + rhsType + " " + std::to_string(rhs) + ")";
			instructions.back().op2 = "(" + rhsType + " " + std::to_string(lhs) + ")";
			instructions.back().source = source;
			break;
		}
		case ONEQ: {
			instructions.back().op = "NE";
			instructions.back().op1 = "(" + rhsType + " " + std::to_string(rhs) + ")";
			instructions.back().op2 = "(" + rhsType + " " + std::to_string(lhs) + ")";
			instructions.back().source = source;
			break;
		}
		// Other
		case OSIZE: {
			// TODO(Rowan) - Maybe get around to this
			throw ParserError("Not dealing with sizeof.");
			// instructions.back().op = "XOR";
			// instructions.back().op1 = "(" + rhsType + " " + std::to_string(rhs) + ")";
			// instructions.back().op2 = "(" + rhsType + " " + std::to_string(lhs) + ")";
			// instructions.back().source = source;
			break;
		}
		case OTERNARY: {
			// TODO(Rowan) - Maybe get around to this
			throw ParserError("Not dealing with turnary operator.");
			// instructions.back().op = "XOR";
			// instructions.back().op1 = "(" + rhsType + " " + std::to_string(rhs) + ")";
			// instructions.back().op2 = "(" + rhsType + " " + std::to_string(lhs) + ")";
			// instructions.back().source = source;
			break;
		}
	}
	return tmp;
}

unsigned IdentifierNode::gen3AC(std::vector<ThreeAddress>& instructions, unsigned& tempTicker) {
	instructions.emplace_back();
	instructions.back().op = "ASSIGN";

	std::string type = etype & EINT || etype & ECHAR || sym->v.pointerLevel != 0
		? "ITemp"
		: "FTemp";

	std::string scope = sym->scopeLevel == 0
		? "Global"
		: "Local";

	instructions.back().dest = std::string("(") + type + " " + std::to_string(tempTicker) + ")";
	instructions.back().op1 = "(" + scope + " " + std::to_string(sym->offset) + ")";
	instructions.back().source = source;
	unsigned tmp = tempTicker;
	tempTicker++;

	return tmp;
}

unsigned FunctionNode::gen3AC(std::vector<ThreeAddress>& instructions, unsigned& tempTicker) {
	instructions.emplace_back();
	instructions.back().op = "LABEL";
	instructions.back().source = source;


	if(func->label == "") {
		unsigned i = 1;
		for(const auto& f : sym->functions) {
			if(&f == func) {
				func->label = instructions.back().op1 = sym->name + std::to_string(i);
				break;
			}
			i++;
		}
	} else {
		instructions.back().op1 = func->label;
	}

	for(SyntaxNode* c : children) {
		if(c != nullptr) {
			c->gen3AC(instructions, tempTicker);
		}
	}

	return 0;
}
