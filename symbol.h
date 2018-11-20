#pragma once

#include "binary_tree.hpp"
#include <algorithm>
#include <list>
#include <string>
#include <iostream>
#include <fstream>
#include <stdexcept>
#include <vector>
#include <unordered_map>

enum EvalType : unsigned {
	EUNSIGNED = 1 << 0,
	EVOID =     1 << 1,
	ECHAR =     1 << 2,
	ESHORT =    1 << 3,
	EINT =      1 << 4,
	ELONG =     1 << 5,
	EFLOAT =    1 << 6,
	EDOUBLE =   1 << 7,
	EPOINTER =  1 << 8,
	EUNKNOWN =  1 << 30
};

inline EvalType operator|(EvalType a, EvalType b)
{return static_cast<EvalType>(static_cast<unsigned>(a) | static_cast<unsigned>(b));}
inline EvalType operator&(EvalType a, EvalType b)
{return static_cast<EvalType>(static_cast<unsigned>(a) & static_cast<unsigned>(b));}
inline EvalType operator~(EvalType a)
{return static_cast<EvalType>(~static_cast<unsigned>(a));}

const std::unordered_map<unsigned, unsigned> precedence({
	{ECHAR, 0}, {EUNSIGNED | ECHAR, 1}, {ESHORT | EINT, 2}, {EUNSIGNED | ESHORT | EINT, 3},
	{EINT, 4}, {EUNSIGNED | EINT, 5}, {ELONG | EINT, 6}, {EUNSIGNED | ELONG | EINT, 7},
	{EFLOAT, 8}, {EDOUBLE, 9}
});

enum TypeQualifier : unsigned {
	TNONE =     0,
	TCONST =    1 << 0,
	TVOLATILE = 1 << 1,
};

inline TypeQualifier operator|(TypeQualifier a, TypeQualifier b)
{return static_cast<TypeQualifier>(static_cast<unsigned>(a) | static_cast<unsigned>(b));}

inline std::ostream& operator<<(std::ostream& out, EvalType a) {
	if(a & EUNSIGNED) out << "unsigned ";
	if(a & EVOID) out << "void ";
	if(a & ECHAR) out << "char ";
	if(a & ESHORT) out << "short ";
	if(a & EINT) out << "int ";
	if(a & ELONG) out << "long ";
	if(a & EFLOAT) out << "float ";
	if(a & EDOUBLE) out << "double ";
	if(a & EPOINTER) out << "* ";
	if(a & EUNKNOWN) out << "UNKNOWN ";

	return out;
}

class Symbol {
	public:
		struct FunctionType {
			bool defined = false;
			unsigned functionDefLine;
			unsigned functionDefCol;

			std::vector<EvalType> parameters;
			EvalType returnType;
		};

		struct VarType {
			bool isArray = false;
			std::vector<int> arrayDimensions;
			unsigned pointerLevel = 0;
		};

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
				EvalType etype = EUNKNOWN;
				enum {
					UNKNOWN,
					VARIABLE,
					FUNCTION,
					ENUMCONSTANT,
					TYPEDEF
				} itype = UNKNOWN;

				// TODO - figure a union out maybe?
				//union {
					// Variable stuff
					VarType v;

					// Function stuff
					std::list<FunctionType> functions;

					// TODO - ENUM?
					// TODO - TYPEDEF?
				//};

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
		unsigned unPopScope();
		void popBackToGlobal();

		// Destructor
		~Symbol();

	friend std::ostream& operator<< (std::ostream& stream, const Symbol& symbol);

	private:
		struct Scope {
			// Scope() {}
			Scope(BinaryTree<std::string, SymbolType>* val, Scope* _parent): tree(val), parent(_parent) {}
			BinaryTree<std::string, SymbolType>* tree;
			std::vector<Scope*> children;
			Scope * const parent;
		};

		void clearFrom(Scope* s);

		Scope* head;
		unsigned _scopeLevel;

		// For when we pop a scope and it's empty so we delete it
		// If we then try to unpop it - don't do anything
		bool recentlyDeletedScope = false;
};
