#pragma once

class ScannerError : public std::runtime_error {
	public:
		ScannerError(std::string what) : std::runtime_error(what) {};
};

class ParserError : public std::runtime_error {
	public:
		ParserError(std::string what) : std::runtime_error(what) {};
};
