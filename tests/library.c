void printInt(int i);
void printFloat(float f);
void printString(char* s);
void printChar(char c);
int readInt();
float readFloat();
void readString(char* s, int n);
char readChar();

int main() {}

void printInt(int i) {
	i = 3;
}

void printFloat(float f) {
	f = 2.5;
}

void printString(char* s) {
	s = 2;
}

void printChar(char c) {
	c = 'c';
}

int readInt() {
	return 3;
}

float readFloat() {
	return 2.0;
}

void readString(char* s, int n) {
	n = s = 4;
}

char readChar() {
	return 'c';
}
