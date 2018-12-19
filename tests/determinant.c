int readInt();
void printInt(int);
void printChar(char);

struct Matrix {
	int entries[5][5];
	unsigned rows;
	unsigned columns;
};

int determinant(struct Matrix);
struct Matrix readMatrix();
void printMatrix(struct Matrix m);
struct Matrix minor(struct Matrix, int, int);

int main() {
	struct Matrix m;
	int i;

	printInt(determinant(readMatrix()));
}

struct Matrix readMatrix() {
	struct Matrix m;
	int i, j;

	printChar('E');
	printChar('N');
	printChar('T');
	printChar('E');
	printChar('R');
	printChar(' ');
	printChar('S');
	printChar('I');
	printChar('Z');
	printChar('E');
	printChar(' ');
	printChar('(');
	printChar('N');
	printChar(' ');
	printChar('x');
	printChar(' ');
	printChar('N');
	printChar(')');
	printChar(':');
	printChar(' ');

	m.rows = m.columns = readInt();

	printChar('E');
	printChar('N');
	printChar('T');
	printChar('E');
	printChar('R');
	printChar(' ');
	printChar('E');
	printChar('N');
	printChar('T');
	printChar('R');
	printChar('I');
	printChar('E');
	printChar('S');
	printChar(' ');
	printChar('(');

	printInt((int) (m.rows * m.columns));

	printChar(')');
	printChar(':');
	printChar((char) 10);

	// Read in Matrix
	for (i = 0; i < m.rows && i < 5; i++) {
		for (j = 0; j < m.columns && j < 5; j++) { m.entries[i][j] = readInt(); }
	}

	printMatrix(m);

	return m;
}

int determinant(struct Matrix m) {
	unsigned det = 0;
	int i, j, ticker = 1;

	if (m.rows != m.columns) {
		return 0;
	} else if (m.rows == 1)
		return m.entries[0][0];

	for (j = 0; j < m.columns; j++) {
		det += determinant(minor(m, 0, j)) * ticker * m.entries[0][j];
		ticker *= 0 - 1;
	}

	return det;
}

struct Matrix minor(struct Matrix m, int i, int j) {
	int a, b;
	for (a = 0; a < m.rows; a++) {
		for (b = 0; b < m.columns; b++) {
			if (a >= i && b >= j) {
				m.entries[a][b] = m.entries[a + 1][b + 1];
			} else if (a >= i) {
				m.entries[a][b] = m.entries[a + 1][b];
			} else if (b >= j) {
				m.entries[a][b] = m.entries[a][b + 1];
			}
		}
	}

	for (a = 0; a < m.rows; a++) m.entries[a][m.columns - 1] = 0;
	for (b = 0; b < m.rows; b++) m.entries[m.rows - 1][b] = 0;

	m.columns--;
	m.rows--;

	return m;
}

void printMatrix(struct Matrix m) {
	int i, j;
	for (i = 0; i < m.rows && i < 5; i++) {
		for (j = 0; j < m.columns && j < 5; j++) {
			printInt(m.entries[i][j]);
			printChar((char) 9);
		}
		printChar((char) 10);
	}
}
