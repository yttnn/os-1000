#!/bin/bash

set -xue

# file path of qemu
QEMU=$HOME/tools/qemu-riscv32-8.1.2/bin/qemu-system-riscv32

# launch qemu
$QEMU -machine virt -bios opensbi-riscv32-generic-fw_dynamic.bin -nographic -serial mon:stdio --no-reboot
# $QEMU -machine virt -bios default -nographic -serial mon:stdio --no-reboot
