#pragma once

template <typename NodeVal>
class BinaryTree {
  public:
    // Constructors
    BinaryTree();
    BinaryTree(const BinaryTree& other);

    // Operators
    BinaryTree& operator = (const BinaryTree& other);

    // Member functions
    bool insert(const NodeVal& val);
    BinaryTree* copy() const;
    // Destructors
    ~BinaryTree();

  private:
    struct Node {
      Node() {};
      Node(NodeVal val, Node* left_ptr, Node* right_ptr, bool is_red):
        data(val),
        left(left_ptr),
        right(right_ptr),
        red(is_red) {}
      NodeVal data;
      Node* left, right;
      bool red;
    };

    Node* root;
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
 * Carefully delete all of the nodes.
 * @param None
 * @return None
 */
template<typename T>
BinaryTree<T>::~BinaryTree() {

}
