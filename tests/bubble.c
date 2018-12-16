int main() {
	int arr[10];
	int i;
	int swapTemp;
	unsigned upperBound;
	unsigned currentIndex;

	// Assign descending order array
	for (i = 0; i < 10; i++) { arr[i] = 10 - i; }

	// Then sort
	// Start by sorting the full array
	// After each iteration, the last value in the array should be correct, so lower the upper bound
	// by 1
	for (upperBound = 10; upperBound > 0; upperBound--) {
		for (currentIndex = 0; currentIndex < upperBound; currentIndex++) {
			// If the number we're looking at is in the wrong place, swap it to the right
			if (arr[currentIndex] > arr[currentIndex + 1]) {
				swapTemp              = arr[currentIndex];
				arr[currentIndex]     = arr[currentIndex + 1];
				arr[currentIndex + 1] = swapTemp;
			}
		}
	}
}
