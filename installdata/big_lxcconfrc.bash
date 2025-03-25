#!/bin/bash

LXC_CONT_NAMES=(    \
    dpdk_c0         \
    dpdk_c1         \
    dpdk_c2         \
    dpdk_c3         \
    dpdk_c4         \
    dpdk_c5         \
    dpdk_c6         \
    dpdk_c7         \
    dpdk_three0     \
    dpdk_three1     \
)

# Use PHYSICAL CORES from NUMA node0 (even numbers, avoid hyperthreads)
LXC_CONT_CPUS=(         \
    0,2                 \
    4,6                 \
    8,10                \
    12,14               \
    16,18               \
    20,22               \
    24,26               \
    28,30               \
    0,2,4               \  # For three0 (3 cores)
    6,8,10              \  # For three1 (3 cores)
)

# Use your X710 VF interfaces (enp4s2* from `ip link`)
LXC_CONT_VFS=(          \
    enp4s2              \
    enp4s2f1            \
    enp4s2              \  # Adjust if more VFs exist
    enp4s2f1            \
    enp4s2              \
    enp4s2f1            \
    enp4s2              \
    enp4s2f1            \
    enp4s2              \
    enp4s2f1            \
)

# MACs (ensure uniqueness)
LXC_CONT_MACS=(         \
    02:00:00:00:00:10   \
    02:00:00:00:00:11   \
    02:00:00:00:00:12   \
    02:00:00:00:00:13   \
    02:00:00:00:00:14   \
    02:00:00:00:00:15   \
    02:00:00:00:00:16   \
    02:00:00:00:00:17   \
    02:00:00:00:00:18   \
    02:00:00:00:00:19   \
)

# IPs cplex3
LXC_CONT_IPS=(          \
    172.31.100.10       \
    172.31.100.11       \
    172.31.100.12       \
    172.31.100.13       \
    172.31.100.14       \
    172.31.100.15       \
    172.31.100.16       \
    172.31.100.17       \
    172.31.100.18       \
    172.31.100.19       \
)

LXC_CONT_NMASKS=(       \
    24                  \
    24                  \
    24                  \
    24                  \
    24                  \
    24                  \
    24                  \
    24                  \
    24                  \
    24                  \
)

# "uioX" for using igb_uio, need change "vfio-pci" if using VFIO ..?
LXC_CONT_VFDEVS=(       \
    uio0                \
    uio1                \
    uio2                \
    uio3                \
    uio4                \
    uio5                \
    uio6                \
    uio7                \
    uio8                \
    uio9                \
)

# Full PCI addresses of your X710 VFs (from lspci)
LXC_CONT_VFPCIS=(       \
    0000:04:02.0        \
    0000:04:02.1        \
    0000:04:02.0        \  
    0000:04:02.1        \
    0000:04:02.0        \
    0000:04:02.1        \
    0000:04:02.0        \
    0000:04:02.1        \
    0000:04:02.0        \
    0000:04:02.1        \
)

LXC_CONT_SOCKS=(        \
    sock0               \
    sock1               \
    sock2               \
    sock3               \
    sock4               \
    sock5               \
    sock6               \
    sock7               \
    sock8               \
    sock9               \
)