struct Matrix {
	int elements[3][3];
	int rows;
	int columns;
};

struct Matrix calc_product(struct Matrix, struct Matrix);

void main(void) {
	struct Matrix mat1, mat2, mat3;
	mat1.rows           = 3;
	mat1.columns        = 3;
	mat1.elements[0][0] = 1.0f;
	mat1.elements[0][1] = 0.0f;
	mat1.elements[0][2] = 0.0f;
	mat1.elements[1][0] = 0.0f;
	mat1.elements[1][1] = 1.0f;
	mat1.elements[1][2] = 0.0f;
	mat1.elements[2][0] = 0.0f;
	mat1.elements[2][1] = 0.0f;
	mat1.elements[2][2] = 1.0f;

	mat2.rows           = 3;
	mat2.columns        = 3;
	mat2.elements[0][0] = 1.0f;
	mat2.elements[0][1] = 2.0f;
	mat2.elements[0][2] = 3.0f;
	mat2.elements[1][0] = 2.0f;
	mat2.elements[1][1] = 3.0f;
	mat2.elements[1][2] = 4.0f;
	mat2.elements[2][0] = 3.0f;
	mat2.elements[2][1] = 4.0f;
	mat2.elements[2][2] = 5.0f;

	mat3 = calc_product(mat1, mat2);
}

struct Matrix calc_product(struct Matrix mat1, struct Matrix mat2) {
	struct Matrix mat3;
	int i = 0, j = 0, k = 0;

	mat3.rows    = mat1.rows;
	mat3.columns = mat2.columns;
	for (i = 0; i < mat3.rows; i++) {
		for (j = 0; j < mat3.columns; j++) { mat3.elements[i][j] = 0.0f; }
	}

	if (mat1.columns != mat2.rows) return mat3;

	for (i = 0; i < mat1.rows; i++) {
		for (j = 0; j < mat2.columns; j++) {
			for (k = 0; k < mat2.rows; k++) {
				mat3.elements[i][j] += mat1.elements[i][k] * mat2.elements[k][j];
			}
		}
	}

	return mat3;
}