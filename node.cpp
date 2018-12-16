#include "node.h"

std::string fixedLength(int value, int digits = 5) {
	unsigned int uvalue = value;
	if (value < 0) { uvalue = -uvalue; }
	std::string result;
	while (digits-- > 0) {
		result += ('0' + uvalue % 10);
		uvalue /= 10;
	}
	if (value < 0) { result += '-'; }
	std::reverse(result.begin(), result.end());
	return result;
}

ConstantNode* evalConst(SyntaxNode* node) {
	if (!node->isConst) { throw ParserError("Cannot evaluate non-constant expression."); }

	if (node->type == SyntaxNode::CONSTANT) { return (ConstantNode*) node; }

	if (node->type == SyntaxNode::OPERATOR) { return ((OperatorNode*) node)->evalNode(); }

	throw ParserError("Something went horribly awry...");
}

SyntaxNode::SyntaxNode(const Source& s, Type t, EvalType e, unsigned n...)
    : type(t), etype(e), line(s.line), source(s.source) {
	if (n > 0) {
		va_list args;
		va_start(args, n);

		children.resize(n);

		for (unsigned i = 0; i < n; i++) { children[i] = va_arg(args, SyntaxNode*); }

		va_end(args);
	}
}

void SyntaxNode::semanticCheck() {
	for (SyntaxNode* child : children) {
		if (child != nullptr) child->semanticCheck();
	}

	// Compress generic nodes
	// If a node has generic children, then just grab all of the grandchildren
	if (type != Type::CONDITIONAL) {
		for (unsigned i = 0; i < children.size(); i++) {
			if (children[i] == nullptr) {
				if (type == GENERIC) {
					children.erase(children.begin() + i);
					i--;
				}
			} else if (children[i]->type == GENERIC) {
				unsigned size = children[i]->children.size();
				children.insert(children.begin() + i, children[i]->children.begin(),
				                children[i]->children.end());
				delete children[i + size];
				children.erase(children.begin() + i + size);
				i--;
			} else if (children[i]->type == IDENTIFIER && type == GENERIC) {
				delete children[i];
				children.erase(children.begin() + i);
				i--;
			}
		}
	}
}

void FunctionNode::semanticCheck() {
	SyntaxNode::semanticCheck();

	// Replace the symbol references for the function to the defined function reference
	// for (auto& i : sym->functions) {
	// 	bool notMatched = false;
	// 	for (unsigned j = 0; j < i.parameters.size(); j++) {
	// 		if (j > func->parameters.size() - 1) {
	// 			notMatched = true;
	// 			break;
	// 		}
	// 		if (i.parameters[j].first != func->parameters[j].first) {
	// 			notMatched = true;
	// 			break;
	// 		}
	// 	}
	// 	if (!notMatched) {
	// 		i = *func;
	// 		std::cout << "Replacing..." << std::endl;
	// 	}
	// }
	// Try and find return statements - make certain they match the function
	std::queue<SyntaxNode*> check;
	SyntaxNode* next;

	check.push(this);
	while (!check.empty()) {
		next = check.front();
		check.pop();

		if (next == nullptr) continue;

		for (SyntaxNode* child : next->children) { check.push(child); }

		if (next->type == SyntaxNode::Type::RETURN) {
			if (next->children.size() == 0) {
				// Not returning anything - but a non-void funciton
				if (func->returnType.type != EvalType::VOID)
					throw ParserError("Missing return value in non-void function", source);
			} else if (func->returnType.type == EvalType::VOID) {
				// Returning something but a void function
				throw ParserError("Attempting to return value from void function", source);
			} else if (func->returnType != next->children.front()->etype) {
				// Returning something in a non-void function, but types don't match
				// So insert a coercion
				SyntaxNode* ret = next->children.front();

				next->children.front() =
				    new CoercionNode({line, source}, ret->etype, func->returnType, ret);
			}
		}
	}
}

OperatorNode::OperatorNode(const Source& s, EvalType _type, OpType _opType, unsigned n...)
    : SyntaxNode(s, OPERATOR, _type, 0), opType(_opType) {
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
	if (!isConst) { throw ParserError("Cannot evaluate non-constant expression."); }

	ConstantNode* lhs = children[0]->type == SyntaxNode::CONSTANT ?
	                        (ConstantNode*) children[0] :
	                        ((OperatorNode*) children[0])->evalNode();

	ConstantNode* rhs = children.size() > 1 ? children[1]->type == SyntaxNode::CONSTANT ?
	                                          (ConstantNode*) children[1] :
	                                          ((OperatorNode*) children[1])->evalNode() :
	                                          nullptr;

	switch (opType) {
		// Binary Operators
		case OBAND: {
			if (etype.integral()) {
				return new ConstantNode({line, source}, etype, lhs->i & rhs->i);
			} else {
				throw ParserError("Cannot perform operation of type \"&\" on non-integral types.");
			}
		}
		case OBOR: {
			if (etype.integral()) {
				return new ConstantNode({line, source}, etype, lhs->i | rhs->i);
			} else {
				throw ParserError("Cannot perform operation of type \"|\" on non-integral types.");
			}
		}
		case OBXOR: {
			if (etype.integral()) {
				return new ConstantNode({line, source}, etype, lhs->i ^ rhs->i);
			} else {
				throw ParserError("Cannot perform operation of type \"^\" on non-integral types.");
			}
		}
		case OBNOT: {
			if (etype.integral()) {
				return new ConstantNode({line, source}, etype, ~lhs->i);
			} else {
				throw ParserError("Cannot perform operation of type \"~\" on non-integral types.");
			}
		}
		case OLSHIFT: {
			if (etype.integral()) {
				return new ConstantNode({line, source}, etype, lhs->i << rhs->i);
			} else {
				throw ParserError("Cannot perform operation of type \"<<\" on non-integral types.");
			}
		}
		case ORSHIFT: {
			if (etype.integral()) {
				return new ConstantNode({line, source}, etype, lhs->i >> rhs->i);
			} else {
				throw ParserError("Cannot perform operation of type \">>\" on non-integral types.");
			}
		}
		// Arithmetic
		case OMOD: {
			if (etype.integral()) {
				return new ConstantNode({line, source}, etype, lhs->i % rhs->i);
			} else {
				throw ParserError("Cannot perform operation of type \"%\" on non-integral types.");
			}
		}
		case ODIV: {
			if (etype.integral()) {
				return new ConstantNode({line, source}, etype, lhs->i / rhs->i);
			} else {
				throw ParserError("Cannot perform operation of type \"/\" on non-integral types.");
			}
		}
		case OMULT: {
			if (etype.integral()) {
				return new ConstantNode({line, source}, etype, lhs->i * rhs->i);
			} else {
				throw ParserError("Cannot perform operation of type \"*\" on non-integral types.");
			}
		}
		case OADD: {
			if (etype.integral()) {
				return new ConstantNode({line, source}, etype, lhs->i + rhs->i);
			} else {
				throw ParserError("Cannot perform operation of type \"+\" on non-integral types.");
			}
		}
		case OSUB: {
			if (etype.integral()) {
				return new ConstantNode({line, source}, etype, lhs->i - rhs->i);
			} else {
				throw ParserError("Cannot perform operation of type \"-\" on non-integral types.");
			}
		}
		case OINCPOST:
		case OINC: {
			if (etype.integral()) {
				return new ConstantNode({line, source}, etype, ++lhs->i);
			} else {
				throw ParserError("Cannot perform operation of type \"++\" on non-integral types.");
			}
		}
		case ODECPOST:
		case ODEC: {
			if (etype.integral()) {
				return new ConstantNode({line, source}, etype, --lhs->i);
			} else {
				throw ParserError("Cannot perform operation of type \"%\" on non-integral types.");
			}
		}
		// Logic
		case OLNOT: {
			if (etype.integral()) {
				return new ConstantNode({line, source}, etype, (long int) (!lhs->i));
			} else {
				throw ParserError("Cannot perform operation of type \"!\" on non-integral types.");
			}
		}
		case OLAND: {
			if (etype.integral()) {
				return new ConstantNode({line, source}, etype, (long int) (lhs->i && rhs->i));
			} else {
				throw ParserError("Cannot perform operation of type \"&&\" on non-integral types.");
			}
		}
		case OLOR: {
			if (etype.integral()) {
				return new ConstantNode({line, source}, etype, (long int) (lhs->i || rhs->i));
			} else {
				throw ParserError("Cannot perform operation of type \"||\" on non-integral types.");
			}
		}
		// Comparison
		case OLESS: {
			if (etype.integral()) {
				return new ConstantNode({line, source}, etype, (long int) (lhs->i < rhs->i));
			} else {
				throw ParserError("Cannot perform operation of type \"<\" on non-integral types.");
			}
		}
		case OGREAT: {
			if (etype.integral()) {
				return new ConstantNode({line, source}, etype, (long int) (lhs->i > rhs->i));
			} else {
				throw ParserError("Cannot perform operation of type \">\" on non-integral types.");
			}
		}
		case OLEQ: {
			if (etype.integral()) {
				return new ConstantNode({line, source}, etype, (long int) (lhs->i <= rhs->i));
			} else {
				throw ParserError("Cannot perform operation of type \"<=\" on non-integral types.");
			}
		}
		case OGEQ: {
			if (etype.integral()) {
				return new ConstantNode({line, source}, etype, (long int) (lhs->i >= rhs->i));
			} else {
				throw ParserError("Cannot perform operation of type \">=\" on non-integral types.");
			}
		}
		case OEQUAL: {
			if (etype.integral()) {
				return new ConstantNode({line, source}, etype, (long int) (lhs->i == rhs->i));
			} else {
				throw ParserError("Cannot perform operation of type \"==\" on non-integral types.");
			}
		}
		case ONEQ: {
			if (etype.integral()) {
				return new ConstantNode({line, source}, etype, (long int) (lhs->i != rhs->i));
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
#define PROCESS_VAL(p)          \
	case (SyntaxNode::Type::p): \
		out << #p;              \
		break;
	switch (t) {
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
		PROCESS_VAL(STRUCT_ACCESS);
		PROCESS_VAL(RETURN);
	}
#undef PROCESS_VAL

	return out;
}

std::ostream& operator<<(std::ostream& out, const SyntaxNode* n) {
	out << "[.{";

	if (n == nullptr) {
		out << "\\textbf{nullptr}} ]";
		return out;
	}

	switch (n->type) {
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

	for (unsigned i = 0; i < n.children.size(); i++) { out << n.children[i]; }

	return out;
}

std::ostream& operator<<(std::ostream& out, const ConstantNode& n) {
	if (n.etype.type == EvalType::CHARACTER) {
		out << '\'' << (char) (n.i) << '\'';
	} else if (n.etype == EvalType::ESTRING) {
		out << '\"' << *n.s << '\"';
	} else if (n.etype.integral()) {
		out << n.i;
	} else if (n.etype.floating()) {
		out << n.f;
	}
	out << "} ";

	return out;
}

std::ostream& operator<<(std::ostream& out, const OperatorNode& n) {
	// TODO: Actually do this output
	out << "\\textbf{";

	switch (n.opType) {
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
		case OperatorNode::OpType::OMODEQ:
			out << "%=";
			break;
		case OperatorNode::OpType::ODIVEQ:
			out << "/=";
			break;
		case OperatorNode::OpType::OMULTEQ:
			out << "*=";
			break;
		case OperatorNode::OpType::OADDEQ:
			out << "+=";
			break;
		case OperatorNode::OpType::OSUBEQ:
			out << "-=";
			break;
		case OperatorNode::OpType::OLEFTEQ:
			out << "<<=";
			break;
		case OperatorNode::OpType::ORIGHTEQ:
			out << ">>=";
			break;
		case OperatorNode::OpType::OANDEQ:
			out << "&=";
			break;
		case OperatorNode::OpType::OXOREQ:
			out << "^=";
			break;
		case OperatorNode::OpType::OOREQ:
			out << "|=";
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

		case OperatorNode::OpType::ODEREF:
			out << "*->";
			break;
	}

	out << "}} ";

	for (unsigned i = 0; i < n.children.size(); i++) { out << n.children[i]; }
	return out;
}

std::ostream& operator<<(std::ostream& out, const IdentifierNode& n) {
	out << *n.sym << " " << n.etype << "} ";

	for (unsigned i = 0; i < n.children.size(); i++) { out << n.children[i]; }
	return out;
}

std::ostream& operator<<(std::ostream& out, const CoercionNode& n) {
	out << "COERCION from: " << n.from << "->" << n.to << "} ";

	for (auto i : n.children) { out << i; }

	return out;
}

std::ostream& operator<<(std::ostream& out, const FunctionNode& n) {
	out << n.sym->name << "(";
	// std::cout <<* n.sym << std::endl;
	// std::cout << "defined: " << n.func->defined << std::endl
	//           << "line: " << n.func->functionDefLine << std::endl
	//           << "col: " << n.func->functionDefCol << std::endl
	//           << "params: " << n.func->parameters.size() << std::endl;
	// std::cout << "Address: " << ((void*)& n.func) << std::endl;

	for (unsigned i = 0; i < n.func->parameters.size(); i++) {
		// std::cout << "Doing the thing" << std::endl;
		// std::cout << "i: " << i << std::endl;
		out << n.func->parameters.at(i).first << " " << n.func->parameters.at(i).second;
		// std::cout << n.func->parameters.at(i) << std::endl;
		if (i < n.func->parameters.size() - 1) { out << ", "; }
	}
	out << ")} ";

	for (unsigned i = 0; i < n.children.size(); i++) { out << n.children[i]; }
	return out;
}

std::ostream& operator<<(std::ostream& out, const FunctionCallNode& n) {
	out << "CALL TO " << n.sym->name << "(";

	for (unsigned i = 0; i < n.func->parameters.size(); i++) {
		out << n.func->parameters[i].first << " " << n.func->parameters[i].second;
		if (i < n.func->parameters.size() - 1) { out << ", "; }
	}
	out << ")} ";

	for (unsigned i = 0; i < n.children.size(); i++) { out << n.children[i]; }

	return out;
}

std::ostream& operator<<(std::ostream& out, const LoopNode& n) {
	out << (n.pre_check ? "PRE_CHECK_LOOP" : "POST_CHECK_LOOP") << "} ";

	for (unsigned i = 0; i < n.children.size(); i++) { out << n.children[i]; }
	return out;
}

void SyntaxNode::clear() {
	for (SyntaxNode*& c : children) {
		if (c != nullptr) {
			c->clear();
			delete c;
			c = nullptr;
		}
	}
	children.clear();
}

Operand SyntaxNode::gen3AC(std::vector<ThreeAddress>& instructions, unsigned& tempTicker,
                           unsigned& labelTicker, Symbol::FunctionType* func) {
	switch (type) {
		case ASSIGN:
		case DECLARE_AND_INIT: {
			Operand dest = children[0]->gen3AC(instructions, tempTicker, labelTicker, func);
			Operand op1  = children[1]->gen3AC(instructions, tempTicker, labelTicker, func);
			instructions.emplace_back(source, "ASSIGN", op1, dest);
			return dest;
		}
		case ACCESS: {
			std::string type = children[0]->etype.integral() ? "ITemp" : "FTemp";
			Symbol::SymbolType* sym;
			unsigned offset;

			if (children[0]->type == IDENTIFIER) {
				sym    = ((IdentifierNode*) children[0])->sym;
				offset = sym->offset;
			} else if (children[0]->type == STRUCT_ACCESS) {
				sym    = ((IdentifierNode*) children[0]->children[1])->sym;
				offset = sym->offset + ((IdentifierNode*) children[0]->children[0])->sym->offset;
			}
			unsigned blockSize;
			Operand lastTemp;
			Operand nextTemp;

			for (unsigned i = 1; i < children.size(); i++) {
				blockSize = 1;
				for (unsigned j = i; j < sym->v.arrayDimensions.size(); j++) {
					blockSize *= sym->v.arrayDimensions[j];
				}

				nextTemp = Operand{"ITemp", tempTicker};
				instructions.emplace_back(
				    source, "MULT",
				    children[i]->gen3AC(instructions, tempTicker, labelTicker, func),
				    Operand{"ICONS", blockSize * sym->etype.size()}, nextTemp);

				tempTicker++;

				if (i > 1) {
					instructions.emplace_back(source, "ADD", lastTemp, nextTemp,
					                          Operand{"ITemp", tempTicker});
					nextTemp = Operand{"ITemp", tempTicker};
					tempTicker++;
				}

				lastTemp = nextTemp;
			}

			instructions.emplace_back(source, "ADD", Operand{"ICONS", offset}, lastTemp,
			                          Operand{"ITemp", tempTicker});
			tempTicker++;

			instructions.emplace_back(source, "OFFSET", Operand{"ITemp", tempTicker - 1});

			if (children[0]->etype.floating())
				return {"FINDR", tempTicker - 1};
			else
				return {"IINDR", tempTicker - 1};
		}
		case GENERIC: {
			for (SyntaxNode* c : children) {
				if (c != nullptr) { c->gen3AC(instructions, tempTicker, labelTicker, func); }
			}
			return {"", ""};
		}
		case CONDITIONAL: {
			Operand cond = children[0]->gen3AC(instructions, tempTicker, labelTicker, func);
			std::string nextLabel = "if" + std::to_string(labelTicker);
			labelTicker++;

			instructions.emplace_back(source, "BREQ", cond, Operand{"ICONS", 0},
			                          Operand{"LABEL", nextLabel});

			children[1]->gen3AC(instructions, tempTicker, labelTicker, func);

			instructions.emplace_back("\t}", "LABEL", Operand{"LABEL", nextLabel});

			if (children.size() > 2) {
				// Jump to the end once we're don with the first body of the if
				nextLabel = "if" + std::to_string(labelTicker);
				instructions.emplace_back("", "BR", Operand{"", ""}, Operand{"LABEL", nextLabel});
				labelTicker++;

				// The else
				children[2]->gen3AC(instructions, tempTicker, labelTicker, func);

				instructions.emplace_back("\t}", "LABEL", Operand{"LABEL", nextLabel});
			}

			return {"ERR", "ERR"};
		}
		case STRUCT_ACCESS: {
			if (((IdentifierNode*) children[1])->sym->etype.floating())
				return {"FLocal", ((IdentifierNode*) children[0])->sym->offset +
				                      ((IdentifierNode*) children[1])->sym->offset};
			else
				return {"ILocal", ((IdentifierNode*) children[0])->sym->offset +
				                      ((IdentifierNode*) children[1])->sym->offset};
		}
		case RETURN: {
			if (children.size() > 0) {
				std::string type = func->returnType.integral() ? "ILocal" : "FLocal";
				instructions.emplace_back(
				    source, "ASSIGN",
				    children[0]->gen3AC(instructions, tempTicker, labelTicker, func),
				    Operand{type, func->size + 4});
			}

			instructions.emplace_back(source, "RETURN");
			return {"ERR", "ERR"};
			break;
		}
		default: {
			for (SyntaxNode* c : children) {
				if (c != nullptr) { c->gen3AC(instructions, tempTicker, labelTicker, func); }
			}
			return {"ERR", "ERR"};
		}
	}
}

Operand OperatorNode::gen3AC(std::vector<ThreeAddress>& instructions, unsigned& tempTicker,
                             unsigned& labelTicker, Symbol::FunctionType* func) {
	Operand rhs, lhs;

	// TODO - The below code is definitely broken, but I'm working on something
	// else right now

	// Get tmp register location of rhs
	lhs = children[0]->gen3AC(instructions, tempTicker, labelTicker, func);
	// If rhs exists get register location of it
	if (children.size() > 1) {
		rhs = children[1]->gen3AC(instructions, tempTicker, labelTicker, func);
	}

	// We only need one type since we already coerce
	std::string rhsType =
	    (children[0]->etype.integral() || children[0]->etype.pointer() > 0) ? "ITemp" : "FTemp";

	Operand dest(rhsType, tempTicker);
	tempTicker++;

	switch (opType) {
		case OBAND: {
			instructions.emplace_back(source, "AND", lhs, rhs, dest);
			break;
		}
		case OBOR: {
			instructions.emplace_back(source, "OR", lhs, rhs, dest);
			break;
		}
		case OBXOR: {
			instructions.emplace_back(source, "XOR", lhs, rhs, dest);
			break;
		}
		case OBNOT: {
			instructions.emplace_back(source, "NOT", lhs, dest);
			break;
		}
		case OLSHIFT: {
			instructions.emplace_back(source, "SLL", lhs, rhs, dest);
			break;
		}
		case ORSHIFT: {
			instructions.emplace_back(source, "SRL", lhs, rhs, dest);
			break;
		}
		// Arithmetic
		case OMOD: {
			instructions.emplace_back(source, "MOD", lhs, rhs, dest);
			break;
		}
		case ODIV: {
			instructions.emplace_back(source, "DIV", lhs, rhs, dest);
			break;
		}
		case OMULT: {
			instructions.emplace_back(source, "MULT", lhs, rhs, dest);
			break;
		}
		case OADD: {
			instructions.emplace_back(source, "ADD", lhs, rhs, dest);
			break;
		}
		case OSUB: {
			instructions.emplace_back(source, "SUB", lhs, rhs, dest);
			break;
		}
		case OINCPOST:
		case OINC: {
			instructions.emplace_back(source, "ADD", lhs, Operand{"ICONS", 1}, lhs);
			tempTicker--;
			break;
		}
		case ODECPOST:
		case ODEC: {
			instructions.emplace_back(source, "SUB", lhs, Operand{"ICONS", 1}, lhs);
			tempTicker--;
			break;
		}
		// Arithmetic assignment
		case OMODEQ:
			instructions.emplace_back(source, "MOD", lhs, rhs, lhs);
			tempTicker--;
			break;
		case ODIVEQ:
			instructions.emplace_back(source, "DIV", lhs, rhs, lhs);
			tempTicker--;
			break;
		case OMULTEQ:
			instructions.emplace_back(source, "MULT", lhs, rhs, lhs);
			tempTicker--;
			break;
		case OADDEQ:
			instructions.emplace_back(source, "ADD", lhs, rhs, lhs);
			tempTicker--;
			break;
		case OSUBEQ:
			instructions.emplace_back(source, "SUB", lhs, rhs, lhs);
			tempTicker--;
			break;
		case OLEFTEQ:
			instructions.emplace_back(source, "SLL", lhs, rhs, lhs);
			tempTicker--;
			break;
		case ORIGHTEQ:
			instructions.emplace_back(source, "SRL", lhs, rhs, lhs);
			tempTicker--;
			break;
		case OANDEQ:
			instructions.emplace_back(source, "AND", lhs, rhs, lhs);
			tempTicker--;
			break;
		case OXOREQ:
			instructions.emplace_back(source, "XOR", lhs, rhs, lhs);
			tempTicker--;
			break;
		case OOREQ:
			instructions.emplace_back(source, "OR", lhs, rhs, lhs);
			tempTicker--;
			break;
		// Logic
		case OLNOT: {
			instructions.emplace_back(source, "NOT", lhs, dest);
			break;
		}
		case OLAND: {
			instructions.emplace_back(source, "LAND", lhs, rhs, dest);
			break;
		}
		case OLOR: {
			instructions.emplace_back(source, "LOR", lhs, rhs, dest);
			break;
		}
		// Comparison
		case OLESS: {
			instructions.emplace_back(source, "LT", lhs, rhs, dest);
			break;
		}
		case OGREAT: {
			instructions.emplace_back(source, "GT", lhs, rhs, dest);
			break;
		}
		case OLEQ: {
			instructions.emplace_back(source, "LE", lhs, rhs, dest);
			break;
		}
		case OGEQ: {
			instructions.emplace_back(source, "GE", lhs, rhs, dest);
			break;
		}
		case OEQUAL: {
			instructions.emplace_back(source, "EQ", lhs, rhs, dest);
			break;
		}
		case ONEQ: {
			instructions.emplace_back(source, "NE", lhs, rhs, dest);
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
		case ODEREF: {
			// TODO (Rowan) - Actually do this
			throw ParserError("Not doing dereference yet.");
			break;
		}
	}
	return dest;
}

Operand IdentifierNode::gen3AC(std::vector<ThreeAddress>& instructions, unsigned& tempTicker,
                               unsigned& labelTicker, Symbol::FunctionType* func) {
	if (sym->scopeLevel != 0) {
		if (sym->etype.floating())
			return {"FLocal", sym->offset};
		else
			return {"ILocal", sym->offset};
	} else {
		return {"Global", sym->name};
	}
}

Operand CoercionNode::gen3AC(std::vector<ThreeAddress>& instructions, unsigned& tempTicker,
                             unsigned& labelTicker, Symbol::FunctionType* func) {
	if ((from.integral() && to.integral()) || (from.floating() && to.floating())) {
		// If we're converting between similar types, just pass up
		// TODO - maybe in the future actully do something here
		return children[0]->gen3AC(instructions, tempTicker, labelTicker, func);
	}

	std::string toType = (to.floating()) ? "FTemp" : "ITemp";

	Operand dest(toType, tempTicker);
	tempTicker++;
	instructions.emplace_back(
	    source, "ASSIGN", children[0]->gen3AC(instructions, tempTicker, labelTicker, func), dest);

	return dest;
}

Operand FunctionNode::gen3AC(std::vector<ThreeAddress>& instructions, unsigned& tempTicker,
                             unsigned& labelTicker, Symbol::FunctionType* funcPtr) {
	if (func->label == "") {
		unsigned i = 1;
		for (const auto& f : sym->functions) {
			if (&f == func) {
				func->label = sym->name + std::to_string(i);
				break;
			}
			i++;
		}
	}

	instructions.emplace_back(source, "LABEL", Operand{"LABEL", func->label});
	// TODO (Rowan) - Figure out stack frame size - add as destination
	unsigned stackSize = func->size + func->returnType.size() + 4;
	instructions.emplace_back(source, "PROCENTRY", Operand{"ICONS", stackSize});

	for (SyntaxNode* c : children) {
		if (c != nullptr) { c->gen3AC(instructions, tempTicker, labelTicker, func); }
	}

	instructions.emplace_back("}", "RETURN");

	return {"LABEL", func->label};
}

Operand FunctionCallNode::gen3AC(std::vector<ThreeAddress>& instructions, unsigned& tempTicker,
                                 unsigned& labelTicker, Symbol::FunctionType* funcPtr) {
	if (func->label == "") {
		unsigned i = 1;
		for (const auto& f : sym->functions) {
			if (&f == func) {
				func->label = sym->name + std::to_string(i);
				break;
			}
			i++;
		}
	}

	instructions.emplace_back(source, "ARGS", Operand{"ICONS", unsigned(children.size())});
	for (unsigned i = 0; i < children.size(); i++) {
		// if (func->parameters[i].second == nullptr) {
		// 	throw std::logic_error("We should be catching this before here.");
		// }
		// int offset = func->size + func->returnType.size() -
		//              ((Symbol::SymbolType*) func->parameters[i].second)->offset + 4;
		// Operand tmp = children[i]->gen3AC(instructions, tempTicker, labelTicker, func);
		// instructions.emplace_back(source, "VALOUT", tmp, Operand{"ICONS", offset});
	}
	instructions.emplace_back(source, "CALL", Operand{"", ""}, Operand{"LABEL", func->label});
	if (func->returnType.floating())
		return {"FLocal", -func->returnType.size()};
	else
		return {"ILocal", -func->returnType.size()};
}

Operand LoopNode::gen3AC(std::vector<ThreeAddress>& instructions, unsigned& tempTicker,
                         unsigned& labelTicker, Symbol::FunctionType* func) {
	// reserves 2 labels, its fine we have plenty even if they dont get used 😃
	unsigned beginLabel = labelTicker, endLabel = labelTicker + 1;
	labelTicker += 2;
	if (children[0] != nullptr) {
		children[0]->gen3AC(instructions, tempTicker, labelTicker, func);
	}
	instructions.emplace_back(source, "LABEL", Operand{"LABEL", "LL" + fixedLength(beginLabel)});
	if (pre_check && children[1] != nullptr) {
		instructions.emplace_back(
		    source, "BREQ",
		    Operand{"ITemp",
		            children[1]->gen3AC(instructions, tempTicker, labelTicker, func).value},
		    Operand{"ICONS", 0}, Operand{"LABEL", "LL" + fixedLength(endLabel)});
	}
	if (children[3] != nullptr) {
		children[3]->gen3AC(instructions, tempTicker, labelTicker, func);
	}
	if (children[2] != nullptr) {
		children[2]->gen3AC(instructions, tempTicker, labelTicker, func);
	}
	if (pre_check) {
		instructions.emplace_back("\t}", "BR");
		instructions.back().dest = Operand{"LABEL", "LL" + fixedLength(beginLabel)};
	}
	if (pre_check) {
		instructions.emplace_back("", "LABEL", Operand{"LABEL", "LL" + fixedLength(endLabel)});
	}
	if (!pre_check && children[1] != nullptr) {
		instructions.emplace_back(
		    "", "BRNE",
		    Operand{"ITemp",
		            children[1]->gen3AC(instructions, tempTicker, labelTicker, func).value},
		    Operand{"ICONS", 0}, Operand{"LABEL", "LL" + fixedLength(beginLabel)});
	}

	return {"", ""};
}

Operand ConstantNode::gen3AC(std::vector<ThreeAddress>& instructions, unsigned& tempTicker,
                             unsigned& labelTicker, Symbol::FunctionType* func) {
	if (etype.integral()) {
		return {"ICONS", (int) i};
	} else if (etype.floating()) {
		return {"FCONS", f};
	} else {
		return {"String", *s};
	}
}

std::ostream& operator<<(std::ostream& out, const ThreeAddress& ins) {
	out << std::left << std::setw(20) << ins.op << std::setw(20) << ins.op1 << std::setw(20)
	    << ins.op2 << std::setw(20) << ins.dest;

	return out;
}

std::ostream& operator<<(std::ostream& out, const Operand& op) {
	unsigned width = out.width();
	unsigned spaces;
	out.width(0);
	if (op.type.size() > 0 || op.value.size() > 0) {
		std::string o = '(' + op.type + ' ' + op.value + ')';
		spaces        = ((o.size() > width) ? 0 : width - o.size());
		out << o;
	} else {
		spaces = width;
	}

	for (unsigned i = 0; i < spaces; i++) { out << ' '; }

	return out;
}
