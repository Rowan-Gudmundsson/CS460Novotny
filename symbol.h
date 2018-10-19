#pragma once

#include "binary_tree.hpp"
#include <string>
#include <iostream>
#include <fstream>
#include <stdexcept>

extern unsigned int lexDLevel;
extern unsigned int symDLevel;
extern unsigned int parseDLevel;

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
				const unsigned& scopeLevel;
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

		const unsigned& scopeLevel;

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
		void dumpSymbolTable();


		SymbolType* find(std::string name);
		SymbolType* findInCurrentScope(std::string name);
		unsigned popScope();

		void debug_token(std::string tokenName, int tokenLine, unsigned tokenScope);


		void toggleDebug_token_enabled();
		void toggleDebug_parse_enabled();

		// Destructor
		~Symbol();

	friend std::ostream& operator<< (std::ostream& stream, const Symbol& symbol);

	private:
		struct Scope {
			Scope() {}
			Scope(BinaryTree<std::string, SymbolType>* val, Scope* next_ptr): tree(val), next(next_ptr) {}
			BinaryTree<std::string, SymbolType>* tree;
			Scope* next;
		};

		Scope* head;
		unsigned _scopeLevel;


		std::ofstream debug_symbol_stream;
		std::ofstream debug_token_stream;
		std::ofstream debug_parse_stream;


		bool debug_token_enabled = false;
		bool debug_parse_enabled = false;
		bool debug_reduce_enabled = false;


};
