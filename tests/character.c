void printChar(char c);

int main() {
	char c;

	for (c = 'a'; c <= 'z'; c++) {
		printChar(c);
		printChar(' ');
	}
}
