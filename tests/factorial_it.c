int readInt();
void printInt(int);

int main() {
	unsigned fact = 1;
	unsigned n    = readInt();
	unsigned i;

	for (i = 1; i <= n; i++) { fact *= i; }

	printInt((int) fact);
}
