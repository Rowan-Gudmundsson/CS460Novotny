int readInt();
void printInt(int);
void printChar(char);
void printString(const char* string);

struct Vec3 {
	int x;
	int y;
	int z;
};

struct Vec3 readVec();
void writeVec(struct Vec3 v);

void main(void) {
	struct Vec3 vec;

	printString("v:\n");

	vec = readVec();
	writeVec(vec);
}

struct Vec3 readVec() {
	struct Vec3 v;
	v.x = readInt();
	v.y = readInt();
	v.z = readInt();

	return v;
}

void writeVec(struct Vec3 v) {
	printChar('<');
	printInt(v.x);
	printString(", ");
	printInt(v.y);
	printString(", ");
	printInt(v.z);
	printChar('>');
	printChar((char) 10);
}