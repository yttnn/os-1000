SRCS = kernel.c common.c
OBJS = $(SRCS:%.c=%.o)

CC = clang
LINKER = ld.lld

CFLAGS = -c -std=c11 -O2 -g3 -Wall -Wextra --target=riscv32 \
			   -ffreestanding -nostdlib -mno-relax
LDFLAGS = -m elf32lriscv -L/lib -Tkernel.ld -Map=kernel.map

.PHONY: kernel
kernel: 

.PHONY: clean
clean:
			rm *.elf *.map *.o