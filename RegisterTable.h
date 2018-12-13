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
			std::string name; 
			bool temporary = false; 
			bool inUse = false;
			enum Type {
				INT,
				FLOAT
			} type = INT;
			std::string currentEntry; 
			//more to be added as needed 

			RegisterEntry(const std::string& n) : name(n) {}
			RegisterEntry(const std::string& n, bool temp) : name(n), temporary(temp) {}
			RegisterEntry(const std::string& n, bool temp, Type t) : name(n), temporary(temp), type(t) {}
		};

		std::string get_register(const std::string& reg_name, bool is_float);

		void free_register(const std::string& reg_name);

		void add_register(const RegisterEntry& r) { registers.push_back(r); }

		static RegisterTable getMIPSRegisters();

		friend std::ostream& operator<< (std::ostream&, const RegisterTable&); 

	private: 
		std::vector<RegisterEntry> registers;
}; 

std::ostream& operator<< (std::ostream&, const RegisterTable::RegisterEntry&); 