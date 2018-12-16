#pragma once

#include <iostream>
#include <utility>

#define BNODE typename BinaryTree<K, T>::Node

template <typename KeyType, typename NodeVal>
class BinaryTree {
private:
	unsigned _size = 0;

	struct Node {
		Node(){};
		Node(const std::pair<KeyType, NodeVal>& _pair, Node* left_ptr, Node* right_ptr,
			 Node* parent_ptr, bool is_red)
			: pair(_pair), left(left_ptr), right(right_ptr), parent(parent_ptr), red(is_red) {}
		Node(const KeyType& key, const NodeVal& val, Node* left_ptr, Node* right_ptr,
			 Node* parent_ptr, bool is_red)
			: pair(key, val), left(left_ptr), right(right_ptr), parent(parent_ptr), red(is_red) {}

		std::pair<KeyType, NodeVal> pair;
		Node* left;
		Node* right;
		Node* parent;
		bool red;

		~Node() {
			if (left != nullptr) delete left;
			if (right != nullptr) delete right;
			left   = nullptr;
			right  = nullptr;
			parent = nullptr;
		}
	};

public:
	class iterator {
	private:
		Node* v;

	public:
		using self_type         = iterator;
		using value_type        = NodeVal;
		using reference         = NodeVal&;
		using pointer           = NodeVal*;
		using iterator_category = std::forward_iterator_tag;
		using difference_type   = int;

		iterator(Node* p = nullptr) : v(p) {}

		NodeVal& operator*() { return v->pair.second; }

		NodeVal* operator->() { return &v->pair.second; }

		// inorder (left to right) traversal
		iterator& operator++() {
			if (v == nullptr) return *this;

			// If there is something to the right - go there then go all the way to the left
			if (v->right != nullptr) {
				v = v->right;
				while (v->left != nullptr) { v = v->left; }
			} else {
				// Find the highest node where we aren't in its right branch
				Node* temp = v->parent;

				// If we're at the top - we're done
				if (temp == nullptr) {
					v = nullptr;
					return *this;
				}

				while (temp->parent != nullptr && v == temp->right) {
					v    = temp;
					temp = temp->parent;
				}

				// If we were in the right branch of the root - we're done
				if (v == temp->right) {
					v = nullptr;
					return *this;
				}

				v = temp;
			}

			return *this;
		}

		iterator operator++(int i) {
			iterator it = *this;
			operator++();
			return it;
		}

		bool operator==(const iterator& other) const { return v == other.v; }

		bool operator!=(const iterator& other) const { return v != other.v; }
	};

	// Constructors
	BinaryTree();
	BinaryTree(const BinaryTree& other);

	// Operators
	BinaryTree<KeyType, NodeVal>& operator=(const BinaryTree<KeyType, NodeVal>& other);

	// Member functions
	NodeVal* insert(const KeyType& key, const NodeVal& val);
	BinaryTree<KeyType, NodeVal>* copy() const;

	NodeVal* find(const KeyType& key);

	template <typename K, typename T>
	friend std::ostream& operator<<(std::ostream& stream, const BinaryTree<K, T>& rhs);

	const unsigned& size = _size;

	// Iterator stuff
	iterator begin() {
		if (root == nullptr) { return iterator(nullptr); }

		// Return furthest left node
		Node* temp = root;
		while (temp->left != nullptr) { temp = temp->left; }

		return iterator(temp);
	}

	iterator end() { return iterator(nullptr); }

	// Destructors
	~BinaryTree();

private:
	Node* root;

	void insertRepair(Node* repairFrom);
	Node* uncle(Node* nephew);
	void rotateLeft(Node* about);
	void rotateRight(Node* about);

	Node* assignmentHelper(const Node* node, Node* parent);
	void outputHelper(std::string spaces, Node* node, std::ostream& out, bool isLeft) const;
};

/**
 * Constructor.
 * @param None.
 * @return None.
 */
template <typename K, typename T>
BinaryTree<K, T>::BinaryTree() {
	root = nullptr;
}

/**
 * Copy constructor.
 * @param {const BinaryTree&} other - The BT to copy into this
 * @return None
 */
template <typename K, typename T>
BinaryTree<K, T>::BinaryTree(const BinaryTree<K, T>& other) {
	(*this) = other;
}

/**
 * Assignment operator.
 * @param {const BinaryTree&} other - The BT to assign to this
 * @return {BinaryTree&} - K,To allow A = B = C;
 */
template <typename K, typename T>
BinaryTree<K, T>& BinaryTree<K, T>::operator=(const BinaryTree<K, T>& other) {
	root  = assignmentHelper(other.root, nullptr);
	_size = other._size;
}

/**
 * Assignment helper.
 * @param {const Node*} node - The current node being copied.
 * @return {Node*} - Pointer to the node to be linked.
 */
template <typename K, typename T>
BNODE* BinaryTree<K, T>::assignmentHelper(const Node* node, Node* parent) {
	if (node == nullptr) { return nullptr; }
	Node* result  = new Node(node->pair, nullptr, nullptr, parent, node->red);
	Node* left    = assignmentHelper(node->left, result);
	Node* right   = assignmentHelper(node->right, result);
	result->left  = left;
	result->right = right;
	return result;
}

/**
 * Insert a value into the tree.
 * @param {const K&} key - The key of the value to insert the value with
 * @param {const T&} val - The value to insert into the tree.
 * @return {T*} - A pointer to the new location within the tree where the value has been inserted,
 * or nullptr if there was a match
 */
template <typename K, typename T>
T* BinaryTree<K, T>::insert(const K& key, const T& val) {
	Node* newNode    = new Node(key, val, nullptr, nullptr, nullptr, true);
	Node* parentNode = root;
	Node** newLocation;
	Node* newRoot;

	if (root == nullptr) {
		// If there is no root - easy this is now root
		newNode->red = false;
		root         = newNode;
	} else {
		// Otherwise find where we need to put it
		while (newNode->parent == nullptr) {
			// Do comparison
			if (key < parentNode->pair.first) {
				newLocation = &parentNode->left;
			} else if (key == parentNode->pair.first) {
				// Found match - don't insert
				delete newNode;
				return nullptr;
			} else {
				newLocation = &parentNode->right;
			}

			// If we've found a leaf, put it there
			// Otherwise keep going
			if (*newLocation == nullptr) {
				*newLocation    = newNode;
				newNode->parent = parentNode;
			} else {
				parentNode = *newLocation;
			}
		}

		// Now fix everything that we've fucked up
		insertRepair(newNode);

		newRoot = root;
		while (root->parent != nullptr) { newRoot = newRoot->parent; }
		root = newRoot;
	}

	_size++;

	return &newNode->pair.second;
}

/**
 * After inserting, fix the tree.
 * @param {Node*} repairFrom - The node to start repairing from.
 * @return None.
 */
template <typename K, typename T>
void BinaryTree<K, T>::insertRepair(Node* repairFrom) {
	Node* uncy;
	Node* grandpa;
	// We only need to repair if there are now two reds in a row
	while (repairFrom->red && repairFrom->parent != nullptr && repairFrom->parent->red) {
		uncy    = uncle(repairFrom);
		grandpa = repairFrom->parent->parent;

		// Case 1: uncle is red
		if (uncy != nullptr && uncy->red) {
			repairFrom->parent->red = false;
			uncy->red               = false;
			if (root != grandpa) grandpa->red = true;
			repairFrom = grandpa;
		}
		// Case 2: uncle is black
		else {
			if (grandpa->left == uncy && grandpa->right->left == repairFrom) {
				rotateRight(repairFrom->parent);
				rotateLeft(repairFrom->parent);
				repairFrom->left->red = true;
				repairFrom->red       = false;
			} else if (grandpa->right == uncy && grandpa->left->right == repairFrom) {
				rotateLeft(repairFrom->parent);
				rotateRight(repairFrom->parent);
				repairFrom->right->red = true;
				repairFrom->red        = false;
			} else if (repairFrom == repairFrom->parent->left) {
				repairFrom->parent->red = false;
				grandpa->red            = true;
				rotateRight(grandpa);
			} else {
				repairFrom->parent->red = false;
				grandpa->red            = true;
				rotateLeft(grandpa);
			}
		}
	}
}

/**
 * Find the nephew's uncy.
 * @param {Node*} nephew - The nephew.
 * @param {Node*} - The uncle.
 */
template <typename K, typename T>
typename BinaryTree<K, T>::Node* BinaryTree<K, T>::uncle(Node* nephew) {
	Node* parent = nephew->parent;
	if (parent == nullptr) return nullptr;
	Node* grandpa = parent->parent;
	if (grandpa == nullptr) return nullptr;

	if (grandpa->left == parent) {
		return grandpa->right;
	} else {
		return grandpa->left;
	}
}

/**
 * Rotate left about a node.
 * @param {Node*} about - The node to rotate about.
 * @return None.
 */
template <typename K, typename T>
void BinaryTree<K, T>::rotateLeft(Node* about) {
	Node** branch;
	Node* parent = about->parent;
	if (about->parent == nullptr) {
		branch = &root;
	} else if (about == about->parent->left) {
		branch = &parent->left;
	} else {
		branch = &parent->right;
	}

	*branch              = about->right;
	about->right->parent = parent;
	about->right         = (*branch)->left;
	if (about->right != nullptr) about->right->parent = about;
	(*branch)->left = about;
	about->parent   = *branch;
}

/**
 * Rotate right about a node.
 * @param {Node*} about - The node to rotate about.
 * @return None.
 */
template <typename K, typename T>
void BinaryTree<K, T>::rotateRight(Node* about) {
	Node** branch;
	Node* parent = about->parent;
	if (about->parent == nullptr) {
		branch = &root;
	} else if (about == about->parent->left) {
		branch = &parent->left;
	} else {
		branch = &parent->right;
	}

	*branch             = about->left;
	about->left->parent = parent;
	about->left         = (*branch)->right;
	if (about->left != nullptr) about->left->parent = about;
	(*branch)->right = about;
	about->parent    = *branch;
}

/**
 * Create a new binary tree and return a pointer to that new tree.
 * @param None
 * @return {BinaryTree<K,T>*} - The pointer to the new tree.
 */
template <typename K, typename T>
BinaryTree<K, T>* BinaryTree<K, T>::copy() const {
	if (root == nullptr) { return nullptr; }
	return nullptr;  // For now...
}

/**
 * Find and return a pointer to the value pointed to by the key.
 * @param {const NodeVal&} key - The key to search for.
 * @return {NodeVal*} - The pointer to the node found.
 */
template <typename K, typename T>
T* BinaryTree<K, T>::find(const K& key) {
	if (root == nullptr) { return nullptr; }
	Node* conductor = root;
	while (conductor != nullptr) {
		if (key == conductor->pair.first) {
			return &conductor->pair.second;
		} else if (key < conductor->pair.first) {
			conductor = conductor->left;
		} else if (key > conductor->pair.first) {
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
template <typename K, typename T>
BinaryTree<K, T>::~BinaryTree() {
	if (root != nullptr) { delete root; }
}

template <typename K, typename T>
void BinaryTree<K, T>::outputHelper(std::string spaces, Node* node, std::ostream& out,
									bool isLeft) const {
	if (node == nullptr) return;
	outputHelper(spaces + (isLeft ? " |   " : "     "), node->right, out, false);
	out << spaces << (isLeft ? " \\" : " /") << "--- ";
	out << "<" << node->pair.first << "," << node->pair.second << ">(" << (node->red ? 'r' : 'b')
		<< ')' << std::endl;
	outputHelper(spaces + (!isLeft ? " |   " : "     "), node->left, out, true);
}

template <typename K, typename T>
std::ostream& operator<<(std::ostream& stream, const BinaryTree<K, T>& rhs) {
	std::string spaces = " \t ";
	rhs.outputHelper(spaces, rhs.root, stream, true);
	return stream;
}
