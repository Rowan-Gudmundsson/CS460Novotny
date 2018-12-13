#include "RegisterTable.h"

std::ostream& operator<< (std::ostream& os, const RegisterEntry& reg) {
	os << reg.name << (reg.inUse ? "(using)" : "(not using)")": " << reg.currentEntry;

	return os;
}

std::ostream& operator<< (std::ostream& os, const RegisterTable& rt)
{
	for(const RegisterEntry& reg : rt.registers) {
		os << reg << '\n';
	}

	return os;
}

RegisterTable RegisterTable::getMIPSRegisters() {
	RegisterTable re;

	// Integer temporaries
	for(int i = 0; i < 10; i++) {
		re.addRegister({"$t" + std::to_string(i), true});
	}

	// Integer saveds
	for(int i = 0; i < 8; i++) {
		re.addRegister({"$s" + std::to_string(i)});
	}

	// Float temporaries
	for(int i = 0; i < 19; i+=2) {
		re.addRegister({"$f" + std::to_string(i), true});
	}

	// Float saveds
	for(int i = 20; i < 31; i+=2) {
		re.addRegister({"$f" + std::to_string(i)});
	}

	return re;
}