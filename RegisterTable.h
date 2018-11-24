#pragma once

#include <iostream>
#include <string>

struct RegisterEntry
{
	std::string name; 
	bool reserved; 
	bool temporary; 
	bool inUse; 
	std::string* currentEntry; 
	//more to be added as needed 

}; 
class RegisterTable
{
	public:
		RegisterTable();
		~RegisterTable(); 
		int get_Register(std::string&); 		
		void free_register(std::string&); 

	friend std::ostream& operator<< (std::ostream&, const RegisterTable&); 
	private: 
		RegisterEntry registers[32]; //MIPS has 32 registers to work with
}; 
