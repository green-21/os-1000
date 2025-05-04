#!/bin/bash
set -xue

# QEMU 실행 파일 경로
QEMU=qemu-system-riscv32

# QEMU 실행
$QEMU -machine virt -bios default -nographic -serial mon:stdio --no-reboot