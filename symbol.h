#pragma once

#include <algorithm>
#include <fstream>
#include <iostream>
#include <list>
#include <map>
#include <sstream>
#include <stdexcept>
#include <string>
#include <vector>
#include "binary_tree.hpp"

enum TypeQualifier { TCONST, TVOLATILE };

struct Object;
struct Scope;

// class Symbol::SymbolType;

struct EvalType {
public:
	enum { UNKNOWN, VOID, CHARACTER, INTEGER, FLOATING, OBJECT } type = UNKNOWN;

	bool sign = true;

	enum { SHORT, NORMAL, LONG } length = NORMAL;

	Object* obj = nullptr;

	struct Qualifier {
		bool cons    = false;
		bool volatil = false;

		bool operator==(const Qualifier& other) const {
			return (cons == other.cons) && (volatil == other.volatil);
		}

		Qualifier(bool c = false, bool v = false) : cons(c), volatil(v) {}
		Qualifier(TypeQualifier t) : cons(t == TCONST), volatil(t == TVOLATILE) {}
		Qualifier(const Qualifier& q) : cons(q.cons), volatil(q.volatil) {}
	};

	// There need to be qualifiers for EACH level of indirection
	// E.g. const int const * * const *
	std::vector<Qualifier> qualifiers = std::vector<Qualifier>(1);

	// Keep track of the level of indirection
	unsigned pointer() const { return qualifiers.size() - 1; }
	void pointer(unsigned p) { qualifiers.resize(p + 1); }
	EvalType& operator++() {
		qualifiers.emplace_back();
		return *this;
	}

	EvalType& operator--() {
		qualifiers.pop_back();
		return *this;
	}

	friend std::ostream& operator<<(std::ostream& out, const EvalType& a);

	EvalType operator|(const EvalType& other) const {
		if (type != other.type) {
			if (type != UNKNOWN && other.type != UNKNOWN) {
				std::stringstream ss;
				ss << "Types \"" << *this << "\" and \"" << other << "\" are incompatible";
				throw std::runtime_error(ss.str());
			}
		} else if (length != other.length) {
			if (length != NORMAL && other.length != NORMAL) {
				std::stringstream ss;
				ss << "Type \"" << *this << "\" and qualifier \"" << other << "\" are incompatible";
				throw std::runtime_error(ss.str());
			}
		}

		EvalType re;
		re.type   = (type == UNKNOWN) ? other.type : type;
		re.sign   = sign || other.sign;
		re.length = (length == NORMAL) ? other.length : length;
		re.qualifiers.assign(qualifiers.begin(), qualifiers.end());
		re.qualifiers.insert(re.qualifiers.end(), other.qualifiers.begin() + 1,
		                     other.qualifiers.end());

		return re;
	}

	bool operator==(const EvalType& other) const {
		return (type == other.type) && (sign == other.sign) && (length == other.length) &&
		       (qualifiers == other.qualifiers) && (obj == other.obj);
	}

	bool operator!=(const EvalType& other) const {
		return (type != other.type) || (sign != other.sign) || (length != other.length) ||
		       (qualifiers != other.qualifiers) || (obj != other.obj);
	}

	bool operator>(const EvalType& other) const {
		return (type == FLOATING && other.type != FLOATING) ||
		       (length == NORMAL && other.length == SHORT) ||
		       (length == LONG && (other.length == NORMAL || other.length == SHORT));
	}

	unsigned size() const;

	bool integral() const { return !pointer() && (type == INTEGER) || (type == CHARACTER); }
	bool string() const { return pointer() == 1 && type == CHARACTER && qualifiers[0].cons; }
	bool floating() const { return !pointer() && type == FLOATING; }
	bool object() const { return !pointer() && type == OBJECT && obj != nullptr; }
	// Default constructor
	EvalType() {}

	EvalType(const EvalType& other)
	    : type(other.type),
	      sign(other.sign),
	      length(other.length),
	      obj(other.obj),
	      qualifiers(other.qualifiers) {}

private:
	// Certain common types
	enum Common {
		CUNKNOWN,
		CVOID,
		CCHAR,
		CSTRING,
		CUNSIGNED,
		CINT,
		CLONG,
		CSHORT,
		CFLOAT,
		CDOUBLE
	};

	// Construct a common type
	EvalType(Common c) {
		switch (c) {
			case CUNKNOWN:
				break;
			case CVOID:
				type = VOID;
				break;
			case CCHAR:
				type = CHARACTER;
				break;
			case CSTRING:
				type = CHARACTER;
				qualifiers.emplace_back();
				qualifiers[0].cons = true;
				break;
			case CUNSIGNED:
				type = INTEGER;
				sign = false;
				break;
			case CINT:
				type = INTEGER;
				break;
			case CLONG:
				type   = INTEGER;
				length = LONG;
				break;
			case CSHORT:
				type   = INTEGER;
				length = SHORT;
				break;
			case CFLOAT:
				type   = FLOATING;
				length = SHORT;
				break;
			case CDOUBLE:
				type = FLOATING;
				break;
		}
	}

public:
	static const EvalType EUNKNOWN;
	static const EvalType EVOID;
	static const EvalType ECHAR;
	static const EvalType ESTRING;
	static const EvalType EUNSIGNED;
	static const EvalType EINT;
	static const EvalType ELONG;
	static const EvalType ESHORT;
	static const EvalType EFLOAT;
	static const EvalType EDOUBLE;
};

inline EvalType::Qualifier operator|(TypeQualifier a, TypeQualifier b) {
	if (a != b) {
		return EvalType::Qualifier(true, true);
	} else if (a == TCONST) {
		return EvalType::Qualifier(true, false);
	} else {
		return EvalType::Qualifier(false, true);
	}
}

class Symbol {
public:
	class SymbolType;

	struct FunctionType {
		bool defined = false;
		unsigned functionDefLine;
		unsigned functionDefCol;

		Scope* scope;

		std::string name;
		std::vector<EvalType> paramTypes;
		std::vector<SymbolType*> params;
		EvalType returnType = EvalType::EVOID;
		std::string label   = "";
		unsigned localSize  = -1;  // Size of the locals part of the stack frame (in bytes)

		// Stack frame is local variables + return address + address of return value
		unsigned stackSize() {
			if (localSize == -1) calcLocalsFromParams();
			if (localSize < returnType.size()) localSize = returnType.size();
			return localSize + 4 + 4;
		}

		void calcLocalsFromParams() {
			localSize = 0;
			for (EvalType& e : paramTypes) localSize += e.size();
		}
	};

	struct VarType {
		bool isArray = false;
		std::vector<int> arrayDimensions;
	};

	class SymbolType {
	private:
		unsigned _offset = -1;

	public:
		SymbolType(const SymbolType& other)
		    : name(other.name), lineNumber(other.lineNumber), scopeLevel(other.scopeLevel) {}
		bool operator<(const SymbolType& rhs) const;
		bool operator>(const SymbolType& rhs) const;
		bool operator==(const SymbolType& rhs) const;

		friend std::ostream& operator<<(std::ostream& out, const SymbolType& sym);

		const std::string name;
		const unsigned lineNumber;
		const unsigned scopeLevel;
		EvalType etype;
		enum { UNKNOWN, VARIABLE, FUNCTION, ENUMCONSTANT, STRUCT, TYPEDEF } itype = UNKNOWN;

		const unsigned& offset = _offset;

		// TODO - figure a union out maybe?
		// union {
		// Variable stuff
		VarType v;

		// Function stuff
		std::list<FunctionType> functions;

		Object* obj;

		// TODO - ENUM?
		// TODO - TYPEDEF?
		//};

		friend class Symbol;

	private:
		SymbolType(std::string key, unsigned line, unsigned scope)
		    : name(key), lineNumber(line), scopeLevel(scope) {}
	};
	// Var type

	enum Mode { READ, WRITE, OBJECT } mode = WRITE;

	const unsigned& scopeLevel;

	// Constructor
	Symbol();
	Symbol(const Symbol& other);

	// Operators
	Symbol& operator=(const Symbol& other);

	friend std::ostream& operator<<(std::ostream& out, const Symbol& table);

	// Member functions
	unsigned pushScope();
	void setLastScopeFunction(FunctionType* f);
	void setNextScopeFunction(FunctionType* f);
	SymbolType* insert(const std::string& name, unsigned line);
	bool clear();
	void dumpSymbolTable();

	SymbolType* find(std::string name);
	SymbolType* findInCurrentScope(std::string name);
	unsigned popScope();
	unsigned unPopScope();
	void popBackToGlobal();

	void setCurrentObject(Object* obj);

	// Calculate Struct sizes and offsets
	void calcStructOffsets();
	// Calculate offsets - only to be used AFTER symbol table has been completely constructed
	void calcOffsets();

	// Get a container of global variables
	BinaryTree<std::string, SymbolType>& getGlobals();

	void printStructs(std::ostream& out);

	// Destructor
	~Symbol();

	friend std::ostream& operator<<(std::ostream& stream, const Symbol& symbol);

private:
	friend Object;
	struct Scope {
		// Scope() {}
		Scope(BinaryTree<std::string, SymbolType>* val, Scope* _parent)
		    : tree(val), parent(_parent), func((_parent != nullptr) ? _parent->func : nullptr) {}
		BinaryTree<std::string, SymbolType>* tree;
		std::vector<Scope*> children;
		Scope* const parent;
		FunctionType* func;
		bool isStruct = false;
	};

	void calcStructOffsetsFrom(Scope* s);
	void calcOffsetsFrom(Scope* s, unsigned& offset);
	void printStructsFrom(Scope* s, std::ostream& out, int& xoffset, bool printedPackage);
	void clearFrom(Scope* s);

	Scope* head;
	Scope* structScope = nullptr;
	unsigned _scopeLevel;

	// For when we pop a scope and it's empty so we delete it
	// If we then try to unpop it - don't do anything
	bool recentlyDeletedScope = false;

	FunctionType* nextFunction = nullptr;

	Scope* getLastScope() {
		if (head == nullptr) return nullptr;
		return head->children.back();
	}
};

struct Object {
	enum Type { STRUCT, UNION } type = STRUCT;

	Symbol::Scope* vars;
	// The symbol Associated with this object
	Symbol::SymbolType* sym;

	unsigned size = -1;

	Object(Symbol& table, Symbol::SymbolType* s) : vars(table.getLastScope()), sym(s) {
		s->obj         = this;
		s->itype       = Symbol::SymbolType::STRUCT;
		vars->isStruct = true;
	}
	Object(Symbol& table, Symbol::SymbolType* s, Type t)
	    : type(t), vars(table.getLastScope()), sym(s) {
		s->obj         = this;
		s->itype       = Symbol::SymbolType::STRUCT;
		vars->isStruct = true;
	}
	Object(const Object& other) : type(other.type), vars(other.vars), sym(other.sym) {}

	std::ostream& print(std::ostream& out, int xoffset);
};

std::ostream& operator<<(std::ostream& out, const Object& obj);
