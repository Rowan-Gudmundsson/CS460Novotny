void printInt(int i);
int factorial(int n);

int main() {
	int n = 11;
	int f = factorial(n);

	printInt(f);
}

int factorial(int n) {
	if (n <= 1)
		return 1;
	else
		return n * factorial(n - 1);
}
