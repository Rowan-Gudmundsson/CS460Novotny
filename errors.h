#pragma once

class scannerError : public std::runtime_error {
	public:
		scannerError(std::string what) : std::runtime_error(what) {};
};
