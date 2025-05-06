# OS in 1000 Lines
[1,000줄 짜리 OS를 만들어보자](https://operating-system-in-1000-lines.vercel.app/ko/)
를 실습하고 작성한 코드 및 이해가 잘 안 되었던 내용을 정리하는 Repo

- 실습 환경: Windows11 WSL Ubuntu LTS

### 환경 구성
1. 필요한 패키지 설치
```
sudo apt update && sudo apt install -y clang llvm lld qemu-system-riscv32 curl
```

2. git clone 및 `QEMU` 로드 파일 다운로드
```
curl -LO https://github.com/qemu/qemu/raw/v8.0.4/pc-bios/opensbi-riscv32-generic-fw_dynamic.bin
```


```
./run.sh
```
