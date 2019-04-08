.POSIX:
.PHONY: clean run run-img

# 生成可启动main.img
main.img: main.elf
	cp '$<' iso/boot
	grub-mkrescue -o '$@' iso

# main.elf是要启动的文件
# 该文件由entry.o和main.o链接而成
main.elf: entry.o main.o
	ld -m elf_i386 -nostdlib -T linker.ld -o '$@' $^

# 生成entry.o文件
# 该文件主要用于初始化CPU寄存器和引导main.o
entry.o: entry.asm
	nasm -f elf32 '$<' -o '$@'

# 生成main.o
# 主程序体
main.o: main.c
	gcc -c -m32 -std=c99 -ffreestanding -fno-builtin -Os -o '$@' -Wall -Wextra '$<'

# 清除生成文件
clean:
	rm -f *.elf *.o iso/boot/*.elf *.img

# 运行main.elf文件
# 该文件为ELF格式文件，用kernel方式启动和运行
run: main.elf
	qemu-system-i386 -kernel '$<'

# 运行main.img
# 该文件为无格式的纯机器码文件，CPU可以直接执行，可以直接刻录到硬盘用于物理机执行
run-img: main.img
	qemu-system-i386 -hda '$<'
