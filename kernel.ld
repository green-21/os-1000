ENTRY(boot)

SECTIONS {
    /* 0x800000000 : DRAM 시작 주소  */
    /* 0x800200000 : 2MB안에는 부트로더, 임시 스택&초기 데이터, align목적의 빈 공간, 등이 있을 수 있음.  */
    . = 0x80200000;
    __kernel_base = .;

    /* .text: 프로그래밍 코드 영역*/
    .text :{
        KEEP(*(.text.boot));        /* .text.boot라는 파일을 가장 앞에 둔다. */
        *(.text .text.*);
    }

    /* .rodata: 읽기 전용 상수*/
    .rodata : ALIGN(4) {
        *(.rodata .rodata.*);
    }

    /* .data: 읽기 및 쓰기가 가능한 데이터가 저장되는 영역*/
    .data : ALIGN(4) {
        *(.data .data.*);
    }

    /* .bss: 초기값이 0인 읽기/쓰기가 가능한 데이터가 저장되는 영역*/
    .bss : ALIGN(4) {
        __bss = .;
        *(.bss .bss.* .sbss .sbss.*);
        __bss_end = .;
    }

    /* 커널 스택을 128kb 만큼 배치 */
    . = ALIGN(4);
    . += 128 * 1024;     /* 128kb */
    __stack_top = .;

    /* heap 영역 배치 (64mb 짜리에 한번에 4kb씩 움직이는...)*/
    . = ALIGN(4096);
    __free_ram = .;
    . += 64 * 1024 * 1024; /* 64mb */
    __free_ram_end = .;
}