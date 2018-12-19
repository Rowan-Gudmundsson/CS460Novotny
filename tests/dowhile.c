int readInt();
void printInt(int);
int pow(int, int);

int main() {
	int n;
	do {
		n = readInt();
		printInt(pow(n, n));
	} while (n != 0);
}

int pow(int n, int p) {
	int re = 1, i;

	for (i = 0; i < p; i++) { re *= n; }

	return re;
}
