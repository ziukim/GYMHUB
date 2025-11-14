# GymHub 구현 가이드

## 📋 목차
1. [프로젝트 개요](#프로젝트-개요)
2. [데이터베이스 구조](#데이터베이스-구조)
3. [프로젝트 구조 및 파일 명명 규칙](#프로젝트-구조-및-파일-명명-규칙)
4. [Git 협업 전략](#git-협업-전략)
5. [코딩 컨벤션](#코딩-컨벤션)
6. [기능별 구현 가이드](#기능별-구현-가이드)
7. [주의사항 및 베스트 프랙티스](#주의사항-및-베스트-프랙티스)

---

## 프로젝트 개요

### 기술 스택
- **Backend**: Spring Boot, MyBatis
- **Frontend**: JSP, JSTL, JavaScript
- **Database**: Oracle
- **Build Tool**: Maven
- **Version Control**: Git

### 프로젝트 구조
```
GYMHUB/
├── src/
│   ├── main/
│   │   ├── java/com/kh/gymhub/
│   │   │   ├── controller/     # 컨트롤러
│   │   │   ├── service/         # 서비스 인터페이스
│   │   │   ├── service/impl/    # 서비스 구현체
│   │   │   ├── model/vo/        # VO 클래스
│   │   │   ├── model/dao/       # DAO 인터페이스
│   │   │   └── model/mapper/    # MyBatis Mapper XML
│   │   └── webapp/
│   │       ├── resources/
│   │       │   ├── css/
│   │       │   │   └── common.css  # 공통 스타일
│   │       │   ├── js/
│   │       │   └── images/
│   │       └── WEB-INF/
│   │           └── views/        # JSP 파일들
│   └── test/
└── gymhub.sql                    # 데이터베이스 스키마
```

---

## 데이터베이스 구조

### 주요 테이블 관계도

```
GYM (헬스장)
├── GYM_DETAIL (헬스장 상세정보)
├── GYM_NOTICE (공지사항)
├── YOUTUBE_URL (운동 영상)
├── MEMBER (회원/트레이너/운영자)
│   ├── MEMBERSHIP (회원권)
│   ├── PT_PASS (PT 이용권)
│   │   └── PT_RESERVE (PT 예약)
│   ├── LOCKER_PASS (락커 이용권)
│   ├── INQUIRY_RESERVE (방문 예약)
│   ├── ATTENDANCE (출결 정보)
│   ├── GOAL_MANAGE (목표 관리)
│   └── INBODY_RECORD (인바디 기록)
├── PURCHASE (구매)
│   └── PURCHASE_ITEM (구매 항목)
├── SALES (매출)
├── STOCK (재고 물품)
│   └── STOCK_MANAGER (재고 관리)
├── MACHINE (기구)
│   └── MACHINE_MANAGE (기구 관리)
└── LOCKER (락커)
```

### 중요 테이블 설명

#### 1. MEMBER 테이블
- `MEMBER_TYPE`: 1=일반회원, 2=트레이너, 3=헬스장운영자
- `GYM_NO`: 소속 헬스장 번호 (NULL 가능)
- **주의**: 회원권 만료/삭제 시 `GYM_NO`를 NULL로 설정해야 함

#### 2. INQUIRY_RESERVE 테이블 (방문 예약)
- `VISIT_DATETIME`: 방문 예정 일시
- `INQUIRY_STATUS`: 예약 상태 ('예약', '대기중', '완료' 등)
- `REQUEST`: 요청사항 (삭제 예정 컬럼)

#### 3. PT_RESERVE 테이블 (PT 예약)
- `PT_HOPE_TRAINER`: 희망 트레이너 (문자열)
- `TRAINER_MEMBER_NO`: 배정된 트레이너 번호 (FK)
- **필요**: `PT_RESERVE_STATUS` 컬럼 추가 필요 (대기중/승인됨/거절됨)

#### 4. ATTENDANCE 테이블 (출결)
- `CHECK_IN_INFO`: '입실' 또는 '퇴실'
- `ATTENDANCE_DATE`: 출석 일시
- **주의**: 입실/퇴실이 각각 별도 레코드로 저장됨

#### 5. ATT_CACHE 테이블 (출결 캐싱)
- 현재 구조: `AVERAGE_COUNT`, `MIN_COUNT`, `MAX_COUNT`만 있음
- **필요**: 시간대별 데이터 저장을 위한 구조 개선 필요
  - `GYM_NO` 추가
  - `CACHE_DATE` 추가
  - `TIME_SLOT` 추가 (00-02, 02-04, ... 22-24)
  - `MEMBER_COUNT` 추가

---

## 프로젝트 구조 및 파일 명명 규칙

### 컨트롤러 명명 규칙
- **회원**: `MemberController.java`
- **트레이너**: `TrainerController.java`
- **헬스장**: `GymController.java`
- **공지사항**: `NoticeController.java`
- **기타**: 기능별로 분리 (예: `StockController.java`, `MachineController.java`)

### 매핑 URL 규칙
- **회원**: `/xxx.me` (예: `/dashboard.me`, `/info.me`)
- **트레이너**: `/xxx.tr` (예: `/dashboard.tr`)
- **헬스장**: `/xxx.gym` (예: `/dashboard.gym`, `/member.gym`)
- **공지사항**: `/xxx.no` (예: `/notice.no`, `/noticeDetail.no`)
- **AJAX**: `/xxx.ajax` (예: `/member/lookup.ajax`)

### JSP 파일 위치 규칙
```
WEB-INF/views/
├── member/          # 회원 전용 페이지
├── trainer/         # 트레이너 전용 페이지
├── gym/             # 헬스장 운영자 전용 페이지
├── notice/          # 공지사항 (공통)
├── booking/         # 방문 예약
├── common/          # 공통 컴포넌트
│   └── sidebar/     # 사이드바
└── index.jsp        # 메인 페이지
```

### 서비스/DAO 명명 규칙
- **서비스 인터페이스**: `XxxService.java`
- **서비스 구현체**: `XxxServiceImpl.java`
- **DAO 인터페이스**: `XxxMapper.java` (MyBatis)
- **Mapper XML**: `XxxMapper.xml` (resources/mapper/)

### VO 클래스 명명 규칙
- 테이블명과 동일하거나 의미에 맞게 명명
- 예: `Member.java`, `Gym.java`, `MemberWithMembership.java`

---

## Git 협업 전략

### 브랜치 전략
```
main (또는 master)
├── develop
│   ├── feature/booking          # 방문예약 기능
│   ├── feature/attendance       # 출결 기능
│   ├── feature/member-dashboard # 회원 대시보드
│   ├── feature/pt-reservation   # PT 예약
│   ├── feature/trainer-dashboard # 트레이너 대시보드
│   ├── feature/gym-dashboard    # 헬스장 대시보드
│   └── feature/index-congestion # 인덱스 혼잡도
```

### 작업 흐름
1. `develop` 브랜치에서 `feature/xxx` 브랜치 생성
2. 기능 개발 완료 후 `develop`에 병합
3. 충돌 해결 후 테스트
4. 최종적으로 `main`에 병합

### 충돌 방지 전략

#### 1. 파일 분리 원칙
- **컨트롤러**: 기능별로 분리된 컨트롤러 사용
  - `MemberController.java` - 회원 관련만
  - `GymController.java` - 헬스장 관련만
  - `TrainerController.java` - 트레이너 관련만

#### 2. 공통 파일 수정 시 주의사항
- `common.css` 수정 시: 반드시 팀원과 사전 협의
- `common/sidebar/` 수정 시: 각자 브랜치에서 작업 후 충돌 해결
- `STYLE_GUIDE.md` 수정 시: 변경 사항 명확히 문서화


#### 3. 데이터베이스 변경 시
- `gymhub.sql` 파일 수정 전 반드시 팀원과 공유
- ALTER TABLE 문은 별도 마이그레이션 파일로 관리 권장
- 예: `migrations/001_add_pt_reserve_status.sql`

#### 4. 동시 작업 시 주의
- 같은 컨트롤러 수정: 각자 메서드 단위로 작업
- 같은 JSP 수정: 섹션별로 분리하여 작업
- 같은 서비스 수정: 메서드 단위로 분리

---

## 코딩 컨벤션

### ⚠️ 중요: 코드 레벨 및 사용 금지 사항

**이 프로젝트는 주니어 개발자가 이해하기 쉬운 코드 레벨을 유지합니다.**

#### 사용 금지 사항
- ❌ **람다식 (Lambda Expression) 사용 금지**
  - 예: `list.stream().map(x -> x.getName()).collect(...)` ❌
  - 대신: 전통적인 for 루프 사용 ✅
  
- ❌ **화살표 함수 (Arrow Function) 사용 금지**
  - 예: `const func = () => {}` ❌
  - 예: `list.forEach(item => {})` ❌
  - 대신: `function` 키워드 사용 ✅

- ❌ **Stream API 사용 금지**
  - 예: `list.stream().filter(...).map(...)` ❌
  - 대신: 전통적인 for 루프와 if 문 사용 ✅

- ❌ **Optional 사용 금지** (간단한 null 체크로 대체)
- ❌ **복잡한 함수형 프로그래밍 패턴 사용 금지**

#### 권장 사항
- ✅ **명시적이고 읽기 쉬운 코드 작성**
- ✅ **전통적인 제어 구조 사용** (for, while, if-else)
- ✅ **명확한 변수명 사용**
- ✅ **단계별 주석 작성**

---

### Java 코딩 규칙

#### 컨트롤러
```java
@Controller
public class MemberController {
    
    // 의존성 주입은 생성자 주입 사용
    private final MemberService memberService;
    
    @Autowired
    public MemberController(MemberService memberService) {
        this.memberService = memberService;
    }
    
    // GET 매핑: 페이지 이동
    @GetMapping("/dashboard.me")
    public String memberDashboard(HttpSession session, Model model) {
        // 세션 체크
        Member loginMember = (Member) session.getAttribute("loginMember");
        if (loginMember == null) {
            session.setAttribute("errorMsg", "로그인이 필요합니다.");
            return "redirect:/";
        }
        
        // 권한 체크 (필요시)
        if (loginMember.getMemberType() != 1) {
            session.setAttribute("errorMsg", "권한이 없습니다.");
            return "redirect:/";
        }
        
        // 비즈니스 로직
        // ...
        
        return "member/memberDashboard";
    }
    
    // POST 매핑: 데이터 처리
    @PostMapping("/updateInfo.me")
    public String updateInfo(@RequestParam String name, HttpSession session) {
        // ...
        return "redirect:/info.me";
    }
    
    // AJAX 응답
    @GetMapping("/check.ajax")
    @ResponseBody
    public Map<String, Object> checkSomething(@RequestParam String param) {
        Map<String, Object> result = new HashMap<>();
        // ...
        return result;
    }
}
```

#### 서비스
```java
public interface MemberService {
    Member getMemberByNo(int memberNo);
    List<Member> getMembersByGymNo(int gymNo);
}

@Service
public class MemberServiceImpl implements MemberService {
    
    private final MemberMapper memberMapper;
    
    @Autowired
    public MemberServiceImpl(MemberMapper memberMapper) {
        this.memberMapper = memberMapper;
    }
    
    @Override
    public Member getMemberByNo(int memberNo) {
        return memberMapper.selectMemberByNo(memberNo);
    }
    
    @Override
    public List<Member> getMembersByGymNo(int gymNo) {
        // ✅ 올바른 방법: 전통적인 방식
        List<Member> allMembers = memberMapper.selectAllMembers();
        List<Member> result = new ArrayList<>();
        
        for (int i = 0; i < allMembers.size(); i++) {
            Member member = allMembers.get(i);
            if (member.getGymNo() != null && member.getGymNo() == gymNo) {
                result.add(member);
            }
        }
        
        return result;
        
        // ❌ 잘못된 방법: Stream API 사용 금지
        // return memberMapper.selectAllMembers().stream()
        //     .filter(m -> m.getGymNo() != null && m.getGymNo() == gymNo)
        //     .collect(Collectors.toList());
    }
}
```

#### Mapper XML
```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" 
    "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="com.kh.gymhub.model.mapper.MemberMapper">
    
    <select id="selectMemberByNo" parameterType="int" resultType="Member">
        SELECT * FROM MEMBER
        WHERE MEMBER_NO = #{memberNo}
        AND STATUS = 'Y'
    </select>
    
</mapper>
```

### Java 반복문 및 컬렉션 처리

#### 리스트 반복 처리
```java
// ✅ 올바른 방법: 전통적인 for 루프
List<Member> members = memberService.getMembersByGymNo(gymNo);
for (int i = 0; i < members.size(); i++) {
    Member member = members.get(i);
    // 처리 로직
    System.out.println(member.getMemberName());
}

// ✅ 또는 향상된 for 루프 (Enhanced for loop)
for (Member member : members) {
    // 처리 로직
    System.out.println(member.getMemberName());
}

// ❌ 잘못된 방법: Stream API 사용 금지
// members.stream().forEach(m -> System.out.println(m.getMemberName()));

// ❌ 잘못된 방법: forEach 메서드 사용 금지
// members.forEach(m -> System.out.println(m.getMemberName()));
```

#### 리스트 필터링
```java
// ✅ 올바른 방법: 전통적인 for 루프로 필터링
List<Member> activeMembers = new ArrayList<>();
for (int i = 0; i < allMembers.size(); i++) {
    Member member = allMembers.get(i);
    if (member.getStatus() != null && member.getStatus().equals("Y")) {
        activeMembers.add(member);
    }
}

// ❌ 잘못된 방법: Stream filter 사용 금지
// List<Member> activeMembers = allMembers.stream()
//     .filter(m -> "Y".equals(m.getStatus()))
//     .collect(Collectors.toList());
```

#### 맵 반복 처리
```java
// ✅ 올바른 방법: EntrySet 사용
Map<String, Object> dataMap = new HashMap<>();
for (Map.Entry<String, Object> entry : dataMap.entrySet()) {
    String key = entry.getKey();
    Object value = entry.getValue();
    // 처리 로직
}

// ❌ 잘못된 방법: forEach 사용 금지
// dataMap.forEach((key, value) -> {});
```

#### 조건부 처리
```java
// ✅ 올바른 방법: 명시적인 if-else
if (member != null) {
    if (member.getGymNo() != null) {
        // 처리 로직
    } else {
        // gymNo가 null인 경우 처리
    }
} else {
    // member가 null인 경우 처리
}

// ❌ 잘못된 방법: Optional 사용 금지
// Optional.ofNullable(member)
//     .map(Member::getGymNo)
//     .ifPresent(gymNo -> {});
```

---

### JSP 코딩 규칙

#### 기본 구조
```jsp
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>페이지 제목</title>
    
    <!-- Common CSS (필수, 먼저 로드) -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common.css">
    
    <!-- 페이지별 스타일 -->
    <style>
        /* 페이지 고유 스타일만 작성 */
    </style>
</head>
<body>
    <div class="app-container">
        <!-- 사이드바 -->
        <jsp:include page="/WEB-INF/views/common/sidebar/sidebarMember.jsp"/>
        
        <!-- 메인 콘텐츠 -->
        <div class="main-content">
            <!-- 내용 -->
        </div>
    </div>
    
    <!-- JavaScript -->
    <script>
        // 페이지별 스크립트
    </script>
</body>
</html>
```

#### JSTL 사용
```jsp
<!-- 조건문 -->
<c:if test="${not empty loginMember}">
    <!-- 로그인 상태 -->
</c:if>

<c:choose>
    <c:when test="${loginMember.memberType == 1}">
        <!-- 일반 회원 -->
    </c:when>
    <c:when test="${loginMember.memberType == 2}">
        <!-- 트레이너 -->
    </c:when>
    <c:otherwise>
        <!-- 기타 -->
    </c:otherwise>
</c:choose>

<!-- 반복문 -->
<c:forEach var="item" items="${list}">
    <div>${item.name}</div>
</c:forEach>

<!-- 인덱스가 필요한 경우 -->
<c:forEach var="item" items="${list}" varStatus="status">
    <div>${status.index + 1}. ${item.name}</div>
</c:forEach>
```

#### JavaScript in JSP
```jsp
<script>
    // ✅ 올바른 방법: function 키워드 사용
    function loadData() {
        // 함수 내용
    }
    
    // 이벤트 리스너
    document.addEventListener('DOMContentLoaded', function() {
        var button = document.getElementById('myButton');
        if (button) {
            button.addEventListener('click', function() {
                alert('클릭됨');
            });
        }
    });
    
    // ❌ 잘못된 방법: 화살표 함수 사용 금지
    // const loadData = () => {};
    // document.addEventListener('DOMContentLoaded', () => {});
    // button.addEventListener('click', () => {});
</script>
```

### JavaScript 코딩 규칙

#### ⚠️ 화살표 함수 사용 금지
- ❌ `const func = () => {}` 
- ❌ `list.forEach(item => {})`
- ✅ `function func() {}` 사용
- ✅ `list.forEach(function(item) {})` 사용

#### AJAX 호출
```javascript
// Fetch API 사용 (화살표 함수 사용 금지)
function loadData() {
    fetch('${pageContext.request.contextPath}/api/data.ajax', {
        method: 'GET',
        headers: {
            'Content-Type': 'application/json'
        }
    })
    .then(function(response) {
        return response.json();
    })
    .then(function(data) {
        // 성공 처리
        console.log(data);
    })
    .catch(function(error) {
        // 에러 처리
        console.error('Error:', error);
    });
}

// POST 요청
function submitData(formData) {
    fetch('${pageContext.request.contextPath}/api/submit.ajax', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify(formData)
    })
    .then(function(response) {
        return response.json();
    })
    .then(function(data) {
        if (data.success) {
            alert('성공');
            location.reload();
        } else {
            alert('실패: ' + data.message);
        }
    })
    .catch(function(error) {
        console.error('Error:', error);
        alert('요청 중 오류가 발생했습니다.');
    });
}
```

#### 이벤트 리스너
```javascript
// ✅ 올바른 방법: function 키워드 사용
document.addEventListener('DOMContentLoaded', function() {
    // 초기화 코드
});

button.addEventListener('click', function() {
    // 클릭 이벤트 처리
});

// ❌ 잘못된 방법: 화살표 함수 사용 금지
// document.addEventListener('DOMContentLoaded', () => {});
// button.addEventListener('click', () => {});
```

#### 반복문 처리
```javascript
// ✅ 올바른 방법: 전통적인 for 루프
var list = [1, 2, 3, 4, 5];
for (var i = 0; i < list.length; i++) {
    console.log(list[i]);
}

// ✅ 또는 forEach 사용 (화살표 함수 없이)
list.forEach(function(item) {
    console.log(item);
});

// ❌ 잘못된 방법: 화살표 함수 사용 금지
// list.forEach(item => console.log(item));
```

#### 배열 처리
```javascript
// ✅ 올바른 방법: 전통적인 for 루프
var filteredList = [];
for (var i = 0; i < originalList.length; i++) {
    if (originalList[i].status === 'active') {
        filteredList.push(originalList[i]);
    }
}

// ✅ 또는 forEach 사용 (화살표 함수 없이)
var filteredList = [];
originalList.forEach(function(item) {
    if (item.status === 'active') {
        filteredList.push(item);
    }
});

// ❌ 잘못된 방법: filter, map 등 함수형 메서드 사용 금지
// var filteredList = originalList.filter(item => item.status === 'active');
// var mappedList = originalList.map(item => item.name);
```

#### 변수 선언
```javascript
// ✅ 올바른 방법: var 사용 (ES5 스타일)
// ✅ const 사용은 허용
const memberName = "홍길동";
var memberName = "홍길동";
var memberNo = 1;
var memberList = [];

// ✅ 또는 function 스코프 내에서 var 사용
function loadMembers() {
    var members = [];
    for (var i = 0; i < 10; i++) {
        members.push(i);
    }
    return members;
}

// ❌ 잘못된 방법: let 사용 금지 (ES6+)
// let memberNo = 1;

// ❌ 잘못된 방법: 구조 분해 할당 사용 금지
// const {name, age} = member;
// members.forEach(({name, age}) => console.log(name, age));
```

---

## 기능별 구현 가이드

### 1. 방문예약 (Booking)

#### 데이터베이스 변경사항
```sql
-- REQUEST 컬럼 삭제 (요청사항 칸 없음)
ALTER TABLE INQUIRY_RESERVE DROP COLUMN REQUEST;
```

#### 구현 단계

**1-1. 컨트롤러 생성/수정**
- 파일: `BookingController.java` (신규 생성 권장) 또는 `MemberController.java`에 추가
- 매핑: `@GetMapping("/booking.me")` - 예약 페이지
- 매핑: `@PostMapping("/booking/submit.me")` - 예약 제출

**1-2. 예약 페이지 로직**
```java
@GetMapping("/booking.me")
public String bookingPage(@RequestParam(required = false) Integer gymNo, 
                         HttpSession session, Model model) {
    // 1. 세션에서 로그인 정보 확인
    Member loginMember = (Member) session.getAttribute("loginMember");
    if (loginMember == null) {
        session.setAttribute("errorMsg", "로그인이 필요합니다.");
        return "redirect:/";
    }
    
    // 2. gymNo 확인 및 가져오기
    if (gymNo == null) {
        gymNo = (Integer) session.getAttribute("selectedGymNo");
    }
    
    if (gymNo == null) {
        session.setAttribute("errorMsg", "헬스장을 선택해주세요.");
        return "redirect:/";
    }
    
    // 3. 헬스장 정보 조회
    Gym gym = gymService.getGymByNo(gymNo);
    if (gym == null) {
        session.setAttribute("errorMsg", "헬스장 정보를 찾을 수 없습니다.");
        return "redirect:/";
    }
    
    model.addAttribute("gym", gym);
    model.addAttribute("loginMember", loginMember);
    
    // 4. 기존 예약 확인
    InquiryReserve existingReserve = inquiryService.getReserveByMemberNo(
        loginMember.getMemberNo());
    
    if (existingReserve != null) {
        // 기존 예약이 있으면 예약 정보 확인 모달 표시
        model.addAttribute("existingReserve", existingReserve);
        model.addAttribute("showReserveModal", true);
    }
    
    // 5. 이미 예약된 시간 조회 (같은 헬스장의 다른 예약들)
    List<InquiryReserve> reservedTimes = inquiryService.getReservedTimesByGymNo(gymNo);
    model.addAttribute("reservedTimes", reservedTimes);
    
    return "booking/booking";
}
```

**1-3. 예약 제출 로직**
```java
@PostMapping("/booking/submit.me")
public String submitBooking(@RequestParam Integer gymNo,
                           @RequestParam String visitDatetime,
                           HttpSession session) {
    Member loginMember = (Member) session.getAttribute("loginMember");
    
    // 중복 예약 체크
    InquiryReserve existing = inquiryService.getReserveByMemberNo(
        loginMember.getMemberNo());
    if (existing != null) {
        session.setAttribute("errorMsg", "이미 예약이 존재합니다.");
        return "redirect:/booking.me?gymNo=" + gymNo;
    }
    
    // 예약 생성
    InquiryReserve reserve = new InquiryReserve();
    reserve.setGymNo(gymNo);
    reserve.setMemberNo(loginMember.getMemberNo());
    reserve.setVisitDatetime(/* 날짜 변환 */);
    reserve.setInquiryStatus("예약"); // '예약' 상태로 설정
    
    int result = inquiryService.insertReserve(reserve);
    
    if (result > 0) {
        session.setAttribute("successMsg", "예약이 완료되었습니다.");
        return "redirect:/"; // index로 이동
    } else {
        session.setAttribute("errorMsg", "예약에 실패했습니다.");
        return "redirect:/booking.me?gymNo=" + gymNo;
    }
}
```

**1-4. JSP 구현**
- 파일: `booking/booking.jsp`
- 상단 카드: 선택된 헬스장 정보 표시
- 예약자 정보: 세션의 `loginMember` 정보 표시
- 예약 정보 확인 모달: 기존 예약이 있을 때 표시

**1-5. Mapper XML**
```xml
<select id="selectReserveByMemberNo" parameterType="int" resultType="InquiryReserve">
    SELECT * FROM INQUIRY_RESERVE
    WHERE MEMBER_NO = #{memberNo}
    AND INQUIRY_STATUS = '예약'
    ORDER BY VISIT_DATETIME DESC
    FETCH FIRST 1 ROWS ONLY
</select>

<select id="selectReservedTimesByGymNo" parameterType="int" resultType="InquiryReserve">
    SELECT VISIT_DATETIME FROM INQUIRY_RESERVE
    WHERE GYM_NO = #{gymNo}
    AND INQUIRY_STATUS = '예약'
    AND VISIT_DATETIME >= SYSDATE
</select>

<insert id="insertReserve" parameterType="InquiryReserve">
    INSERT INTO INQUIRY_RESERVE (
        INQUIRY_NO, GYM_NO, MEMBER_NO, VISIT_DATETIME, INQUIRY_STATUS
    ) VALUES (
        SEQ_INQUIRY_NO.NEXTVAL, #{gymNo}, #{memberNo}, #{visitDatetime}, #{inquiryStatus}
    )
</insert>
```

---

### 2. 출결정보 (Attendance)

#### 구현 단계

**2-1. 출석 체크 로직**
```java
@PostMapping("/attendance/check.gym")
@ResponseBody
public Map<String, Object> checkAttendance(@RequestParam String phone,
                                           HttpSession session) {
    // 결과를 담을 Map 생성
    Map<String, Object> result = new HashMap<>();
    
    // 1. 세션에서 로그인 정보 확인
    Member loginMember = (Member) session.getAttribute("loginMember");
    if (loginMember == null) {
        result.put("success", false);
        result.put("message", "로그인이 필요합니다.");
        return result;
    }
    
    // 2. 헬스장 번호 확인
    Integer gymNo = loginMember.getGymNo();
    if (gymNo == null) {
        result.put("success", false);
        result.put("message", "헬스장 정보를 찾을 수 없습니다.");
        return result;
    }
    
    // 3. 전화번호로 회원 조회 (gym_no 매칭, 만료되지 않은 회원권)
    Member member = attendanceService.getMemberByPhoneAndGymNo(phone, gymNo);
    
    if (member == null) {
        result.put("success", false);
        result.put("message", "등록된 회원이 아니거나 만료된 회원권입니다.");
        return result;
    }
    
    // 4. 오늘 날짜의 출결 기록 조회
    Attendance todayAttendance = attendanceService.getTodayAttendance(
        gymNo, member.getMemberNo());
    
    if (todayAttendance == null) {
        // 입실 처리
        Attendance checkIn = new Attendance();
        checkIn.setGymNo(gymNo);
        checkIn.setMemberNo(member.getMemberNo());
        checkIn.setCheckInInfo("입실");
        checkIn.setAttendanceDate(new Date(System.currentTimeMillis()));
        
        int insertResult = attendanceService.insertAttendance(checkIn);
        
        if (insertResult > 0) {
            // 회원권 정보 조회
            Membership membership = membershipService.getMembershipByMemberNo(
                member.getMemberNo());
            
            result.put("success", true);
            result.put("type", "입실");
            result.put("member", member);
            result.put("membership", membership);
        } else {
            result.put("success", false);
            result.put("message", "입실 처리에 실패했습니다.");
        }
    } else {
        // 퇴실 기록 확인
        Attendance checkOut = attendanceService.getTodayCheckOut(
            gymNo, member.getMemberNo());
        
        if (checkOut != null) {
            // 이미 퇴실했음 - 재입장 정책에 따라 처리
            result.put("success", false);
            result.put("message", "이미 오늘 출결이 완료되었습니다.");
            // 또는 재입장 허용 시 입실 처리
        } else {
            // 퇴실 처리
            Attendance checkOutRecord = new Attendance();
            checkOutRecord.setGymNo(gymNo);
            checkOutRecord.setMemberNo(member.getMemberNo());
            checkOutRecord.setCheckInInfo("퇴실");
            checkOutRecord.setAttendanceDate(new Date(System.currentTimeMillis()));
            
            int insertResult = attendanceService.insertAttendance(checkOutRecord);
            
            if (insertResult > 0) {
                result.put("success", true);
                result.put("type", "퇴실");
                result.put("member", member);
            } else {
                result.put("success", false);
                result.put("message", "퇴실 처리에 실패했습니다.");
            }
        }
    }
    
    return result;
}
```

**2-2. Mapper XML**
```xml
<select id="selectMemberByPhoneAndGymNo" resultType="Member">
    SELECT m.* FROM MEMBER m
    INNER JOIN MEMBERSHIP ms ON m.MEMBER_NO = ms.MEMBER_NO
    WHERE m.MEMBER_PHONE = #{phone}
    AND m.GYM_NO = #{gymNo}
    AND ms.MEMBERSHIP_STATUS != '만료'
    AND ms.END_DATE >= SYSDATE
    FETCH FIRST 1 ROWS ONLY
</select>

<select id="selectTodayAttendance" resultType="Attendance">
    SELECT * FROM ATTENDANCE
    WHERE GYM_NO = #{gymNo}
    AND MEMBER_NO = #{memberNo}
    AND TRUNC(ATTENDANCE_DATE) = TRUNC(SYSDATE)
    AND CHECK_IN_INFO = '입실'
    FETCH FIRST 1 ROWS ONLY
</select>

<select id="selectTodayCheckOut" resultType="Attendance">
    SELECT * FROM ATTENDANCE
    WHERE GYM_NO = #{gymNo}
    AND MEMBER_NO = #{memberNo}
    AND TRUNC(ATTENDANCE_DATE) = TRUNC(SYSDATE)
    AND CHECK_IN_INFO = '퇴실'
    FETCH FIRST 1 ROWS ONLY
</select>
```

---

### 3. 회원 대시보드

#### 구현 단계

**3-1. 대시보드 데이터 조회**
```java
@GetMapping("/dashboard.me")
public String memberDashboard(HttpSession session, Model model) {
    Member loginMember = (Member) session.getAttribute("loginMember");
    Integer gymNo = loginMember.getGymNo();
    
    if (gymNo == null) {
        // 회원권이 없는 경우
        model.addAttribute("hasMembership", false);
        return "member/memberDashboard";
    }
    
    // 회원권 정보
    Membership membership = membershipService.getActiveMembershipByMemberNo(
        loginMember.getMemberNo());
    model.addAttribute("membership", membership);
    
    // 이번 달 출석 수
    int thisMonthAttendance = attendanceService.getThisMonthAttendanceCount(
        gymNo, loginMember.getMemberNo());
    model.addAttribute("thisMonthAttendance", thisMonthAttendance);
    
    // 현재 혼잡도 (입실만 있고 퇴실 없는 인원)
    int currentCongestion = attendanceService.getCurrentCongestion(gymNo);
    model.addAttribute("currentCongestion", currentCongestion);
    
    // 헬스장 공지사항
    List<GymNotice> notices = noticeService.getNoticesByGymNo(gymNo);
    model.addAttribute("notices", notices);
    
    // 운동 영상
    List<YoutubeUrl> videos = youtubeUrlService.getVideosByGymNo(gymNo);
    model.addAttribute("videos", videos);
    
    // 운동 목표
    List<GoalManage> goals = goalService.getGoalsByMemberNo(loginMember.getMemberNo());
    model.addAttribute("goals", goals);
    
    model.addAttribute("hasMembership", true);
    return "member/memberDashboard";
}
```

**3-2. 현재 혼잡도 계산 로직**

**Mapper XML:**
```xml
<select id="selectCurrentCongestion" parameterType="int" resultType="int">
    SELECT COUNT(DISTINCT a1.MEMBER_NO)
    FROM ATTENDANCE a1
    WHERE a1.GYM_NO = #{gymNo}
    AND TRUNC(a1.ATTENDANCE_DATE) = TRUNC(SYSDATE)
    AND a1.CHECK_IN_INFO = '입실'
    AND NOT EXISTS (
        SELECT 1 FROM ATTENDANCE a2
        WHERE a2.GYM_NO = a1.GYM_NO
        AND a2.MEMBER_NO = a1.MEMBER_NO
        AND TRUNC(a2.ATTENDANCE_DATE) = TRUNC(SYSDATE)
        AND a2.CHECK_IN_INFO = '퇴실'
        AND a2.ATTENDANCE_DATE > a1.ATTENDANCE_DATE
    )
</select>
```

**서비스 구현 (Java):**
```java
@Override
public int getCurrentCongestion(int gymNo) {
    // ✅ 올바른 방법: Mapper를 통해 직접 조회
    return attendanceMapper.selectCurrentCongestion(gymNo);
    
    // ❌ 잘못된 방법: Java에서 직접 계산 (비효율적)
    // List<Attendance> allAttendance = attendanceMapper.selectAllByGymNo(gymNo);
    // int count = 0;
    // for (int i = 0; i < allAttendance.size(); i++) {
    //     // 복잡한 로직...
    // }
    // return count;
}
```

**3-3. 목표 관리 AJAX**
```java
@PostMapping("/goal/updateStatus.me")
@ResponseBody
public Map<String, Object> updateGoalStatus(@RequestParam int goalNo,
                                           @RequestParam String status,
                                           HttpSession session) {
    // 결과를 담을 Map 생성
    Map<String, Object> result = new HashMap<>();
    
    // 1. 세션 확인
    Member loginMember = (Member) session.getAttribute("loginMember");
    if (loginMember == null) {
        result.put("success", false);
        result.put("message", "로그인이 필요합니다.");
        return result;
    }
    
    // 2. 상태 업데이트
    int updateResult = goalService.updateGoalStatus(goalNo, status);
    
    // 3. 결과 반환
    if (updateResult > 0) {
        result.put("success", true);
        result.put("message", "목표 상태가 변경되었습니다.");
    } else {
        result.put("success", false);
        result.put("message", "업데이트에 실패했습니다.");
    }
    
    return result;
}

@PostMapping("/goal/deleteAchieved.me")
@ResponseBody
public Map<String, Object> deleteAchievedGoals(HttpSession session) {
    // 결과를 담을 Map 생성
    Map<String, Object> result = new HashMap<>();
    
    // 1. 세션 확인
    Member loginMember = (Member) session.getAttribute("loginMember");
    if (loginMember == null) {
        result.put("success", false);
        result.put("message", "로그인이 필요합니다.");
        return result;
    }
    
    // 2. 달성한 목표 삭제
    int deleteCount = goalService.deleteAchievedGoals(loginMember.getMemberNo());
    
    // 3. 결과 반환
    result.put("success", true);
    result.put("deletedCount", deleteCount);
    result.put("message", deleteCount + "개의 목표가 삭제되었습니다.");
    
    return result;
}
```

**서비스 구현:**
```java
@Override
public int deleteAchievedGoals(int memberNo) {
    // 1. 회원의 모든 목표 조회
    List<GoalManage> allGoals = goalMapper.selectGoalsByMemberNo(memberNo);
    
    // 2. 달성한 목표만 필터링
    List<Integer> achievedGoalNos = new ArrayList<>();
    for (int i = 0; i < allGoals.size(); i++) {
        GoalManage goalManage = allGoals.get(i);
        Goal goal = goalMapper.selectGoalByNo(goalManage.getGoalNo());
        if (goal != null && goal.getGoalStatus() != null && 
            goal.getGoalStatus().equals("달성")) {
            achievedGoalNos.add(goal.getGoalNo());
        }
    }
    
    // 3. 달성한 목표 삭제
    int deleteCount = 0;
    for (int i = 0; i < achievedGoalNos.size(); i++) {
        int goalNo = achievedGoalNos.get(i);
        int result = goalMapper.deleteGoalManage(memberNo, goalNo);
        if (result > 0) {
            deleteCount++;
        }
    }
    
    return deleteCount;
}
```

---

### 4. PT 예약 관련

#### 데이터베이스 변경사항
```sql
-- PT_RESERVE 테이블에 상태 컬럼 추가
ALTER TABLE PT_RESERVE ADD PT_RESERVE_STATUS VARCHAR2(20) DEFAULT '대기중';

-- 컬럼명 변경 (선택사항)
-- ALTER TABLE PT_RESERVE RENAME COLUMN PT_HOPE_TRAINER TO PT_TRAINER;
```

#### 구현 단계

**4-1. PT 예약 상태 관리**
```java
@PostMapping("/pt/approve.gym")
@ResponseBody
public Map<String, Object> approvePtReserve(@RequestParam int ptReserveNo,
                                            @RequestParam int trainerNo) {
    Map<String, Object> result = new HashMap<>();
    
    // PT 예약 승인 및 트레이너 배정
    PtReserve reserve = ptReserveService.getPtReserveByNo(ptReserveNo);
    reserve.setPtReserveStatus("승인됨");
    reserve.setTrainerMemberNo(trainerNo);
    
    int updateResult = ptReserveService.updatePtReserve(reserve);
    
    if (updateResult > 0) {
        result.put("success", true);
    } else {
        result.put("success", false);
    }
    
    return result;
}

@PostMapping("/pt/reject.gym")
@ResponseBody
public Map<String, Object> rejectPtReserve(@RequestParam int ptReserveNo) {
    Map<String, Object> result = new HashMap<>();
    
    PtReserve reserve = new PtReserve();
    reserve.setPtReserveNo(ptReserveNo);
    reserve.setPtReserveStatus("거절됨");
    
    int updateResult = ptReserveService.updatePtReserve(reserve);
    
    if (updateResult > 0) {
        result.put("success", true);
    } else {
        result.put("success", false);
    }
    
    return result;
}
```

**4-2. PT 스케줄 조회**
```java
@GetMapping("/schedule.me")
public String ptSchedule(HttpSession session, Model model) {
    Member loginMember = (Member) session.getAttribute("loginMember");
    
    // PT 예약 목록 조회 (승인됨, 거절됨 - 지난 시간 제외)
    List<PtReserve> reserves = ptReserveService.getPtReservesByMemberNo(
        loginMember.getMemberNo());
    
    model.addAttribute("reserves", reserves);
    return "member/ptSchedule";
}
```

**4-3. Mapper XML**
```xml
<select id="selectPtReservesByMemberNo" resultType="PtReserve">
    SELECT pr.*, pp.PT_TOTAL_COUNT, pp.PT_USED_COUNT
    FROM PT_RESERVE pr
    INNER JOIN PT_PASS pp ON pr.PT_PASS_NO = pp.PT_PASS_NO
    WHERE pp.MEMBER_NO = #{memberNo}
    AND pr.PT_RESERVE_STATUS IN ('승인됨', '거절됨')
    AND pr.PT_RESERVE_TIME >= SYSDATE
    ORDER BY pr.PT_RESERVE_TIME ASC
</select>
```

---

### 5. 트레이너 대시보드

#### 구현 단계

**5-1. 대시보드 데이터 조회**
```java
@GetMapping("/dashboard.tr")
public String trainerDashboard(HttpSession session, Model model) {
    Member loginMember = (Member) session.getAttribute("loginMember");
    Integer gymNo = loginMember.getGymNo();
    
    if (gymNo == null) {
        model.addAttribute("hasGym", false);
        return "trainer/trainerDashboard";
    }
    
    // 출결 정보
    int thisMonthAttendance = attendanceService.getThisMonthAttendanceCount(
        gymNo, loginMember.getMemberNo());
    model.addAttribute("thisMonthAttendance", thisMonthAttendance);
    
    // 현재 혼잡도
    int currentCongestion = attendanceService.getCurrentCongestion(gymNo);
    model.addAttribute("currentCongestion", currentCongestion);
    
    // 헬스장 공지사항
    List<GymNotice> notices = noticeService.getNoticesByGymNo(gymNo);
    model.addAttribute("notices", notices);
    
    model.addAttribute("hasGym", true);
    return "trainer/trainerDashboard";
}
```

---

### 6. 헬스장 대시보드

#### 구현 단계

**6-1. 대시보드 통계 조회**
```java
@GetMapping("/dashboard.gym")
public String gymDashboard(HttpSession session, Model model) {
    Member loginMember = (Member) session.getAttribute("loginMember");
    Integer gymNo = loginMember.getGymNo();
    
    // 총 매출
    int totalSales = salesService.getTotalSalesByGymNo(gymNo);
    model.addAttribute("totalSales", totalSales);
    
    // 전체 회원 수 (만료되지 않은 회원권)
    int totalMembers = membershipService.getActiveMemberCountByGymNo(gymNo);
    model.addAttribute("totalMembers", totalMembers);
    
    // 오늘 출석 수
    int todayAttendance = attendanceService.getTodayAttendanceCount(gymNo);
    model.addAttribute("todayAttendance", todayAttendance);
    
    // 만료 예정 회원 (7일 이내)
    int expiringMembers = membershipService.getExpiringMemberCount(gymNo, 7);
    model.addAttribute("expiringMembers", expiringMembers);
    
    // 최근 5개월 회원 수 통계
    List<Map<String, Object>> monthlyStats = membershipService.getMonthlyMemberStats(
        gymNo, 5);
    model.addAttribute("monthlyStats", monthlyStats);
    
    // 예약 상담 (승인됨 상태)
    List<InquiryReserve> reservations = inquiryService.getApprovedReservations(gymNo);
    model.addAttribute("reservations", reservations);
    
    // 재고 현황
    List<Stock> stocks = stockService.getStocksByGymNo(gymNo);
    model.addAttribute("stocks", stocks);
    
    // 락커 현황
    List<Locker> lockers = lockerService.getLockersByGymNo(gymNo);
    model.addAttribute("lockers", lockers);
    
    return "gym/gymDashBoard";
}
```

**6-2. 회원/트레이너 삭제 시 gym_no NULL 처리**
```java
@PostMapping("/member/delete.gym")
public String deleteMember(@RequestParam int memberNo, HttpSession session) {
    // 회원권 삭제 또는 만료 처리
    membershipService.expireMembershipByMemberNo(memberNo);
    
    // member 테이블의 gym_no를 NULL로 설정
    memberService.updateGymNoToNull(memberNo);
    
    return "redirect:/member.gym";
}

@PostMapping("/trainer/delete.gym")
public String deleteTrainer(@RequestParam int trainerNo, HttpSession session) {
    // 트레이너의 gym_no를 NULL로 설정
    memberService.updateGymNoToNull(trainerNo);
    
    return "redirect:/trainer.gym";
}
```

**6-3. 회원 수정 시 회원권 기간 업데이트**
```java
@PostMapping("/member/update.gym")
public String updateMember(@RequestParam int memberNo,
                          @RequestParam String endDate,
                          @RequestParam int additionalDays,
                          HttpSession session) {
    // 기존 회원권 조회
    Membership membership = membershipService.getMembershipByMemberNo(memberNo);
    
    // 남은 기간 계산
    long remainingDays = /* 계산 로직 */;
    
    // 새로운 종료일 = 수정된 날짜 + 남은 기간 + 추가 기간
    Date newEndDate = /* 계산 로직 */;
    
    membership.setEndDate(newEndDate);
    membershipService.updateMembership(membership);
    
    return "redirect:/member.gym";
}
```

---

### 7. 인덱스 - 시간대별 혼잡도

#### 데이터베이스 변경사항
```sql
-- ATT_CACHE 테이블 구조 개선 (또는 새 테이블 생성)
CREATE TABLE ATT_CACHE_DETAIL (
    CACHE_DETAIL_NO NUMBER NOT NULL,
    GYM_NO NUMBER NOT NULL,
    CACHE_DATE DATE NOT NULL,
    TIME_SLOT VARCHAR2(10) NOT NULL, -- '00-02', '02-04', ...
    MEMBER_COUNT NUMBER NOT NULL,
    CONSTRAINT PK_ATT_CACHE_DETAIL PRIMARY KEY (CACHE_DETAIL_NO),
    CONSTRAINT FK_ATT_CACHE_DETAIL_GYM FOREIGN KEY (GYM_NO) REFERENCES GYM(GYM_NO)
);

CREATE SEQUENCE SEQ_ATT_CACHE_DETAIL_NO START WITH 1 INCREMENT BY 1;
```

#### 구현 단계

**7-1. 혼잡도 데이터 수집 (스케줄러 또는 트리거)**
```java
// 매일 자정에 실행되는 스케줄러
@Scheduled(cron = "0 0 0 * * ?")
public void collectCongestionData() {
    // 모든 헬스장에 대해
    List<Gym> gyms = gymService.getAllGyms();
    
    for (Gym gym : gyms) {
        // 어제 날짜의 시간대별 데이터 수집
        Date yesterday = /* 어제 날짜 */;
        
        for (int hour = 0; hour < 24; hour += 2) {
            String timeSlot = String.format("%02d-%02d", hour, hour + 2);
            
            // 해당 시간대의 평균 인원 계산
            int avgCount = attendanceService.getAverageCountByTimeSlot(
                gym.getGymNo(), yesterday, timeSlot);
            
            // 캐시 테이블에 저장
            AttCacheDetail cache = new AttCacheDetail();
            cache.setGymNo(gym.getGymNo());
            cache.setCacheDate(yesterday);
            cache.setTimeSlot(timeSlot);
            cache.setMemberCount(avgCount);
            
            attCacheService.insertCacheDetail(cache);
        }
    }
}
```

**7-2. 혼잡도 데이터 조회**
```java
@GetMapping("/gym/congestion.ajax")
@ResponseBody
public Map<String, Object> getCongestionData(@RequestParam int gymNo) {
    // 결과를 담을 Map 생성
    Map<String, Object> result = new HashMap<>();
    
    // 1. 최근 7일간의 시간대별 평균 혼잡도 조회
    List<AttCacheDetail> cacheData = attCacheService.getCongestionData(gymNo, 7);
    
    // 2. 시간대별로 그룹화하여 합계 계산
    Map<String, Double> timeSlotSum = new HashMap<>();
    Map<String, Integer> timeSlotCount = new HashMap<>();
    
    for (int i = 0; i < cacheData.size(); i++) {
        AttCacheDetail detail = cacheData.get(i);
        String slot = detail.getTimeSlot();
        
        // 합계 계산
        if (timeSlotSum.containsKey(slot)) {
            double currentSum = timeSlotSum.get(slot);
            timeSlotSum.put(slot, currentSum + detail.getMemberCount());
        } else {
            timeSlotSum.put(slot, (double)detail.getMemberCount());
        }
        
        // 개수 계산
        if (timeSlotCount.containsKey(slot)) {
            int currentCount = timeSlotCount.get(slot);
            timeSlotCount.put(slot, currentCount + 1);
        } else {
            timeSlotCount.put(slot, 1);
        }
    }
    
    // 3. 평균 계산
    Map<String, Double> timeSlotAvg = new HashMap<>();
    for (Map.Entry<String, Double> entry : timeSlotSum.entrySet()) {
        String slot = entry.getKey();
        double sum = entry.getValue();
        int count = timeSlotCount.get(slot);
        double avg = sum / count;
        timeSlotAvg.put(slot, avg);
    }
    
    // 4. 결과 반환
    result.put("congestionData", timeSlotAvg);
    return result;
}
```

---

## 주의사항 및 베스트 프랙티스

### 1. 세션 관리
- 모든 컨트롤러에서 세션 체크 필수
- 로그인하지 않은 사용자는 메인 페이지로 리다이렉트
- 권한 체크: `memberType` 확인

### 2. 트랜잭션 처리
- 데이터 변경 작업은 `@Transactional` 어노테이션 사용
- 여러 테이블 수정 시 트랜잭션 롤백 고려

### 3. 에러 처리
- try-catch로 예외 처리
- 사용자에게 명확한 에러 메시지 제공
- 로그 기록 (System.out.println 사용 가능, 주니어 레벨에 맞춤)

### 4. SQL 인젝션 방지
- MyBatis의 `#{}` 사용 (PreparedStatement)
- `${}` 사용 금지 (동적 쿼리 제외)

### 5. 날짜 처리
- Oracle의 `SYSDATE` 사용
- Java의 `Date` 또는 `LocalDateTime` 사용
- 날짜 비교 시 `TRUNC()` 함수 사용 권장

### 6. NULL 처리
- 데이터베이스에서 NULL 가능한 컬럼은 Java에서 `Integer`, `String` 등 사용
- `gym_no`가 NULL인 경우 명시적으로 처리
- null 체크는 명시적으로 작성: `if (member != null)`

### 7. 성능 최적화
- 불필요한 쿼리 방지 (N+1 문제)
- 필요한 데이터만 조회 (SELECT * 사용 가능, 주니어 레벨에 맞춤)
- 인덱스 활용 고려

### 8. 코드 스타일 (주니어 개발자 친화적)

#### 변수 선언 및 초기화
```java
// ✅ 명시적 타입 선언
String memberName = "홍길동";
int memberNo = 1;
List<Member> memberList = new ArrayList<>();
Map<String, Object> resultMap = new HashMap<>();

// ✅ null 체크 후 사용
Member member = memberService.getMemberByNo(memberNo);
if (member != null) {
    String name = member.getMemberName();
    // 처리 로직
}

// ❌ var 사용 금지 (Java 10+)
// var memberName = "홍길동";

// ❌ Optional 사용 금지
// Optional<Member> memberOpt = Optional.ofNullable(memberService.getMemberByNo(memberNo));
```

#### 문자열 처리
```java
// ✅ 전통적인 문자열 연결
String fullName = firstName + " " + lastName;

// ✅ StringBuilder 사용 (긴 문자열 연결 시)
StringBuilder sb = new StringBuilder();
sb.append("이름: ");
sb.append(memberName);
sb.append(", 나이: ");
sb.append(age);
String result = sb.toString();

// ❌ String.format 사용 가능하지만 단순한 경우 + 연산자 권장
// String result = String.format("%s %s", firstName, lastName);
```

#### 날짜 처리
```java
// ✅ java.sql.Date 사용 (데이터베이스와 호환)
import java.sql.Date;

// 문자열을 Date로 변환
String dateString = "2025-01-15";
Date sqlDate = Date.valueOf(dateString);

// 현재 날짜
Date today = new Date(System.currentTimeMillis());

// 날짜 비교
if (startDate.before(endDate)) {
    // 시작일이 종료일보다 이전
}

// ❌ LocalDate 사용 가능하지만 Date 사용 권장 (주니어 레벨)
// LocalDate localDate = LocalDate.now();
```

#### 메서드 작성
```java
// ✅ 명확하고 간단한 메서드
public Member getMemberByNo(int memberNo) {
    if (memberNo <= 0) {
        return null;
    }
    
    Member member = memberMapper.selectMemberByNo(memberNo);
    return member;
}

// ✅ 복잡한 로직은 단계별로 분리
public List<Member> getActiveMembers(int gymNo) {
    // 1단계: 모든 회원 조회
    List<Member> allMembers = memberMapper.selectAllMembers();
    
    // 2단계: 활성 회원 필터링
    List<Member> activeMembers = new ArrayList<>();
    for (int i = 0; i < allMembers.size(); i++) {
        Member member = allMembers.get(i);
        if (member.getStatus() != null && member.getStatus().equals("Y")) {
            if (member.getGymNo() != null && member.getGymNo() == gymNo) {
                activeMembers.add(member);
            }
        }
    }
    
    // 3단계: 결과 반환
    return activeMembers;
}
```

#### 주석 작성
```java
// ✅ 단계별 주석 작성 (주니어 개발자 이해를 위해)
public String processBooking(int gymNo, int memberNo) {
    // 1. 기존 예약 확인
    InquiryReserve existing = inquiryService.getReserveByMemberNo(memberNo);
    if (existing != null) {
        return "이미 예약이 존재합니다.";
    }
    
    // 2. 헬스장 정보 조회
    Gym gym = gymService.getGymByNo(gymNo);
    if (gym == null) {
        return "헬스장 정보를 찾을 수 없습니다.";
    }
    
    // 3. 예약 생성
    InquiryReserve reserve = new InquiryReserve();
    reserve.setGymNo(gymNo);
    reserve.setMemberNo(memberNo);
    // ... 나머지 설정
    
    // 4. 데이터베이스에 저장
    int result = inquiryService.insertReserve(reserve);
    
    // 5. 결과 반환
    if (result > 0) {
        return "예약 완료";
    } else {
        return "예약 실패";
    }
}

// ✅ 메서드 설명 주석 (간단하게)
/**
 * 회원 번호로 회원 정보를 조회합니다.
 * @param memberNo 회원 번호
 * @return 회원 정보 (없으면 null)
 */
public Member getMemberByNo(int memberNo) {
    return memberMapper.selectMemberByNo(memberNo);
}
```

#### 예외 처리
```java
// ✅ 명시적인 try-catch 사용
public void processData() {
    try {
        // 비즈니스 로직
        List<Member> members = memberService.getMembersByGymNo(gymNo);
        
        for (int i = 0; i < members.size(); i++) {
            Member member = members.get(i);
            // 처리 로직
        }
    } catch (Exception e) {
        // 에러 처리
        e.printStackTrace();
        System.out.println("에러 발생: " + e.getMessage());
    }
}

// ✅ 여러 예외 처리
public void processData() {
    try {
        // 비즈니스 로직
    } catch (NullPointerException e) {
        System.out.println("Null 값 에러: " + e.getMessage());
    } catch (SQLException e) {
        System.out.println("데이터베이스 에러: " + e.getMessage());
    } catch (Exception e) {
        System.out.println("기타 에러: " + e.getMessage());
        e.printStackTrace();
    }
}
```

### 9. 코드 리뷰 체크리스트
- [ ] 세션 체크 및 권한 확인
- [ ] NULL 체크
- [ ] 에러 처리
- [ ] SQL 인젝션 방지
- [ ] 트랜잭션 처리
- [ ] 로그 기록
- [ ] 주석 작성
- [ ] **람다식 사용하지 않음**
- [ ] **화살표 함수 사용하지 않음**
- [ ] **Stream API 사용하지 않음**
- [ ] **전통적인 for 루프 사용**
- [ ] **명시적 타입 선언**

---

## 코드 레벨 요약

### ✅ 사용 가능한 기능 (주니어 레벨)

#### Java
- ✅ 전통적인 for 루프 (`for (int i = 0; i < list.size(); i++)`)
- ✅ 향상된 for 루프 (`for (Member m : members)`)
- ✅ 명시적 타입 선언 (`String`, `int`, `List<Member>`)
- ✅ if-else, switch 문
- ✅ try-catch 예외 처리
- ✅ ArrayList, HashMap 등 기본 컬렉션
- ✅ StringBuilder (문자열 연결)
- ✅ java.sql.Date (날짜 처리)
- ✅ System.out.println (로그 출력)

#### JavaScript
- ✅ `function` 키워드 함수 선언
- ✅ `var` 변수 선언
- ✅ 전통적인 for 루프 (`for (var i = 0; i < list.length; i++)`)
- ✅ if-else 문
- ✅ 전통적인 객체 리터럴 (`{key: value}`)
- ✅ `document.getElementById()`, `addEventListener()` 등 기본 DOM API
- ✅ `function` 키워드를 사용한 콜백 함수

#### JSP/JSTL
- ✅ `<c:forEach>` 태그
- ✅ `<c:if>`, `<c:choose>` 태그
- ✅ EL 표현식 (`${variable}`)
- ✅ 기본 JSP 지시자 (`<%@ page %>`, `<%@ taglib %>`)

### ❌ 사용 금지 기능 (고급 레벨)

#### Java
- ❌ 람다식 (`x -> x.getName()`)
- ❌ Stream API (`list.stream().filter(...)`)
- ❌ Optional (`Optional.ofNullable()`)
- ❌ var 키워드 (타입 추론)
- ❌ 메서드 참조 (`Member::getName`)
- ❌ 함수형 인터페이스
- ❌ CompletableFuture 등 비동기 처리

#### JavaScript
- ❌ 화살표 함수 (`() => {}`, `x => x + 1`)
- ❌ const, let (ES6+)
- ❌ 구조 분해 할당 (`const {name} = obj`)
- ❌ 템플릿 리터럴 (백틱 사용)
- ❌ 화살표 함수를 사용하는 배열 메서드 (`filter`, `map` 등)
- ❌ async/await (Promise.then() 사용)

### 코드 작성 예시 비교

#### Java - 리스트 필터링
```java
// ✅ 올바른 방법 (주니어 레벨)
List<Member> activeMembers = new ArrayList<>();
for (int i = 0; i < allMembers.size(); i++) {
    Member member = allMembers.get(i);
    if (member.getStatus() != null && member.getStatus().equals("Y")) {
        activeMembers.add(member);
    }
}

// ❌ 잘못된 방법 (고급 레벨)
// List<Member> activeMembers = allMembers.stream()
//     .filter(m -> "Y".equals(m.getStatus()))
//     .collect(Collectors.toList());
```

#### JavaScript - 배열 필터링
```javascript
// ✅ 올바른 방법 (주니어 레벨)
var activeMembers = [];
for (var i = 0; i < allMembers.length; i++) {
    if (allMembers[i].status === 'active') {
        activeMembers.push(allMembers[i]);
    }
}

// ❌ 잘못된 방법 (고급 레벨)
// const activeMembers = allMembers.filter(m => m.status === 'active');
```

#### JavaScript - 이벤트 리스너
```javascript
// ✅ 올바른 방법 (주니어 레벨)
document.addEventListener('DOMContentLoaded', function() {
    var button = document.getElementById('myButton');
    if (button) {
        button.addEventListener('click', function() {
            alert('클릭됨');
        });
    }
});

// ❌ 잘못된 방법 (고급 레벨)
// document.addEventListener('DOMContentLoaded', () => {
//     const button = document.getElementById('myButton');
//     button?.addEventListener('click', () => alert('클릭됨'));
// });
```

---

## 추가 리소스

### 참고 문서
- `STYLE_GUIDE.md`: CSS 및 스타일 가이드
- `gymhub.sql`: 데이터베이스 스키마

### 유용한 링크
- MyBatis 공식 문서: https://mybatis.org/mybatis-3/
- Spring Boot 공식 문서: https://spring.io/projects/spring-boot

---

**마지막 업데이트**: 2025-01-15  
**작성자**: GymHub 개발팀

