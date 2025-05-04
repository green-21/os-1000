typedef unsigned char uint8_t;
typedef unsigned int uint32_t;
typedef uint32_t size_t;

extern char __bss[], __bss_end[], __stack_top[];

void *memset(void *buf, char c, size_t n) {
    uint8_t *p = (uint8_t*) buf;
    while(n--) {
        *p++ = c;
    }
    return buf;
}

void kernel_main(void) {
    memset(__bss, 0, (size_t) __bss_end - (size_t) __bss);

    for(;;);
}

__attribute__((section(".text.boot")))      // 함수를 .text.boot라는 섹션에 배치
__attribute__((naked))                      // 컴파일러가 자동으로 생성하는 코드들 생략
void boot(void) {
    __asm__ __volatile__ (
        "mv sp, %[stack_top]\n"             // stack_top이라는 키워드의 값을 sp에 대입
        "j kernel_main\n"                   // kernel_main이라는 함수로 pc jump
        :                                   // output
        : [stack_top] "r" (__stack_top)     // stack_top이라는 키워드와 __stack_top을 어떤 'R'egister에서 담아서 사용용
    );
}