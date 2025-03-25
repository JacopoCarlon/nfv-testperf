#!/bin/bash

LXC_CONT_NAMES=(        \
    dpdk_c0             \
    dpdk_c1 
)

# Use NUMA node0 cores (even numbers for physical cores)
LXC_CONT_CPUS=(         \
    0,2                 \
    4,6 
)

# PCI addresses of the VFs
LXC_CONT_VFPCIS=(       \
    0000:04:02.0        \
    0000:04:02.1 
)

# DPDK uses PCI directly
LXC_CONT_VFS=(          \
    ""                  \
    "" 
)

# MAC/IP settings (ensure uniqueness)
LXC_CONT_MACS=(         \
    02:00:00:00:00:10   \
    02:00:00:00:00:11 
)

LXC_CONT_IPS=(          \
    172.31.100.10       \
    172.31.100.11 
)

LXC_CONT_NMASKS=(       \
    24                  \
    24 
)

# Use vfio-pci driver
LXC_CONT_VFDEVS=(       \
    vfio-pci            \
    vfio-pci 
)

LXC_CONT_VFPCIS=(       \
    04:02.0             \
    04:02.1             
)

LXC_CONT_SOCKS=(        \
    sock0               \
    sock1 
)