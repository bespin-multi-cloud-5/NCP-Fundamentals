# 04 VPC & Networking / 08 Gallery - Custom VPC 이전

공인 IP로 노출되어 있던 Gallery를 본 챕터가 구성한 구조로 이전한다. 전용 VPC를 처음부터 조립하고 Gallery를 Private Subnet에 배포하면, 애플리케이션은 그대로 동작하는데 인터넷에서 접속할 수 없는 상태가 된다.

## What you will learn

- 서버는 Subnet을 변경할 수 없으므로 배치를 옮긴다는 것이 새로 생성한다는 의미라는 점 — 애플리케이션은 같은 저장소에서 같은 명령으로 빌드한다
- Gallery가 전용 VPC를 사용하는 이유 — 자원 정리가 갈리고, VPC가 다르면 `LOCAL` 경로로 통신하지 않아 Bastion을 공유할 수 없다
- 격리된 VPC끼리는 주소가 겹쳐도 무방하다는 점과, 겹치면 안 되는 경우가 VPC를 연결할 때라는 점
- 자원이 필요해지는 시점에 그 자원이 요구하는 유형으로 Subnet을 생성한다는 점 — 사용할 곳이 없는 대역은 예약 상태로 둔다
- 서버가 먼저 보내는 요청에 Outbound 규칙이 필요하다는 사실을 빌드 과정에서 다시 확인한다는 점
- 애플리케이션은 동작하는데 외부에서 접속할 수 없는 상태 — 다음 챕터의 출발점이 된다

## Examples

- VPC · Subnet 넷 · Route Table 둘 · Bastion · NAT Gateway를 처음부터 조립
- Gallery를 Private Subnet에 배포하고 서버 내부에서 `/actuator/health` 확인
- Gallery 서버와 `ncp-fund-gal-acg-web`을 반납하고 네트워크 · Bastion · `ncp-fund-gal-acg-bas`는 다음 챕터로 인계

## Reference

- Draft: `.claude/draft/04.08.claude.notion.md`
- Notion: [Notion 문서]()
