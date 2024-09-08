#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>
#include <ctype.h>
#include <gtk/gtk.h>

#define MIN_STR_LEN 8
#define MAX_NUM_LEN 32

char* g_utf8_strtitle(const char* str) {

	char* str_ = strdup(str);

	unsigned int len_utf8 = g_utf8_strlen(str_, -1);
	unsigned int len_byte = strlen(str_);

	char firstLetter[8] = {0};
	for (unsigned int i = 0; i < (len_byte - len_utf8) + 1; i++) {
		firstLetter[i] = str_[i];
	}

	char* up = g_utf8_strup(firstLetter, -1);
	for (unsigned int i = 0; i < strlen(up); i++) { str_[i] = up[i]; }
	free(up);

	return str_;
}

int echo(const char* str) {
	return (g_utf8_strlen(str, -1) >= MIN_STR_LEN ? printf("%s\n", str) : 0);
}

int echo_pre(char* buff, const char* word, const char* istr) {
	sprintf(buff, "%s%s", word, istr); echo(buff);
	sprintf(buff, "%s%s", istr, word); echo(buff);
	sprintf(buff, "%s%s%s", istr, word, istr); echo(buff);
	return 0;
}

void num_sufix(char* buff, const char* word) {
	char ibuff[MAX_NUM_LEN];
	for (int i = 0; i < 1000001; i++) {
		sprintf(ibuff, "%d", i);
		echo_pre(buff, word, ibuff);
	}
}

void padleft(char* buff, char* str, int pad) {
	buff[0] = '\0';
	int g = pad - g_utf8_strlen(str, -1);
	for (int i = 0; i < g; i++) { strcat(buff, "0"); }
	strcat(buff, str);
}
void num_padsufix(char* buff, const char* word) {
	char ibuff[MAX_NUM_LEN];
	char ibuff2[MAX_NUM_LEN];
	for (int x = 2; x < 5; x++) {
		double g = pow(10, (x-1));
		for (int y = 0; y < g; y++) {
			sprintf(ibuff, "%d", y);
			padleft(ibuff2, ibuff, x);
			//printf("x, y: %d , %d --> %s\n", x, y, ibuff2);
			echo_pre(buff, word, ibuff2);
		}
	}
}

int genWordlist_numberSwapper(char* buff, const char* word) {

	// just print the word
	echo(word);

	/* // could cause a dupe if some of the cases below match the normal case
	// normal case
	num_sufix(buff, word);
	num_padsufix(buff, word);
	//*/

	// upper case
	char* word_up = g_utf8_strup(word, -1);
	num_sufix(buff, word_up);
	num_padsufix(buff, word_up);
	free(word_up);
	
	// lower case
	char* word_down = g_utf8_strdown(word, -1);
	num_sufix(buff, word_down);
	num_padsufix(buff, word_down);
	free(word_down);

	// title case
	char* word_title = g_utf8_strtitle(word);
	num_sufix(buff, word_title);
	num_padsufix(buff, word_title);
	free(word_title);

	return 0;
}

int main(int argc, char** argv) {
	
	if (argc < 2) {
		printf("ABOUT: generate wordlist from word(s)\n");
		printf("USAGE: %s <word1> <word2> <wrd3> <...>\n", argv[0]);
		return 1;
	}

	for (int i = 1; i < argc; i++) {
		char* buff = (char*)calloc(strlen(argv[i]) * MAX_NUM_LEN, sizeof(char));
		genWordlist_numberSwapper(buff, argv[i]);
		free(buff);
	}

	return 0;
}
