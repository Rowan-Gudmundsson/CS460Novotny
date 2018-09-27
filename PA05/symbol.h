#pragma once

#include "binary_tree.hpp"
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
		struct Scope {
			Scope() {}
			Scope(BinaryTree<std::string, VarType>* val, Scope* next_ptr): tree(val), next(next_ptr) {}
			BinaryTree<std::string, VarType>* tree;
			Scope* next;
		};

		Scope* head;
};
