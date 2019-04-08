#include "stdint.h"

// 定义取色板
enum color {
    BLACK = 0,
	BLUE = 1,
	GREEN = 2,	
	RED = 4,
    BRIGHT = 7
};

// 所能显示的字符空间
enum size {
    COLS = 80,
    ROWS = 25
};

// 显存地址
uint16_t *const video = (uint16_t*) 0xB8000;

// 显示一个字符
void putc(uint8_t x, uint8_t y, enum color fg, enum color bg, char c) {
    video[y * COLS + x] = (bg << 12) | (fg << 8) | c;
}

// 显示字符串
void puts(uint8_t x, uint8_t y, enum color fg, enum color bg, const char *s) {
    for (; *s; s++, x++)
        putc(x, y, fg, bg, *s);
}

// 清屏
void clear(enum color bg) {
    uint8_t x, y;
    for (y = 0; y < ROWS; y++)
        for (x = 0; x < COLS; x++)
            putc(x, y, bg, bg, ' ');
}

// 主函数
int __attribute__((noreturn)) main() {
    clear(BLACK);
    puts(0, 0, GREEN, BLACK, "hello world");
    while (1);
}
