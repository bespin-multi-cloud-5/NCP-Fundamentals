# 05 Traffic Management & High Availability / 03 Load Balancer 개요

Auto Scaling이 생성한 서버는 공인 IP가 없고 이름도 매번 달라진다. 외부에서 특정 서버를 지목할 방법이 없는 상태에서 그 대상을 대신 받는 자원이 Load Balancer다. 종류 셋과 Target Group, 상태 확인의 개념을 다룬다.

## What you will learn

- Load Balancer가 대상을 소유하지 않는다는 점 — 대상에서 제외해도 서버는 유지되고, 대수를 결정하는 것은 Auto Scaling이다
- 용도가 `LoadBalancer`인 전용 Subnet이 필요하다는 점과 `Internet Gateway 전용 여부`가 공인과 사설을 구분한다는 점
- 존을 생성 시점에 여럿 선택할 수 있고 이중화가 강제되지 않는다는 점 — AWS가 최소 두 AZ를 요구하는 것과 다르며, 생성한 뒤에는 추가만 가능하다
- 종류 셋의 구분 — Application(L7)과 Network(L4, DSR), Network Proxy(L4, proxy)의 응답 경로 차이
- Load Balancer가 서버를 직접 가리키지 않고 Target Group을 가리킨다는 점과 그에 따른 생성 순서
- Target Group의 대상이 존과 Subnet에 관계없이 등록된다는 점 — Auto Scaling Group이 존 하나에 묶이는 것과 다르며, 존을 나누는 일과 대상을 모으는 일이 서로 다른 자원의 역할이 된다
- 상태 확인이 Target Group에 붙는다는 점과 Auto Scaling의 헬스 체크와 판단 대상이 다르다는 점

## Reference

- Draft: `.claude/draft/05.03.claude.notion.md`
- Notion: [Notion 문서]()
