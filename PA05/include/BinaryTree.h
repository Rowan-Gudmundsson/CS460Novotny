#pragma once

#include <iostream>

#define COLOR "\033"
#define BLACK "[1;30m"
#define RED "[1;31m"

template <typename NodeVal>
class BinaryTree {
	public:
		// Constructors
		BinaryTree();
		BinaryTree(const BinaryTree& other);

		// Operators
		BinaryTree<NodeVal>& operator = (const BinaryTree<NodeVal>& other);

		// Member functions
		bool insert(const NodeVal& val);
		BinaryTree<NodeVal>* copy() const;

		NodeVal* find(const NodeVal& key);

		friend std::ostream& operator << (std::ostream& stream, const BinaryTree<NodeVal>& rhs);

		// Destructors
		~BinaryTree();

	private:
		struct Node {
			Node() {};
			Node(NodeVal val, Node* left_ptr, Node* right_ptr, Node* parent_ptr, bool is_red):
				data(val),
				left(left_ptr),
				right(right_ptr),
				parent(parent_ptr),
				red(is_red) {}
			NodeVal data;
			Node* left;
			Node* right;
			Node* parent;
			bool red;
		};

		Node* root;

		void insertRepair(Node* repairFrom);
		Node* uncle(Node* nephew);
		void rotateLeft(Node* about);
		void rotateRight(Node* about);

		void outputHelper(std::string spaces, Node* node, std::ostream& out, bool isLeft);
};

/**
 * Constructor.
 * @param None.
 * @return None.
 */
template<typename T>
BinaryTree<T>::BinaryTree() {
	root = nullptr;
}

/**
 * Copy constructor.
 * @param {const BinaryTree&} other - The BT to copy into this
 * @return None
 */
template<typename T>
BinaryTree<T>::BinaryTree(const BinaryTree<T>& other) {
	(*this) = other;
}

/**
 * Assignment operator.
 * @param {const BinaryTree&} other - The BT to assign to this
 * @return {BinaryTree&} - To allow A = B = C;
 */
template<typename T>
BinaryTree<T>& BinaryTree<T>::operator = (const BinaryTree<T>& other) {

}

/**
 * Insert a value into the tree.
 * @param {const T&} val - The value to insert into the tree.
 * @return {bool} - Whether or not it ws successfully inserted.
 */
template<typename T>
bool BinaryTree<T>::insert(const T& val) {
	Node* newNode = new Node(val, nullptr, nullptr, nullptr, true);
	Node* parentNode = root;
	Node*& newLocation;
	Node* newRoot;

	if(root == nullptr) {
		// If there is no root - easy this is now root
		newNode->red = false;
		root = newNode;
	} else {
		// Otherwise find where we need to put it
		while(newNode->parent == nullptr) {
			// Do comparison
			if(val < parentNode->val) {
				newLocation = parentNode->left;
			} else {
				newLocation = parentNode->right;
			}

			// If we've found a leaf, put it there
			// Otherwise keep going
			if(newLocation == nullptr) {
				newLocation = newNode;
				newNode->parent = parentNode;
			} else {
				parentNode = newLocation;
			}
		}

		// Now fix everything that we've fucked up
		insertRepair(newNode);

		newRoot = root;
		while(root->parent != nullptr) {
			newRoot = newRoot->parent;
		}
		root = newRoot;
	}

	return true;
}

template<typename T>
void BinaryTree<T>::insertRepair(Node* repairFrom) {
	Node* uncy;
	Node* grandpa;
	// We only need to repair if there are now two reds in a row
	while(repairFrom->parent->red) {
		uncy = uncle(repairFrom);
		grandpa = repairFrom->parent->parent;

		// Case 1: uncle is red
		if(uncy != nullptr && uncy->red) {
			repairFrom->parent->red = false;
			uncy->red = false;
			grandpa->red = true;
			repairFrom = grandpa;
		} 
		// Case 2: uncle is black
		else {
			if(grandpa->left = uncy && grandpa->right->left == repairFrom) {
				rotateRight(repairFrom->parent);
				rotateLeft(repairFrom->parent);
				repairFrom->left->red = true;
			} else if(grandpa->right = uncy && grandpa->left->right == repairFrom) {
				rotateLeft(repairFrom->parent);
				rotateRight(repairFrom->parent);
				repairFrom->right->red = true;
			}
			repairFrom->red = false;
		}
	}
}

template<typename T>
typename BinaryTree<T>::Node* BinaryTree<T>::uncle(Node* nephew) {
	Node* parent = nephew->parent;
	if(parent == nullptr) return nullptr;
	Node* grandpa = parent->parent;
	if(grandpa == nullptr) return nullptr;
	
	if(grandpa->left == parent) {
		return grandpa->right;
	} else {
		return grandpa->left;
	}
}

template<typename T>
void BinaryTree<T>::rotateLeft(Node* about) {
	Node*& branch;
	Node* parent = about->parent;
	if(about->parent == nullptr) {
		branch = root;
	} else if(about == about->parent->left) {
		branch = parent->left;
	} else {
		branch = parent->right;
	}

	branch = about->right;
	about->right->parent = parent;
	about->right = branch->left;
	about->right->parent = about;
	branch->left = about;
	about->parent = branch;
}

template<typename T>
void BinaryTree<T>::rotateRight(Node* about) {
	Node*& branch;
	Node* parent = about->parent;
	if(about->parent == nullptr) {
		branch = root;
	} else if(about == about->parent->left) {
		branch = parent->left;
	} else {
		branch = parent->right;
	}

	branch = about->left;
	about->left->parent = parent;
	about->left = branch->right;
	about->left->parent = about;
	branch->right = about;
	about->parent = branch;
}

/**
 * Create a new binary tree and return a pointer to that new tree.
 * @param None
 * @return {BinaryTree<T>*} - The pointer to the new tree.
 */
template<typename T>
BinaryTree<T>* BinaryTree<T>::copy() const{
	if (root == nullptr) {
		return nullptr;
	}
	return nullptr; // For now...
}

/**
 * Find and return a pointer to the value pointed to by the key.
 * @param {const NodeVal&} key - The key to search for.
 * @return {NodeVal*} - The pointer to the node found.
 */
template<typename T>
T* BinaryTree<T>::find(const T& key) {
	if (root == nullptr) {
		return nullptr;
	}
	Node* conductor = root;
	while (conductor != nullptr) {
		if (key == conductor->data) {
			return &conductor->data;
		}
		if (key < conductor->data) {
			conductor = conductor->left;
		} else if (key > conductor->data) {
			conductor = conductor->right;
		}
	}
	return nullptr;
}

/**
 * Carefully delete all of the nodes.
 * @param None
 * @return None
 */
template<typename T>
BinaryTree<T>::~BinaryTree() {

}

template <typename T>
void BinaryTree<T>::outputHelper(std::string spaces, Node* node, std::ostream& out, bool isLeft) {
	if(node == nullptr) return;
	outputHelper(spaces +(isLeft ? " |   " : "     ") , node->right, out, false);
	out << spaces << (isLeft ? " \\" : " /") << "--- ";
	if(node->red) out << COLOR << RED << node->data << COLOR << BLACK << std::endl;
	else out << node->data << std::endl;
	outputHelper(spaces + (!isLeft ? " |   " : "     ") , node->left, out, true);
}

template <typename T>
std::ostream& operator << (std::ostream& stream, const BinaryTree<T>& rhs) {
	std::string spaces = " \t ";
	rhs.outputHelper(spaces, rhs.root, stream, true);
	return stream;
}
