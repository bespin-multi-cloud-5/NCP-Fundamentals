# 04 VPC & Networking / 02 Public Subnet & Internet Gateway

인터넷으로 나가는 경로를 구성한다. NCP에는 Internet Gateway라는 생성 대상 자원이 없으며, Route Table의 유형을 지정하는 작업이 곧 그 경로를 결정하는 작업이다.

## What you will learn

- Internet Gateway가 자원이 아니라 Route Table의 Target으로만 나타난다는 점 — 생성하지도 이름을 지정하지도 않으므로 네이밍 규칙에 약어가 없다
- Route Table의 `공인`·`사설` 유형이 기본 route를 결정한다는 점 — 공인 유형은 `0.0.0.0/0 · IGW`를 생성 시점에 이미 포함한다
- 유형이 일치하는 Subnet만 연관된다는 점과, Subnet 하나에는 Route Table 하나만 연관되어 새로 연관시키면 이전 연관이 해제된다는 점
- Public Subnet에 배치되었다는 사실만으로 인터넷과 통신하지 않는다는 점 — 공인 Route Table 연관, 공인 IP 할당, ACG 허용 세 요소가 모두 필요하며, 이 셋을 제거한 구성이 Private Subnet 격리가 된다

## Examples

- `lab07` → 공인 Route Table 생성, Public Subnet 둘에 연관, 서버 배치 후 인터넷 통신 확인, 서버 반납과 Route Table 유지

## Reference

- Draft: `.claude/draft/04.02.claude.notion.md`
- Notion: [Notion 문서]()
