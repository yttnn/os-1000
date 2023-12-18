KERNEL_SRCS = kernel.c common.c
KERNEL_OBJS = $(KERNEL_SRCS:%.c=%.o) shell.bin.o

SHELL_SRCS = shell.c user.c common.c
SHELL_OBJS = $(SHELL_SRCS:%.c=%.o)

CC = clang
LINKER = ld.lld
OBJCOPY = llvm-objcopy

CFLAGS = -c -std=c11 -O2 -g3 -Wall -Wextra --target=riscv32 \
			   -ffreestanding -nostdlib -mno-relax
LDFLAGS = -m elf32lriscv -L/lib

.PHONY: shell
shell: $(SHELL_SRCS) user.ld
		$(CC) $(CFLAGS) $(SHELL_SRCS)
		$(LINKER) $(LDFLAGS) -Tuser.ld -Map=shell.map $(SHELL_OBJS) -o shell.elf
		$(OBJCOPY) --set-section-flags .bss=alloc,contents -O binary shell.elf shell.bin
		$(OBJCOPY) -Ibinary -Oelf32-littleriscv shell.bin shell.bin.o

.PHONY: kernel
kernel: $(KERNEL_SRCS) kernel.ld shell
			$(CC) $(CFLAGS) $(KERNEL_SRCS)
			$(LINKER) $(LDFLAGS) -Tkernel.ld -Map=kernel.map $(KERNEL_OBJS) -o kernel.elf


.PHONY: clean
clean:
			rm *.elf *.map *.o