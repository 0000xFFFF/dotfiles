#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <linux/kd.h>
#include <sys/ioctl.h>

int main(int argc, char* argv[]) {
    int fd = open("/dev/tty10", O_RDONLY);
    if (fd == -1) { fprintf(stderr, "fd = -1\n"); return 1; }
    if (argc != 3) { printf("usage: %s <frequency> <duration>\n", argv[0]); return 1; }
    return ioctl(fd, KDMKTONE, (atoi(argv[2])<<16)+(1193180/atoi(argv[1])));
}
