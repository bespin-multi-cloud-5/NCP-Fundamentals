# 03 Compute - Server / 04 Gallery - Server 기본 배포

Gallery 애플리케이션을 공인 IP가 할당된 서버 한 대에 배포한다. 업로드한 이미지와 데이터베이스 데이터가 그 서버 안에 누적되는 상태를 구성하고, 이후 챕터들이 그 상태를 서버 밖으로 이전한다.

## What you will learn

- 애플리케이션의 상태가 무엇이며 어디에 누적되는가
- 상태를 두는 곳의 조건 — 서버보다 오래 유지되고, 여러 서버가 동시에 접근하고, 그 자체가 이중화되어 있어야 한다
- 본 구성에서는 그 조건이 하나도 갖춰지지 않는다는 것
- 애플리케이션을 systemd 서비스로 등록하여 재시작 이후에도 기동되게 하는 방법
- 서버가 공인 IP로 인터넷에 직접 노출되어 있다는 것

## Examples

- Gallery 배포 → ACG 개방, 소스 내려받기, 빌드, systemd 서비스 등록, 브라우저 확인
- 인증키만 남기고 나머지 자원은 반납한다

## Reference

- Draft: `.claude/draft/03.04.claude.notion.md`
- Notion: [Notion 문서]()
