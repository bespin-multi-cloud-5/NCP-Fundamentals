# 02 Sub Account & 권한 관리 / 01 NCP 권한 관리 개요

리소스를 생성하기 전에 권한을 나누는 구조를 정리한다. NCP의 계정 구분이 하나뿐이라는 사실에서 시작하여, 계정 안에서 권한을 부여하는 세 수단과 계정 위에 적용되는 층위까지 다룬다.

## What you will learn

- 계정 구분 — 계정은 그 자체로 존재하고 Sub Account는 어떤 계정 안에서만 존재한다. 메인·마스터·멤버는 종류가 아니라 관계에 붙는 이름이다
- 메인 계정과 Sub Account의 책임 구분, 그리고 로그인 방식의 차이 — 이메일과 접속키·로그인 아이디
- 권한을 부여하는 세 수단 — 정책(관리형·사용자), 그룹, 역할. 콘솔의 `Sub Account` 서비스 하나에 모여 있고, 권한과 다른 축으로 계정 보안 설정(MFA, 접근 위치 제한)이 있다
- 역할의 두 갈래 — 자원에 부여하는 Server 유형(STS 임시 Access Key)과 계정 간 전환. 본 시리즈가 다루는 것은 앞의 것이다
- 계정 위의 층위 — Organization과 Quota Policy가 계정 밖에서 제약을 건다. 본 시리즈는 실습하지 않는다

## Reference

- Draft: `.claude/draft/02.01.claude.notion.md`
- Notion: [Notion 문서]()
