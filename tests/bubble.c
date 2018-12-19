void printChar(char);
void printString(const char* string);
int readInt();
void printInt(int);

typedef struct foo {
	int x;
} Foo;

int main() {
	int arr[100];
	int* ptrAr[10];
	int n, i, swapTemp;
	unsigned upperBound, currentIndex;
	int* j;
	Foo z;

	j   = &z.x;
	z.x = 5;

	printInt(*j);

	printString("# of elements: ");

	// Read in # of elements
	n = readInt();

	printString("input values:\n");

	// Read in values
	for (i = 0; i < n && i < 100; i++) { arr[i] = readInt(); }

	// Then sort
	// Start by sorting the full array
	// After each iteration, the last value in the array should be correct, so lower the upper bound
	// by 1
	for (upperBound = n - 1; upperBound > 0; upperBound--) {
		for (currentIndex = 0; currentIndex < upperBound; currentIndex++) {
			// If the number we're looking at is in the wrong place, swap it to the right
			if (arr[currentIndex] > arr[currentIndex + 1]) {
				swapTemp              = arr[currentIndex];
				arr[currentIndex]     = arr[currentIndex + 1];
				arr[currentIndex + 1] = swapTemp;
			}
		}
	}

	// Print values
	for (i = 0; i < n && i < 100; i++) {
		printInt(arr[i]);
		printChar(' ');
	}
}
