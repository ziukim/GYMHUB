# 🚀 GymHub

> 헬스장 통합 관리 시스템 - 회원, 트레이너, 운영자를 위한 종합 헬스장 관리 플랫폼

## 📘 개요 (Overview)

본 프로젝트는 **Spring Boot와 MyBatis를 이용한 MVC 패턴 기반의 웹 애플리케이션**으로,  
헬스장 운영에 필요한 모든 기능을 통합 관리할 수 있는 시스템입니다.

**회원 관리**, **PT 예약**, **출결 관리**, **락커 관리**, **기구 관리**, **재고 관리**, **매출 관리** 등  
헬스장 운영에 필요한 핵심 기능들을 제공하며,  
**일반회원**, **트레이너**, **헬스장 운영자** 각각의 역할에 맞는 대시보드를 제공합니다.

Oracle 데이터베이스와 MyBatis를 통해 데이터 연동을 수행하며,  
Spring Boot 내장 Tomcat 서버에서 실행 가능합니다.

## 🧱 기술 스택 (Tech Stack)

| 구분 | 사용 기술 |
|------|------------|
| **Backend** | Java 17, Spring Boot 3.5.7, MyBatis 3.0.5 |
| **Frontend** | HTML, CSS, JavaScript, JSP, JSTL |
| **Server** | Apache Tomcat (Embedded) |
| **Database** | Oracle Database |
| **Build Tool** | Maven |
| **Security** | Spring Security 3.5.6 |
| **Tools** | IntelliJ IDEA, Git, GitHub |
| **Library** | Lombok, Apache Commons FileUpload |

## 🛠️ 설치 및 실행 (Installation & Run)

### 1. 프로젝트 클론

```bash
git clone https://github.com/username/gymhub.git
cd gymhub
```

### 2. IntelliJ IDEA에서 프로젝트 열기

- `File > Open` 또는 `Welcome Screen > Open`
- 복제한 프로젝트 폴더 선택 후 Open
- Maven 프로젝트로 인식되면 자동으로 의존성 다운로드
- 프로젝트가 열리면 우측 상단의 Maven 탭에서 `Reload All Maven Projects` 클릭

### 3. 데이터베이스(Oracle) 설정

1. Oracle Database 실행
2. 데이터베이스 및 사용자 생성
   ```sql
   CREATE USER c##gymhub IDENTIFIED BY gymhub;
   GRANT CONNECT, RESOURCE TO c##gymhub;
   ```
3. 프로젝트 루트의 `gymhub.sql` 파일 실행하여 테이블 생성
4. `src/main/resources/application.properties` 파일에서 데이터베이스 연결 정보 확인/수정
   ```properties
   spring.datasource.url=jdbc:oracle:thin:@localhost:1521:xe
   spring.datasource.username=c##gymhub
   spring.datasource.password=gymhub
   ```

### 4. Spring Boot 애플리케이션 실행

#### 방법 1: IntelliJ IDEA에서 실행
- `GymhubApplication.java` 파일을 열고
- 상단의 실행 버튼(▶) 클릭 또는 `Shift + F10`
- 또는 `Run > Run 'GymhubApplication'` 메뉴 선택

#### 방법 2: Maven 명령어로 실행
```bash
mvn spring-boot:run
```

#### 방법 3: JAR 파일로 실행
```bash
mvn clean package
java -jar target/gymhub-0.0.1-SNAPSHOT.war
```

### 5. 웹 애플리케이션 접속

브라우저에서 접속:
```
http://localhost:8005
```

> **참고**: 기본 포트는 `8005`이며, `application.properties`에서 변경 가능합니다.

## 📂 프로젝트 구조 (Directory Structure)

```
GYMHUB/
├── src/
│   ├── main/
│   │   ├── java/com/kh/gymhub/
│   │   │   ├── controller/          # 컨트롤러 (요청 처리)
│   │   │   │   ├── MemberController.java      # 회원 관련 컨트롤러
│   │   │   │   ├── TrainerController.java    # 트레이너 관련 컨트롤러
│   │   │   │   ├── GymController.java         # 헬스장 운영자 관련 컨트롤러
│   │   │   │   ├── BookingController.java     # 방문 예약 관련 컨트롤러
│   │   │   │   ├── NoticeController.java      # 공지사항 관련 컨트롤러
│   │   │   │   ├── MachineController.java     # 기구/락커 관리 컨트롤러
│   │   │   │   └── StockController.java       # 재고 관리 컨트롤러
│   │   │   ├── service/              # 서비스 인터페이스
│   │   │   │   ├── MemberService.java
│   │   │   │   ├── GymService.java
│   │   │   │   ├── AttendanceService.java
│   │   │   │   ├── StockService.java
│   │   │   │   └── ... (기타 서비스 인터페이스)
│   │   │   ├── service/impl/         # 서비스 구현체
│   │   │   │   ├── MemberServiceImpl.java
│   │   │   │   ├── GymServiceImpl.java
│   │   │   │   └── ... (기타 서비스 구현체)
│   │   │   ├── model/
│   │   │   │   ├── vo/               # VO (Value Object)
│   │   │   │   │   ├── Member.java
│   │   │   │   │   ├── Gym.java
│   │   │   │   │   ├── Stock.java
│   │   │   │   │   └── ... (기타 VO 클래스)
│   │   │   │   └── mapper/           # MyBatis Mapper 인터페이스
│   │   │   │       ├── MemberMapper.java
│   │   │   │       ├── GymMapper.java
│   │   │   │       └── ... (기타 Mapper 인터페이스)
│   │   │   ├── config/               # 설정 클래스
│   │   │   └── GymhubApplication.java
│   │   ├── resources/
│   │   │   ├── application.properties # 데이터베이스 설정
│   │   │   └── mappers/              # MyBatis Mapper XML
│   │   │       ├── member-mapper.xml
│   │   │       ├── gym-mapper.xml
│   │   │       ├── attendance-mapper.xml
│   │   │       ├── stock-mapper.xml
│   │   │       ├── notice-mapper.xml
│   │   │       └── ... (기타 Mapper XML 파일)
│   │   └── webapp/
│   │       ├── resources/
│   │       │   ├── css/
│   │       │   │   └── common.css     # 공통 스타일
│   │       │   ├── js/
│   │       │   └── images/           # 이미지 리소스
│   │       └── WEB-INF/
│   │           └── views/            # JSP 뷰 페이지
│   │               ├── member/       # 회원 전용 페이지
│   │               │   ├── memberDashboard.jsp
│   │               │   ├── memberInfo.jsp
│   │               │   └── ...
│   │               ├── trainer/      # 트레이너 전용 페이지
│   │               │   ├── trainerDashboard.jsp
│   │               │   └── ...
│   │               ├── gym/          # 헬스장 운영자 전용 페이지
│   │               │   ├── gymDashBoard.jsp
│   │               │   ├── gymMemberManagement.jsp
│   │               │   ├── gymStockManagement.jsp
│   │               │   └── ...
│   │               ├── notice/       # 공지사항
│   │               │   ├── noticeList.jsp
│   │               │   ├── noticeDetail.jsp
│   │               │   └── ...
│   │               ├── booking/      # 방문 예약
│   │               │   └── booking.jsp
│   │               ├── common/       # 공통 컴포넌트
│   │               │   └── sidebar/  # 사이드바 컴포넌트
│   │               └── index.jsp     # 메인 페이지
│   └── test/                         # 테스트 코드
├── gymhub.sql                        # 데이터베이스 스키마
├── pom.xml                           # Maven 의존성 관리
├── IMPLEMENTATION_GUIDE.md           # 구현 가이드
└── README.md                         # 프로젝트 소개
```

## 🌟 주요 기능 (Key Features)

### 👤 회원 기능
- ✅ **회원가입 / 로그인 / 로그아웃**
  - 일반 회원, 트레이너, 헬스장 운영자 회원가입
  - BCrypt를 이용한 비밀번호 암호화
  - 세션 기반 인증 관리
- ✅ **회원 정보 관리**
  - 회원 정보 조회 및 수정
  - 비밀번호 변경
  - 프로필 이미지 업로드
  - 회원 탈퇴
- ✅ **대시보드**
  - 출결 현황, 회원권 정보, PT 일정 요약
  - 최근 인바디 기록 조회
- ✅ **회원권 및 상품 관리**
  - 회원권 조회 및 구매
  - PT 이용권 구매 및 예약
  - 락커 이용권 구매 및 배정
  - 구매 내역 조회
- ✅ **PT 예약 관리**
  - 트레이너별 PT 일정 조회
  - 예약 가능한 시간대 확인
  - PT 예약 신청 및 취소
- ✅ **출결 관리**
  - 입실/퇴실 기록
  - 출결 이력 조회
- ✅ **인바디 기록 관리**
  - 인바디 측정 기록 등록
  - 인바디 기록 목록 조회
  - 최신 인바디 기록 조회
- ✅ **운동 목표 관리**
  - 운동 목표 추가/삭제
  - 목표 달성 상태 토글
  - 목표 목록 조회
- ✅ **헬스장 정보 조회**
  - 헬스장 목록 조회 및 검색
  - 헬스장 상세 정보 조회
  - 헬스장 혼잡도 조회
  - 헬스장 기구 목록 조회
- ✅ **방문 예약**
  - 헬스장 방문 예약 신청
  - 예약 시간 선택 및 등록
- ✅ **운동 영상 시청**
  - 헬스장별 운동 영상 목록 조회
  - YouTube URL을 통한 영상 시청
- ✅ **공지사항 조회**
  - 헬스장별 공지사항 목록 조회
  - 공지사항 상세 조회

### 🏋️ 트레이너 기능
- ✅ **트레이너 대시보드**
  - PT 일정 요약
  - 회원 관리 현황
- ✅ **PT 일정 관리**
  - PT 일정 조회
  - 날짜별 PT 일정 필터링
  - 회원 PT 예약 승인/거절
- ✅ **회원 관리**
  - 담당 회원 조회
  - 회원 출결 현황 조회
- ✅ **공지사항 조회**
  - 헬스장 공지사항 조회
- ✅ **회원 정보 관리**
  - 트레이너 정보 수정
  - 비밀번호 변경
  - 회원 탈퇴

### 🏢 헬스장 운영자 기능
- ✅ **헬스장 정보 관리**
  - 헬스장 정보 등록 및 수정
  - 헬스장 상세정보 관리 (시설, 운영시간 등)
  - 헬스장 이미지 업로드
  - 헬스장 탈퇴 처리
- ✅ **대시보드**
  - 매출 통계 및 현황
  - 회원 현황 요약
  - 기구 관리 현황
  - 출결 통계
- ✅ **회원 관리**
  - 회원 목록 조회 (페이징)
  - 회원 상세 정보 조회
  - 회원 정보 수정
  - 회원 삭제
  - 회원 구매 상품 조회
- ✅ **트레이너 관리**
  - 트레이너 목록 조회
  - 트레이너 등록
  - 트레이너 삭제
  - 트레이너 조회
- ✅ **상품 관리**
  - 회원권 상품 등록/수정/삭제
  - PT 이용권 등록/수정/삭제
  - 락커 이용권 등록/수정/삭제
  - 상품 목록 조회 (AJAX)
- ✅ **PT 관리**
  - PT 예약 현황 조회
  - PT 예약 승인/거절
  - 날짜별 PT 예약 필터링
- ✅ **락커 관리**
  - 락커 등록
  - 락커 목록 조회
  - 락커 상태 변경 (빈/사용중/수리중)
  - 락커 상세 정보 조회
- ✅ **기구 관리**
  - 기구 등록 (이미지 업로드 포함)
  - 기구 목록 조회
  - 기구 정보 수정
  - 기구 삭제
  - 기구 상태 관리
- ✅ **재고 관리**
  - 재고 목록 조회
  - 재고 등록 (물품명, 목표 재고 수량, 가격)
  - 재고 정보 수정
  - 재고 입출고 처리
  - 재고 삭제
  - 입출고 내역 조회
- ✅ **매출 관리**
  - 매출 통계 조회
  - 일별/월별 매출 현황
  - 상품별 매출 분석
- ✅ **공지사항 관리**
  - 공지사항 등록/수정/삭제
  - 공지사항 목록 조회 (페이징)
  - 공지사항 상세 조회
  - 공지사항 고정 기능
  - 파일 첨부 지원
- ✅ **운동 영상 관리**
  - YouTube URL 등록
  - 운동 영상 목록 조회
  - 운동 영상 삭제
- ✅ **출결 관리**
  - 출결 체크 페이지
  - 실시간 출결 현황 조회
  - 출결 통계 및 혼잡도 관리
  - 현재 헬스장 이용자 수 조회 (AJAX)
- ✅ **방문 예약 관리**
  - 방문 예약 목록 조회 (페이징)
  - 예약 상태 변경 (대기/승인/거절)
  - 날짜별 예약 필터링

### 📋 공통 기능
- ✅ **헬스장 목록 조회 및 검색**
  - 메인 페이지에서 헬스장 목록 조회
  - 헬스장명, 지역별 검색
- ✅ **헬스장 상세 정보 조회**
  - 헬스장 기본 정보
  - 헬스장 상세 정보 (운영시간, 시설 등)
  - 헬스장 이미지 조회
- ✅ **공지사항 조회**
  - 헬스장별 공지사항 목록 조회
  - 공지사항 상세 조회
  - 고정 공지사항 우선 표시
- ✅ **파일 업로드**
  - 프로필 사진 업로드
  - 헬스장 사진 업로드
  - 기구 사진 업로드
  - 공지사항 파일 첨부
  - 파일 경로 관리

## 📸 화면 미리보기 (Preview)

### 🏠 메인 페이지 및 공통 기능

| 화면 | 설명 | 이미지 |
|------|------|--------|
| 메인 페이지 | 헬스장 목록 조회 및 검색 | ![메인 페이지](./src/main/webapp/resources/previewImages/index.png) |
| 헬스장 상세 모달 | 헬스장 상세 정보, 시설, 혼잡도 조회 | ![헬스장 상세 모달](./src/main/webapp/resources/previewImages/index-detailmodal.png) |
| 로그인 필요 모달 | 로그인 필요 시 표시되는 모달 | ![로그인 필요](./src/main/webapp/resources/previewImages/login-required.png) |
| 방문 예약 | 헬스장 방문 예약 신청 | ![방문 예약](./src/main/webapp/resources/previewImages/booking.png) |
| 회원가입 (일반 회원) | 일반 회원 회원가입 | ![회원가입](./src/main/webapp/resources/previewImages/enroll-member.png) |
| 회원가입 (트레이너) | 트레이너 회원가입 | ![트레이너 회원가입](./src/main/webapp/resources/previewImages/eneoll-trainer.png) |
| 회원가입 (헬스장 운영자) | 헬스장 운영자 회원가입 | ![헬스장 운영자 회원가입](./src/main/webapp/resources/previewImages/enroll-gym.png) |
| 헬스장 미등록 회원 | 헬스장에 등록되지 않은 회원 화면 | ![헬스장 미등록 회원](./src/main/webapp/resources/previewImages/none-gym-member.png) |

### 👤 회원 기능

| 화면 | 설명 | 이미지 |
|------|------|--------|
| 회원 대시보드 | 회원 정보, 출결 현황, 회원권 정보 | ![회원 대시보드](./src/main/webapp/resources/previewImages/member-dashboard.png) |
| 회원 정보 | 회원 정보 조회 및 수정 | ![회원 정보](./src/main/webapp/resources/previewImages/memberInfo.png) |
| PT 예약 | PT 이용권 구매 및 예약 | ![PT 예약](./src/main/webapp/resources/previewImages/pt-booking.png) |
| PT 스케줄 | 회원의 PT 일정 조회 | ![PT 스케줄](./src/main/webapp/resources/previewImages/pt-스케줄.png) |

### 🏋️ 트레이너 기능

| 화면 | 설명 | 이미지 |
|------|------|--------|
| 트레이너 대시보드 | PT 일정, 회원 관리 | ![트레이너 대시보드](./src/main/webapp/resources/previewImages/trainer-dashboard.png) |
| 트레이너 PT 스케줄 | 트레이너의 PT 일정 관리 | ![트레이너 PT 스케줄](./src/main/webapp/resources/previewImages/trainer-pt-스케줄.png) |

### 🏢 헬스장 운영자 기능

| 화면 | 설명 | 이미지 |
|------|------|--------|
| 헬스장 선택 | 헬스장 운영자 메뉴 선택 | ![헬스장 선택](./src/main/webapp/resources/previewImages/select-gym.png) |
| 헬스장 대시보드 | 매출 통계, 회원 현황, 기구 관리 | ![헬스장 대시보드](./src/main/webapp/resources/previewImages/gym-dashboard.png) |
| 출결 체크 | 회원 입실/퇴실 관리 | ![출결 체크](./src/main/webapp/resources/previewImages/check-in.png) |
| 회원 관리 | 회원 목록 조회 및 관리 | ![회원 관리](./src/main/webapp/resources/previewImages/gym-member-management.png) |
| 회원 등록 | 신규 회원 등록 | ![회원 등록](./src/main/webapp/resources/previewImages/gym-member-enroll.png) |
| 트레이너 관리 | 트레이너 목록 조회 및 관리 | ![트레이너 관리](./src/main/webapp/resources/previewImages/gym-trainer-manage.png) |
| 회원권 관리 | 회원권 상품 관리 | ![회원권 관리](./src/main/webapp/resources/previewImages/gym-membership.png) |
| PT 보드 | PT 예약 현황 관리 | ![PT 보드](./src/main/webapp/resources/previewImages/gym-ptboard.png) |
| 방문 예약 관리 | 방문 예약 목록 및 승인 관리 | ![방문 예약 관리](./src/main/webapp/resources/previewImages/gym-booking-manage.png) |
| 공지사항 관리 | 공지사항 등록 및 관리 | ![공지사항 관리](./src/main/webapp/resources/previewImages/gym-notice.png) |
| 유튜브 영상 관리 | 운동 영상 URL 관리 | ![유튜브 영상 관리](./src/main/webapp/resources/previewImages/gym-youtube.png) |
| 헬스장 상세 정보 | 헬스장 정보 및 시설 관리 | ![헬스장 상세 정보](./src/main/webapp/resources/previewImages/gym-detail-form.png) |
| 기구 등록 | 운동 기구 등록 및 관리 | ![기구 등록](./src/main/webapp/resources/previewImages/gym-machine-enroll.png) |
| 재고 관리 | 재고 물품 입출고 관리 | ![재고 관리](./src/main/webapp/resources/previewImages/gym-stock-manage.png) |
| 매출 관리 | 매출 통계 및 현황 조회 | ![매출 관리](./src/main/webapp/resources/previewImages/gym-sales.png) |
| 시설 관리 | 헬스장 시설 정보 관리 | ![시설 관리](./src/main/webapp/resources/previewImages/gym-fa.png) |

## 💡 학습 포인트 (Learning Points)

- **Spring Boot 기반 MVC 구조 설계 방법 학습**
  - Controller, Service, Mapper 계층 분리
  - 의존성 주입(DI) 활용
  - RESTful API 설계 (AJAX 통신)

- **MyBatis를 통한 데이터베이스 연동**
  - Mapper XML을 통한 SQL 관리
  - 동적 SQL 활용 (if, choose, foreach 등)
  - 페이징 처리 구현
  - 복잡한 JOIN 쿼리 작성

- **JSP & JSTL을 활용한 동적 페이지 구현**
  - JSTL core 태그 라이브러리 활용
  - EL 표현식 사용
  - JSP Fragment를 통한 공통 컴포넌트 재사용

- **Spring Security를 통한 인증 및 권한 관리**
  - 역할 기반 접근 제어 (일반회원, 트레이너, 운영자)
  - BCrypt를 이용한 비밀번호 암호화
  - 세션 기반 인증 관리

- **파일 업로드 처리**
  - MultipartFile을 통한 파일 업로드
  - 이미지 파일 관리 및 경로 저장
  - 파일 크기 및 타입 검증

- **AJAX를 활용한 비동기 통신**
  - @ResponseBody를 통한 JSON 응답
  - 실시간 데이터 조회 (혼잡도, 출결 현황 등)
  - 동적 페이지 업데이트

- **Oracle 데이터베이스 설계 및 관리**
  - 복잡한 테이블 관계 설계
  - 트랜잭션 관리
  - 시퀀스를 통한 PK 자동 생성
  - 제약조건 설정 (PK, FK, UNIQUE 등)

- **페이징 처리 구현**
  - PageInfo 객체를 통한 페이징 로직
  - 페이지네이션 UI 구현

- **실시간 데이터 처리**
  - 출결 캐시를 통한 혼잡도 관리
  - 실시간 이용자 수 조회

## 🔐 사용자 역할 (User Roles)

| 역할 | 설명 | 권한 |
|------|------|------|
| **일반회원** | 헬스장을 이용하는 회원 | 회원권 구매, PT 예약, 출결 관리, 인바디 기록 등 |
| **트레이너** | PT를 제공하는 트레이너 | PT 일정 관리, 회원 예약 승인, 회원 관리 |
| **헬스장 운영자** | 헬스장을 운영하는 관리자 | 모든 기능 접근 및 관리 권한 |

## 📝 데이터베이스 구조

### 주요 테이블
- `MEMBER`: 회원/트레이너/운영자 정보
- `GYM`: 헬스장 정보
- `GYM_DETAIL`: 헬스장 상세정보 (운영시간, 시설 등)
- `GYM_NOTICE`: 헬스장 공지사항
- `MEMBERSHIP`: 회원권 정보
- `PT_PASS`: PT 이용권
- `PT_RESERVE`: PT 예약
- `PT_SCHEDULE`: PT 일정
- `LOCKER`: 락커 정보
- `LOCKER_PASS`: 락커 이용권
- `ATTENDANCE`: 출결 정보
- `ATT_CACHE`: 출결 캐시 (실시간 혼잡도)
- `MACHINE`: 기구 정보
- `MACHINE_MANAGE`: 기구 관리 정보
- `STOCK`: 재고 물품
- `STOCK_MANAGE`: 재고 입출고 내역
- `PURCHASE`: 구매 정보
- `SALES`: 매출 정보
- `INQUIRY_RESERVE`: 방문 예약 정보
- `GOAL`: 운동 목표
- `INBODY_RECORD`: 인바디 기록
- `YOUTUBE_URL`: 운동 영상 URL

자세한 데이터베이스 구조는 `gymhub.sql` 파일을 참고하세요.

![Uploading GYMhub (3).png…]()


## 🚧 개발 환경 요구사항

- **JDK**: 17 이상
- **IDE**: IntelliJ IDEA
- **Database**: Oracle Database 11g 이상
- **Maven**: 3.6 이상
- **Browser**: Chrome, Edge, Firefox 등 최신 브라우저

## 📚 참고 문서

- [구현 가이드](./IMPLEMENTATION_GUIDE.md) - 상세한 구현 가이드 및 코딩 컨벤션
- [스타일 가이드](./src/main/resources/STYLE_GUIDE.md) - 코드 스타일 가이드

## 🤝 기여하기 (Contributing)

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📄 라이선스 (License)

이 프로젝트는 교육 목적으로 제작되었습니다.

---

**마지막 업데이트**: 2025-11-19  
**프로젝트**: GymHub  
**버전**: 0.0.1-SNAPSHOT
