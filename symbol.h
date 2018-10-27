#pragma once

#include "binary_tree.hpp"
#include <string>
#include <iostream>
#include <fstream>
#include <stdexcept>

enum EvalType : unsigned {
	ESIGNED =   1 << 0,
	EUNSIGNED = 1 << 1,
	EVOID =     1 << 2,
	ECHAR =     1 << 3,
	ESHORT =    1 << 4,
	EINT =      1 << 5,
	ELONG =     1 << 6,
	EFLOAT =    1 << 7,
	EDOUBLE =   1 << 8,
	EPOINTER =  1 << 9,
	EUNKNOWN =  1 << 30
};

inline EvalType operator|(EvalType a, EvalType b)
{return static_cast<EvalType>(static_cast<unsigned>(a) | static_cast<unsigned>(b));}
inline EvalType operator&(EvalType a, EvalType b)
{return static_cast<EvalType>(static_cast<unsigned>(a) & static_cast<unsigned>(b));}
inline EvalType operator~(EvalType a)
{return static_cast<EvalType>(~static_cast<unsigned>(a));}
class Symbol {
	public:
		// Var type
		class SymbolType {
			public:
				SymbolType(const SymbolType& other) : name(other.name), lineNumber(other.lineNumber), scopeLevel(other.scopeLevel) {}
				bool operator < (const SymbolType& rhs) const;
				bool operator > (const SymbolType& rhs) const;
				bool operator == (const SymbolType& rhs) const;

				friend std::ostream& operator << (std::ostream& out, const SymbolType& sym);

				const std::string name;
				const unsigned lineNumber;
				const unsigned scopeLevel;
				EvalType etype;
				enum {
					UNKNOWN,
					VARIABLE,
					FUNCTION,
					ENUMCONSTANT,
					TYPEDEF
				} itype = UNKNOWN;

				bool isArray = false;
				int arraySize = -1;


				friend class Symbol;
			private:
				SymbolType(std::string key, unsigned line, unsigned scope): name(key), lineNumber(line), scopeLevel(scope) {}
		};

		enum Mode {
			READ,
			WRITE
		} mode = WRITE;

		const unsigned& scopeLevel;

		// Constructor
		Symbol();
		Symbol(const Symbol& other);

		// Operators
		Symbol& operator = (const Symbol& other);

		friend std::ostream& operator << (std::ostream& out, const Symbol& table);

		// Member functions
		unsigned pushScope();
		SymbolType* insert(const std::string& name, unsigned line);
		bool clear();
		void dumpSymbolTable();


		SymbolType* find(std::string name);
		SymbolType* findInCurrentScope(std::string name);
		unsigned popScope();

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
};
