#pragma once

template <typename NodeVal>
class BinaryTree {
  public:
    // Constructors
    BinaryTree();
    BinaryTree(const BinaryTree&);

    // Operators
    BinaryTree& operator = (const BinaryTree&);

    // Member functions
    bool insert(const NodeVal&);

    // Destructors
    ~BinaryTree();

  private:
    struct Node {
      NodeVal data;
      Node* left, right;
    };

    Node* root;
};

#include "BinaryTree.cpp"
