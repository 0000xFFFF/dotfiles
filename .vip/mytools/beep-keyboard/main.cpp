#include <stdio.h>
#include <termios.h>   //getch
#include <fcntl.h>     //O_RDONLY, open
#include <linux/kd.h>  //KDMKTONE
#include <sys/ioctl.h> //ioctl

static struct termios old, new_;
//Initialize new_ terminal i/o settings
void initTermios(int echo) {
	tcgetattr(0, &old);                  //grab old terminal i/o settings
	new_ = old;                          //make new_ settings same as old settings */
	new_.c_lflag &= ~ICANON;             //disable buffered i/o
	if (echo) { new_.c_lflag |= ECHO;  } //set echo mode
	else      { new_.c_lflag &= ~ECHO; } //no echo mode
	tcsetattr(0, TCSANOW, &new_);        //use these new_ terminal i/o settings now
}
void resetTermios(void) { tcsetattr(0, TCSANOW, &old);} // Restore old terminal i/o settings
char getch_(int echo)   { char ch; initTermios(echo); ch = getchar(); resetTermios(); return ch; }
char getch(void)        { return getch_(0); }
char getche(void)       { return getch_(1); }

//beep with motherboard speaker
int beep(int fq, int dur) {
	int fd = open("/dev/tty10", O_RDONLY);
	if (fd == -1) { fprintf(stderr, "fd = -1\n"); return 1; } //fail
	return ioctl(fd, KDMKTONE, (dur<<16) + (1193180/fq));
}

int main(int argc, char* argv[]) {
	printf(" we tyu op ]\n");
	printf("asdfghjkl;'\\\n");
	while(true) {
		char note = getch();
		switch(note) {
			//lower
			case 'a':  beep(261, 200); break;
			case 's':  beep(293, 200); break;
			case 'd':  beep(329, 200); break;
			case 'f':  beep(349, 200); break;
			case 'g':  beep(392, 200); break;
			case 'h':  beep(440, 200); break;
			case 'j':  beep(493, 200); break;
			case 'k':  beep(523, 200); break;
			case 'l':  beep(587, 200); break;
			case ';':  beep(659, 200); break;
			case '\'': beep(698, 200); break;
			case '\\': beep(784, 200); break;
			//upper
			case 'w': beep(277, 200); break;
			case 'e': beep(311, 200); break;
			case 't': beep(370, 200); break;
			case 'y': beep(415, 200); break;
			case 'u': beep(466, 200); break;
			case 'o': beep(554, 200); break;
			case 'p': beep(622, 200); break;
			case ']': beep(740, 200); break;
			//special
			// case 'q': return 0; break;
		}
	}
	
	return 0;
}
