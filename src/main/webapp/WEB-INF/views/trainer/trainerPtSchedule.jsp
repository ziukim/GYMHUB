<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>PT 스케줄 관리 - GymHub</title>

    <!-- Common CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common.css">

    <style>
        /* trainerPtSchedule 전용 스타일 */
        .main-content {
            padding: 40px 40px 40px 20px;
        }

        /* Header */
        .pt-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 24px;
        }

        .pt-title-section {
            display: flex;
            align-items: center;
            gap: 16px;
        }

        .pt-title h1 {
            font-size: 32px;
            color: #ff6b00;
            margin-bottom: 4px;
        }

        .pt-title p {
            font-size: 14px;
            color: #b0b0b0;
        }

        /* 날짜 필터 스타일 */
        .date-filter-container {
            display: flex;
            align-items: center;
            gap: 12px;
            margin-bottom: 24px;
        }

        .date-selector {
            display: flex;
            align-items: center;
            gap: 12px;
            padding: 12px 16px;
            background-color: #2d1810;
            border: 2px solid #ff6b00;
            border-radius: 8px;
            cursor: pointer;
            transition: all 0.2s;
            flex: 1;
            max-width: 300px;
        }

        .date-selector:hover {
            border-color: #ff8533;
            background-color: #3a2a1f;
        }

        .date-text {
            flex: 1;
            color: #ffa366;
            font-size: 14px;
            font-weight: 500;
        }

        .filter-clear-btn {
            padding: 12px 20px;
            background-color: transparent;
            border: 2px solid #8a6a50;
            border-radius: 8px;
            color: #8a6a50;
            font-size: 14px;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.2s;
        }

        .filter-clear-btn:hover {
            border-color: #ff6b00;
            color: #ff6b00;
            background-color: rgba(255, 107, 0, 0.1);
        }

        /* PT 스케줄 카드 리스트 */
        .pt-schedule-list {
            display: flex;
            flex-direction: column;
            gap: 16px;
        }

        .pt-schedule-card {
            background-color: #1a0f0a;
            border: 2px solid #ff6b00;
            border-radius: 14px;
            padding: 25px;
            transition: all 0.3s;
            cursor: pointer;
        }

        .pt-schedule-card:hover {
            background-color: #2d1810;
            box-shadow: 0 0 20px rgba(255, 107, 0, 0.4);
            transform: translateY(-2px);
        }

        .pt-schedule-header {
            display: flex;
            align-items: center;
            gap: 12px;
            margin-bottom: 16px;
            padding-bottom: 16px;
            border-bottom: 1px solid #4a3020;
        }

        .user-icon {
            display: flex;
            align-items: center;
            justify-content: center;
            width: 40px;
            height: 40px;
            background-color: rgba(255, 107, 0, 0.1);
            border-radius: 50%;
        }

        .user-icon img {
            width: 24px;
            height: 24px;
        }

        .schedule-user-info {
            flex: 1;
        }

        .schedule-user-name {
            font-size: 18px;
            font-weight: 600;
            color: #ff6b00;
            margin-bottom: 4px;
        }

        .schedule-badge {
            padding: 4px 12px;
            border-radius: 8px;
            font-size: 12px;
            font-weight: 600;
            flex-shrink: 0;
        }

        .schedule-badge.approved {
            background-color: rgba(76, 175, 80, 0.2);
            border: 1px solid #4caf50;
            color: #4caf50;
        }

        .schedule-details {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 12px;
            margin-bottom: 12px;
        }

        .detail-item {
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .detail-icon {
            width: 16px;
            height: 16px;
            vertical-align: middle;
        }

        .detail-label {
            font-size: 12px;
            color: #b0b0b0;
        }

        .detail-value {
            font-size: 14px;
            color: #ffa366;
            font-weight: 500;
        }

        .schedule-time {
            flex: 1;
            font-size: 16px;
            font-weight: 600;
            color: #ffa366;
        }

        /* Empty State */
        .empty-state {
            text-align: center;
            padding: 60px 20px;
            color: #8a6a50;
            background-color: #1a0f0a;
            border: 1px solid #ff6b00;
            border-radius: 14px;
        }

        .empty-text {
            font-size: 16px;
        }

        /* 달력 팝업 스타일 */
        .calendar-overlay {
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background-color: rgba(0, 0, 0, 0.7);
            display: flex;
            justify-content: center;
            align-items: center;
            opacity: 0;
            visibility: hidden;
            transition: all 0.3s;
            z-index: 1100;
        }

        .calendar-overlay.show {
            opacity: 1;
            visibility: visible;
        }

        .calendar-popup {
            background-color: #1a0f0a;
            border: 2px solid #ff6b00;
            border-radius: 12px;
            padding: 24px;
            width: 90%;
            max-width: 400px;
            box-shadow: 0 0 30px rgba(255, 107, 0, 0.5);
        }

        .calendar-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }

        .calendar-nav-btn {
            background-color: transparent;
            border: 1px solid #ff6b00;
            color: #ff6b00;
            width: 36px;
            height: 36px;
            border-radius: 8px;
            cursor: pointer;
            font-size: 16px;
            transition: all 0.3s;
            display: flex;
            align-items: center;
            justify-content: center;
            font-family: 'Noto Sans KR', sans-serif;
        }

        .calendar-nav-btn:hover {
            background-color: #ff6b00;
            color: white;
        }

        .calendar-month {
            font-size: 18px;
            font-weight: bold;
            color: #ff6b00;
        }

        .calendar-weekdays {
            display: grid;
            grid-template-columns: repeat(7, 1fr);
            gap: 8px;
            margin-bottom: 12px;
        }

        .calendar-weekday {
            text-align: center;
            font-size: 14px;
            color: #ffa366;
            font-weight: 500;
            padding: 8px 0;
        }

        .calendar-days {
            display: grid;
            grid-template-columns: repeat(7, 1fr);
            gap: 8px;
        }

        .calendar-day {
            aspect-ratio: 1;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 8px;
            cursor: pointer;
            font-size: 14px;
            color: white;
            transition: all 0.3s;
            border: 1px solid transparent;
        }

        .calendar-day:hover:not(.disabled):not(.empty) {
            background-color: rgba(255, 107, 0, 0.2);
            border-color: #ff6b00;
        }

        .calendar-day.selected {
            background-color: #ff6b00;
            color: white;
            font-weight: bold;
        }

        .calendar-day.disabled {
            color: #666;
            cursor: not-allowed;
            opacity: 0.3;
        }

        .calendar-day.empty {
            cursor: default;
        }

        .calendar-day.other-month {
            color: #666;
            opacity: 0.5;
        }

        .calendar-day.current-month {
            color: white;
        }

        .calendar-day.today {
            border: 1px solid #ff6b00;
        }

        .calendar-close-btn {
            width: 100%;
            margin-top: 20px;
            padding: 12px;
            background-color: #ff6b00;
            border: none;
            border-radius: 8px;
            color: white;
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
            font-family: 'Noto Sans KR', sans-serif;
        }

        .calendar-close-btn:hover {
            background-color: #ff8500;
            box-shadow: 0 0 15px rgba(255, 107, 0, 0.4);
        }

        @media (max-width: 768px) {
            .schedule-details {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
<div class="app-container">
    <!-- Sidebar Include -->
    <jsp:include page="../common/sidebar/sidebarTrainer.jsp" />

    <!-- Main Content -->
    <div class="main-content">
        <!-- Header -->
        <div class="pt-header">
            <div class="pt-title-section">
                <div class="pt-title">
                    <h1>PT 스케줄 관리</h1>
                    <p>배정된 회원의 PT 스케줄을 관리하세요</p>
                </div>
            </div>
        </div>

        <!-- 날짜 필터 -->
        <div class="date-filter-container">
            <div class="date-selector" onclick="openDateCalendar()">
                <svg width="20" height="20" viewBox="0 0 20 20" fill="none">
                    <path d="M6.66667 1.66667V5" stroke="#8A6A50" stroke-width="1.66667" stroke-linecap="round" stroke-linejoin="round"/>
                    <path d="M13.3333 1.66667V5" stroke="#8A6A50" stroke-width="1.66667" stroke-linecap="round" stroke-linejoin="round"/>
                    <path d="M15.8333 3.33334H4.16667C3.24619 3.33334 2.5 4.07953 2.5 5V16.6667C2.5 17.5872 3.24619 18.3333 4.16667 18.3333H15.8333C16.7538 18.3333 17.5 17.5872 17.5 16.6667V5C17.5 4.07953 16.7538 3.33334 15.8333 3.33334Z" stroke="#8A6A50" stroke-width="1.66667" stroke-linecap="round" stroke-linejoin="round"/>
                    <path d="M2.5 8.33334H17.5" stroke="#8A6A50" stroke-width="1.66667" stroke-linecap="round" stroke-linejoin="round"/>
                </svg>
                <span class="date-text" id="selectedDateText">전체 날짜</span>
                <svg width="20" height="20" viewBox="0 0 20 20" fill="none">
                    <path d="M5 7.5L10 12.5L15 7.5" stroke="#8A6A50" stroke-width="1.66667" stroke-linecap="round" stroke-linejoin="round"/>
                </svg>
            </div>
            <button class="filter-clear-btn" id="clearDateFilter" onclick="clearDateFilter()" style="display: none;">필터 초기화</button>
        </div>

        <!-- PT 스케줄 리스트 -->
        <div class="pt-schedule-list" id="scheduleList">
            <c:choose>
                <c:when test="${not empty reserves}">
                    <c:forEach var="reserve" items="${reserves}">
                        <div class="pt-schedule-card">
                            <div class="pt-schedule-header">
                                <div class="user-icon">
                                    <img src="${pageContext.request.contextPath}/resources/images/icon/person.png" alt="회원">
                                </div>
                                <div class="schedule-user-info">
                                    <div class="schedule-user-name">${reserve.memberName}</div>
                                </div>
                                <span class="schedule-badge approved">승인됨</span>
                            </div>
                            <div class="schedule-details">
                                <div class="detail-item">
                                    <img src="${pageContext.request.contextPath}/resources/images/icon/calendar.png" alt="예약일" class="detail-icon">
                                    <span class="detail-label">예약일:</span>
                                    <span class="detail-value">${reserve.reserveDate}</span>
                                </div>
                                <div class="detail-item">
                                    <img src="${pageContext.request.contextPath}/resources/images/icon/clock.png" alt="예약시간" class="detail-icon">
                                    <span class="detail-label">예약시간:</span>
                                    <span class="detail-value">${reserve.reserveTime}</span>
                                </div>
                                <div class="detail-item">
                                    <img src="${pageContext.request.contextPath}/resources/images/icon/call.png" alt="전화번호" class="detail-icon">
                                    <span class="detail-label">전화번호:</span>
                                    <span class="detail-value">${empty reserve.memberPhone ? '-' : reserve.memberPhone}</span>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <div class="empty-state">
                        <div class="empty-text">배정된 PT 스케줄이 없습니다.</div>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</div>

<!-- 날짜 선택 달력 팝업 -->
<div class="calendar-overlay" id="dateCalendarOverlay" onclick="closeDateCalendarOnOverlay(event)">
    <div class="calendar-popup" onclick="event.stopPropagation()">
        <div class="calendar-header">
            <button type="button" class="calendar-nav-btn" onclick="prevDateMonth()">◀</button>
            <div class="calendar-month" id="dateCalendarMonth"></div>
            <button type="button" class="calendar-nav-btn" onclick="nextDateMonth()">▶</button>
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

        <div class="calendar-days" id="dateCalendarDays"></div>

        <button type="button" class="calendar-close-btn" onclick="closeDateCalendar()">확인</button>
    </div>
</div>

<script>
    // 전역 변수
    var contextPath = '${pageContext.request.contextPath}';
    var selectedFilterDate = null;
    var dateCurrentMonth = new Date();
    var dateTempSelected = null;

    // ========================================
    // 날짜 필터링 관련 함수
    // ========================================

    // 달력 열기
    function openDateCalendar() {
        dateTempSelected = selectedFilterDate ? new Date(selectedFilterDate) : null;
        renderDateCalendar();
        document.getElementById('dateCalendarOverlay').classList.add('show');
    }

    // 달력 닫기
    function closeDateCalendar() {
        if (dateTempSelected) {
            selectedFilterDate = new Date(dateTempSelected);
            updateDateFilterDisplay();
            filterByDate();
        }
        document.getElementById('dateCalendarOverlay').classList.remove('show');
    }

    // 오버레이 클릭 시 달력 닫기
    function closeDateCalendarOnOverlay(event) {
        if (event.target.id === 'dateCalendarOverlay') {
            closeDateCalendar();
        }
    }

    // 달력 렌더링
    function renderDateCalendar() {
        var year = dateCurrentMonth.getFullYear();
        var month = dateCurrentMonth.getMonth();

        // 월 표시
        var monthNames = ['1월', '2월', '3월', '4월', '5월', '6월',
            '7월', '8월', '9월', '10월', '11월', '12월'];
        document.getElementById('dateCalendarMonth').textContent = year + '년 ' + monthNames[month];

        // 날짜 계산
        var firstDay = new Date(year, month, 1).getDay();
        var lastDate = new Date(year, month + 1, 0).getDate();
        var today = new Date();
        today.setHours(0, 0, 0, 0);

        var daysContainer = document.getElementById('dateCalendarDays');
        daysContainer.innerHTML = '';

        // 이전 달 빈 칸
        for (var i = 0; i < firstDay; i++) {
            var emptyDay = document.createElement('div');
            emptyDay.className = 'calendar-day other-month empty';
            daysContainer.appendChild(emptyDay);
        }

        // 현재 달 날짜
        for (var date = 1; date <= lastDate; date++) {
            var dayElement = document.createElement('div');
            dayElement.className = 'calendar-day current-month';
            dayElement.textContent = date;

            var currentDate = new Date(year, month, date);
            currentDate.setHours(0, 0, 0, 0);

            // 오늘 날짜 표시
            if (currentDate.getTime() === today.getTime()) {
                dayElement.classList.add('today');
            }

            // 날짜 선택 이벤트 (과거 날짜도 선택 가능)
            dayElement.onclick = (function(d) {
                return function() {
                    selectFilterDate(new Date(year, month, d));
                };
            })(date);

            // 선택된 날짜 표시
            if (dateTempSelected &&
                dateTempSelected.getFullYear() === year &&
                dateTempSelected.getMonth() === month &&
                dateTempSelected.getDate() === date) {
                dayElement.classList.add('selected');
            }

            daysContainer.appendChild(dayElement);
        }
    }

    // 날짜 선택
    function selectFilterDate(date) {
        dateTempSelected = date;
        renderDateCalendar();
    }

    // 이전 달
    function prevDateMonth() {
        dateCurrentMonth.setMonth(dateCurrentMonth.getMonth() - 1);
        renderDateCalendar();
    }

    // 다음 달
    function nextDateMonth() {
        dateCurrentMonth.setMonth(dateCurrentMonth.getMonth() + 1);
        renderDateCalendar();
    }

    // 선택된 날짜 표시 업데이트
    function updateDateFilterDisplay() {
        if (selectedFilterDate) {
            var weekdays = ['일요일', '월요일', '화요일', '수요일', '목요일', '금요일', '토요일'];
            var year = selectedFilterDate.getFullYear();
            var month = selectedFilterDate.getMonth() + 1;
            var day = selectedFilterDate.getDate();
            var weekday = weekdays[selectedFilterDate.getDay()];

            var dateString = year + '년 ' + month + '월 ' + day + '일 ' + weekday;
            document.getElementById('selectedDateText').textContent = dateString;
            document.getElementById('clearDateFilter').style.display = 'block';
        } else {
            document.getElementById('selectedDateText').textContent = '전체 날짜';
            document.getElementById('clearDateFilter').style.display = 'none';
        }
    }

    // 날짜 필터 초기화
    function clearDateFilter() {
        selectedFilterDate = null;
        updateDateFilterDisplay();
        location.reload();
    }

    // 날짜별 필터링
    function filterByDate() {
        var dateStr = null;

        if (selectedFilterDate) {
            var year = selectedFilterDate.getFullYear();
            var month = String(selectedFilterDate.getMonth() + 1).padStart(2, '0');
            var day = String(selectedFilterDate.getDate()).padStart(2, '0');
            dateStr = year + '-' + month + '-' + day;
        }

        // 날짜가 선택되지 않았으면 전체 조회
        if (!dateStr) {
            location.reload();
            return;
        }

        // AJAX로 날짜별 조회
        fetch(contextPath + '/ptSchedule/filterByDate.ajax?date=' + dateStr)
            .then(function(response) {
                return response.json();
            })
            .then(function(data) {
                if (data.success) {
                    renderFilteredSchedules(data.reserves);
                } else {
                    alert(data.message || '데이터 조회에 실패했습니다.');
                }
            })
            .catch(function(error) {
                console.error('날짜 필터링 오류:', error);
                alert('날짜 필터링 중 오류가 발생했습니다.');
            });
    }

    // 필터링된 스케줄 목록 렌더링
    function renderFilteredSchedules(reserves) {
        var listContainer = document.getElementById('scheduleList');
        
        // 기존 카드 제거
        listContainer.innerHTML = '';

        if (reserves && reserves.length > 0) {
            reserves.forEach(function(reserve) {
                var card = document.createElement('div');
                card.className = 'pt-schedule-card';
                
                var phoneHtml = reserve.memberPhone ? reserve.memberPhone : '-';
                
                card.innerHTML = 
                    '<div class="pt-schedule-header">' +
                    '    <div class="user-icon">' +
                    '        <img src="' + contextPath + '/resources/images/icon/person.png" alt="회원">' +
                    '    </div>' +
                    '    <div class="schedule-user-info">' +
                    '        <div class="schedule-user-name">' + reserve.memberName + '</div>' +
                    '    </div>' +
                    '    <span class="schedule-badge approved">승인됨</span>' +
                    '</div>' +
                    '<div class="schedule-details">' +
                    '    <div class="detail-item">' +
                    '        <img src="' + contextPath + '/resources/images/icon/calendar.png" alt="예약일" class="detail-icon">' +
                    '        <span class="detail-label">예약일:</span>' +
                    '        <span class="detail-value">' + reserve.reserveDate + '</span>' +
                    '    </div>' +
                    '    <div class="detail-item">' +
                    '        <img src="' + contextPath + '/resources/images/icon/clock.png" alt="예약시간" class="detail-icon">' +
                    '        <span class="detail-label">예약시간:</span>' +
                    '        <span class="detail-value">' + reserve.reserveTime + '</span>' +
                    '    </div>' +
                    '    <div class="detail-item">' +
                    '        <img src="' + contextPath + '/resources/images/icon/call.png" alt="전화번호" class="detail-icon">' +
                    '        <span class="detail-label">전화번호:</span>' +
                    '        <span class="detail-value">' + phoneHtml + '</span>' +
                    '    </div>' +
                    '</div>';
                
                listContainer.appendChild(card);
            });
        } else {
            listContainer.innerHTML = 
                '<div class="empty-state">' +
                '    <div class="empty-text">해당 날짜에 배정된 PT 스케줄이 없습니다.</div>' +
                '</div>';
        }
    }

</script>
</body>
</html>

