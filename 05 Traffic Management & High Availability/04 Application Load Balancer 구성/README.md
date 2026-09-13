# 05 Traffic Management & High Availability / 04 Application Load Balancer 구성

앞 섹션에서 개념으로 다룬 Load Balancer를 실제로 생성한다. 전용 Subnet을 먼저 생성하고 Target Group을 대상 없이 구성한 뒤, 존마다 Auto Scaling Group을 하나씩 두어 두 존의 서버가 하나의 주소로 응답하게 한다.

## What you will learn

- Target Group의 프로토콜과 포트가 대상이 받는 쪽이고 리스너의 것이 외부에서 받는 쪽이라는 점 — 둘을 다르게 지정하면 `80`으로 받아 `8080`으로 전달하는 구성이 된다
- 분산 알고리즘이 요청을 나누는 기준을 결정한다는 점 — `Source Ip Hash`는 출발지 IP로 판별하므로 같은 회선의 클라이언트가 한 대상으로 집중된다
- 상태 확인의 주기와 임계값이 함께 반응 속도를 결정한다는 점 — 기본값에서는 서버가 중단된 뒤 대상에서 제외되기까지 60초가 소요된다
- `Public` Load Balancer에는 용도가 `LoadBalancer`이고 `Internet Gateway 전용 여부`가 `Y`인 Subnet이 미리 존재해야 한다는 점
- 존을 함께 선택할 수 있으나 강제되지 않는다는 점 — 한 존에 배치된 Load Balancer가 두 존의 서버로 요청을 전달한다
- 리스너와 Target Group 사이에 규칙이 있다는 점 — 생성 시 `DEFAULT` 규칙 하나가 함께 만들어지고, 규칙을 추가하면 경로나 호스트로 분기하거나 가중치로 분배할 수 있다
- 부하 처리 성능이 Load Balancer 자신의 연결 수이고 대상 서버의 수량이나 사양과 무관하다는 점
- Auto Scaling Group 둘이 같은 Target Group을 선택할 수 있다는 점 — 존을 나누는 일과 대상을 모으는 일이 서로 다른 자원의 역할이다
- 대상은 비워 두고 생성하며 등록하는 주체가 Auto Scaling이라는 점 — 연결은 그룹을 생성할 때만 가능하다

## Examples

- `lab14` → LoadBalancer 용도 Subnet, Target Group, Application Load Balancer를 생성하고 존마다 Auto Scaling Group을 두어 새로 고칠 때마다 다른 서버가 응답하는 것을 확인한다. Load Balancer는 KR-1 한 존에만 배치한다
- 앞 실습의 `ncp-fund-lab-acg-asg`에 Load Balancer Subnet 대역을 인바운드로 추가한다 — 누락하면 상태 확인이 전부 실패한다
- Load Balancer를 삭제해도 서버가 유지되는 것과, Auto Scaling Group이 참조하는 동안 Target Group이 삭제되지 않는 것을 자원 정리에서 확인한다

## Reference

- Draft: `.claude/draft/05.04.claude.notion.md`
- Notion: [Notion 문서]()
