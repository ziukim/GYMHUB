<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>방문 예약 - GymHub</title>

    <!-- Common CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common.css">
    
    <style>
        /* 방문 예약 페이지 전용 스타일 */
        body {
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', 'Malgun Gothic', 'Apple SD Gothic Neo', sans-serif;
            background-color: #0a0a0a;
            color: #fff;
            min-height: 100vh;
            padding: 20px;
        }

        /* 헤더 */
        header {
            background: linear-gradient(180deg, #3a2820 0%, #2a1810 100%);
            padding: 15px 40px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            border-bottom: 2px solid #ff6b00;
            margin: -20px -20px 32px -20px;
        }

        header .logo {
            display: flex;
            align-items: center;
            gap: 10px;
        }

        /* 컨테이너 */
        .container {
            max-width: 1400px;
            margin: 0 auto;
            padding: 0 100px;
        }

        /* 헬스장 정보 카드 */
        .gym-info-card {
            background-color: #1a0f0a;
            border: 1px solid #ff6b00;
            border-radius: 14px;
            padding: 25px;
            margin-bottom: 32px;
        }

        .gym-info-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .gym-name {
            font-size: 16px;
            color: #ff6b00;
            font-weight: 600;
        }

        .gym-badges {
            display: flex;
            gap: 8px;
        }

        .gym-badge {
            background-color: #2d1810;
            border: 1px solid #ff6b00;
            color: #ffa366;
            padding: 3px 9px;
            border-radius: 8px;
            font-size: 12px;
        }

        /* 메인 폼 영역 */
        .form-container {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 32px;
            margin-bottom: 32px;
        }

        /* 섹션 */
        .section {
            background-color: #1a0f0a;
            border: 1px solid #ff6b00;
            border-radius: 14px;
            padding: 25px;
        }

        .section-header {
            display: flex;
            align-items: center;
            gap: 8px;
            margin-bottom: 24px;
            color: #ff6b00;
            font-size: 16px;
            font-weight: 600;
        }

        /* 일정 선택 */
        .date-input-group {
            margin-bottom: 0;
        }

        .date-label {
            font-size: 14px;
            color: #ffa366;
            margin-bottom: 12px;
            display: block;
        }

        .date-input-wrapper {
            position: relative;
        }

        .date-input {
            background-color: #2d1810;
            border: 1px solid #ff6b00;
            border-radius: 6px;
            padding: 12px;
            color: #8a6a50;
            font-size: 14px;
            width: 100%;
            cursor: pointer;
        }

        .date-input:hover {
            border-color: #ff8533;
        }

        .selected-date-display {
            margin-top: 24px;
            padding-top: 24px;
            border-top: 1px solid #2d1810;
            display: flex;
            align-items: center;
            gap: 24px;
            font-size: 14px;
            color: #8a6a50;
        }

        .date-info {
            display: flex;
            align-items: center;
            gap: 8px;
        }

        /* 시간대 선택 */
        .time-slots-container {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 24px;
        }

        .time-slot {
            background-color: #2d1810;
            border-radius: 10px;
            padding: 12px;
            cursor: pointer;
            transition: all 0.3s;
        }

        .time-slot-content {
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .time-slot-icon {
            width: 40px;
            height: 40px;
            background-color: #1a0f0a;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .time-slot-info {
            flex: 1;
        }

        .time-slot-status {
            font-size: 16px;
            color: #ffa366;
            margin-bottom: 4px;
        }

        .time-slot-time {
            font-size: 14px;
            color: #8a6a50;
        }

        .time-slot-btn {
            background-color: #2d1810;
            border: 1px solid #ff6b00;
            color: #ffa366;
            border-radius: 8px;
            padding: 3px 12px;
            font-size: 12px;
            cursor: pointer;
            transition: all 0.3s;
        }

        /* 빈 시간 (선택 가능) */
        .time-slot.available:hover {
            background-color: #3d2820;
        }

        .time-slot.available .time-slot-btn {
            background-color: #ff6b00;
        }

        .time-slot.available .time-slot-btn:hover {
            background-color: #ff8533;
        }

        /* 예약된 시간 (비활성화) */
        .time-slot.reserved {
            cursor: not-allowed;
            opacity: 0.6;
        }

        .time-slot.reserved .time-slot-status {
            border: 1px solid #ff6b00;
            border-radius: 6px;
            padding: 2px 7px;
            display: inline-block;
        }

        .time-slot.reserved .time-slot-btn {
            background-color: #2d1810;
            cursor: not-allowed;
        }

        /* 선택된 시간 */
        .time-slot.selected {
            background-color: #ff6b00;
        }

        .time-slot.selected .time-slot-status {
            color: #0a0a0a;
        }

        .time-slot.selected .time-slot-time {
            color: #1a0f0a;
        }

        .time-slot.selected .time-slot-btn {
            background-color: #0a0a0a;
            color: #ff6b00;
        }

        /* 버튼 그룹 */
        .button-group {
            display: flex;
            justify-content: flex-end;
            gap: 12px;
            margin-top: 32px;
        }

        /* 취소 버튼 */
        .cancel-btn {
            background-color: transparent;
            border: 1px solid #ff6b00;
            color: #ffa366;
            font-size: 20px;
            font-weight: 600;
            padding: 15px 40px;
            border-radius: 8px;
            cursor: pointer;
            transition: all 0.3s;
        }

        .cancel-btn:hover {
            background-color: rgba(255, 107, 0, 0.1);
            border-color: #ff8533;
            color: #ff8533;
        }

        .cancel-btn:active {
            background-color: rgba(255, 107, 0, 0.2);
        }

        /* 예약하기 버튼 */
        .submit-btn {
            background-color: #ff6b00;
            border: 1px solid #ff6b00;
            color: #0a0a0a;
            font-size: 20px;
            font-weight: 600;
            padding: 15px 40px;
            border-radius: 8px;
            cursor: pointer;
            transition: all 0.3s;
        }

        .submit-btn:hover {
            background-color: #ff8533;
        }

        .submit-btn:active {
            background-color: #e65f00;
        }

        /* 예약 확인 모달 */
        .confirm-overlay {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.7);
            z-index: 2000;
            align-items: center;
            justify-content: center;
        }

        .confirm-overlay.show {
            display: flex;
        }

        .confirm-modal {
            background-color: #1a0f0a;
            border: 1px solid #ff6b00;
            border-radius: 14px;
            padding: 25px;
            max-width: 463px;
            width: 90%;
            position: relative;
        }

        .confirm-title {
            font-size: 16px;
            color: #ff6b00;
            margin-bottom: 46px;
        }

        .confirm-content {
            display: flex;
            flex-direction: column;
            gap: 8px;
            margin-bottom: 64px;
        }

        .confirm-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .confirm-label {
            font-size: 16px;
            color: #8a6a50;
        }

        .confirm-value {
            font-size: 16px;
            color: #ffa366;
        }

        .confirm-buttons {
            display: flex;
            justify-content: flex-end;
            gap: 14px;
        }

        .confirm-cancel-btn {
            background-color: #0a0a0a;
            border: 1px solid #ff6b00;
            color: #ffa366;
            padding: 9px 17px;
            border-radius: 8px;
            font-size: 14px;
            cursor: pointer;
            transition: all 0.3s;
        }

        .confirm-cancel-btn:hover {
            background-color: #1a0f0a;
        }

        .confirm-submit-btn {
            background-color: #ff6b00;
            border: none;
            color: #0a0a0a;
            padding: 8px 16px;
            border-radius: 8px;
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
            display: flex;
            align-items: center;
            gap: 8px;
            transition: all 0.3s;
        }

        .confirm-submit-btn:hover {
            background-color: #ff8533;
        }

        @media (max-width: 1200px) {
            .container {
                padding: 0 40px;
            }

            header {
                padding: 14px 40px;
            }

            .form-container {
                grid-template-columns: 1fr;
            }

            .time-slots-container {
                grid-template-columns: 1fr;
            }
        }

        @media (max-width: 768px) {
            .container {
                padding: 0 20px;
            }

            header {
                padding: 14px 20px;
            }
        }
    </style>
</head>

<body>
<!-- 헤더 -->
<header>
    <div class="logo">
        <img src="${pageContext.request.contextPath}/resources/images/icon/logo.png" class="logo-icon" alt="GYMHub">
        <span class="logo-text">GYMHub</span>
    </div>
</header>

<!-- 컨테이너 -->
<div class="container">
    <!-- 헬스장 정보 -->
    <div class="gym-info-card">
        <div class="gym-info-header">
            <div>
                <div class="gym-name">피트니스 센터 강남점</div>
                <div class="selected-date-display" id="selectedDateDisplay">
                    <div class="date-info">
                        <svg width="16" height="16" viewBox="0 0 16 16" fill="none">
                            <path d="M5.33333 1.33333V4" stroke="#8A6A50" stroke-width="1.33333" stroke-linecap="round" stroke-linejoin="round"/>
                            <path d="M10.6667 1.33333V4" stroke="#8A6A50" stroke-width="1.33333" stroke-linecap="round" stroke-linejoin="round"/>
                            <path d="M12.6667 2.66667H3.33333C2.59695 2.66667 2 3.26362 2 4V13.3333C2 14.0697 2.59695 14.6667 3.33333 14.6667H12.6667C13.403 14.6667 14 14.0697 14 13.3333V4C14 3.26362 13.403 2.66667 12.6667 2.66667Z" stroke="#8A6A50" stroke-width="1.33333" stroke-linecap="round" stroke-linejoin="round"/>
                            <path d="M2 6.66667H14" stroke="#8A6A50" stroke-width="1.33333" stroke-linecap="round" stroke-linejoin="round"/>
                        </svg>
                        <span id="displaySelectedDate"></span>
                    </div>
                    <div class="date-info">
                        <span>피트니스 센터 강남점</span>
                    </div>
                </div>
            </div>
            <div class="gym-badges">
                <span class="gym-badge">24시간</span>
                <span class="gym-badge">주차가능</span>
                <span class="gym-badge">샤워실</span>
            </div>
        </div>
    </div>

    <!-- 폼 -->
    <form id="bookingForm" action="${pageContext.request.contextPath}/booking/submit" method="post">
        <!-- 숨겨진 필드 -->
        <input type="hidden" name="date" id="hiddenDate">
        <input type="hidden" name="time" id="hiddenTime">

        <div class="form-container">
            <!-- 일정 선택 -->
            <div class="section">
                <div class="section-header">
                    <svg width="20" height="20" viewBox="0 0 20 20" fill="none">
                        <path d="M5.83333 1.66667V4.16667" stroke="currentColor" stroke-width="1.66667" stroke-linecap="round" stroke-linejoin="round"/>
                        <path d="M14.1667 1.66667V4.16667" stroke="currentColor" stroke-width="1.66667" stroke-linecap="round" stroke-linejoin="round"/>
                        <path d="M16.6667 3.33333H3.33333C2.41286 3.33333 1.66667 4.07952 1.66667 5V16.6667C1.66667 17.5871 2.41286 18.3333 3.33333 18.3333H16.6667C17.5871 18.3333 18.3333 17.5871 18.3333 16.6667V5C18.3333 4.07952 17.5871 3.33333 16.6667 3.33333Z" stroke="currentColor" stroke-width="1.66667" stroke-linecap="round" stroke-linejoin="round"/>
                        <path d="M1.66667 8.33333H18.3333" stroke="currentColor" stroke-width="1.66667" stroke-linecap="round" stroke-linejoin="round"/>
                    </svg>
                    일정 선택
                </div>

                <div class="date-input-group">
                    <label class="date-label">날짜를 선택하세요</label>
                    <div class="date-input-wrapper">
                        <input type="text" class="date-input" id="dateInput" placeholder="날짜를 선택하세요" readonly onclick="openCalendar()">
                    </div>
                </div>
            </div>

            <!-- 예약자 정보 -->
            <div class="section">
                <div class="section-header">
                    <svg width="20" height="20" viewBox="0 0 20 20" fill="none">
                        <path d="M15.8333 17.5V15.8333C15.8333 14.9493 15.4821 14.1014 14.857 13.4763C14.2319 12.8512 13.3841 12.5 12.5 12.5H7.5C6.61594 12.5 5.7681 12.8512 5.14298 13.4763C4.51786 14.1014 4.16667 14.9493 4.16667 15.8333V17.5" stroke="currentColor" stroke-width="1.66667" stroke-linecap="round" stroke-linejoin="round"/>
                        <path d="M10 9.16667C11.8409 9.16667 13.3333 7.67428 13.3333 5.83333C13.3333 3.99238 11.8409 2.5 10 2.5C8.15905 2.5 6.66667 3.99238 6.66667 5.83333C6.66667 7.67428 8.15905 9.16667 10 9.16667Z" stroke="currentColor" stroke-width="1.66667" stroke-linecap="round" stroke-linejoin="round"/>
                    </svg>
                    예약자 정보
                </div>

                <div class="input-group">
                    <label class="input-label">이름<span class="required">*</span></label>
                    <input type="text" class="input-field" name="name" id="nameInput" placeholder="이름을 입력하세요" required>
                </div>

                <div class="input-group">
                    <label class="input-label">전화번호<span class="required">*</span></label>
                    <input type="tel" class="input-field" name="phone" id="phoneInput" placeholder="010-0000-0000" required>
                </div>

                <div class="input-group">
                    <label class="input-label">이메일<span class="optional">(선택)</span></label>
                    <input type="email" class="input-field" name="email" id="emailInput" placeholder="example@email.com">
                </div>
            </div>
        </div>

        <!-- 시간대 선택 -->
        <div class="section" style="margin-bottom: 32px;">
            <div class="time-slots-container" id="timeSlotsContainer">
                <!-- 시간대는 JavaScript로 동적 생성 -->
            </div>
        </div>

        <!-- 버튼 영역 -->
        <div class="button-group justify-end">
            <button type="button" class="cancel-btn" onclick="history.back()">취소</button>
            <button type="button" class="submit-btn" onclick="submitBooking()">예약하기</button>
        </div>
        <div style="clear: both; margin-bottom: 40px;"></div>
    </form>
</div>

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

<!-- 예약 확인 모달 -->
<div class="confirm-overlay" id="confirmOverlay">
    <div class="confirm-modal">
        <div class="confirm-title">예약 정보 확인</div>

        <div class="confirm-content">
            <div class="confirm-row">
                <span class="confirm-label">헬스장</span>
                <span class="confirm-value">피트니스 센터 강남점</span>
            </div>
            <div class="confirm-row">
                <span class="confirm-label">날짜</span>
                <span class="confirm-value" id="confirmDate"></span>
            </div>
            <div class="confirm-row">
                <span class="confirm-label">시간</span>
                <span class="confirm-value" id="confirmTime"></span>
            </div>
        </div>

        <div class="confirm-buttons">
            <button type="button" class="confirm-cancel-btn" onclick="closeConfirmModal()">취소</button>
            <button type="button" class="confirm-submit-btn" onclick="confirmBooking()">
                <svg width="16" height="16" viewBox="0 0 16 16" fill="none">
                    <path d="M13.3333 4L6 11.3333L2.66667 8" stroke="#0A0A0A" stroke-width="1.33333" stroke-linecap="round" stroke-linejoin="round"/>
                </svg>
                예약 확정
            </button>
        </div>
    </div>
</div>

<script>
    // 예약된 시간대 (실제로는 서버에서 가져와야 함)
    const reservedTimes = ['10:00 - 11:00', '16:00 - 17:00'];

    // 시간대 생성
    const timeSlots = [
        '10:00 - 11:00', '11:00 - 12:00', '12:00 - 13:00',
        '13:00 - 14:00', '14:00 - 15:00', '15:00 - 16:00',
        '16:00 - 17:00', '17:00 - 18:00', '18:00 - 19:00',
        '19:00 - 20:00', '20:00 - 21:00', '21:00 - 22:00'
    ];

    let selectedTime = null;
    let selectedDate = null;
    let currentMonth = new Date();
    let tempSelectedDate = null;

    // 시간대 렌더링
    function renderTimeSlots() {
        const container = document.getElementById('timeSlotsContainer');
        container.innerHTML = '';

        timeSlots.forEach(time => {
            const isReserved = reservedTimes.includes(time);
            const status = isReserved ? 'reserved' : 'available';
            const statusText = isReserved ? '예약된 시간' : '빈 시간';

            const slot = document.createElement('div');
            slot.className = 'time-slot ' + status;
            slot.innerHTML = `
                    <div class="time-slot-content">
                        <div class="time-slot-icon">
                            <svg width="20" height="20" viewBox="0 0 17 17" fill="none">
                                <path d="M8.33333 4.16671V8.33333L10.8333 10.8333" stroke="#FF6B00" stroke-width="1.66667" stroke-linecap="round" stroke-linejoin="round"/>
                                <path d="M8.33333 15.8333C12.4754 15.8333 15.8333 12.4754 15.8333 8.33333C15.8333 4.1912 12.4754 0.833335 8.33333 0.833335C4.1912 0.833335 0.833335 4.1912 0.833335 8.33333C0.833335 12.4754 4.1912 15.8333 8.33333 15.8333Z" stroke="#FF6B00" stroke-width="1.66667" stroke-linecap="round" stroke-linejoin="round"/>
                            </svg>
                        </div>
                        <div class="time-slot-info">
                            <div class="time-slot-status">` + statusText + `</div>
                            <div class="time-slot-time">` + time + `</div>
                        </div>
                        <button type="button" class="time-slot-btn" onclick="event.stopPropagation()">+</button>
                    </div>
                `;

            if (!isReserved) {
                slot.onclick = function() {
                    selectTime(time, this);
                };
            }

            container.appendChild(slot);
        });
    }

    // 시간 선택
    function selectTime(time, element) {
        // 이전 선택 해제
        document.querySelectorAll('.time-slot.selected').forEach(slot => {
            slot.classList.remove('selected');
        });

        // 새로운 선택
        element.classList.add('selected');
        selectedTime = time;
    }

    // 달력 관련 함수
    function openCalendar() {
        document.getElementById('calendarOverlay').classList.add('show');
        renderCalendar();
    }

    function closeCalendar() {
        document.getElementById('calendarOverlay').classList.remove('show');
        if (tempSelectedDate) {
            selectedDate = tempSelectedDate;
            updateDateDisplay();
        }
    }

    function closeCalendarOnOverlay(event) {
        if (event.target === event.currentTarget) {
            closeCalendar();
        }
    }

    function prevMonth() {
        currentMonth.setMonth(currentMonth.getMonth() - 1);
        renderCalendar();
    }

    function nextMonth() {
        currentMonth.setMonth(currentMonth.getMonth() + 1);
        renderCalendar();
    }

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

    function updateDateDisplay() {
        if (selectedDate) {
            const year = selectedDate.getFullYear();
            const month = String(selectedDate.getMonth() + 1).padStart(2, '0');
            const day = String(selectedDate.getDate()).padStart(2, '0');

            const dateString = year + '. ' + month + '. ' + day + '.';
            document.getElementById('dateInput').value = dateString;
            document.getElementById('displaySelectedDate').textContent = dateString;
            document.getElementById('selectedDateDisplay').classList.add('show');

            // 숨겨진 필드에 날짜 저장 (YYYY-MM-DD 형식)
            document.getElementById('hiddenDate').value = year + '-' + month + '-' + day;
        }
    }

    // 예약하기
    function submitBooking() {
        const name = document.getElementById('nameInput').value.trim();
        const phone = document.getElementById('phoneInput').value.trim();

        if (!selectedDate) {
            alert('날짜를 선택해주세요.');
            return;
        }

        if (!name) {
            alert('이름을 입력해주세요.');
            return;
        }

        if (!phone) {
            alert('전화번호를 입력해주세요.');
            return;
        }

        if (!selectedTime) {
            alert('시간대를 선택해주세요.');
            return;
        }

        // 예약 확인 모달 표시
        showConfirmModal();
    }

    // 예약 확인 모달 열기
    function showConfirmModal() {
        // 날짜 포맷 변환
        const weekdays = ['일요일', '월요일', '화요일', '수요일', '목요일', '금요일', '토요일'];
        const year = selectedDate.getFullYear();
        const month = selectedDate.getMonth() + 1;
        const day = selectedDate.getDate();
        const weekday = weekdays[selectedDate.getDay()];

        const formattedDate = year + '년 ' + month + '월 ' + day + '일 ' + weekday;

        // 시간 포맷 (시작 시간만 표시)
        const timeStart = selectedTime.split(' - ')[0];

        // 모달에 정보 표시
        document.getElementById('confirmDate').textContent = formattedDate;
        document.getElementById('confirmTime').textContent = timeStart;

        // 숨겨진 필드에 시간 저장
        document.getElementById('hiddenTime').value = selectedTime;

        // 모달 표시
        document.getElementById('confirmOverlay').classList.add('show');
        document.body.style.overflow = 'hidden';
    }

    // 예약 확인 모달 닫기
    function closeConfirmModal() {
        document.getElementById('confirmOverlay').classList.remove('show');
        document.body.style.overflow = '';
    }

    // 예약 확정
    function confirmBooking() {
        // 폼 제출
        document.getElementById('bookingForm').submit();
    }


    // 예약 확정
    function confirmBooking() {
        // 날짜 포맷 변환 (YYYY-MM-DD → YYYY년 MM월 DD일)
        const dateParts = document.getElementById('hiddenDate').value.split('-');
        const formattedDate = dateParts[0] + '년 ' + dateParts[1] + '월 ' + dateParts[2] + '일';

        // 시간 정보
        const timeInfo = selectedTime;

        // 이름 정보
        const userName = document.getElementById('nameInput').value.trim();

        // 예약 정보 저장 (모달 닫은 후 alert에서 사용)
        const bookingInfo = '예약이 완료되었습니다!\n\n' +
            '예약 날짜: ' + formattedDate + '\n' +
            '예약 시간: ' + timeInfo + '\n' +
            '예약자명: ' + userName;

        // 모달 닫기
        closeConfirmModal();

        // 예약 정보 alert 표시
        alert(bookingInfo);

        // 폼 제출
        document.getElementById('bookingForm').submit();
    }

    // 초기화
    renderTimeSlots();
</script>
</body>
</html>
