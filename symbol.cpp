#include "symbol.h"
#include <stdio.h>

#ifdef YYDEBUG
extern int yydebug;
extern int yyparse;
#endif

const EvalType EvalType::EUNKNOWN  = EvalType(CUNKNOWN);
const EvalType EvalType::EVOID     = EvalType(CVOID);
const EvalType EvalType::ECHAR     = EvalType(CCHAR);
const EvalType EvalType::ESTRING   = EvalType(CSTRING);
const EvalType EvalType::EUNSIGNED = EvalType(CUNSIGNED);
const EvalType EvalType::EINT      = EvalType(CINT);
const EvalType EvalType::ELONG     = EvalType(CLONG);
const EvalType EvalType::ESHORT    = EvalType(CSHORT);
const EvalType EvalType::EFLOAT    = EvalType(CFLOAT);
const EvalType EvalType::EDOUBLE   = EvalType(CDOUBLE);

std::ostream& operator<<(std::ostream& out, const EvalType& a) {
	if (a.qualifiers[0].cons) out << "const ";
	if (a.qualifiers[0].volatil) out << "volatile ";

	switch (a.type) {
		case EvalType::UNKNOWN:
			out << "unknown";
			return out;
		case EvalType::VOID:
			out << "void";
			return out;
		case EvalType::CHARACTER:
			if (!a.sign) out << "unsigned ";
			out << "char";
			break;
		case EvalType::INTEGER:
			if (!a.sign) out << "unsigned ";
			switch (a.length) {
				case EvalType::SHORT:
					out << "short ";
					break;
				case EvalType::NORMAL:
					break;
				case EvalType::LONG:
					out << "long ";
					break;
			}
			out << "int";
			break;
		case EvalType::FLOATING:
			switch (a.length) {
				case EvalType::SHORT:
					out << "float";
					break;
				case EvalType::NORMAL:
					out << "double";
					break;
				case EvalType::LONG:
					out << "long double";
					break;
			}
			break;
		case EvalType::OBJECT:
			out << "Object " << a.obj->sym->name;
			break;
	}

	bool needSpace = true;
	for (unsigned i = 1; i < a.qualifiers.size(); i++) {
		if (needSpace) out << ' ';
		out << '*';
		needSpace = false;
		if (a.qualifiers[i].cons) {
			needSpace = true;
			out << " const";
		}
		if (a.qualifiers[i].volatil) {
			needSpace = true;
			out << " volatile";
		}
	}

	return out;
}

unsigned EvalType::size() const {
	if (pointer() > 0) {
		// Pointer size
		return 4;
	}

	switch (type) {
		case EvalType::UNKNOWN:
			return -1;
		case EvalType::VOID:
			return 0;
		case EvalType::CHARACTER:
			return 4;
		case EvalType::INTEGER:
			// TODO - actual different sizes
			return 4;
		case EvalType::FLOATING:
			switch (length) {
				case EvalType::SHORT:
					return 4;
				case EvalType::NORMAL:
				case EvalType::LONG:
					return 8;
			}
		case EvalType::OBJECT:
			return obj->size;
	}

	return -2;
}

/**
 * Equality operator for SymbolType.
 * @param {const SymbolType&} rhs - The right hand side of the operator
 * @return {bool} - the tree of the comparison
 */
bool Symbol::SymbolType::operator==(const SymbolType& rhs) const {
	return name == rhs.name;
}

/**
 * Less than operator for SymbolType.
 * @param {const SymbolType&} rhs - The right hand side of the operator
 * @return {bool} - the tree of the comparison
 */
bool Symbol::SymbolType::operator<(const SymbolType& rhs) const {
	return name < rhs.name;
}

/**
 * Greater than operator for SymbolType.
 * @param {const SymbolType&} rhs - The right hand side of the operator
 * @return {bool} - the tree of the comparison
 */
bool Symbol::SymbolType::operator>(const SymbolType& rhs) const {
	return name > rhs.name;
}

std::ostream& operator<<(std::ostream& out, const Symbol::SymbolType& sym) {
	if (sym.itype == Symbol::SymbolType::FUNCTION) {
		// TODO - figure this out
		// if(sym.isFunctionDefined) {
		//	out << "<" << sym.name << "(), line " << sym.functionDefLine << ">";
		//} else {
		out << "<" << sym.name << "()>";
		//}
	} else if (sym.itype == Symbol::SymbolType::STRUCT) {
		out << "{Struct " << sym.name << "}";
	} else if (sym.v.isArray) {
		out << "<" << sym.name;
		for (auto i : sym.v.arrayDimensions) { out << "[" << i << "]"; }
		out << ", line " << sym.lineNumber << ">";
	} else if (sym.etype.pointer() > 0) {
		out << "<" << sym.name << "$^{";
		for (unsigned i = 0; i < sym.etype.pointer(); i++) { out << "*"; }
		out << "}$, line " << sym.lineNumber << ">";
	} else {
		out << "<" << sym.name << ", line " << sym.lineNumber << ">";
	}
	return out;
}

/**
 * Constructor.
 * @param None
 * @return None
 */
Symbol::Symbol() : scopeLevel(_scopeLevel), head(nullptr) {
	pushScope();
	mode = Mode::READ;
}

/**
 * Copy Constructor
 * @param {const Symbol&} other - The Symbol table we asssign to this
 * @return None
 */
Symbol::Symbol(const Symbol& other) : scopeLevel(_scopeLevel), head(nullptr) {
	(*this) = other;
}

/**
 * Assignment operator
 * @param {const Symbol&} other - The symbol table we assign to this
 * @return {Symbol&} - To allow for A = B = C.
 */
Symbol& Symbol::operator=(const Symbol& other) {
	/* // TODO - This doesn't work - I don't wanna fix it right now
	Scope* other_conduct = other.head;
	Scope* this_conduct = head;
	while(other_conduct != nullptr) {
	    this_conduct = new Scope(other_conduct->tree->copy(), other_conduct->next);
	    other_conduct = other_conduct->next;
	    this_conduct = other_conduct->next;
	}
	*/
	return (*this);
}

std::ostream& operator<<(std::ostream& out, const Symbol& table) {
	Symbol::Scope* conductor = table.head;
	unsigned scopeLevel      = table._scopeLevel;
	while (conductor != nullptr) {
		out << "Scope level: " << scopeLevel << std::endl << *conductor->tree << std::endl;
		scopeLevel--;
		conductor = conductor->parent;
	}
	return out;
}

/**
 * Push a new scope onto the stack.
 * @param None.
 * @return {unsigned} - New scope level
 */
unsigned Symbol::pushScope() {
	if (head == nullptr) {
		head        = new Scope(new BinaryTree<std::string, SymbolType>(), nullptr);
		_scopeLevel = 0;
		return true;
	}

	Scope* tmp = new Scope(new BinaryTree<std::string, SymbolType>(), head);

	if (nextFunction != nullptr) {
		tmp->func    = nextFunction;
		nextFunction = nullptr;
	}

	head->children.push_back(tmp);
	head = tmp;
	_scopeLevel++;

	recentlyDeletedScope = true;

	return _scopeLevel;
}

void Symbol::setLastScopeFunction(FunctionType* f) {
	if (head->children.size() > 0)
		head->children.back()->func = f;
	else
		head->func = f;
}

void Symbol::setNextScopeFunction(FunctionType* f) {
	nextFunction = f;
}

/**
 * Insert a BT into the linked list based stack.
 * @param {const BinaryTree<SymbolType>&} val - The tree to insert.
 * @return {bool} - Whether or not the tree was successfully inserted.
 */
Symbol::SymbolType* Symbol::insert(const std::string& name, unsigned line) {
	SymbolType* re = head->tree->insert(name, SymbolType(name, line, _scopeLevel));
	return re;
}

/**
 * Return a pointer to the SymbolType which matches the key given.
 * @param None.
 * @return {T*} - The address of the tree found, nullptr if nothing.
 */
Symbol::SymbolType* Symbol::find(std::string key) {
	if (structScope != nullptr) { return structScope->tree->find(key); }

	Scope* conductor = head;
	SymbolType* result;
	while (conductor != nullptr) {
		result = conductor->tree->find(key);
		if (result != nullptr) { return result; }
		conductor = conductor->parent;
	}
	return nullptr;
}

/**
 * Return a pointer to the SymbolType which matches the key given only in the current scope
 * @param {std::string} name - The name oof the variable we are trying to find.
 * @return {SymbolType*} - A pointer to the variable or nullptr if it doesnt exist.
 */
Symbol::SymbolType* Symbol::findInCurrentScope(std::string name) {
	if (structScope != nullptr)
		return structScope->tree->find(name);
	else
		return head->tree->find(name);
}

/**
 * Remove the item from the head of the list.
 * @param None.
 * @return {unsigned} - New scope level
 */
unsigned Symbol::popScope() {
	if (head->parent == nullptr) {
		throw std::logic_error("Tried to pop a scope from global scope");
	}

	// If there are no variables in this scope - it is useless
	if (head->tree->size == 0 && head->children.size() == 0) {
		Scope* parent               = head->parent;
		std::vector<Scope*>& pchild = parent->children;
		pchild.erase(std::find(pchild.begin(), pchild.end(), head));
		delete head;
		head                 = parent;
		recentlyDeletedScope = true;
	} else {
		recentlyDeletedScope = false;
		head                 = head->parent;
	}

	_scopeLevel--;

	return _scopeLevel;
}

unsigned Symbol::unPopScope() {
	if (recentlyDeletedScope) return _scopeLevel;

	head = head->children.back();
	_scopeLevel++;

	return _scopeLevel;
}

void Symbol::popBackToGlobal() {
	if (head->parent != nullptr) {
		while (popScope() > 0)
			;
	}
}

void Symbol::setCurrentObject(Object* obj) {
	if (obj == nullptr)
		structScope = nullptr;
	else
		structScope = obj->vars;
}

void Symbol::calcStructOffsets() {
	Scope* tmp = head;
	// Find the root
	while (tmp->parent != nullptr) { tmp = tmp->parent; }

	calcStructOffsetsFrom(tmp);
}

void Symbol::calcStructOffsetsFrom(Scope* scope) {
	if (scope->isStruct) return;

	unsigned offset;
	unsigned mult;

	for (Symbol::SymbolType& s : *scope->tree) {
		if (s.itype == Symbol::SymbolType::STRUCT) {
			offset = 0;
			for (Symbol::SymbolType& structSym : *s.obj->vars->tree) {
				if (structSym.itype != Symbol::SymbolType::STRUCT) {
					structSym._offset = offset;
					mult              = 1;
					for (unsigned i : structSym.v.arrayDimensions) { mult *= i; }
					offset += mult * structSym.etype.size();
				}
			}
			s.obj->size = offset;
		}
	}

	for (Scope* s : scope->children) { calcStructOffsetsFrom(s); }
}

void Symbol::calcOffsets() {
	Scope* tmp = head;
	// Find the root
	while (tmp->parent != nullptr) { tmp = tmp->parent; }

	for (Scope* s : tmp->children) { calcOffsetsFrom(s, 0); }
}

void Symbol::calcOffsetsFrom(Scope* scope, unsigned offset) {
	if (scope->isStruct) return;

	for (Symbol::SymbolType& s : *scope->tree) {
		if (s.itype != Symbol::SymbolType::STRUCT) {
			s._offset = offset;
			std::cout << "Offset of " << s << ": " << offset << std::endl;
			unsigned mult = 1;
			for (unsigned i : s.v.arrayDimensions) { mult *= i; }
			offset += mult * s.etype.size();
		}
	}

	for (Scope* s : scope->children) { calcOffsetsFrom(s, offset); }

	if (scope->func != nullptr) { scope->func->size = offset; }
}

void Symbol::printStructs(std::ostream& out) {
	Scope* tmp = head;
	// Find the root
	while (tmp->parent != nullptr) { tmp = tmp->parent; }

	int xoffset = 0;
	printStructsFrom(tmp, out, xoffset, false);
}

void Symbol::printStructsFrom(Scope* s, std::ostream& out, int& xoffset, bool printedPackage) {
	bool didPrintPackage = printedPackage;

	for (const Symbol::SymbolType& sym : *s->tree) {
		if (sym.itype == SymbolType::STRUCT) {
			if (!didPrintPackage && s->func != nullptr) {
				out << "\t\\begin{package}{" << s->func->name << "}\n";
				didPrintPackage = true;
			}
			sym.obj->print(out, xoffset);
			xoffset += 7;
		}
	}

	for (Scope* sub : s->children) { printStructsFrom(sub, out, xoffset, didPrintPackage); }

	if (!printedPackage && didPrintPackage) { out << "\t\\end{package}\n"; }
}

BinaryTree<std::string, Symbol::SymbolType>& Symbol::getGlobals() {
	Scope* tmp = head;
	// Find the root
	while (tmp->parent != nullptr) { tmp = tmp->parent; }

	return *tmp->tree;
}

/**
 * Clear the table
 * @param None
 * @return {bool} - If the clear was successful
 */
bool Symbol::clear() {
	Scope* tmp = head;
	// Find the root
	while (tmp->parent != nullptr) { tmp = tmp->parent; }
	clearFrom(tmp);
	return true;
}

void Symbol::clearFrom(Scope* s) {
	if (s == nullptr) return;

	while (!s->children.empty()) { clearFrom(s->children.front()); }

	Scope* parent = s->parent;
	if (parent != nullptr) {
		if (!parent->children.empty()) {
			auto i = std::find(parent->children.begin(), parent->children.end(), s);
			if (i != parent->children.end()) { parent->children.erase(i); }
		}
	}
	delete s->tree;
	delete s;
}

/**
 * Destructor
 * @param None
 * @return None
 */
Symbol::~Symbol() {
	clear();
}

std::ostream& Object::print(std::ostream& out, int xoffset) {
	out << "\t\\begin{class}{" << sym->name << "}{" << xoffset << ", 0}\n";

	out << "\t\t\\attribute{size = " << size << "}\n";
	for (const Symbol::SymbolType& s : *vars->tree) {
		out << "\t\t\\attribute{" << s.name << " : " << s.etype << " (" << s.offset << ")}\n";
	}
	out << "\t\\end{class}\n";

	return out;
}
