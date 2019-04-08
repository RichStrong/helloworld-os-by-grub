; 全局标号，供其它地方使用
global loader
global stack_ptr

; 引用其它文件中的符号
extern main

; 定义常量
MODULEALIGN equ 1<<0				; 模块对齐大小
MEMINFO equ 1<<1					; 内存信息
FLAGS equ MODULEALIGN | MEMINFO		; 标志位
MAGIC equ 0x1BADB002				; 幻数
CHECKSUM equ -(MAGIC + FLAGS)		; 校验和

STACKSIZE equ 0x4000				; 定义堆栈大小

; 定义grub的头部信息，4字节对齐
section .mbheader
align 4
MultiBootHeader:
  dd MAGIC							; 幻数
  dd FLAGS							; 标志位
  dd CHECKSUM						; 头部校验和

; text段
section .text
loader:
  mov esp, stack+STACKSIZE			; 设置堆栈
  push eax
  push ebx

  call main							; 执行main函数

  cli								; 禁止中断

hang:
  hlt								; 休眠CPU
  jmp hang

; bss段
section .bss
align 4
stack:
  resb STACKSIZE
stack_ptr:
