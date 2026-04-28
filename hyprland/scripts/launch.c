// Translated from https://github.com/oem/lnch/blob/master/main.go

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

int main(int argc, char *argv[]) {
    if (argc <= 1) {
        printf("Usage: lnch <command> <optional parameters>\n");
        exit(1);
    }

    pid_t pid = fork();

    if (pid < 0) {
        perror("fork");
        exit(1);
    }

    if (pid == 0) {
        // put child in new process group to avoid being killed when parent is killed
        setpgid(0, 0);
        execvp(argv[1], &argv[1]);
        // only reach if execvp fails
        perror("execvp");
        exit(1);
    }

    // parent exits immdiately
    return 0;
}
