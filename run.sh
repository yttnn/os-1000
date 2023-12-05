#!/bin/bash

set -xue

# file path of qemu
QEMU=$HOME/tools/qemu-riscv32-8.1.2/bin/qemu-system-riscv32
# path of clang
CLANG=clang
CFLAGS="-c -std=c11 -O2 -g3 -Wall -Wextra --target=riscv32 -ffreestanding -nostdlib -mno-relax"
# linker
LINKER=ld.lld
LDFLAGS="-m elf32lriscv -L/lib -Tkernel.ld -Map=kernel.map"
# build kernel
$CLANG $CFLAGS -o kernel.o kernel.c
$LINKER $LDFLAGS kernel.o -o kernel.elf

# launch qemu
$QEMU -machine virt -bios opensbi-riscv32-generic-fw_dynamic.bin -nographic -serial mon:stdio --no-reboot \
    -kernel kernel.elf
