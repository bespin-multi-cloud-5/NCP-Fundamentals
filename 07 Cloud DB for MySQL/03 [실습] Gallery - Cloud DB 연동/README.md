# 07 Cloud DB for MySQL / 03 [실습] Gallery: Cloud DB 연동

Gallery의 이미지 목록을 각 서버의 인메모리 데이터베이스에서 관리형 데이터베이스로 옮긴다. 파일은 앞 챕터에서 Object Storage로 나갔고 목록이 본 실습에서 나가므로, 서버에는 애플리케이션만 남는다.

## What you will learn

- 데이터베이스와 계정을 만드는 절차가 「Cloud DB for MySQL 생성과 연결」과 같다는 점 — 콘솔 `Database 관리`로 `gallery`를 추가하고 SQL로 그 데이터베이스에만 권한을 갖는 계정을 만든다
- 자동 생성 ACG의 인바운드에 Auto Scaling Group의 ACG를 소스로 지정한다는 점 — 그룹이 만드는 서버는 모두 그 ACG를 가지므로 서버가 늘거나 교체되어도 규칙을 다시 손대지 않는다
- 계정의 접근 허용 주소를 `10.0.%`로 둔다는 점 — Auto Scaling Group이 만드는 서버는 사설 IP가 매번 달라져 개별 주소를 지정할 수 없다
- JDBC URL의 스킴이 `jdbc:mariadb`라는 점 — 애플리케이션에 포함된 드라이버가 MariaDB Connector/J 하나이고 Spring Boot가 스킴으로 드라이버를 판별한다
- 접속 정보가 Init Script에 그대로 들어간다는 점 — 콘솔에서 조회되므로 운영 환경이라면 별도의 비밀 관리 수단이 필요하다
- 두 서버가 같은 데이터베이스를 바라보면 어느 쪽이 응답하든 같은 목록이 반환된다는 점 — 앞 실습에서 새로 고칠 때마다 목록이 달라지던 문제가 해소된다
- 서버를 전부 반납했다가 다시 만들어도 데이터가 남는다는 점 — 파일과 목록이 모두 서버 밖에 있어 서버 수명이 데이터에 영향을 주지 않는다

## Examples

- 예약해 둔 `10.0.103.0/24`에 데이터베이스 전용 Subnet을 만들고 `Stand Alone`으로 DB Server를 생성한다
- 임시 서버를 만들어 콘솔로 추가한 `gallery` 데이터베이스에 `GRANT ALL PRIVILEGES`를 갖는 `gallery` 계정을 SQL로 만들고, 작업을 마치면 임시 서버를 반납한다
- Init Script에 datasource 파라미터 셋을 더해 `v3`으로 만들고 Launch Configuration을 교체한 뒤 서버를 반납하여 교체한다
- 기대 용량을 `0`으로 내려 서버를 전부 없앴다가 다시 올리고, 반납 이전에 업로드한 이미지가 그대로 있는 것을 확인한다

## Reference

- Draft: `.claude/draft/07.03.claude.notion.md`
- Notion: [Notion 문서]()
