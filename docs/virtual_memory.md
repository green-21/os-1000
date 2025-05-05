# Supervisor Virtual 32 (SV32) 포맷

RISC-V의 Privileged Architecture에서 정의된 Virtual Memory System.  
32비트의 가상 주소를 34비트 물리 주소로 매핑. 
  
  
## 1. 가상 메모리 주소의 구조

- 총 32비트를 사용
- 최초 10비트는 1 단계 페이지 테이블의 인덱스로 사용 (VPN1)
- 그 다음 10 비트는 2 단계 페이지 테이블의 인텍스로 사용 (VPN2)
- 나머지 12비트는 실제 물리 주소의 하위 주소로, 4kb 내에서의 위치를 표현 (Offset)
  
0x [ VPN1 (10bit) ] - [ VPN0 (10bit) ] - [ Offset (12bit) ]
  
  
## 2. 페이지 테이블

2개의 페이지 테이블 구조로 되어 있음. 각 페이지 테이블은 테이블 당 4kb만큼의 주소를 할당 받으며, Page Table Entry(PTE)라는 4byte의 페이지에 대한 메타 데이터를 저장함.
  
  
### Page Table Entry

- 페이지의 실제 물리적 위치 주소나 Valid나 RWX 같은 페이지의 메타데이터를 표현
- 4byte 크기로 되어 있음.

| name | bit | 역할 |
| ---- | --- | --- |
| V | 0 | Valid |
| R | 1 | Readable |
| W | 2 | Writable |
| X | 3 | eXecutable |
| D | 4 | Dirty (수졍 여부?) |
| A | 5 | Accessd |
| U | 6 | User 모드 접근 여부 |
| G | 7 | Global |
| Reserved | 8 ~ 9 | 예약 (항상 0) |
| PPN | 10 ~ 31 | 22bit의 물리 페이지 주소 |


- 1 단계 페이지 테이블의 PTE
  - 2 단계 페이지 테이블의 주소를 PPN으로 가짐.
  - Valid 외의 모든 플래그는 의미가 없음 (보통 0으로 설정 됨.)
- 2 단계 페이지 테이블의 PTE
  - 실제 페이지가 위치한 물리 메모리의 주소를 PPN으로 가짐.


## 3. sapt 레지스터

Supervisor Address Translation and Protection 레지스터.  
Memory Management Unit (MMU)를 제어하는 레지스터로 RISC-V의 CSRs (Control and Status Registers) 중 하나.

CPU가 메모리를 접근 할 때, 가상 주소를 물리 주소로 변환할지 말지, 어디서 페이지테이블을 시작할 지와 관련된 정보를 담고 있음.

- 
| name | bit | 역할 |
| ---- | ------- | -----------------------------               |
| PPN  | 0 ~ 21  | 1단계 페이지 테이블의 물리 주소               |
| ASID | 22 ~ 30 | 프로세스 구분을 위한 ID                       |
| MODE | 31      | 1이면 SV32(가상 메모리)가 활성화 되었음을 알림 |

0x [ PPN ] [ ASID ] [ MODE ]

satp==0x80080255 이면,
테이블의 위치는 (0x80080255 & 0x3fffff) << 12로 구할 수 있음.

