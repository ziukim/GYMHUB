# GymHub 스타일 가이드

## 개요
GymHub 프로젝트의 스타일 관리 규칙입니다.
- **공통 스타일**: `common.css`에 정의 (모든 페이지에서 공통 사용)
- **페이지별 스타일**: 각 JSP 파일의 `<style>` 태그 내에 정의 (해당 페이지에서만 사용)

---

## 스타일 관리 원칙

### ✅ 올바른 방법

1. **공통 스타일은 `common.css`에 정의**
   - 모든 페이지에서 공통으로 사용되는 컴포넌트 스타일
   - 레이아웃, 사이드바, 기본 카드, 버튼, 폼 등
   - 프로젝트 전체에서 재사용 가능한 스타일

2. **페이지별 스타일은 각 JSP 파일의 `<style>` 태그에 정의**
   - 특정 페이지에서만 사용되는 고유한 스타일
   - 인덱스 페이지의 헤더, 히어로 섹션, 검색 UI 등
   - 해당 페이지에서만 필요한 모달 스타일
   - 페이지 고유 레이아웃 및 특수 컴포넌트

### ❌ 잘못된 방법

- 페이지별 스타일을 `common.css`에 추가하는 것
- 공통 스타일을 각 JSP 파일에 중복 정의하는 것
- 인라인 스타일 사용 (특별한 경우 제외)

---

## 프로젝트 구조

```
webapp/
├── resources/
│   ├── css/
│   │   └── common.css         # 공통 스타일만 포함
│   └── images/
│       └── icon/
│           ├── calendar.png
│           ├── campaign.png
│           ├── home.png
│           ├── logo.png
│           ├── output.png
│           └── person.png
│
└── WEB-INF/
    └── views/
        ├── index.jsp           # <style> 태그로 페이지별 스타일 포함
        ├── attendance/
        │   └── attendance.jsp
        ├── booking/
        │   ├── booking.jsp
        │   └── bookingWithoutLogin.jsp
        ├── board/
        │   ├── salesBoard.jsp
        │   └── stockBoard.jsp
        ├── common/
        │   ├── modal.html
        │   └── sidebar/
        │       ├── sidebarGym.html
        │       ├── sidebarMember.html
        │       └── sidebarTrainer.html
        ├── facility/
        │   ├── facilitiesBoard.jsp
        │   └── machineEnrollForm.jsp
        ├── gym/
        │   ├── gymBookingList.jsp
        │   ├── gymDashBoard.jsp
        │   ├── gymDetailUpdateForm.jsp
        │   ├── gymMemberManagement.jsp
        │   └── gymTrainerListView.jsp
        ├── member/
        │   ├── memberDashBoard.jsp
        │   └── memberInfo.jsp
        ├── notice/
        │   ├── noticeDetail.jsp
        │   ├── noticeEnrollForm.jsp
        │   ├── noticeListView.jsp
        │   └── noticeUpdateForm.jsp
        ├── pt/
        │   ├── ptBookingForm.jsp
        │   ├── ptManagement.jsp
        │   └── ptSchedule.jsp
        ├── trainer/
        └── video/
            └── videoList.jsp
```

---

## CSS 파일 배치 규칙

### 1. common.css 위치
```
webapp/resources/css/common.css
```

**common.css에 포함되는 스타일:**
- 기본 리셋 스타일
- 레이아웃 (app-container, main-content)
- 사이드바 관련 스타일
- 공통 카드 및 섹션
- 통계 카드
- 테이블 기본 스타일
- 공통 폼 스타일
- 공통 버튼 스타일
- 기본 모달 구조
- 배지 및 상태 표시
- 검색, 페이지네이션, 탭 등 공통 컴포넌트
- 유틸리티 클래스

**common.css에 포함하지 않는 스타일:**
- 특정 페이지의 고유 레이아웃 (예: index.jsp의 헤더, 히어로 섹션)
- 페이지별 모달 스타일 (예: index.jsp의 로그인/회원가입 모달, 헬스장 상세 모달)
- 페이지 고유 컴포넌트 (예: index.jsp의 검색 UI, 카드 그리드)

### 2. JSP 파일의 기본 구조

```jsp
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>페이지 제목</title>
    
    <!-- 1. Common CSS 링크 (필수, 먼저 로드) -->
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/common.css">
    
    <!-- 2. 구글 폰트 (선택) -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;700&family=ABeeZee&family=ADLaM+Display&display=swap" rel="stylesheet">
    
    <!-- 3. 페이지별 스타일 (필요시에만 추가) -->
    <style>
        /* 이 페이지에서만 사용하는 스타일 */
        .page-specific-header {
            /* ... */
        }
        
        .page-specific-modal {
            /* ... */
        }
        
        /* 반응형 스타일도 여기에 */
        @media (max-width: 768px) {
            /* ... */
        }
    </style>
</head>
<body>
    <!-- 페이지 내용 -->
</body>
</html>
```

### 3. 스타일 우선순위

1. **common.css** - 기본 스타일 (먼저 로드)
2. **페이지별 `<style>` 태그** - 특수 스타일 (나중에 로드되어 오버라이드 가능)

**중요:** common.css를 먼저 로드하고, 페이지별 스타일을 나중에 작성해야 오버라이드가 가능합니다.

---

## 실제 사용 예제

### 예제 1: index.jsp (페이지별 스타일 포함)

```jsp
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>GYMHub - 나에게 맞는 헬스 찾기</title>

    <!-- Common CSS 링크 (필수) -->
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/common.css">

    <!-- 구글 폰트 -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;700&family=ABeeZee&family=ADLaM+Display&display=swap" rel="stylesheet">
    
    <!-- Index 페이지 전용 스타일 -->
    <style>
        /* Index 페이지 전용 헤더 */
        header {
            background: linear-gradient(180deg, #3a2820 0%, #2a1810 100%);
            padding: 15px 40px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            border-bottom: 2px solid #ff6b00;
        }

        /* 히어로 섹션 */
        .hero {
            background: linear-gradient(180deg, #2a1810 0%, #000 100%);
            padding: 80px 40px;
            text-align: center;
        }

        /* Index 페이지 전용 모달 스타일 */
        .modal-overlay .modal-container {
            background: linear-gradient(180deg, #1a0f0a 0%, #0a0a0a 100%);
            /* ... */
        }

        /* 반응형 */
        @media (max-width: 768px) {
            .hero {
                padding: 40px 20px;
            }
        }
    </style>
</head>
<body>
    <!-- 페이지 내용 -->
</body>
</html>
```

### 예제 2: 일반 페이지 (common.css만 사용)

```jsp
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>회원 관리</title>

    <!-- Common CSS만 사용 (페이지별 스타일 불필요) -->
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/common.css">
</head>
<body>
    <div class="app-container">
        <div class="sidebar">
            <!-- 사이드바 (common.css 스타일 사용) -->
        </div>
        <div class="main-content">
            <div class="card">
                <!-- 카드 (common.css 스타일 사용) -->
            </div>
        </div>
    </div>
</body>
</html>
```

---

## 경로 설명

### contextPath란?
- 프로젝트의 루트 경로를 나타냄
- 배포 환경에 따라 자동으로 변경됨
- 예: `http://localhost:8080/gymhub` → contextPath는 `/gymhub`

### 올바른 경로 사용법

```jsp
<!-- ❌ 잘못된 방법 (하드코딩) -->
<link rel="stylesheet" href="/resources/css/common.css">
<img src="/resources/images/icon/logo.png">

<!-- ✅ 올바른 방법 (contextPath 사용) -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common.css">
<img src="${pageContext.request.contextPath}/resources/images/icon/logo.png">
```

**모든 위치에서 동일한 경로 사용!** contextPath가 자동으로 처리해줍니다.

---

## 색상표

| 용도 | 색상 코드 | 설명 |
|------|----------|------|
| 메인 배경 | `#0a0a0a` | 어두운 검정 |
| 카드 배경 | `#1a0f0a` | 밝은 검정 |
| 강조 배경 | `#2d1810` | 갈색 계열 |
| 주요 색상 | `#ff6b00` | 주황색 (강조) |
| 주요 색상 호버 | `#ff8533` | 주황색 (호버) |
| 보조 텍스트 | `#ffa366` | 밝은 주황 |
| 설명 텍스트 | `#b0b0b0` | 회색 |
| 설명 텍스트 2 | `#8a6a50` | 갈색 회색 |
| 구분선 | `#4a3020` | 어두운 갈색 |
| 오류/삭제 | `#ff5252` | 빨강 |
| 성공/정상 | `#4caf50` | 초록 |
| 경고 | `#ffc107` | 노랑 |

---

## common.css에 포함된 컴포넌트

### 레이아웃
```html
<div class="app-container">
    <div class="sidebar">...</div>
    <div class="main-content">...</div>
</div>
```

### 사이드바
```html
<div class="sidebar">
    <div class="logo-container">
        <div class="icon"><img src="logo.png"></div>
        <div class="logo-text">GymHub</div>
    </div>
    <div class="divider"></div>
    <nav class="sidebar-nav">
        <a href="#" class="nav-item active">대시보드</a>
        <a href="#" class="nav-item">회원관리</a>
        <button class="nav-button logout">로그아웃</button>
    </nav>
</div>
```

### 카드 & 섹션
```html
<!-- 기본 카드 -->
<div class="card">
    <h3>카드 제목</h3>
    <p>카드 내용</p>
</div>

<!-- 섹션 (헤더 포함) -->
<div class="section">
    <div class="section-header">
        <h2 class="section-title">섹션 제목</h2>
        <button class="add-button">추가</button>
    </div>
    <p class="section-text">내용</p>
</div>

<!-- 정보 카드 그리드 -->
<div class="info-cards">
    <div class="info-card">
        <div class="card-header">
            <h3>회원권</h3>
        </div>
        <p>만료일: 2025-12-31</p>
    </div>
</div>
```

### 통계
```html
<div class="stats-grid">
    <div class="stat-card">
        <div class="stat-card-label">총 회원</div>
        <div class="stat-card-value">245명</div>
        <div class="stat-card-sub">전월 대비 +12</div>
    </div>
</div>
```

### 테이블
```html
<table>
    <thead>
        <tr>
            <th>이름</th>
            <th>이메일</th>
            <th>상태</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>홍길동</td>
            <td>hong@example.com</td>
            <td><span class="status-badge status-normal">정상</span></td>
        </tr>
    </tbody>
</table>
```

### 폼
```html
<div class="form-grid">
    <div class="form-group">
        <label class="form-label">이름<span class="required">*</span></label>
        <input type="text">
    </div>
    <div class="form-group">
        <label class="form-label">이메일</label>
        <input type="email">
    </div>
    <div class="form-group full-width">
        <label class="form-label">주소</label>
        <input type="text">
    </div>
</div>

<!-- 체크박스 -->
<div class="checkbox-group">
    <label class="checkbox-item">
        <input type="checkbox">
        <span class="checkbox-label">옵션 1</span>
    </label>
</div>
```

### 버튼
```html
<button class="btn btn-primary">저장</button>
<button class="btn btn-secondary">취소</button>
<button class="add-button">추가하기</button>
<button class="edit-btn">수정</button>
<button class="delete-btn">삭제</button>

<div class="action-buttons">
    <button class="edit-btn">수정</button>
    <button class="delete-btn">삭제</button>
</div>

<div class="button-group">
    <button class="btn btn-secondary">취소</button>
    <button class="btn btn-primary">확인</button>
</div>
```

### 모달 (기본 구조)
```html
<div class="modal-overlay" id="myModal">
    <div class="modal-container">
        <div class="modal-header">
            <h2 class="modal-title">제목</h2>
            <button class="modal-close" onclick="closeModal()">×</button>
        </div>
        <div class="modal-body">
            <div class="modal-form-group">
                <label class="modal-label">이름</label>
                <input type="text" class="modal-input">
            </div>
        </div>
        <div class="modal-footer">
            <button class="btn btn-secondary">취소</button>
            <button class="btn btn-primary">확인</button>
        </div>
    </div>
</div>

<script>
// 모달 열기
document.getElementById('myModal').classList.add('active');
// 모달 닫기
document.getElementById('myModal').classList.remove('active');
</script>
```

**참고:** 모달의 세부 스타일(배경색, 크기, 특수 레이아웃 등)은 페이지별로 다를 수 있으므로 각 JSP 파일의 `<style>` 태그에 정의합니다.

### 배지
```html
<span class="badge">일반</span>
<span class="status-badge status-normal">정상</span>
<span class="status-badge status-warning">경고</span>
<span class="status-badge status-danger">위험</span>
```

### 검색, 페이지네이션, 탭
```html
<!-- 검색 -->
<div class="search-area">
    <input type="text" class="search-input" placeholder="검색...">
    <button class="search-btn">검색</button>
</div>

<!-- 페이지네이션 -->
<div class="pagination">
    <button class="btn btn-primary">< 이전</button>
    <button class="btn btn-secondary">1</button>
    <button class="btn btn-primary active">2</button>
    <button class="btn btn-primary">다음 ></button>
</div>

<!-- 탭 -->
<div class="tabs">
    <button class="tab-button active">탭1</button>
    <button class="tab-button">탭2</button>
</div>
<div class="tab-content active">탭1 내용</div>
<div class="tab-content">탭2 내용</div>
```

### 프로그레스 바
```html
<div class="progress-bar">
    <div class="progress-fill" style="width: 60%"></div>
</div>
```

### 이미지 업로드
```html
<div class="image-upload-area" onclick="document.getElementById('file').click()">
    <div class="upload-icon">📷</div>
    <div class="upload-text">클릭하여 이미지 업로드</div>
    <div class="upload-subtext">JPG, PNG (최대 5MB)</div>
</div>
<input type="file" id="file" class="hidden">
```

### 달력 팝업 (공통)
```html
<!-- 날짜 입력 필드 -->
<input type="text" class="date-input-field" id="dateInput" placeholder="날짜를 선택하세요" readonly onclick="openCalendar()">

<!-- 달력 팝업 -->
<div class="calendar-overlay" id="calendarOverlay" onclick="closeCalendarOnOverlay(event)">
    <div class="calendar-popup" onclick="event.stopPropagation()">
        <div class="calendar-header">
            <button type="button" class="calendar-nav-btn" onclick="prevMonth()">◀</button>
            <div class="calendar-month" id="calendarMonth"></div>
            <button type="button" class="calendar-nav-btn" onclick="nextMonth()">▶</button>
        </div>

        <div class="calendar-weekdays">
            <div class="calendar-weekday">일</div>
            <div class="calendar-weekday">월</div>
            <div class="calendar-weekday">화</div>
            <div class="calendar-weekday">수</div>
            <div class="calendar-weekday">목</div>
            <div class="calendar-weekday">금</div>
            <div class="calendar-weekday">토</div>
        </div>

        <div class="calendar-days" id="calendarDays"></div>

        <button type="button" class="calendar-close-btn" onclick="closeCalendar()">확인</button>
    </div>
</div>

<script>
    let currentMonth = new Date();
    let tempSelectedDate = null;
    let selectedDate = null;

    // 달력 열기
    function openCalendar() {
        document.getElementById('calendarOverlay').classList.add('show');
        renderCalendar();
    }

    // 달력 닫기
    function closeCalendar() {
        document.getElementById('calendarOverlay').classList.remove('show');
        if (tempSelectedDate) {
            selectedDate = tempSelectedDate;
            updateDateDisplay();
        }
    }

    // 오버레이 클릭 시 닫기
    function closeCalendarOnOverlay(event) {
        if (event.target === event.currentTarget) {
            closeCalendar();
        }
    }

    // 이전 달
    function prevMonth() {
        currentMonth.setMonth(currentMonth.getMonth() - 1);
        renderCalendar();
    }

    // 다음 달
    function nextMonth() {
        currentMonth.setMonth(currentMonth.getMonth() + 1);
        renderCalendar();
    }

    // 달력 렌더링
    function renderCalendar() {
        const year = currentMonth.getFullYear();
        const month = currentMonth.getMonth();

        document.getElementById('calendarMonth').textContent =
            year + '년 ' + (month + 1) + '월';

        const firstDay = new Date(year, month, 1).getDay();
        const daysInMonth = new Date(year, month + 1, 0).getDate();
        const today = new Date();

        const daysContainer = document.getElementById('calendarDays');
        daysContainer.innerHTML = '';

        // 빈 칸 채우기
        for (let i = 0; i < firstDay; i++) {
            const emptyDay = document.createElement('div');
            daysContainer.appendChild(emptyDay);
        }

        // 날짜 채우기
        for (let day = 1; day <= daysInMonth; day++) {
            const dayElement = document.createElement('div');
            dayElement.className = 'calendar-day';
            dayElement.textContent = day;

            const currentDate = new Date(year, month, day);

            // 과거 날짜는 비활성화
            if (currentDate < new Date(today.getFullYear(), today.getMonth(), today.getDate())) {
                dayElement.classList.add('disabled');
            } else {
                // 선택된 날짜 표시
                if (tempSelectedDate &&
                    tempSelectedDate.getDate() === day &&
                    tempSelectedDate.getMonth() === month &&
                    tempSelectedDate.getFullYear() === year) {
                    dayElement.classList.add('selected');
                }

                dayElement.onclick = function() {
                    document.querySelectorAll('.calendar-day.selected').forEach(d => {
                        d.classList.remove('selected');
                    });
                    this.classList.add('selected');
                    tempSelectedDate = new Date(year, month, day);
                };
            }

            daysContainer.appendChild(dayElement);
        }
    }

    // 날짜 표시 업데이트
    function updateDateDisplay() {
        if (selectedDate) {
            const year = selectedDate.getFullYear();
            const month = String(selectedDate.getMonth() + 1).padStart(2, '0');
            const day = String(selectedDate.getDate()).padStart(2, '0');

            const dateString = year + '-' + month + '-' + day;
            document.getElementById('dateInput').value = dateString;
        }
    }
</script>
```

**참고:** 
- 여러 달력을 사용하는 경우 ID와 함수명을 고유하게 변경하세요 (예: `startDateCalendar`, `endDateCalendar`)
- 과거 날짜 비활성화 기능이 기본으로 포함되어 있습니다
- 스타일은 common.css에 정의되어 있으므로 별도 CSS 작성이 필요 없습니다

### 유틸리티 클래스
```html
<!-- 텍스트 정렬 -->
<p class="text-center">중앙 정렬</p>
<p class="text-left">좌측 정렬</p>
<p class="text-right">우측 정렬</p>

<!-- 텍스트 색상 -->
<span class="text-primary">주황색</span>
<span class="text-secondary">밝은 주황</span>
<span class="text-muted">회색</span>
<span class="text-danger">빨강</span>
<span class="text-success">초록</span>

<!-- 간격 -->
<div class="mb-8">아래 여백 8px</div>
<div class="mb-16">아래 여백 16px</div>
<div class="mb-24">아래 여백 24px</div>
<div class="mb-32">아래 여백 32px</div>
<div class="mt-16">위 여백 16px</div>
<div class="mt-24">위 여백 24px</div>

<!-- Flexbox -->
<div class="flex items-center justify-between gap-16">
    <div>왼쪽</div>
    <div>오른쪽</div>
</div>
<div class="flex flex-col gap-8">
    <div>위</div>
    <div>아래</div>
</div>

<!-- 기타 -->
<div class="hidden">숨김</div>
```

---

## HTML → JSP 변환 가이드

### 변환 규칙

1. **공통 스타일은 common.css 클래스로 변경**
   - HTML의 `<style>` 태그에서 공통 컴포넌트 스타일 제거
   - common.css에 정의된 클래스 사용

2. **페이지별 스타일은 JSP의 `<style>` 태그에 유지**
   - 해당 페이지에서만 사용되는 고유 스타일
   - 페이지 특정 레이아웃 및 모달 스타일

3. **JSP 기능 추가**
   - 반복 데이터는 `<c:forEach>`로 변환
   - 조건부 내용은 `<c:if>`, `<c:choose>`로 변환
   - 링크 경로는 나중에 컨트롤러 매핑에 맞춰 설정 (선택사항)
   - JSP 지시자와 JSTL 선언 추가

### AI에게 요청하는 방법

```
이 HTML을 JSP로 변환해주세요.

변환 규칙:
1. 공통 스타일은 common.css 클래스로 변경
2. 페이지별 고유 스타일은 JSP 파일의 <style> 태그에 유지
3. 반복 데이터는 <c:forEach>로 변환
4. 조건부 내용은 <c:if>로 변환
5. 링크 경로는 나중에 컨트롤러 매핑에 맞춰 설정 (선택사항)
6. JSP 지시자와 JSTL 선언 추가

첨부 파일:
- [변환할 HTML 파일]
- common.css
- STYLE_GUIDE.md (이 파일)
```

### 스타일 매핑표

| HTML 스타일 | common.css 클래스 | 비고 |
|------------|------------------|------|
| 사이드바 전체 | `.sidebar` | 공통 |
| 로고 영역 | `.logo-container` + `.logo-text` | 공통 |
| 네비게이션 메뉴 | `.sidebar-nav` + `.nav-item` | 공통 |
| 메인 콘텐츠 | `.main-content` | 공통 |
| 카드 | `.card` 또는 `.section` | 공통 |
| 통계 카드 | `.stats-grid` + `.stat-card` | 공통 |
| 테이블 | `<table>` (기본 스타일 자동 적용) | 공통 |
| 폼 | `.form-grid` + `.form-group` | 공통 |
| 버튼 (주황) | `.btn.btn-primary` | 공통 |
| 버튼 (테두리) | `.btn.btn-secondary` | 공통 |
| 기본 모달 구조 | `.modal-overlay` + `.modal-container` | 공통 |
| 달력 팝업 | `.calendar-overlay` + `.calendar-popup` | 공통 |
| 날짜 입력 필드 | `.date-input-field` | 공통 |
| 배지 | `.badge` 또는 `.status-badge` | 공통 |
| 페이지 헤더 | 페이지별 `<style>` 태그 | 페이지별 |
| 페이지 특수 레이아웃 | 페이지별 `<style>` 태그 | 페이지별 |
| 페이지별 모달 스타일 | 페이지별 `<style>` 태그 | 페이지별 |

---

## 변환 예제

### 예제 1: 사이드바 (common.css 사용)

**HTML (변환 전)**
```html
<div style="position: fixed; width: 255px; background: #1a0f0a; border-right: 1px solid #ff6b00;">
    <div style="padding: 24px;">GymHub</div>
    <a href="members.html">회원관리</a>
</div>
```

**JSP (변환 후)**
```jsp
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common.css">

<div class="sidebar">
    <div class="logo-container">
        <div class="logo-text">GymHub</div>
    </div>
    <nav class="sidebar-nav">
        <!-- 링크 경로는 나중에 컨트롤러 매핑에 맞춰 설정 -->
        <a href="#" class="nav-item">회원관리</a>
    </nav>
</div>
```

### 예제 2: 리스트 (common.css 테이블 사용)

**HTML (변환 전)**
```html
<table>
    <tr><td>제목1</td><td>작성자1</td></tr>
    <tr><td>제목2</td><td>작성자2</td></tr>
</table>
```

**JSP (변환 후)**
```jsp
<table>
    <thead>
        <tr>
            <th>제목</th>
            <th>작성자</th>
        </tr>
    </thead>
    <tbody>
        <c:forEach var="item" items="${list}">
            <tr>
                <td>${item.title}</td>
                <td>${item.writer}</td>
            </tr>
        </c:forEach>
    </tbody>
</table>
```

### 예제 3: 페이지별 스타일이 필요한 경우

**HTML (변환 전)**
```html
<style>
    .page-header {
        background: linear-gradient(180deg, #3a2820 0%, #2a1810 100%);
        padding: 15px 40px;
    }
    
    .page-specific-modal {
        max-width: 600px;
        background: #1a0f0a;
    }
</style>
```

**JSP (변환 후)**
```jsp
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>페이지 제목</title>
    
    <!-- Common CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common.css">
    
    <!-- 페이지별 스타일 -->
    <style>
        .page-header {
            background: linear-gradient(180deg, #3a2820 0%, #2a1810 100%);
            padding: 15px 40px;
        }
        
        .page-specific-modal {
            max-width: 600px;
            background: #1a0f0a;
        }
    </style>
</head>
<body>
    <!-- 내용 -->
</body>
</html>
```

---

## 주의사항

### ❌ 나쁜 예

```jsp
<!-- 1. 페이지별 스타일을 common.css에 추가 -->
<!-- common.css에 추가하면 안됨! -->
.page-specific-header {
    background: #1a0f0a;
}

<!-- 2. 공통 스타일을 각 페이지에 중복 정의 -->
<style>
    .card {
        background: #1a0f0a; /* 이미 common.css에 있음 */
    }
</style>

<!-- 3. contextPath 누락 -->
<a href="/page.do">링크</a>

<!-- 4. 인라인 스타일 남용 -->
<div style="background: #1a0f0a; padding: 20px;">
```

### ✅ 좋은 예

```jsp
<!-- 1. common.css에서 공통 클래스 사용 -->
<div class="card">내용</div>

<!-- 2. 페이지별 스타일은 <style> 태그에 -->
<style>
    .page-specific-layout {
        /* 이 페이지에서만 사용 */
    }
</style>

<!-- 3. contextPath 사용 -->
<a href="${pageContext.request.contextPath}/page.do">링크</a>

<!-- 4. common.css 클래스 활용 -->
<div class="card mb-24">
    <h3 class="section-title">제목</h3>
</div>
```

---

## JSTL 치트시트

```jsp
<!-- 조건문 -->
<c:if test="${조건}">내용</c:if>

<c:choose>
    <c:when test="${조건1}">내용1</c:when>
    <c:when test="${조건2}">내용2</c:when>
    <c:otherwise>기본</c:otherwise>
</c:choose>

<!-- 반복문 -->
<c:forEach var="item" items="${list}">
    ${item.name}
</c:forEach>

<c:forEach var="i" begin="1" end="10">
    ${i}
</c:forEach>

<!-- 변수 -->
<c:set var="변수" value="값" />
```

---

## 문제 해결

**Q: 스타일이 적용 안돼요**
```
1. CSS 파일 경로 확인
2. 클래스 이름 오타 확인
3. common.css를 먼저 로드했는지 확인
4. 페이지별 <style> 태그가 common.css 이후에 있는지 확인
5. 브라우저 캐시 삭제 (Ctrl+F5)
```

**Q: 어떤 스타일을 common.css에 넣어야 할까요?**
```
규칙:
- 여러 페이지에서 공통으로 사용되는 스타일 → common.css
- 특정 페이지에서만 사용되는 스타일 → 해당 JSP의 <style> 태그
```

**Q: 페이지별 스타일을 common.css에 추가해도 되나요?**
```
❌ 안됩니다!
- 페이지별 스타일은 반드시 해당 JSP 파일의 <style> 태그에 작성
- common.css는 프로젝트 전체 공통 스타일만 포함
```

**Q: 모바일에서 깨져요**
```
- common.css에 기본 반응형 스타일이 포함되어 있음 (768px, 1400px 브레이크포인트)
- 추가 조정이 필요하면 페이지별 <style> 태그에 미디어 쿼리 추가
```

---

## 요약

### 스타일 관리 원칙

1. **공통 스타일** → `common.css`
   - 모든 페이지에서 공통 사용
   - 레이아웃, 사이드바, 기본 컴포넌트 등

2. **페이지별 스타일** → 각 JSP 파일의 `<style>` 태그
   - 해당 페이지에서만 사용
   - 페이지 고유 레이아웃, 모달, 특수 컴포넌트

3. **로드 순서**
   - `common.css` 먼저 로드
   - 페이지별 `<style>` 태그 나중에 작성 (오버라이드 가능)

4. **경로 규칙** 
   - 웬만하면 `${pageContext.request.contextPath}` 사용
   - 하드코딩 경로는 가급적 사용에 주의할 것 (보안규칙에 어긋날 수 있음)

---

**마지막 업데이트:** 2025-01-15  
**프로젝트:** GymHub
