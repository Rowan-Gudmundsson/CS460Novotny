#include "symbol.h"
#include <stdio.h>

#ifdef YYDEBUG
extern int yydebug;
extern int yyparse;
#endif


/**
 * Equality operator for SymbolType.
 * @param {const SymbolType&} rhs - The right hand side of the operator
 * @return {bool} - the tree of the comparison
 */
bool Symbol::SymbolType::operator == (const SymbolType& rhs) const {
	return name == rhs.name;
}

/**
 * Less than operator for SymbolType.
 * @param {const SymbolType&} rhs - The right hand side of the operator
 * @return {bool} - the tree of the comparison
 */
bool Symbol::SymbolType::operator < (const SymbolType& rhs) const {
	return name < rhs.name;
}

/**
 * Greater than operator for SymbolType.
 * @param {const SymbolType&} rhs - The right hand side of the operator
 * @return {bool} - the tree of the comparison
 */
bool Symbol::SymbolType::operator > (const SymbolType& rhs) const {
	return name > rhs.name;
}

std::ostream& operator << (std::ostream& out, const Symbol::SymbolType& sym) {
	if(sym.itype == Symbol::SymbolType::FUNCTION) {
		if(sym.isFunctionDefined) {
			out << "<" << sym.name << "(), line " << sym.functionDefLine << ">";
		} else {
			out << "<" << sym.name << "(), not defined>";
		}
	} else if (sym.isArray) {
		out << "<" << sym.name;
		for (auto i : sym.arrayDimensions) {
			out << "[" << i << "]";
		}
		out << ", line " << sym.lineNumber << ">";
	} else if (sym.pointerLevel > 0) {
		out << "<" << sym.name << "$^{";
		for (unsigned i = 0; i < sym.pointerLevel; i++) {
			out << "*";
		}
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
Symbol::Symbol() : scopeLevel(_scopeLevel) {
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
Symbol& Symbol::operator = (const Symbol& other) {
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

std::ostream& operator << (std::ostream& out, const Symbol& table) {
	Symbol::Scope* conductor = table.head;
	unsigned scopeLevel = table._scopeLevel;
	while(conductor != nullptr) {
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
		head = new Scope(new BinaryTree<std::string, SymbolType>(), nullptr);
		_scopeLevel = 0;
		return true;
	}

	Scope* tmp = new Scope(new BinaryTree<std::string, SymbolType>(), head);
	head->children.push_back(tmp);
	head = tmp;
	_scopeLevel++;


	return _scopeLevel;
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
	Scope* conductor = head;
	SymbolType* result;
	while(conductor != nullptr) {
		result = conductor->tree->find(key);
		if (result != nullptr) {
			return result;
		}
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

	head = head->parent;

	_scopeLevel--;

	return _scopeLevel;
}

/**
 * Clear the table
 * @param None
 * @return {bool} - If the clear was successful
 */
bool Symbol::clear() {
	Scope* tmp = head;
	// Find the root
	while(tmp->parent != nullptr) {
		tmp = tmp->parent;
	}
	clearFrom(tmp);
	return true;
}

void Symbol::clearFrom(Scope* s) {
	if(s == nullptr) return;
	for(Scope* _s : s->children) {
		clearFrom(_s);
	}

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

// void Symbol::debug_token(std::string tokenName, int tokenLine, unsigned tokenScope)
// {
// 	std::cout << "XXX DEBUG TOKEN CALLED" << std::endl;
// 	if(lexDLevel > 0 || debug_token_enabled)
// 	{
// 		debug_token_stream << "Identifier found: " << tokenName
// 		          << " on line: " << tokenLine
// 		          << " in scope level: " << tokenScope
// 		          << " (current scope level: " << scopeLevel << ")" << std::endl;
// 	}
// }


// void Symbol::toggleDebug_token_enabled()
// {
// 	debug_token_enabled = !debug_token_enabled;
// }

// void Symbol::toggleDebug_parse_enabled()
// {
// 	#ifdef YYDEBUG
// 	debug_parse_enabled = !debug_parse_enabled;
// 	if(parseDLevel == 0)
// 	{
// 		yydebug = debug_parse_enabled ? 1 : 0;
// 	}

// 	std::cout << "XXX PARSER DEBUG CALLED " << yydebug << std::endl;

// 	#endif

// }
