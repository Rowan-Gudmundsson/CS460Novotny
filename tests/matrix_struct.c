int readInt();
void printInt(int);
void printChar(char);

struct Matrix {
	int elements[10][10];
	int rows, columns;
};

struct Matrix readMatrix();
void printMatrix(struct Matrix);
struct Matrix multiplyMatrices(struct Matrix, struct Matrix);

void main(void) {
	struct Matrix mat1, mat2, mat3;
	int i, j;

	// Read in matrices
	mat1 = readMatrix();
	printChar((char) 10);
	printChar((char) 10);
	mat2 = readMatrix();

	// Separate Answer
	printChar((char) 10);
	printChar((char) 10);

	printMatrix(multiplyMatrices(mat1, mat2));
}

struct Matrix readMatrix() {
	struct Matrix re;
	int i, j;

	// Read in dimension
	re.rows = readInt();
	printChar('X');
	re.columns = readInt();
	printChar((char) 10);

	// Read in Matrix
	for (i = 0; i < re.rows && i < 10; i++) {
		for (j = 0; j < re.columns && j < 10; j++) { re.elements[i][j] = readInt(); }
	}

	return re;
}

void printMatrix(struct Matrix m) {
	int i, j;
	for (i = 0; i < m.rows && i < 10; i++) {
		for (j = 0; j < m.columns && j < 10; j++) { printInt(m.elements[i][j]); }
	}
}

struct Matrix multiplyMatrices(struct Matrix m1, struct Matrix m2) {
	struct Matrix re;
	int i, j, k;

	if (m1.columns != m2.rows) {
		printChar('E');
		printChar('R');
		printChar('R');
		printChar('O');
		printChar('R');
		printChar(':');
		printChar(' ');
		printChar('D');
		printChar('I');
		printChar('M');
		printChar('E');
		printChar('N');
		printChar('S');
		printChar('I');
		printChar('O');
		printChar('N');
		printChar('S');
		return re;
	}

	re.rows    = m1.rows;
	re.columns = m2.columns;

	for (int i = 0; i < m1.rows; i++) {
		for (int j = 0; j < m2.columns; j++) {
			re.elements[i][j] = 0;
			for (int k = 0; k < m2.rows; k++) {
				re.elements[i][j] += m1.elements[i][k] * m2.elements[k][j];
			}
		}
	}

	return re;
}
