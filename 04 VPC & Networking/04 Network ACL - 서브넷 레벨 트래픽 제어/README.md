# 04 VPC & Networking / 04 Network ACL - 서브넷 레벨 트래픽 제어

Subnet 경계에서 적용되는 통제를 다룬다. ACG와 정반대로 규칙이 없으면 모든 트래픽이 통과하고, Stateless이므로 응답도 규칙을 통과한다.

## What you will learn

- Network ACL이 Subnet에 적용되어 그 안의 모든 서버에 동일하게 작용한다는 점 — 서버 하나만 예외로 둘 수 없으므로 예외가 필요하면 Subnet을 분리하거나 ACG로 처리한다
- 규칙이 없으면 전부 통과한다는 점 — 같은 「규칙 없음」이 ACG에서는 전부 차단이고 Network ACL에서는 전부 통과다
- 허용과 차단을 모두 등록하고 우선순위 `0~199`로 판정한다는 점 — 처음 일치하는 규칙에서 평가가 종료된다
- Stateless이므로 응답도 Outbound 규칙을 통과한다는 점 — 차단을 시작하는 순간 ephemeral port가 나타나고, 차단한 대상과 중단된 통신이 달라 보여 원인을 찾기 어렵다
- 트래픽이 Network ACL을 먼저 통과하고 ACG를 통과한다는 점 — ACG에서 허용한 트래픽이 Subnet 경계에서 차단될 수 있다
- 이후 실습이 default Network ACL을 그대로 두고 ACG로 통제한다는 점 — 세 자원의 default 처리 방침이 이 섹션에서 정해진다

## Examples

- `lab09` → Network ACL 생성 후 Subnet에 연결, ICMP 차단으로 ACG가 허용한 트래픽이 차단되는 것 확인, 접속 중 Outbound 차단으로 세션이 중단되는 것 확인, Network ACL 연결 해제와 삭제

## Reference

- Draft: `.claude/draft/04.04.claude.notion.md`
- Notion: [Notion 문서]()
