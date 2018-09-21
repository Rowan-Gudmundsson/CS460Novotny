#include "Symbol.h"

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
 * Return a copy of the head of the list.
 * @param None.
 * @return {BinaryTree<T>} - The copy of the head data;
 */
template<typename T>
BinaryTree<T> BinaryTree<T>::peek() {
	return *head->value;
}

/**
 * Remove the item from the head of the list.
 * @param None.
 * @return {bool} - Whether or not the pop was successful.
 */
template<typename T>
bool BinaryTree<T>::pop() {
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
}
/**
 * Destructor
 * @param None
 * @return None
 */
Symbol::~Symbol() {
	clear();
}
