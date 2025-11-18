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
│   │   │   │   ├── MemberController.java
│   │   │   │   ├── TrainerController.java
│   │   │   │   ├── GymController.java
│   │   │   │   ├── BookingController.java
│   │   │   │   ├── NoticeController.java
│   │   │   │   ├── MachineController.java
│   │   │   │   └── StockController.java
│   │   │   ├── service/              # 서비스 인터페이스
│   │   │   ├── service/impl/         # 서비스 구현체
│   │   │   ├── model/
│   │   │   │   ├── vo/               # VO (Value Object)
│   │   │   │   └── mapper/           # MyBatis Mapper 인터페이스
│   │   │   ├── config/               # 설정 클래스
│   │   │   └── GymhubApplication.java
│   │   ├── resources/
│   │   │   ├── application.properties # 데이터베이스 설정
│   │   │   └── mappers/              # MyBatis Mapper XML
│   │   │       ├── member-mapper.xml
│   │   │       ├── gym-mapper.xml
│   │   │       ├── attendance-mapper.xml
│   │   │       └── ...
│   │   └── webapp/
│   │       ├── resources/
│   │       │   ├── css/
│   │       │   │   └── common.css     # 공통 스타일
│   │       │   ├── js/
│   │       │   └── images/           # 이미지 리소스
│   │       └── WEB-INF/
│   │           └── views/            # JSP 뷰 페이지
│   │               ├── member/       # 회원 전용 페이지
│   │               ├── trainer/      # 트레이너 전용 페이지
│   │               ├── gym/          # 헬스장 운영자 전용 페이지
│   │               ├── notice/       # 공지사항
│   │               ├── booking/      # 방문 예약
│   │               ├── common/       # 공통 컴포넌트
│   │               └── index.jsp     # 메인 페이지
│   └── test/                         # 테스트 코드
├── gymhub.sql                        # 데이터베이스 스키마
├── pom.xml                           # Maven 의존성 관리
├── IMPLEMENTATION_GUIDE.md           # 구현 가이드
└── README.md                         # 프로젝트 소개
```

## 🌟 주요 기능 (Key Features)

### 👤 회원 기능
- ✅ 회원가입 / 로그인 / 로그아웃
- ✅ 회원 정보 조회 및 수정
- ✅ 회원권 조회 및 구매
- ✅ PT 이용권 구매 및 예약
- ✅ 락커 이용권 구매 및 배정
- ✅ 출결 관리 (입실/퇴실)
- ✅ 인바디 기록 관리
- ✅ 운동 목표 설정 및 관리
- ✅ 헬스장 혼잡도 조회
- ✅ 방문 예약

### 🏋️ 트레이너 기능
- ✅ 트레이너 대시보드
- ✅ PT 일정 관리
- ✅ 회원 PT 예약 승인/거절
- ✅ 회원 관리 및 조회
- ✅ 출결 현황 조회

### 🏢 헬스장 운영자 기능
- ✅ 헬스장 정보 관리 (등록, 수정)
- ✅ 헬스장 상세정보 관리 (시설, 운영시간 등)
- ✅ 회원 관리 (조회, 수정, 삭제)
- ✅ 트레이너 관리
- ✅ 회원권 상품 관리
- ✅ PT 이용권 관리
- ✅ 락커 관리 (등록, 배정, 상태 관리)
- ✅ 기구 관리 (등록, 점검, 수리)
- ✅ 재고 관리
- ✅ 매출 관리 및 통계
- ✅ 공지사항 관리
- ✅ 운동 영상(Youtube URL) 관리
- ✅ 출결 통계 및 혼잡도 관리

### 📋 공통 기능
- ✅ 헬스장 목록 조회 및 검색
- ✅ 헬스장 상세 정보 조회
- ✅ 공지사항 조회
- ✅ 파일 업로드 (프로필 사진, 헬스장 사진, 기구 사진 등)

## 📸 화면 미리보기 (Preview)

| 기능 | 설명 |
|------|-----------|
| 메인 페이지 | 헬스장 목록 조회 및 검색 |
| 회원 대시보드 | 회원 정보, 출결 현황, 회원권 정보 |
| 트레이너 대시보드 | PT 일정, 회원 관리 |
| 헬스장 운영자 대시보드 | 매출 통계, 회원 현황, 기구 관리 |
| PT 예약 | PT 이용권 구매 및 예약 |
| 출결 관리 | 입실/퇴실 기록 및 통계 |
| 락커 관리 | 락커 배정 및 상태 관리 |

> **참고**: 실제 화면 캡처 이미지는 추후 추가 예정입니다.

## 💡 학습 포인트 (Learning Points)

- **Spring Boot 기반 MVC 구조 설계 방법 학습**
  - Controller, Service, Mapper 계층 분리
  - 의존성 주입(DI) 활용

- **MyBatis를 통한 데이터베이스 연동**
  - Mapper XML을 통한 SQL 관리
  - 동적 SQL 활용

- **JSP & JSTL을 활용한 동적 페이지 구현**
  - JSTL core 태그 라이브러리 활용
  - EL 표현식 사용

- **Spring Security를 통한 인증 및 권한 관리**
  - 역할 기반 접근 제어 (일반회원, 트레이너, 운영자)

- **파일 업로드 처리**
  - Apache Commons FileUpload 활용
  - 이미지 파일 관리

- **Oracle 데이터베이스 설계 및 관리**
  - 복잡한 테이블 관계 설계
  - 트랜잭션 관리

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
- `GYM_DETAIL`: 헬스장 상세정보
- `MEMBERSHIP`: 회원권 정보
- `PT_PASS`: PT 이용권
- `PT_RESERVE`: PT 예약
- `LOCKER`: 락커 정보
- `LOCKER_PASS`: 락커 이용권
- `ATTENDANCE`: 출결 정보
- `MACHINE`: 기구 정보
- `STOCK`: 재고 물품
- `PURCHASE`: 구매 정보
- `SALES`: 매출 정보
- `NOTICE`: 공지사항

자세한 데이터베이스 구조는 `gymhub.sql` 파일을 참고하세요.

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

**마지막 업데이트**: 2025-11-18  
**프로젝트**: GymHub  
**버전**: 0.0.1-SNAPSHOT
