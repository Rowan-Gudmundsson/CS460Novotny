#include "node.h"

std::string fixedLength(int value, int digits = 5) {
    unsigned int uvalue = value;
    if (value < 0) {
        uvalue = -uvalue;
    }
    std::string result;
    while (digits-- > 0) {
        result += ('0' + uvalue % 10);
        uvalue /= 10;
    }
    if (value < 0) {
        result += '-';
    }
    std::reverse(result.begin(), result.end());
    return result;
}

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
			out << "$\\leq$";
			break;
		case OperatorNode::OpType::OGEQ:
			out << "$\\geq$";
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

Operand SyntaxNode::gen3AC(std::vector<ThreeAddress>& instructions, unsigned& tempTicker, unsigned& labelTicker) {
	switch(type) {
		case ASSIGN:
		case DECLARE_AND_INIT: {
			Operand dest = children[0]->gen3AC(instructions, tempTicker, labelTicker);
			instructions.emplace_back(source, "ASSIGN", children[1]->gen3AC(instructions, tempTicker, labelTicker), dest);
			return dest;
		}
		case ACCESS: {
			std::string type = children[0]->etype & EINT || children[0]->etype & ECHAR
				? "ITemp"
				: "FTemp";
			unsigned offset = ((IdentifierNode*) children[0])->sym->offset;

			instructions.emplace_back(source, "MULT", children[1]->gen3AC(instructions, tempTicker, labelTicker), Operand{"ICONS", size(((IdentifierNode*) children[0])->sym->etype)}, Operand{"ITemp", tempTicker});
			tempTicker++;

			instructions.emplace_back(source, "ADD", Operand{"ICONS", offset}, Operand{"ITemp", tempTicker - 1}, Operand{"ITemp", tempTicker});
			tempTicker++;

			return {"INDR", tempTicker - 1};
		}
		case GENERIC: {
			for(SyntaxNode* c : children) {
				if(c != nullptr) {
					c->gen3AC(instructions, tempTicker, labelTicker);
				}
			}
			return {"", ""};
		}
		case CONDITIONAL: {
			Operand cond = children[0]->gen3AC(instructions, tempTicker, labelTicker);
			std::string nextLabel = "if" + std::to_string(labelTicker);
			labelTicker++;

			instructions.emplace_back(source, "BREQ", cond, Operand{"ICONS", 0}, Operand{"LABEL", nextLabel});

			children[1]->gen3AC(instructions, tempTicker, labelTicker);

			instructions.emplace_back("}", "LABEL", Operand{"LABEL", nextLabel});

			if(children.size() > 2) {
				// Jump to the end once we're don with the first body of the if
				nextLabel = "if" + std::to_string(labelTicker);
				instructions.emplace_back("", "BR", Operand{"", ""}, Operand{"LABEL", nextLabel});
				labelTicker++;

				// The else
				children[2]->gen3AC(instructions, tempTicker, labelTicker);

				instructions.emplace_back("}", "LABEL", Operand{"LABEL", nextLabel});
			}

			return {"ERR", "ERR"};
		}
		default: {
			for(SyntaxNode* c : children) {
				if(c != nullptr) {
					c->gen3AC(instructions, tempTicker, labelTicker);
				}
			}
			return {"ERR", "ERR"};
		}
	}
}

Operand OperatorNode::gen3AC(std::vector<ThreeAddress>& instructions, unsigned& tempTicker, unsigned& labelTicker) {
	Operand rhs, lhs;

	// TODO - The below code is definitely broken, but I'm working on something else right now

	// Get tmp register location of rhs
	lhs = children[0]->gen3AC(instructions, tempTicker, labelTicker);
	// If rhs exists get register location of it
	if (children.size() > 1) {
		rhs = children[1]->gen3AC(instructions, tempTicker, labelTicker);
	}

	// We only need one type since we already coerce
	std::string rhsType = (children[0]->etype & EINT) | (children[0]->etype & ECHAR) | (children[0]->etype & EPOINTER)
		? "ITemp"
		: "FTemp";

	Operand dest(rhsType, tempTicker);
	tempTicker++;

	switch (opType) {
		case OBAND: {
			instructions.emplace_back(source, "AND", rhs, lhs, dest);
			break;
		}
		case OBOR: {
			instructions.emplace_back(source, "OR", rhs, lhs, dest);
			break;
		}
		case OBXOR: {
			instructions.emplace_back(source, "XOR", rhs, lhs, dest);
			break;
		}
		case OBNOT: {
			instructions.emplace_back(source, "NOT", lhs, dest);
			break;
		}
		case OLSHIFT: {
			instructions.emplace_back(source, "SLL", rhs, lhs, dest);
			break;
		}
		case ORSHIFT: {
			instructions.emplace_back(source, "SRL", rhs, lhs, dest);
			break;
		}
		// Arithmetic
		case OMOD: {
			instructions.emplace_back(source, "MOD", rhs, lhs, dest);
			break;
		}
		case ODIV: {
			instructions.emplace_back(source, "DIV", rhs, lhs, dest);
			break;
		}
		case OMULT: {
			instructions.emplace_back(source, "MULT", rhs, lhs, dest);
			break;
		}
		case OADD: {
			instructions.emplace_back(source, "ADD", rhs, lhs, dest);
			break;
		}
		case OSUB: {
			instructions.emplace_back(source, "SUB", rhs, lhs, dest);
			break;
		}
		case OINCPOST:
		case OINC: {
			instructions.emplace_back(source, "ADDI", lhs, Operand{"ICONS", 1}, dest);
			break;
		}
		case ODECPOST:
		case ODEC: {
			instructions.emplace_back(source, "SUBI", lhs, Operand{"ICONS", 1}, dest);
			break;
		}
		// Logic
		case OLNOT: {
			instructions.emplace_back(source, "NOT", lhs, dest);
			break;
		}
		case OLAND: {
			instructions.emplace_back(source, "LAND", rhs, lhs, dest);
			break;
		}
		case OLOR: {
			instructions.emplace_back(source, "LOR", rhs, lhs, dest);
			break;
		}
		// Comparison
		case OLESS: {
			instructions.emplace_back(source, "LT", rhs, lhs, dest);
			break;
		}
		case OGREAT: {
			instructions.emplace_back(source, "GT", rhs, lhs, dest);
			break;
		}
		case OLEQ: {
			instructions.emplace_back(source, "LE", rhs, lhs, dest);
			break;
		}
		case OGEQ: {
			instructions.emplace_back(source, "GE", rhs, lhs, dest);
			break;
		}
		case OEQUAL: {
			instructions.emplace_back(source, "EQ", rhs, lhs, dest);
			break;
		}
		case ONEQ: {
			instructions.emplace_back(source, "NE", rhs, lhs, dest);
			break;
		}
		// Other
		case OSIZE: {
			// TODO(Rowan) - Maybe get around to this
			throw ParserError("Not dealing with sizeof.");
			break;
		}
		case OTERNARY: {
			// TODO(Rowan) - Maybe get around to this
			throw ParserError("Not dealing with turnary operator.");
			break;
		}
	}
	return dest;
}

Operand IdentifierNode::gen3AC(std::vector<ThreeAddress>& instructions, unsigned& tempTicker, unsigned& labelTicker) {
	if(sym->scopeLevel != 0) {
		return {"Local", sym->offset};
	} else {
		return {"Global", sym->name};
	}
}

Operand CoercionNode::gen3AC(std::vector<ThreeAddress>& instructions, unsigned& tempTicker, unsigned& labelTicker) {
	if((from & (EINT | ESHORT | ELONG | ECHAR) && to & (EINT | ESHORT | ELONG | ECHAR)) || (from & (EFLOAT | EDOUBLE) && to & (EFLOAT | EDOUBLE))) {
		// If we're converting between similar types, just pass up
		// TODO - maybe in the future actully do something here
		return children[0]->gen3AC(instructions, tempTicker, labelTicker);
	}

	std::string toType = (to & (EFLOAT | EDOUBLE)) ?
		"FTemp" :
		"ITemp";

	Operand dest(toType, tempTicker);
	tempTicker++;
	instructions.emplace_back(source, "ASSIGN", children[0]->gen3AC(instructions, tempTicker, labelTicker), dest);

	return dest;
}

Operand FunctionNode::gen3AC(std::vector<ThreeAddress>& instructions, unsigned& tempTicker, unsigned& labelTicker) {
	if(func->label == "") {
		unsigned i = 1;
		for(const auto& f : sym->functions) {
			if(&f == func) {
				func->label = sym->name + std::to_string(i);
				break;
			}
			i++;
		}
	}

	instructions.emplace_back(source, "LABEL", Operand{"LABEL", func->label});
	instructions.emplace_back(source, "PROCENTRY");

	for(SyntaxNode* c : children) {
		if(c != nullptr) {
			c->gen3AC(instructions, tempTicker, labelTicker);
		}
	}

	instructions.emplace_back("}", "RETURN");

	return {"LABEL", func->label};
}

Operand FunctionCallNode::gen3AC(std::vector<ThreeAddress>& instructions, unsigned& tempTicker, unsigned& labelTicker) {
	if(func->label == "") {
		unsigned i = 1;
		for(const auto& f : sym->functions) {
			if(&f == func) {
				func->label = sym->name + std::to_string(i);
				break;
			}
			i++;
		}
	}

	instructions.emplace_back(source, "ARGS", Operand{"CONS", unsigned(callParameters.size())});
	for (SyntaxNode* i : callParameters) {
		Operand tmp = i->gen3AC(instructions, tempTicker, labelTicker);
		instructions.emplace_back(source, "VALOUT", tmp);
	}
	instructions.emplace_back(source, "CALL", Operand{"LABEL", func->label});
	unsigned returnVal = tempTicker;
	tempTicker++;
	return {((func->returnType & (EINT | ECHAR)) ? "ITemp" : "FTemp"), returnVal};
}

Operand LoopNode::gen3AC(std::vector<ThreeAddress>& instructions, unsigned& tempTicker, unsigned& labelTicker) {
	// reserves 2 labels, its fine we have plenty even if they dont get used 😃
	unsigned beginLabel = labelTicker, endLabel = labelTicker + 1;
	labelTicker += 2;
	if (children[0] != nullptr) {
		children[0]->gen3AC(instructions, tempTicker, labelTicker);
	}
	instructions.emplace_back(source, "LABEL", Operand{"LABEL", "LL" + fixedLength(beginLabel)});
	if (pre_check && children[1] != nullptr) {
		instructions.emplace_back(source, "BREQ",
			Operand{"ITemp", children[1]->gen3AC(instructions, tempTicker, labelTicker).value},
			Operand{"CONS", 0},
			Operand{"LABEL", "LL" + fixedLength(endLabel)}
		);
	}
	if (children[3] != nullptr) {
		children[3]->gen3AC(instructions, tempTicker, labelTicker);
	}
	if (children[2] != nullptr) {
		children[2]->gen3AC(instructions, tempTicker, labelTicker);
	}
	if (pre_check) {
		instructions.emplace_back("}", "BR");
		instructions.back().dest = Operand{"LABEL", "LL" + fixedLength(beginLabel)};
	}
	if (pre_check) {
		instructions.emplace_back("", "LABEL", Operand{"LABEL", "LL" + fixedLength(endLabel)});
	}
	if (!pre_check && children[1] != nullptr) {
		instructions.emplace_back("", "BRNE",
			Operand{"ITemp", children[1]->gen3AC(instructions, tempTicker, labelTicker).value},
			Operand{"CONS", 0},
			Operand{"LABEL", "LL" + fixedLength(beginLabel)}
		);
	}

	return {"", ""};
}

Operand ConstantNode::gen3AC(std::vector<ThreeAddress>& instructions, unsigned& tempTicker, unsigned& labelTicker) {
	if(etype & (EINT | ESHORT | ELONG | ECHAR)) {
		return {"ICONS", (int) i};
	} else if(etype & (EFLOAT | EDOUBLE)) {
		return {"FCONS", f};
	} else {
		return {"String", *s};
	}
}

std::ostream& operator<<(std::ostream& out, const ThreeAddress& ins) {
	out << std::left << std::setw(20) << ins.op << std::setw(20)  << ins.op1 << std::setw(20)  << ins.op2 << std::setw(20) << ins.dest;

	return out;
}

std::ostream& operator<<(std::ostream& out, const Operand& op) {
	unsigned width = out.width();
	unsigned spaces;
	out.width(0);
	if(op.type.size() > 0 || op.value.size() > 0) {
		std::string o = '(' + op.type + ' ' + op.value + ')';
		spaces = ((o.size() > width) ? 0 : width - o.size());
		out << o;
	} else {
		spaces = width;
	}

	for(unsigned i = 0; i < spaces; i++) {
		out << ' ';
	}

	return out;
}
