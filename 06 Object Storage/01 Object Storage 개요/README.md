# 06 Object Storage / 01 Object Storage 개요

서버가 일회성 자원이 되면서 서버 안에 저장한 데이터도 서버와 함께 소멸하게 되었다. 파일을 서버 밖으로 이전하기 전에 그 저장소가 무엇이고 Block Storage·NAS와 무엇이 다른지 다룬다.

## What you will learn

- 파일 하나를 객체 하나로 다룬다는 점 — 전체를 저장하고 전체를 조회하며 일부만 수정할 수 없다
- 서버에 연결하여 마운트하지 않고 HTTP 요청으로 다룬다는 점
- VPC 밖에 있다는 점 — 주소가 리전마다 하나씩이고 거기에 VPC도 Subnet도 없다
- 도메인이 공인과 사설 둘이라는 점 — Private Subnet의 서버는 사설 도메인으로 NAT Gateway 없이 통신하지만, 주소가 사설이어도 Object Storage가 VPC 안으로 편입되지는 않으며 사설 도메인에는 별도 요금이 부과된다
- 사용하기 전에 `[이용 신청]`을 한 번 수행해야 한다는 점
- Bucket 이름이 리전 안에서 하나뿐이어야 한다는 점 — 계정 밖에서 겹치지 않아야 하는 첫 자원이다
- 객체 이름이 그대로 주소의 일부가 된다는 점 — 공개하지 않은 객체에도 주소는 존재하며, 무엇이 조회 가능 여부를 결정하는지는 다음 섹션에서 다룬다
- 저장소에 계층이 없다는 점 — 이름에 포함된 `/`를 화면이 읽어 트리로 표시하고 폴더를 생성하면 빈 객체가 하나 생성된다
- S3 API 호환의 범위와 끊기는 지점 — `GET Bucket (List Objects) Version 2`는 지원하지 않는다
- 스토리지 셋의 용도 구분 — Block Storage, NAS, Object Storage. NAS도 여러 서버가 공유하지만 VPC 안의 자원이고 마운트하여 사용한다
- 저장 계층의 경계가 AWS와 다르다는 점 — AWS는 S3 안의 스토리지 클래스로 나누고 NCP는 Archive Storage라는 별도 서비스로 나누므로 Object Storage의 클래스는 하나뿐이다
- 한국 리전에는 버전 관리가 없다는 점 — 리전마다 선택 가능한 항목이 다르다

## Reference

- Draft: `.claude/draft/06.01.claude.notion.md`
- Notion: [Notion 문서]()
