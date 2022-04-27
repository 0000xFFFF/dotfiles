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

	// get password
	printf("PASSWORD: ");
	char pass[KSIZ] = {0};
	fgets(pass, KSIZ-1, stdin);
	int passlen = strlen(pass);

	if (strstr(filepath, ".cry")) {
		// make new filename
		char* filepath2 = (char*)calloc(passlen + 1, sizeof(char));
		strcpy(filepath2, filepath);
		strremove(filepath2, ".cry");

		// open newfile and decrypt
		FILE* fp2 = fopen(filepath2, "wb");
		if (!fp1) { fprintf(stderr, "Failed to open file: %s\n", filepath2); return 1; }
		int c;
		int i = 0;
		while ((c = fgetc(fp1)) != EOF) {
			int g = c - pass[i];
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
	else {
		// make new filename
		char* filepath2 = (char*)calloc(passlen + 1, sizeof(char));
		strcpy(filepath2, filepath);
		strcat(filepath2, ".cry");

		FILE* fp2 = fopen(filepath2, "wb");
		if (!fp1) { fprintf(stderr, "Failed to open file: %s\n", filepath2); return 1; }
		int c;
		int i = 0;
		while ((c = fgetc(fp1)) != EOF) {
			int g = c + pass[i];
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



	return 0;
}
