int readInt();
void printInt(int);
void printChar(char);

struct Matrix {
	int elements[10][10];
	int rows;
	int columns;
};

struct Matrix readMatrix();
void printMatrix(struct Matrix);
struct Matrix multiplyMatrices(struct Matrix, struct Matrix);

void main(void) {
	struct Matrix mat1, mat2, mat3;
	int i, j;
	char* string = "Hello world!";
	// Read in matrices
	mat1 = readMatrix();
	printMatrix(mat1);
	printChar((char) 10);
	printChar((char) 10);

	mat2 = readMatrix();
	printMatrix(mat2);
	printChar((char) 10);
	printChar((char) 10);

	printMatrix(multiplyMatrices(mat1, mat2));
}

struct Matrix readMatrix() {
	struct Matrix re;
	int i, j, m;
	float x = 2.0f;
	printChar('E');
	printChar('N');
	printChar('T');
	printChar('E');
	printChar('R');
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
	printChar(':');
	printChar((char) 10);

	// Read in dimension
	re.rows = readInt();
	printChar('X');
	printChar((char) 10);
	re.columns = readInt();
	printChar((char) 10);

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

	for (m = 1; m < re.rows * re.columns; m *= 10) {}

	while (m > 1) {
		printChar(((char) ('0' + ((re.rows * re.columns) % m) / (m / 10))));
		m /= 10;
	}

	printChar(')');
	printChar(':');
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
		for (j = 0; j < m.columns && j < 10; j++) {
			printInt(m.elements[i][j]);
			printChar((char) 9);
		}
		printChar((char) 10);
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
		printChar((char) 10);
		return re;
	}

	re.rows    = m1.rows;
	re.columns = m2.columns;

	for (i = 0; i < m1.rows; i++) {
		for (j = 0; j < m2.columns; j++) {
			re.elements[i][j] = 0;
			for (k = 0; k < m2.rows; k++) {
				re.elements[i][j] += m1.elements[i][k] * m2.elements[k][j];
			}
		}
	}

	return re;
}
