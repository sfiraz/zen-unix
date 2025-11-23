#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/wait.h>
#include <pwd.h>
#include <unistd.h>
#include <sys/stat.h>

#define MAX_INPUT 1024

void show_logo() {
    printf("\n");
    printf("    ███████╗███████╗███╗   ██╗    ┌──────────────┐\n");
    printf("    ╚══███╔╝██╔════╝████╗  ██║    │ Zen Unix     │\n");
    printf("      ███╔╝ █████╗  ██╔██╗ ██║    │ ARM64        │\n");
    printf("     ███╔╝  ██╔══╝  ██║╚██╗██║    │ Minimal      │\n");
    printf("    ███████╗███████╗██║ ╚████║    │ v0.1         │\n");
    printf("    ╚══════╝╚══════╝╚═╝  ╚═══╝    └──────────────┘\n");
    printf("\n");
}

void setup_environment() {
    // Buat home directory
    mkdir("/home", 0755);
    mkdir("/home/user", 0755);
    
    // Set HOME environment variable
    setenv("HOME", "/home/user", 1);
    setenv("USER", "user", 1);
    setenv("SHELL", "/bin/zen", 1);
    
    // Change to home directory
    chdir("/home/user");
}

void shell() {
    char input[MAX_INPUT];
    char cwd[256];
    
    printf("Zen Shell - Type 'exit' to quit\n");
    
    setup_environment();
    
    while(1) {
        // Get current directory
        getcwd(cwd, sizeof(cwd));
        
        // Show prompt dengan path
        printf("☯ %s $ ", cwd);
        fflush(stdout);
        
        if (!fgets(input, MAX_INPUT, stdin)) {
            break;
        }
        
        input[strcspn(input, "\n")] = 0;
        
        if (strcmp(input, "exit") == 0 || strcmp(input, "quit") == 0) {
            printf("\n");
            break;
        }
        
        if (strlen(input) == 0) {
            continue;
        }
        
        // Change directory command
        if (strncmp(input, "cd ", 3) == 0) {
            char *path = input + 3;
            if (chdir(path) != 0) {
                printf("cd: %s: No such directory\n", path);
            }
            continue;
        }
        
        pid_t pid = fork();
        if (pid == 0) {
            execl("/bin/sh", "sh", "-c", input, NULL);
            printf("Command failed: %s\n", input);
            exit(1);
        } else if (pid > 0) {
            wait(NULL);
        } else {
            printf("Fork failed\n");
        }
        
        printf("\n");
    }
}

int main() {
    show_logo();
    shell();
    printf("Goodbye!\n");
    return 0;
}
