# PIF Frontend

사람들이 자신의 행동 기록을 남기고, 이를 기반으로 소통할 수 있는 SNS 형식의 Flutter 애플리케이션입니다.  
이 저장소는 **프론트엔드(UI 및 데이터 흐름)** 를 담당합니다.

---

## 📌 프로젝트 개요
- 사용자는 자신의 하루/행동 기록을 시간 단위로 남길 수 있음
- 기록은 타임라인 형식으로 보여지고, 다른 사용자와 공유 가능
- SNS 기능 (게시글, 댓글, 좋아요 등) 포함
- Flutter 기반 크로스 플랫폼 앱 (Android / iOS)

---

## ⚙️ 기술 스택
- **Framework**: Flutter (Dart)
- **State 관리**: 기본 setState, FutureBuilder (추후 Provider, Riverpod 확장 가능)
- **UI**: Material Design
- **네트워크 통신**: `http` 패키지
- **기타**: Fluttertoast, Custom Widgets

---

## 📂 폴더 구조
lib/
┣ bar/ # AppBar, Sidebar 등 공통 UI
┣ model/ # 데이터 모델 (Post, Record, Member 등)
┣ screen/ # 주요 화면 (홈, 랭킹, 캐릭터 등)
┣ service/ # API 호출 서비스 (예: PostService, CommentService)
┣ widget/ # 재사용 가능한 위젯들
┣ main.dart # 앱 실행 진입점

🔄 데이터 흐름
게시글 목록 호출 예시

1. 백엔드로부터 받아오는 API 요청
2. JSON → 모델 변환
3. UI 렌더링

📌 주의 사항

이 저장소는 프론트엔드 전용입니다.

실제 데이터는 백엔드 API와 연동해야 합니다.

더미 데이터(Mock Data)로도 테스트 가능하며, API 주소는 service/ 내부에서 설정합니다.
