# 04 VPC & Networking / 05 Private Subnet 격리 - Bastion 서버

외부에서 접근할 수 없는 Private Subnet을 구성하고, 그 안의 서버를 운영하는 경로를 만든다. 격리는 차단 정책이 아니라 경로의 부재로 성립한다.

## What you will learn

- Private Subnet의 격리 근거 — Private Route Table에 `0.0.0.0/0` 경로가 없다
- ACG를 전면 개방해도 접근이 불가능한 이유 — 인터넷에서 가리킬 공인 IP가 없다
- NCP에 관리형 Bastion 서비스가 없어 Public Subnet의 일반 서버로 구성한다는 점 — `[서버 접속 콘솔]`은 세션 제약이 있는 비상 복구 도구다
- ACG를 접근 소스로 지정하는 방식 — Bastion을 교체해도 규칙이 유지된다
- ProxyJump가 Bastion을 TCP 중계 통로로만 사용해 목적지 비밀번호가 Bastion을 거치지 않는다는 점

## Examples

- `lab10` → 사설 Route Table 생성과 연관, 공인 IP 없는 서버의 접근 불가 확인, Bastion 전용 Subnet과 Bastion 생성, ACG 소스 지정, ProxyJump 접속
- [`ssh-pj.sh`](ssh-pj.sh) · [`ssh-pja.sh`](ssh-pja.sh) · [`ssh-pja.ps1`](ssh-pja.ps1) — Bastion 경유 접속 스크립트

## Reference

- Draft: `.claude/draft/04.05.claude.notion.md`
- Notion: [Notion 문서]()
