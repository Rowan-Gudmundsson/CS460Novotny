#pragma once

#include <iostream>
#include <string>
#include <vector>

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

		int get_Register(std::string&); 		
		void free_register(std::string&);

		void addRegister(const RegisterEntry& r) { registers.push_back(r); }

		static RegisterTable getMIPSRegisters();

		friend std::ostream& operator<< (std::ostream&, const RegisterTable&); 

	private: 
		std::vector<RegisterEntry> registers;
}; 

std::ostream& operator<< (std::ostream&, const RegisterEntry&); 