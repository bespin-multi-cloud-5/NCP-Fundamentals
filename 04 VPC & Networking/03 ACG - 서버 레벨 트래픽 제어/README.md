# 04 VPC & Networking / 03 ACG - 서버 레벨 트래픽 제어

서버마다 다르게 적용되는 트래픽 통제를 다룬다. ACG는 Network Interface에 적용되고 허용 규칙만 갖는 구조이므로, 규칙이 없으면 어떤 트래픽도 통과하지 않는다.

## What you will learn

- ACG의 적용 단위가 서버가 아니라 Network Interface라는 점 — 서버 생성 화면의 `디바이스: eth0`이 그 단위이고, 같은 Subnet의 서버끼리도 열린 포트가 다를 수 있다
- 허용 규칙만 존재하고 우선순위가 없다는 점 — 규칙 사이에 충돌이 발생하지 않으므로 등록 순서를 고려하지 않는다
- 직접 생성한 ACG에는 규칙이 없지만 default ACG에는 22와 3389가 `0.0.0.0/0`으로 이미 개방되어 있다는 점
- Stateful이므로 응답은 규칙 없이 나가지만, 서버가 먼저 보내는 요청에는 Outbound 규칙이 필요하다는 점
- 접근 소스에 IP 대역 대신 다른 ACG를 지정할 수 있다는 점 — 서버를 교체해도 규칙을 수정하지 않으며 Bastion 경유 접속이 이 방식으로 구성된다
- 허용되지 않은 트래픽이 거부가 아니라 폐기된다는 점 — 외부에서는 서버가 존재하지 않는 상태와 구분되지 않는다

## Examples

- `lab08` → 규칙 없는 ACG 생성, 서버에 적용하여 접속 실패 확인, 22번 포트 개방, Outbound 규칙 추가, ICMP 개방, 서버와 ACG 반납

## Reference

- Draft: `.claude/draft/04.03.claude.notion.md`
- Notion: [Notion 문서]()
