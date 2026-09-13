# 05 Traffic Management & High Availability / 05 Gallery - Load Balancer와 Auto Scaling

Gallery의 배포 절차를 Init Script로 이관하고 Auto Scaling Group이 서버를 생성하도록 구조를 변경한다. 존마다 그룹을 하나씩 두어 하나의 Target Group에 등록하면 Load Balancer 하나가 두 존의 서버로 요청을 분산하며, 서버가 두 대가 되는 순간 상태가 서버마다 따로 있다는 사실이 화면에 드러난다.

## What you will learn

- 터미널에서 실행하던 명령을 부팅 스크립트로 이관할 때 달라지는 조건 — `set -e`가 없으면 일부만 구성된 서버가 정상으로 표시되고, `HOME`이 없으면 Maven이 `.m2` 위치를 결정하지 못한다
- 헬스 체크 보류 기간을 애플리케이션 기동 시간에 맞춰야 한다는 점 — 기본값 `300`으로는 부족하며, 짧게 지정하면 기동 중인 서버를 반납하고 교체가 반복된다
- Auto Scaling Group 둘이 하나의 Target Group을 공유하는 구성 — 존을 나누는 일과 대상을 모으는 일이 서로 다른 자원의 역할이다
- Load Balancer가 `80`으로 받아 서버의 `8080`으로 전달하는 구성 — 리스너 포트와 대상 포트를 다르게 지정한다
- 화면 하단 `Instance:` 표시로 요청 분산을 확인하는 방법 — NCP에서 hostname이 서버 이름이므로 Auto Scaling이 부여한 이름이 그대로 나타난다
- 서버가 두 대가 되면 업로드한 이미지가 새로 고침마다 나타났다 사라진다는 점 — 파일과 목록 데이터가 모두 서버 안에 있기 때문이며, 다음 두 챕터가 그 상태를 밖으로 옮긴다

## Examples

- Init Script로 배포 절차를 이관하고 Launch Configuration `v1`을 생성한다 — 버전을 이름에 포함하여 다음 챕터의 `v2`와 구분한다
- LoadBalancer 용도 Subnet, Target Group, Application Load Balancer를 구성하고 존별 Auto Scaling Group 둘을 같은 Target Group에 등록한다
- 서버가 한 대일 때와 두 대일 때 `Instance:` 표시와 이미지 목록이 어떻게 달라지는지 대조한다
- 그룹은 삭제하지 않고 용량만 `0`으로 내려 서버를 반납한다 — 다음 챕터가 Launch Configuration을 교체하여 이어받는다

## Reference

- Draft: `.claude/draft/05.05.claude.notion.md`
- Notion: [Notion 문서]()
