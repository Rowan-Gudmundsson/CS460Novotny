#include "symbol.h"

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

Symbol::SymbolType& Symbol::SymbolType::operator = (const SymbolType& rhs) {
	name = rhs.name;
	lineNumber = rhs.lineNumber;
	_scopeLevel = rhs._scopeLevel;
	type = rhs.type;
	return *this;
}

/**
 * Constructor.
 * @param None
 * @return None
 */
Symbol::Symbol() : head(nullptr), scopeLevel(_scopeLevel) {
	pushScope();
	mode = Mode::READ;
}

/**
 * Copy Constructor
 * @param {const Symbol&} other - The Symbol table we asssign to this
 * @return None
 */
Symbol::Symbol(const Symbol& other) : head(nullptr), scopeLevel(_scopeLevel) {
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
	head = tmp;
	_scopeLevel++;
	return _scopeLevel;
}

/**
 * Insert a BT into the linked list based stack.
 * @param {const BinaryTree<SymbolType>&} val - The tree to insert.
 * @return {bool} - Whether or not the tree was successfully inserted.
 */
Symbol::SymbolType* Symbol::insert(const SymbolType& val) {
	SymbolType* re = head->tree->insert(val.name, val);
	re->_scopeLevel = _scopeLevel;
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
		conductor = conductor->next;
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
	if (head == nullptr) {
		throw std::logic_error("Tried to pop a scope when there were no scopes.");
	}

	Scope* tmp = head;
	head = head->next;
	delete tmp->tree;
	delete tmp;
	tmp = nullptr;

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
	while(head != nullptr) {
		tmp = head;
		head = head->next;
		delete tmp->tree;
		delete tmp;
	}
	head = nullptr;
	return true;
}

/**
 * Destructor
 * @param None
 * @return None
 */
Symbol::~Symbol() {
	clear();
}

std::ostream& operator << (std::ostream& stream, const Symbol::SymbolType& rhs) {
	stream << rhs.name;
	return stream;
}
