#include "Symbol.h"

/**
 * Equality operator for VarType.
 * @param {const VarType&} rhs - The right hand side of the operator
 * @return {bool} - the tree of the comparison
 */
bool Symbol::VarType::operator == (const VarType& rhs) const {
	return name == rhs.name;
}

/**
 * Less than operator for VarType.
 * @param {const VarType&} rhs - The right hand side of the operator
 * @return {bool} - the tree of the comparison
 */
bool Symbol::VarType::operator < (const VarType& rhs) const {
	return name < rhs.name;
}

/**
 * Greater than operator for VarType.
 * @param {const VarType&} rhs - The right hand side of the operator
 * @return {bool} - the tree of the comparison
 */
bool Symbol::VarType::operator > (const VarType& rhs) const {
	return name > rhs.name;
}

/**
 * Constructor.
 * @param None
 * @return None
 */
Symbol::Symbol() {
	head = nullptr;
	pushScope();
}

/**
 * Copy Constructor
 * @param {const Symbol&} other - The Symbol table we asssign to this
 * @return None
 */
Symbol::Symbol(const Symbol& other) {
	head = nullptr;
	(*this) = other;
}

/**
 * Assignment operator
 * @param {const Symbol&} other - The symbol table we assign to this
 * @return {Symbol&} - To allow for A = B = C.
 */
Symbol& Symbol::operator = (const Symbol& other) {
	Scope* other_conduct = other.head;
	Scope* this_conduct = head;
	while(other_conduct != nullptr) {
		this_conduct = new Scope(other_conduct->tree->copy(), other_conduct->next);
		other_conduct = other_conduct->next;
		this_conduct = other_conduct->next;
	}
	return (*this);
}

/**
 * Push a new scope onto the stack.
 * @param None.
 * @return {bool} - successful or not.
 */
bool Symbol::pushScope() {
	if (head == nullptr) {
		head = new Scope(new BinaryTree<std::string, VarType>(), nullptr);
		return true;
	}

	Scope* tmp = new Scope(new BinaryTree<std::string, VarType>(), head);
	head = tmp;
	return true;
}

/**
 * Insert a BT into the linked list based stack.
 * @param {const BinaryTree<VarType>&} val - The tree to insert.
 * @return {bool} - Whether or not the tree was successfully inserted.
 */
bool Symbol::insert(const VarType& val) {
	return head->tree->insert(val.name, val) != nullptr;
}

/**
 * Return a pointer to the VarType which matches the key given.
 * @param None.
 * @return {T*} - The address of the tree found, nullptr if nothing.
 */
Symbol::VarType* Symbol::find(std::string key) {
	Scope* conductor = head;
	VarType* result;
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
 * Remove the item from the head of the list.
 * @param None.
 * @return {bool} - Whether or not the pop was successful.
 */
bool Symbol::popScope() {
	if (head == nullptr) {
		return false;
	}

	Scope* tmp = head;
	head = head->next;
	delete tmp->tree;
	delete tmp;
	tmp = nullptr;

	return true;
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

std::ostream& operator << (std::ostream& stream, const Symbol::VarType& rhs) {
	stream << rhs.name;
	return stream;
}
