/**
 * Constructor.
 * @param None.
 * @return None.
 */
template<typename T>
BinaryTree::BinaryTree() {
	root = nullptr;
}

/**
 * Copy constructor.
 * @param {const BinaryTree&} other - The BT to copy into this
 * @return None
 */
template<typename T>
BinaryTree::BinaryTree(const BinaryTree& other) {
	(*this) = other;
}

/**
 * Assignment operator.
 * @param {const BinaryTree&} other - The BT to assign to this
 * @return {BinaryTree&} - To allow A = B = C;
 */
template<typename T>
BinaryTree& BinaryTree::operator = (const BinaryTree& other) {

}

/**
 * Insert a value into the tree.
 * @param {const T&} val - The value to insert into the tree.
 * @return {bool} - Whether or not it ws successfully inserted.
 */
template<typename T>
bool BinaryTree::insert(const T& val) {

}

/**
 * Carefully delete all of the nodes.
 * @param None
 * @return None
 */
template<typename T>
BinaryTree::~BinaryTree() {

}
