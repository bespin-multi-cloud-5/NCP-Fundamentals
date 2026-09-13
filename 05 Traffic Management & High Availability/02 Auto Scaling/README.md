# 05 Traffic Management & High Availability / 02 Auto Scaling

앞 섹션에서 서버 생성 절차를 자동화했으나 수량은 사용자가 직접 지정했다. Auto Scaling은 부하에 따라 수량까지 조절하는 구성이다. 자원 넷의 역할을 나누어 정리하고 CPU 부하로 증감을 확인한다.

## What you will learn

- Auto Scaling을 구성하는 자원 넷 — Launch Configuration, Auto Scaling Group, 정책, Cloud Insight Event Rule
- Launch Configuration이 네트워크 설정을 포함하지 않는다는 점 — Subnet과 ACG는 Auto Scaling Group이 지정하고 공인 IP 옵션은 제공되지 않는다
- Auto Scaling Group이 단일 Subnet만 수용한다는 점 — 멀티 존 구성에는 존별 그룹이 필요하다
- Launch Configuration이 앞으로 생성될 서버의 명세라는 점 — 변경해도 기존 서버는 유지되고 반납해야 교체된다
- 정책과 실행 조건의 분리 — 조건은 Cloud Insight Event Rule이 갖는다

## Examples

- `lab13` → Launch Configuration과 Auto Scaling Group 생성, 명세 교체를 통한 서버 재배포, 정책과 Cloud Insight Event Rule 구성, CPU 부하로 증감 확인
- [`init-web-v3.sh`](init-web-v3.sh) — 웹 서버 기동과 부하 도구 배치를 수행하는 Init Script
- [`cpuload.sh`](cpuload.sh) — `sha1sum`을 코어 수만큼 실행해 CPU 사용률을 채우는 부하 스크립트

## Reference

- Draft: `.claude/draft/05.02.claude.notion.md`
- Notion: [Notion 문서]()
