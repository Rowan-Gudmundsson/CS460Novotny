#pragma once

#include "binary_tree.hpp"
#include <string>
#include <iostream>
#include <stdexcept>

#define SPIC_UNDEFINED_REFERENCE 0
#define SPIC_REDECLARATION 1

class Symbol {
	public:
		// Var type
		class SymbolType {
			public:
				SymbolType() : scopeLevel(_scopeLevel) {}
				SymbolType(std::string key, unsigned line): name(key), lineNumber(line), scopeLevel(_scopeLevel) {}
				SymbolType(const SymbolType& other) : scopeLevel(_scopeLevel) {*(this) = other;}
				bool operator < (const SymbolType& rhs) const;
				bool operator > (const SymbolType& rhs) const;
				bool operator == (const SymbolType& rhs) const;
				SymbolType& operator = (const SymbolType& rhs);

				friend std::ostream& operator << (std::ostream& out, const SymbolType& sym);

				std::string name;
				unsigned lineNumber;
				unsigned& scopeLevel;
				enum Type {
					INT,
					FLOAT,
					CHAR
				} type;

				friend class Symbol;
			private:
				unsigned _scopeLevel = 0;
		};

		enum Mode {
			READ,
			WRITE
		} mode;

		// Constructor
		Symbol();
		Symbol(const Symbol& other);

		// Operators
		Symbol& operator = (const Symbol& other);

		friend std::ostream& operator << (std::ostream& out, const Symbol& table);

		// Member functions
		unsigned pushScope();
		SymbolType* insert(const SymbolType& val);
		bool clear();

		SymbolType* find(std::string name);
		SymbolType* findInCurrentScope(std::string name);
		unsigned popScope();

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
		unsigned _scopeLevel;
	public:
		const unsigned& scopeLevel;
};
