#include "RegisterTable.h"

std::ostream& operator<< (std::ostream& os, const RegisterTable::RegisterEntry& reg) {
	os << reg.name << (reg.inUse ? "(using)" : "(not using)") << reg.currentEntry;

	return os;
}

std::ostream& operator<< (std::ostream& os, const RegisterTable& rt)
{
	for(const RegisterTable::RegisterEntry& reg : rt.registers) {
		os << reg << '\n';
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

std::string RegisterTable::get_register(const std::string& reg_name, bool is_float) {
	RegisterEntry* available = nullptr;
	for (auto& i : registers) {
		if (i.currentEntry == reg_name) {
			available = &i;
			break;
		}
	}
	if (available == nullptr) {
		for (auto& i : registers) {
			if (!i.inUse && (is_float 
					? (i.type == RegisterEntry::Type::FLOAT) 
					: (i.type == RegisterEntry::Type::INT))) {
				available = &i; // Check if any registers are free
				break;
			}
		}
	}
	if (available == nullptr) { // No register is not being used, spilling
		return "invalid_register";
	} else {
		available->inUse = true;
		available->currentEntry = reg_name;
		return available->name;
	}
}

void RegisterTable::free_register(const std::string& reg_name) {
	for (auto i : registers) {
		if (i.currentEntry == reg_name) i.inUse = false;
	}
}