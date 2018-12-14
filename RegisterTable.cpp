#include "RegisterTable.h"

RegisterTable::RegisterEntry RegisterTable::IN_MEMORY("memory", false);

std::ostream& operator<< (std::ostream& os, const RegisterTable::RegisterEntry& reg) {
	os << reg.name;

	return os;
}

std::ostream& operator<< (std::ostream& os, const RegisterTable& rt)
{
	for(const RegisterTable::RegisterEntry& reg : rt.registers) {
		os << reg << (reg.inUse ? "(using)     : " : "(not using) : ") << reg.currentEntry<< '\n';
	}

	return os;
}

RegisterTable RegisterTable::getMIPSRegisters() {
	RegisterTable re;

	// Integer temporaries
	for(int i = 0; i < 10; i++) {
		re.add_register({"$t" + std::to_string(i), true, RegisterEntry::Type::INT});
	}

	// Integer saveds
	for(int i = 0; i < 8; i++) {
		re.add_register({"$s" + std::to_string(i), RegisterEntry::Type::INT});
	}

	// Float temporaries
	for(int i = 0; i < 19; i+=2) {
		re.add_register({"$f" + std::to_string(i), true, RegisterEntry::Type::FLOAT});
	}

	// Float saveds
	for(int i = 20; i < 31; i+=2) {
		re.add_register({"$f" + std::to_string(i), RegisterEntry::Type::FLOAT});
	}

	return re;
}

RegisterTable::RegisterEntry& RegisterTable::getUnusedRegister(const std::string& contents, bool temporary, bool floating) {
	RegisterEntry::Type t = (floating ? RegisterEntry::FLOAT : RegisterEntry::INT);
	for(RegisterEntry& reg : registers) {
		if(reg.temporary == temporary && !reg.inUse && reg.type == t) {
			reg.inUse = true;
			reg.currentEntry = contents;
			return reg;
		}
	}
}

RegisterTable::RegisterEntry& RegisterTable::findLocation(const std::string& contents) {
	for(RegisterEntry& reg : registers) {
		if(reg.currentEntry == contents) {
			if(reg.temporary) {
				reg.inUse = false;
			}

			return reg;
		}
	}

	return IN_MEMORY;
}