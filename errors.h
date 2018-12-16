#pragma once

class ScannerError : public std::runtime_error {
public:
	ScannerError(const std::string& what) : std::runtime_error(what){};
};

class ParserError : public std::runtime_error {
public:
	ParserError(const std::string& what) : std::runtime_error(what){};
	ParserError(const std::string& what, const std::string& src)
	    : std::runtime_error(what), source(src){};

private:
	const std::string source;
};
