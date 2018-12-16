struct Matrix {
	float elements[3][3];
	int rows, columns;
};

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

	mat3.rows           = 3;
	mat3.columns        = 3;
	mat3.elements[0][0] = 0.0f;
	mat3.elements[0][1] = 0.0f;
	mat3.elements[0][2] = 0.0f;
	mat3.elements[1][0] = 0.0f;
	mat3.elements[1][1] = 0.0f;
	mat3.elements[1][2] = 0.0f;
	mat3.elements[2][0] = 0.0f;
	mat3.elements[2][1] = 0.0f;
	mat3.elements[2][2] = 0.0f;

	if (mat1.columns != mat2.rows) return;

	for (int i = 0; i < mat1.rows; i++) {
		for (int j = 0; j < mat2.columns; j++) {
			for (int k = 0; k < mat2.rows; k++) {
				mat3.elements[i][j] += mat1.elements[i][k] * mat2.elements[k][j];
			}
		}
	}
}