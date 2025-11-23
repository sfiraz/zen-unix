#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/wait.h>
#include <pwd.h>
#include <unistd.h>

#define MAX_INPUT 1024

void show_logo() {
    printf("\n");
    printf(COLOR_CYAN "    ███████╗███████╗███╗   ██╗" COLOR_RESET "    " COLOR_GREEN "┌──────────────┐\n" COLOR_RESET);
    printf(COLOR_CYAN "    ╚══███╔╝██╔════╝████╗  ██║" COLOR_RESET "    " COLOR_GREEN "│" COLOR_YELLOW " Zen Unix     " COLOR_GREEN "│\n" COLOR_RESET);
    printf(COLOR_CYAN "      ███╔╝ █████╗  ██╔██╗ ██║" COLOR_RESET "    " COLOR_GREEN "│" COLOR_YELLOW " ARM64        " COLOR_GREEN "│\n" COLOR_RESET);
    printf(COLOR_CYAN "     ███╔╝  ██╔══╝  ██║╚██╗██║" COLOR_RESET "    " COLOR_GREEN "│" COLOR_YELLOW " Minimal      " COLOR_GREEN "│\n" COLOR_RESET);
    printf(COLOR_CYAN "    ███████╗███████╗██║ ╚████║" COLOR_RESET "    " COLOR_GREEN "│" COLOR_YELLOW " v0.1         " COLOR_GREEN "│\n" COLOR_RESET);
    printf(COLOR_CYAN "    ╚══════╝╚══════╝╚═╝  ╚═══╝" COLOR_RESET "    " COLOR_GREEN "└──────────────┘\n" COLOR_RESET);
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
    
    printf(COLOR_GREEN "Zen Shell" COLOR_RESET " - Type 'exit' to quit\n");
    
    setup_environment();
    
    while(1) {
        // Get current directory
        getcwd(cwd, sizeof(cwd));
        
        // Show prompt dengan path
        printf(COLOR_MAGENTA "☯ " COLOR_CYAN "%s" COLOR_MAGENTA " $ " COLOR_RESET, cwd);
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
                printf(COLOR_RED "cd: %s: No such directory\n" COLOR_RESET, path);
            }
            continue;
        }
        
        pid_t pid = fork();
        if (pid == 0) {
            execl("/bin/sh", "sh", "-c", input, NULL);
            printf(COLOR_RED "Command failed: %s\n" COLOR_RESET, input);
            exit(1);
        } else if (pid > 0) {
            wait(NULL);
        } else {
            printf(COLOR_RED "Fork failed\n" COLOR_RESET);
        }
        
        printf("\n");
    }
}

int main() {
    show_logo();
    shell();
    printf(COLOR_GREEN "Goodbye!\n" COLOR_RESET);
    return 0;
}
