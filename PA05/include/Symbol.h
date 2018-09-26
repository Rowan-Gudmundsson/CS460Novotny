#pragma once

#include "BinaryTree.h"
#include <string>
#include <iostream>

class Symbol {
	public:
		// Var type
		class VarType {
			public:
				VarType() {}
				VarType(std::string key): name(key) {}
				bool operator < (const VarType& rhs) const;
				bool operator > (const VarType& rhs) const;
				bool operator == (const VarType& rhs) const;

				std::string name;
				unsigned int lineNumber;
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
		bool pushScope();
		bool insert(const VarType& val);
		bool clear();

		VarType* find(std::string name);
		bool popScope();

		// Destructor
		~Symbol();
	private:
		struct Node {
			Node() {}
			Node(BinaryTree<std::string, VarType>* val, Node* next_ptr): tree(val), next(next_ptr) {}
			BinaryTree<std::string, VarType>* tree;
			Node* next;
		};

		Node* head;
};
