void printInt(int i);
void printFloat(float f);
void printString(char* s);
void printChar(char c);
int readInt();
float readFloat();
void readString(char* s, int n);
char readChar();

int main() {
	int a[2][2];
	int b[2][2];
	int c[2][2];
	int i, j, k;

	// Read in matrix a
	for (i = 0; i < 2; i++) {
		for (j = 0; j < 2; j++) { a[i][j] = readInt(); }
	}

	printChar((char) 10);

	// Read in matrix b
	for (i = 0; i < 2; i++) {
		for (j = 0; j < 2; j++) { b[i][j] = readInt(); }
	}

	// c = a b
	for (i = 0; i < 2; i++) {
		for (j = 0; j < 2; j++) { c[i][j] = 0; }
	}
	for (i = 0; i < 2; i++) {
		for (j = 0; j < 2; j++) {
			for (k = 0; k < 2; k++) { c[i][j] += a[i][k] * b[k][j]; }
		}
	}

	// Display matrix c
	for (i = 0; i < 2; i++) {
		for (j = 0; j < 2; j++) {
			printInt(c[i][j]);
			printChar((char) 9);
		}
		printChar((char) 10);
	}
}
