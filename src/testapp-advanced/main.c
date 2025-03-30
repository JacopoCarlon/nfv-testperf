#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "commands.h"
#include <rte_cycles.h>
#include <rte_eal.h>

static inline int run_command(int argc, char *argv[]) {
    int is_dpdk = 0;
    char* original_command = argv[0];
    int command_index = -1;
    
    // Check if command is a DPDK variant
    if (strncmp(original_command, "dpdk-", 5) == 0) {
        is_dpdk = 1;
        original_command += 5;  // Remove "dpdk-" prefix
    }

    // Find command index
    for (int i = 0; i < num_commands; ++i) {
        if (strcmp(original_command, commands_n[i]) == 0) {
            command_index = i;
            break;
        }
    }

    if (command_index == -1) {
        fprintf(stderr, "Invalid command: %s\n", argv[0]);
        return EXIT_FAILURE;
    }

    // Handle DPDK initialization
    if (is_dpdk) {
        // Find EAL/application argument separator
        int eal_argc = 0;
        for (; eal_argc < argc; eal_argc++) {
            if (strcmp(argv[eal_argc], "--") == 0) break;
        }

        // Prepare EAL arguments (need at least "dummy" program name)
        int ret = rte_eal_init(eal_argc, argv);
        if (ret < 0) {
            fprintf(stderr, "DPDK EAL initialization failed!\n");
            return EXIT_FAILURE;
        }

        // Adjust arguments for application (skip EAL args and "--")
        argc -= (eal_argc + 1);
        argv += (eal_argc + 1);
        
        // Ensure we have at least the command name left
        if (argc < 1) {
            fprintf(stderr, "No arguments after DPDK EAL parameters\n");
            return EXIT_FAILURE;
        }
    }

    printf("Executing command: %s\n", commands_n[command_index]);
    return commands_f[command_index](argc, argv);

}




int main(int argc, char *argv[]) {
    if (argc < 2) {
        printf("Usage: %s <command> [options]\n", argv[0]);
        printf("Available commands:\n");
        printf("  Regular commands: server, client, clientst, send, recv\n");
        printf("  DPDK commands: dpdk-server, dpdk-client, dpdk-clientst, dpdk-send, dpdk-recv\n");
        return EXIT_SUCCESS;
    }

    printf("-------- TESTAPP NEW VERSION --------\n");

    return run_command(argc - 1, argv + 1);
}



