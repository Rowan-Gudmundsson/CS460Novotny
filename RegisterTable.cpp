#include "RegisterTable.h"

void populateRegister(RegisterEntry& re, std::string theName, 
								bool isReserved)
{
	re.name = theName;
	re.reserved = isReserved; 
	re.temporary = false; 
	re.inUse = false; 
	re.currentEntry = NULL; 
}

RegisterTable::RegisterTable()
{
	/* hardwired to zero */
	populateRegister(registers[0], "zero", true);

	/* reserved got pseudo-instructions */
	populateRegister(registers[1], "at", true);

	/* return values from functions */
	populateRegister(registers[2], "v0", true);
	populateRegister(registers[3], "v1", true);

	/* arguments to functions -- not preserved by subprograms */
	populateRegister(registers[4], "a0", false);
	populateRegister(registers[5], "a1", false);
	populateRegister(registers[6], "a2", false);
	populateRegister(registers[7], "a3", false);

	/* temporary data -- not preserved by subprograms */
	populateRegister(registers[8], "t0", false);
	populateRegister(registers[9], "t1", false);
	populateRegister(registers[10], "t2", false);
	populateRegister(registers[11], "t3", false);
	populateRegister(registers[12], "t4", false);
	populateRegister(registers[13], "t5", false);
	populateRegister(registers[14], "t6", false);
	populateRegister(registers[15], "t7", false);

	/* saved registers -- preserved by subprograms */
	populateRegister(registers[16], "s0", false);
	populateRegister(registers[17], "s1", false);
	populateRegister(registers[18], "s2", false);
	populateRegister(registers[19], "s3", false);
	populateRegister(registers[20], "s4", false);
	populateRegister(registers[21], "s5", false);
	populateRegister(registers[22], "s6", false);
	populateRegister(registers[23], "s7", false);

	/* more temporary registers -- not preserved by subprograms */
	populateRegister(registers[24], "t8", false);
	populateRegister(registers[25], "t9", false);

	/* reserved for the kernal do not use */
	populateRegister(registers[26], "k0", false);
	populateRegister(registers[27], "k1", false);

	/* global area pointer (base of global data segment) */
	populateRegister(registers[28], "gp", true);

	/* stack pointer */
	populateRegister(registers[29], "sp", true);

	/* frame pointer */
	populateRegister(registers[30], "fp", true);

	/* return address (aka program counter) */
	populateRegister(registers[31], "pc", true);

}

RegisterTable::~RegisterTable() {
	for (int i = 0; i < 32; i++) {
		if (registers[i].currentEntry != nullptr) {
			delete(registers[i].currentEntry);
			registers[i].currentEntry = nullptr;
		}
	}	
}

std::ostream& operator<< (std::ostream& os, const RegisterTable& rt)
{
	for(int i =0; i < 32; i++)
	{	
		RegisterEntry entry = rt.registers[i];
		os << "R" << i << " " << entry.name;
		if(entry.reserved) 
		{
			os << "*";
		} else {
			os << " ";
		}
		os << std::endl; 
	}

	return os;
}
