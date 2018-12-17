void printInt(int i);
int readInt();

int factorial(int n);

int main() {
	printInt(factorial(readInt()));
}

int factorial(int n) {
	if (n <= 1)
		return 1;
	else
		return n * factorial(n - 1);
}
