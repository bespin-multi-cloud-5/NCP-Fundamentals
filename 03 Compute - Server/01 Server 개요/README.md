# 03 Compute - Server / 01 Server 개요

첫 자원인 Server가 무엇으로 구성되고 어떤 선택지가 있는지 정리한다. 서버 하나를 생성할 때 함께 만들어지는 자원, 타입과 세대 체계, 그리고 이미지와 Init Script의 관계를 다룬다.

## What you will learn

- 서버를 구성하는 자원과 그 사이의 관계 — 의존, 생성, 참조 세 갈래로 나뉘며 ACG는 서버가 아니라 Network Interface 단위로 적용된다
- 타입 체계 — 용도로 나뉘고 타입마다 vCPU 대비 메모리 비율이 고정된다. Micro는 무료 제공을 위한 별도 타입이며 제약이 따로 있다
- 세대와 하이퍼바이저 — 세대가 다르면 하이퍼바이저가 다르고, 스토리지와 이미지가 그 경계를 넘지 못한다
- 스펙 코드 읽는 법과 서버의 상태, 그리고 정지와 반납의 차이. 정지에는 기간 제한이 있다
- 서버 이미지와 Init Script의 관계 — 필요한 상태를 미리 구성하는가 시작할 때 구성하는가의 차이

## Reference

- Draft: `.claude/draft/03.01.claude.notion.md`
- Notion: [Notion 문서]()
