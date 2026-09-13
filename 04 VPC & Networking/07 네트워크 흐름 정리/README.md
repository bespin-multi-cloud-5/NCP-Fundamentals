# 04 VPC & Networking / 07 네트워크 흐름 정리

본 챕터에서 하나씩 생성한 자원들이 함께 이루는 구조를 정리한다. 경로 넷과 통제 두 층이 한 그림에서 만나고, 통신이 차단됐을 때 어디부터 확인하는지를 순서로 남긴다.

## What you will learn

- Subnet 여섯과 Route Table 둘이 나누어 참조되는 구조 — Public 넷은 공인 Route Table에, Private 둘은 사설 Route Table에 연관되고 default 둘은 연관 Subnet이 없는 상태로 남는다
- 경로 넷 — Public 서버로, Bastion을 경유하여 Private 서버로, NAT Gateway를 경유하여 외부로, 그리고 VPC 내부에서 `LOCAL`로
- 진입 경로와 유출 경로가 서로 다른 자원을 통과한다는 점 — Bastion을 삭제해도 나가는 경로는 유지되고 그 반대도 같다
- 통제 두 층의 통과 순서 — 들어올 때는 Network ACL이 먼저이고 나갈 때는 ACG가 먼저이며, 두 층 모두 허용해야 통과한다
- 차단 지점을 찾는 순서 — 경로 → 주소 → Network ACL → ACG → 운영체제이고, 앞의 둘은 구조이며 뒤의 둘은 규칙이다
- 격리가 경로와 주소의 부재이며 규칙으로 차단하는 것보다 강하다는 점 — 규칙은 실수로 개방될 수 있으나 경로와 주소는 실수로 생성되지 않는다
- NCP는 생성 시점에 속성으로 고정하고 AWS는 자원 사이의 관계로 결정한다는 차이 — 설계를 앞당기는 대신 잘못 조합할 여지가 줄어든다

## Examples

- 실습 없음. 본 챕터의 실습 결과를 다이어그램과 표로 정리한다

## Reference

- Draft: `.claude/draft/04.07.claude.notion.md`
- Notion: [Notion 문서]()
