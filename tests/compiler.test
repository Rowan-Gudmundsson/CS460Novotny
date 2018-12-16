void blah();
void blah(int);
void blah(char);

int something = 2;
#DUMP

struct T {
	int s;
	float y[4];
};

int main() {
	// This is a test
	char z  = 's';
	short x = 0, y = 2;
	long a, b;
	int q[50 + 2];
	int m[2][5];
	int n[3 + 2][3 * 2][4];
	int o[2 * 1][2 / 1][2 << 0][2 >> 0][2];
	struct T t;

	struct B {
		int d;
		char e;
	};

	struct G {
		int d;
		char e;
	} g;

	t.s = 2;
	t.s = t.y[1] + g.d;

	something = 3;
	/* test */
	{
		/* This
		   Is
		   A
		   Multiline
		   Comment */
		int x;
	}

	x = x + y / 2;
	y *= 3 % z;

	if (x == 2 || y > z / 2) {
		z = 3;
	} else if (1) {
		y = 3;
	} else {
		x = 2;
	}

	if (x % y > q[y + z]) { q[x * y] = 42; }

	m[2][3]          = 3;
	n[x + y][2][z]   = 4;
	o[0][1][x][0][1] = o[1][1][x][y][1];

	for (x = 0; x < 4; x++) { q[x] = y * x; }

	blah(q[2] + 3 * 4);
	blah(z);
	blah();
}

void blah(int y) {
	int x = y * 2;
	blah(x);
	blah(y);
#DUMP
}

void blah(char y) {
	struct F {
		int* a;
	};
	char x = 0;
}
