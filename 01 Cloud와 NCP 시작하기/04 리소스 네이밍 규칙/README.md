# 01 Cloud와 NCP 시작하기 / 04 리소스 네이밍 규칙

NCP에는 리소스를 묶는 상위 단위가 없어 소속을 나타낼 수 있는 곳이 이름뿐이다. 다음 챕터부터 생성하는 모든 리소스가 따를 이름 규칙을 여기서 정한다.

## What you will learn

- 이름의 역할 — 상위 단위가 없는 환경에서 어느 실습의 자원인지, 반납 대상인지를 이름이 담당한다
- 패턴 `{org}-{project}-{capability}-{identity}` — 각 세그먼트가 나타내는 것, `identity`의 조합과 생략, Subnet의 30자 제한이 요구하는 축약
- `project` 토큰의 수명 구분 — `lab{NN}`은 실습과 함께 종료되고, `lab`은 실습을 넘어 유지되며, `gal`은 Gallery 자원이다
- 계정 밖에서 고유해야 하는 값과 `{uniq}` 표기 — 고유 범위는 자원마다 다르다
- AWS와의 약어 대응 — 네트워크 영역은 이름까지 같고, 컴퓨트·스토리지는 서비스 이름이 달라 약어도 갈린다

## Reference

- Draft: `.claude/draft/01.04.claude.notion.md`
- Notion: [Notion 문서]()
