#!/bin/bash

set -xue

# file path of qemu
QEMU=$HOME/tools/qemu-riscv32-8.1.2/bin/qemu-system-riscv32
# path of clang
CLANG=clang
CFLAGS="-std=c11 -O2 -g3 -Wall -Wextra --target=riscv32 -ffreestanding -nostdlib -v"

# build kernel
$CLANG $CFLAGS -Wl,-Tkernel.ld -Wl,-Map=kernel.map -o kernel.elf \
    kernel.c

# launch qemu
# $QEMU -machine virt -bios opensbi-riscv32-generic-fw_dynamic.bin -nographic -serial mon:stdio --no-reboot \
#     -kernel kernel.elf
