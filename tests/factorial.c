
int factorial(int n);

int main() {
	int n = 11;
	int f = factorial(n);
}

int factorial(int n) {
	if (n <= 1)
		return 1;
	else
		return n * factorial(n - 1);
}
