# 04 VPC & Networking / 06 Private Subnet 격리 - NAT Gateway

격리된 서버가 외부로 나갈 수 있도록 경로를 구성한다. 들어오는 방향은 열지 않으므로 아웃바운드를 개방해도 격리가 유지된다.

## What you will learn

- Bastion으로 진입 경로를 구성해도 유출 경로는 없다는 점 — 사설 Route Table에 `0.0.0.0/0`이 없으면 목적지가 VPC 밖인 트래픽은 보낼 대상이 정의되지 않는다
- 운영체제 패키지는 나가는 경로 없이도 받아진다는 점 — DNS, 패키지 미러, 시각 동기화가 `169.254.0.0/16` link-local 대역이라 Route Table을 통과하지 않으며, 차단되는 것은 저장소 clone과 빌드 의존성이다
- NAT Gateway가 나간 요청의 응답만 되돌리므로 인바운드가 성립하지 않는다는 점
- `용도`가 `NatGateway`이고 `Internet Gateway 전용 여부`가 `Y`인 전용 Subnet에만 생성할 수 있다는 점 — 두 값 모두 Subnet 생성 시점에 고정된다
- 생성만으로는 경로가 구성되지 않고 Route Table에 route를 등록해야 한다는 점
- NAT Gateway가 존에 종속되어 다른 존의 서버가 존을 넘어 나간다는 점
- AWS의 NAT instance 패턴이 NCP에는 없다는 점 — Target 유형이 다섯으로 고정되어 있다

## Examples

- `lab11` → Private 서버에서 `dnf`는 성공하고 `git clone`은 차단되는 것 확인, NAT 전용 Subnet과 NAT Gateway 생성, 사설 Route Table에 route 추가, 출발지 주소가 NAT Gateway의 공인 IP로 변환되는 것과 그 주소로는 들어올 수 없는 것 확인

## Reference

- Draft: `.claude/draft/04.06.claude.notion.md`
- Notion: [Notion 문서]()
