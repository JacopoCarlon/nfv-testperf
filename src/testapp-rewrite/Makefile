# Variables that can be overwritten from outside
DIR_ROOTFS ?= $(NFV_PATH)/install/rootfs
BUILD ?= release

# DPDK configuration using pkg-config
PKG_CONFIG ?= pkg-config
DPDK_CFLAGS := $(shell $(PKG_CONFIG) --cflags libdpdk)
DPDK_LDFLAGS := $(shell $(PKG_CONFIG) --libs libdpdk)

# Source files
SRCS = main.c config.c commands.c threads.c cores.c timestamp.c \
       loops.c stats.c nfv_socket.c nfv_socket_simple.c nfv_socket_dpdk.c dpdk.c

OBJS = $(SRCS:.c=.o)
APP = testapp

# Compiler flags
CFLAGS += -I./inc -Wall -Wextra -march=native
CFLAGS += $(DPDK_CFLAGS)
CFLAGS += -D_GNU_SOURCE  # Ensure GNU extensions are available

ifeq ($(BUILD),debug)
    CFLAGS += -O0 -ggdb
else
    CFLAGS += -O3
endif

# Comprehensive DPDK library linking
DPDK_LIBS = -lrte_eal \
            -lrte_mempool \
            -lrte_ring \
            -lrte_timer \
            -lrte_mbuf \
            -lrte_net \
            -lrte_ethdev \
            -lrte_kvargs

# Linker flags
LDFLAGS += $(DPDK_LDFLAGS) $(DPDK_LIBS)
# Additional required libraries for DPDK
LDFLAGS += -pthread -lnuma -ldl -lrt  

.PHONY: all clean install

all: $(APP)

$(APP): $(OBJS)
	$(CC) $^ $(LDFLAGS) -o $@

%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@

install: $(APP)
	cp -f $(APP) $(DIR_ROOTFS)/$(APP)

clean:
	rm -f $(APP) *.o

