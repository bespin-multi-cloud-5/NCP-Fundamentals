# 06 Object Storage / 04 Gallery - Object Storage 연동

Gallery 애플리케이션이 업로드된 이미지를 서버 디스크가 아닌 Object Storage에 저장하도록 전환한다. Bucket과 서버 역할을 생성하고, 저장소를 지정한 Init Script로 서버를 교체한 뒤 저장 결과를 검증한다.

## What you will learn

- 서버에 키를 두지 않고 자격증명을 얻는 방법 — `Server` 유형의 역할을 생성하여 서버에 부여한다
- 역할이 적용 대상 서버를 지정하는 구조 — Launch Configuration에 역할 항목이 없어 서버 생성 후 등록한다
- Launch Configuration을 교체해도 운영 중인 서버는 변경되지 않는다는 점
- 업로드 주소와 조회 주소의 분리 — 사설 도메인과 공인 도메인이 동일한 Bucket을 가리킨다
- 파일은 서버 밖으로 이관됐으나 이미지 목록은 여전히 서버별 H2에 남아 있다는 점

## Gallery Project

- `Gallery: Object Storage 연동` → Bucket 생성, `NCP_OBJECT_STORAGE_MANAGER`를 부여한 역할 생성과 적용, Init Script `v2`로 저장소 유형과 Bucket 이름 전달, 서버 교체 후 업로드 파일의 Bucket 저장 확인

## Reference

- Draft: `.claude/draft/06.04.claude.notion.md`
- Notion: [Notion 문서]()
