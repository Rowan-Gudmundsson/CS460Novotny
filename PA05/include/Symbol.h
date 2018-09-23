#pragma once

#include "BinaryTree.h"
#include <string>

class Symbol {
	public:
		// Var type
		class VarType {
			public:
				VarType() {}
				VarType(std::string key): name(key) {}
				bool operator < (const VarType& rhs);
				bool operator > (const VarType& rhs);
				bool operator == (const VarType& rhs);
			private:
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

		VarType* find(std::string name);
		bool pop();

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
