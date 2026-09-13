# 04 VPC & Networking / 01 VPC와 Subnet - CIDR & Route Table

이후 챕터들이 공유할 네트워크를 설계하여 구성한다. VPC의 주소 범위는 생성 이후 변경할 수 없으므로, 앞으로 필요해질 Subnet까지 계산하여 대역을 분할한다.

## What you will learn

- VPC와 Subnet의 종속 범위 — VPC는 리전에 속하고 Subnet은 Zone에 종속되므로, Zone을 분리하는 작업은 Subnet을 분리하는 작업이 된다
- CIDR 설계 제약 — 사설 대역이 강제되고 생성 이후 변경할 수 없으며, 가용 IP는 표기된 수보다 일곱 개 적다
- `Internet Gateway 전용 여부`가 Public과 Private을 구분하고 Route Table 연관까지 결정한다는 점 — Route Table에도 공인과 사설 유형이 있어 서로 일치해야 연관된다
- Subnet의 `용도` — 전용 유형을 요구하는 자원은 Load Balancer와 NAT Gateway 둘이며, `용도`와 `Internet Gateway 전용 여부`는 생성 시점에만 지정된다
- VPC 생성 시 함께 생성되는 자원 — Network ACL 하나와 Route Table 둘이 VPC 화면에서 조회되고 default ACG는 `Server > ACG` 메뉴에 있으며, 두 default Route Table의 차이는 `0.0.0.0/0 · IGW` 한 줄이다

## Examples

- `lab06` → VPC 생성, 두 Zone에 Public 2 + Private 2 Subnet 배치, 함께 생성된 자원 확인, 관리·NAT 대역 예약

## Reference

- Draft: `.claude/draft/04.01.claude.notion.md`
- Notion: [Notion 문서]()
