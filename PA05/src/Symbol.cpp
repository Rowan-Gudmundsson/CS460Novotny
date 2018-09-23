#include "Symbol.h"

/**
 * Equality operator for VarType.
 * @param {const VarType&} rhs - The right hand side of the operator
 * @return {bool} - the value of the comparison
 */
bool Symbol::VarType::operator == (const VarType& rhs) const {
	return name == rhs.name;
}

/**
 * Less than operator for VarType.
 * @param {const VarType&} rhs - The right hand side of the operator
 * @return {bool} - the value of the comparison
 */
bool Symbol::VarType::operator < (const VarType& rhs) const {
	return name < rhs.name;
}

/**
 * Greater than operator for VarType.
 * @param {const VarType&} rhs - The right hand side of the operator
 * @return {bool} - the value of the comparison
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
	Node* other_conduct = other.head;
	Node* this_conduct = head;
	while(other_conduct != nullptr) {
		this_conduct = new Node(other_conduct->value->copy(), other_conduct->next);
		other_conduct = other_conduct->next;
		this_conduct = other_conduct->next;
	}
	return (*this);
}

/**
 * Insert a BT into the linked list based stack.
 * @param {const BinaryTree<VarType>&} val - The value to insert.
 * @return {bool} - Whether or not the value was successfully inserted.
 */
bool Symbol::insert(const BinaryTree<VarType>& val) {
	if (head == nullptr) {
		head = new Node(val.copy(), nullptr);
		return true;
	}

	Node* tmp = new Node(val.copy(), head);
	head = tmp;
	return true;
}

/**
 * Return a pointer to the VarType which matches the key given.
 * @param None.
 * @return {T*} - The address of the value found, nullptr if nothing.
 */
Symbol::VarType* Symbol::find(std::string key) {
	Node* conductor = head;
	VarType* result;
	VarType keyVal(key);
	while(conductor != nullptr) {
		result = conductor->value->find(keyVal);
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
bool Symbol::pop() {
	if (head == nullptr) {
		return false;
	}

	Node* tmp = head;
	head = head->next;
	delete tmp->value;
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
	Node* tmp = head;
	while(head != nullptr) {
		tmp = head;
		head = head->next;
		delete tmp->value;
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
	out << rhs.name;
	return stream;
}
