#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>

int main(int argc, char* argv[]) {
	if (argc == 1) { fprintf(stderr, "USAGE: %s <string>\n", argv[0]); return 0; }
	srand(time(0));
	char* argv1 = argv[1];
	int strl = strlen(argv1);
	int strl2 = strl * 2;
	char arr[strl2];
	int c = 0;
	for (int i = 0; i < strl2; i++) {
		arr[c] = argv1[i];
		c++;
		arr[c] = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"[random () % (26*2)];
		c++;
	}
	printf("%s\n", arr);
}
