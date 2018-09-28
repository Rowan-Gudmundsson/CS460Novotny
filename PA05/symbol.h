#pragma once

#include "binary_tree.hpp"
#include <string>
#include <iostream>

class Symbol {
	public:
		// Var type
		class SymbolType {
			public:
				SymbolType() {}
				SymbolType(std::string key): name(key) {}
				bool operator < (const SymbolType& rhs) const;
				bool operator > (const SymbolType& rhs) const;
				bool operator == (const SymbolType& rhs) const;

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
		bool insert(const SymbolType& val);
		bool clear();

		SymbolType* find(std::string name);
		bool popScope();

		// Destructor
		~Symbol();
	private:
		struct Scope {
			Scope() {}
			Scope(BinaryTree<std::string, SymbolType>* val, Scope* next_ptr): tree(val), next(next_ptr) {}
			BinaryTree<std::string, SymbolType>* tree;
			Scope* next;
		};

		Scope* head;
};
