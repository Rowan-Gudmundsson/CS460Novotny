void printChar(char);
int readInt();
void printInt(int);

int main() {
	int arr[100];
	int n, i, swapTemp;
	unsigned upperBound, currentIndex;

	printChar('#');
	printChar(' ');
	printChar('o');
	printChar('f');
	printChar(' ');
	printChar('e');
	printChar('l');
	printChar('e');
	printChar('m');
	printChar('e');
	printChar('n');
	printChar('t');
	printChar('s');
	printChar(':');
	printChar(' ');

	// Read in # of elements
	n = readInt();

	printChar('i');
	printChar('n');
	printChar('p');
	printChar('u');
	printChar('t');
	printChar(' ');
	printChar('v');
	printChar('a');
	printChar('l');
	printChar('u');
	printChar('e');
	printChar('s');
	printChar(':');
	printChar((char) 10);

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
