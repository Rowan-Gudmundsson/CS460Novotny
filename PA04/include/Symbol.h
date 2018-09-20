#pragma once

#include "BinaryTree.h"
#include <string>

class Symbol {
  public:
    // Var type
    struct VarType {
      std::string name;
      enum Type {
        INT,
        FLOAT,
        CHAR
      } type;
    };

    // Constructor
    Symbol();
    Symbol(const Symbol& other);

    // Operators
    Symbol& operator = (const Symbol& other);

    // Member functions
    bool insert(const BinaryTree<VarType>& val);
    bool clear();

    // Destructor
    ~Symbol();
  private:
    struct Node {
      Node() {}
      Node(BinaryTree<VarType>* val, Node* next_ptr): value(val), next(next_ptr) {}
      BinaryTree<VarType>* value;
      Node* next;
    };

    Node* head;
};
