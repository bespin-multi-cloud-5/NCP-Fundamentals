# 05 Traffic Management & High Availability / 01 프로비저닝 - 같은 서버를 반복해 만든다

Gallery를 두 번 배포하면서 동일한 명령을 직접 두 번 입력했다. 서버 수량을 사용자가 지정하지 않으려면 그 절차가 사람 손을 떠나야 한다. 같은 서버를 반복해 생성하는 두 방식을 비교하고, 본 시리즈가 사용하는 Init Script로 서버 두 대를 준비된 상태로 생성한다.

## What you will learn

- 미리 굽는 방식(Server Image)과 부팅할 때 만드는 방식(Init Script)의 차이 — 기동 시간, 변경 방법, 내용 파악 방식이 갈린다
- 본 시리즈가 Init Script를 선택하는 이유 — 이후 챕터에서 변경되는 것이 애플리케이션 설정 몇 줄이라 스크립트만 수정하면 된다
- Init Script가 독립 자원이라는 점 — 미리 생성해 두고 서버 생성 화면에서 선택하며, 하나를 여러 서버가 공유한다
- 스크립트가 `root` 권한으로 최초 부팅 한 번만 실행되며 결과가 `/var/log/ncloud-init.log`에 명령 출력 그대로 기록된다는 점
- 서버가 사용하고 있어도 Init Script는 삭제된다는 점 — 인증키·ACG와 쓰이는 시점이 달라 취급이 다르다
- AWS User Data와 달리 cloud-init이 아니어서 `#cloud-config` 형식이 해석되지 않는다는 점

## Examples

- [`init-web.sh`](init-web.sh) — 웹 서버를 설치하고 서버 이름과 Zone을 첫 화면에 기록한다. link-local 대역만 사용하므로 나가는 경로가 없어도 동작한다
- 동일한 스크립트로 서버 두 대를 서로 다른 존에 생성하여, 판 표식은 같고 이름과 존만 다른 것을 확인
- 서버 둘과 ACG는 반납하고 Init Script는 유지 — 다음 섹션의 Auto Scaling이 이어받는다

## Reference

- Draft: `.claude/draft/05.01.claude.notion.md`
- Notion: [Notion 문서]()
