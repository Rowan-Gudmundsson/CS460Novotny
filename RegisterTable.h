#pragma once

#include <iostream>
#include <string>
#include <vector>

// Going off of these specs
// http://www.cs.uwm.edu/classes/cs315/Bacon/Lecture/HTML/ch05s03.html

class RegisterTable
{
	public:
		struct RegisterEntry
		{
			const std::string name; 
			const bool temporary = false; 
			const enum Type {
				INT,
				FLOAT
			} type = INT;

			bool inUse = false;
			std::string currentEntry; 

			RegisterEntry(const std::string& n) : name(n) {}
			RegisterEntry(const std::string& n, bool temp) : name(n), temporary(temp) {}
			RegisterEntry(const std::string& n, bool temp, Type t) : name(n), temporary(temp), type(t) {}
		};

		static RegisterEntry IN_MEMORY;

		RegisterEntry& getUnusedRegister(const std::string& contents, bool temporary = true, bool floating = false);
		RegisterEntry& findLocation(const std::string& contents);

		void add_register(const RegisterEntry& r) { registers.push_back(r); }

		static RegisterTable getMIPSRegisters();

		friend std::ostream& operator<< (std::ostream&, const RegisterTable&); 

	private: 
		std::vector<RegisterEntry> registers;
}; 

std::ostream& operator<< (std::ostream&, const RegisterTable::RegisterEntry&);