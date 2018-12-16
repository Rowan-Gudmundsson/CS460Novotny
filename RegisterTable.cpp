#include "RegisterTable.h"

std::ostream& operator<<(std::ostream& os, const RegisterTable::RegisterEntry& reg) {
	os << reg.name;

	return os;
}

std::ostream& operator<<(std::ostream& os, const RegisterTable& rt) {
	for (const RegisterTable::RegisterEntry& reg : rt.registers) {
		os << reg << (reg.inUse ? "(using)     : " : "(not using) : ") << reg.currentEntry << '\n';
	}

	return os;
}

RegisterTable RegisterTable::getMIPSRegisters() {
	RegisterTable re;

	// Integer temporaries
	for (int i = 0; i < 10; i++) {
		re.add_register({"$t" + std::to_string(i), true, RegisterEntry::Type::INT});
	}

	// Integer saveds
	for (int i = 0; i < 8; i++) {
		re.add_register({"$s" + std::to_string(i), RegisterEntry::Type::INT});
	}

	// Float temporaries
	for (int i = 0; i < 19; i += 2) {
		re.add_register({"$f" + std::to_string(i), true, RegisterEntry::Type::FLOAT});
	}

	// Float saveds
	for (int i = 20; i < 31; i += 2) {
		re.add_register({"$f" + std::to_string(i), RegisterEntry::Type::FLOAT});
	}

	return re;
}

RegisterTable::RegisterEntry* RegisterTable::getUnusedRegister(const Operand& contents) {
	RegisterEntry::Type t = (contents.isFloat() ? RegisterEntry::FLOAT : RegisterEntry::INT);
	bool temporary        = contents.isTemp() || contents.isConst() || contents.isIndr();

	// First search for a register matching the temporary-ness
	for (RegisterEntry& reg : registers) {
		if (reg.temporary == temporary && !reg.inUse && reg.type == t) {
			reg.inUse        = true;
			reg.currentEntry = contents;
			reg.usedAsTemp   = temporary;
			return &reg;
		}
	}

	// Then if we can't find one of those - just choose an empty one
	for (RegisterEntry& reg : registers) {
		if (!reg.inUse && reg.type == t) {
			reg.inUse        = true;
			reg.currentEntry = contents;
			reg.usedAsTemp   = temporary;
			return &reg;
		}
	}

	std::cout << "About to return nullptr:" << std::endl << *this << std::endl;

	// TODO - Register spilling
	return nullptr;
}

RegisterTable::RegisterEntry* RegisterTable::findLocation(const Operand& contents) {
	if (contents.isIndr()) {
		RegisterEntry* addReg = findLocation({"ITemp", contents.value});
		if (addReg == nullptr)
			throw std::runtime_error("Found no register when searching for indirect.");

		RegisterEntry entry((contents.isFloat() ? RegisterEntry::FLOAT : RegisterEntry::INT),
		                    addReg);

		indirects.push_back(entry);

		return &indirects.back();
	}

	for (RegisterEntry& reg : registers) {
		if (reg.inUse && reg.currentEntry == contents) { return &reg; }
	}

	return nullptr;
}