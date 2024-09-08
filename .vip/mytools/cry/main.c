#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define KSIZ 1024

char* strremove(char* str, const char* sub) {
	size_t len = strlen(sub);
	if (len > 0) {
		char *p = str;
		while ((p = strstr(p, sub)) != NULL) {
			memmove(p, p + len, strlen(p + len) + 1);
		}
	}
	return str;
}

const char* ext(const char* filename) {
    const char* dot = strrchr(filename, '.');
    if(!dot || dot == filename) return "";
    return dot + 1;
}

int main(int argc, char** argv) {

	// check args
	if (argc < 2) {
		fprintf(stderr, "USAGE: %s <file/file.cry>\n", argv[0]);
		return 1;
	}

	// open file
	char* filepath = argv[1];
	FILE* fp1 = fopen(filepath, "rb");
	if (!fp1) { fprintf(stderr, "Failed to open file: %s\n", filepath); return 1; }

	// check filename ext
	int dec = 0;
	if (strstr(ext(filepath), "cry")) { dec = 1; printf("DECRYPTION MODE\n"); }
	else                                            {          printf("ENCRYPTION MODE\n"); }

	// get password
	printf("PASSWORD: ");
	char pass[KSIZ] = {0};
	fgets(pass, KSIZ-1, stdin);
	int passlen = strlen(pass);

	// make new filename for output
	char* filepath2 = (char*)calloc(passlen + 1, sizeof(char));
	if (filepath2 == NULL) { fprintf(stderr, "error: failed to calloc name for output file\n"); return 1; }
	strcpy(filepath2, filepath);
	if (dec) { strremove(filepath2, ".cry"); }
	else     { strcat   (filepath2, ".cry"); }

	// open output file
	FILE* fp2 = fopen(filepath2, "wb");
	if (!fp1) { fprintf(stderr, "failed to open output file: %s\n", filepath2); return 1; }

	// cry algorithm
	int c;
	int i = 0;
	while ((c = fgetc(fp1)) != EOF) {
		int g = dec ? c - pass[i] : c + pass[i];
		fputc(g, fp2);
		i++;
		if (i > passlen-1) { i = 0; }
	}

	// cleanup
	free(filepath2);
	fclose(fp1);
	fclose(fp2);

	return 0;
}
