#pragma once

#include <exception>
#include <iostream>
#include <string>
#include <vector>
#include "node.h"

// Going off of these specs
// http://www.cs.uwm.edu/classes/cs315/Bacon/Lecture/HTML/ch05s03.html

class RegisterTable {
public:
	struct RegisterEntry {
		const std::string name;
		const bool temporary                = false;
		const enum Type { INT, FLOAT } type = INT;
		RegisterEntry* const indirect       = nullptr;

		bool inUse = false;
		bool usedAsTemp;
		Operand currentEntry;

		RegisterEntry(const std::string& n) : name(n) {}
		RegisterEntry(const std::string& n, bool temp) : name(n), temporary(temp) {}
		RegisterEntry(const std::string& n, bool temp, Type t)
		    : name(n), temporary(temp), type(t) {}

		friend RegisterTable;

	private:
		RegisterEntry(Type t, RegisterEntry* indr)
		    : name('(' + indr->name + ')'), type(t), indirect(indr) {}
	};

	RegisterEntry* getUnusedRegister(const Operand& contents);
	RegisterEntry* findLocation(const Operand& contents);
	void invalidateRegisters(bool saved = false);
	void add_register(const RegisterEntry& r) { registers.push_back(r); }

	static RegisterTable getMIPSRegisters();

	friend std::ostream& operator<<(std::ostream&, const RegisterTable&);

private:
	std::vector<RegisterEntry> registers;
	std::vector<RegisterEntry> indirects;
};

std::ostream& operator<<(std::ostream&, const RegisterTable::RegisterEntry&);