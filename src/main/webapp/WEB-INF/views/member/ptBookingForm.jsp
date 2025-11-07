<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>PT 예약 - GymHub</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common.css">
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;700;900&display=swap" rel="stylesheet">

    <!-- jQuery -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Noto Sans KR', sans-serif;
            background-color: #0a0a0a;
            color: #ffa366;
            min-height: 100vh;
        }

        .app-container {
            display: flex;
        }

        .main-content {
            flex: 1;
            padding: 24px;
            min-height: 100vh;
            margin-left: 0px;
        }

        .header {
            display: flex;
            align-items: center;
            gap: 16px;
            margin-bottom: 24px;
            justify-content: flex-start;
        }

        .back-button {
            width: 36px;
            height: 36px;
            background-color: #0a0a0a;
            border: 1px solid #ff6b00;
            border-radius: 8px;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
        }

        .back-button:hover {
            opacity: 0.8;
        }

        .header-title h1 {
            font-size: 30px;
            font-weight: 900;
            color: #ff6b00;
            line-height: 36px;
            margin-bottom: 8px;
        }

        .header-subtitle {
            font-size: 16px;
            color: #8a6a50;
        }

        .trainer-card {
            background-color: #1a0f0a;
            border: 1px solid #ff6b00;
            border-radius: 14px;
            padding: 25px;
            margin-bottom: 24px;
        }

        .card-title {
            font-size: 16px;
            color: #ff6b00;
            margin-bottom: 30px;
        }

        .trainer-info {
            display: flex;
            align-items: center;
            gap: 16px;
        }

        .trainer-avatar {
            width: 64px;
            height: 64px;
            background-color: #2d1810;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: #ff6b00;
            font-size: 24px;
            font-weight: bold;
        }

        .trainer-details {
            flex: 1;
            background-color: #2d1810;
            border: 1px solid #ff6b00;
            border-radius: 6px;
            padding: 0 16px;
            height: 64px;
            display: flex;
            align-items: center;
            gap: 16px;
        }

        .trainer-name {
            font-size: 18px;
            color: #ffa366;
            font-weight: 500;
        }

        .trainer-specialty,
        .trainer-experience {
            font-size: 14px;
            color: #8a6a50;
        }

        .schedule-header {
            background-color: #563c30;
            height: 36px;
            border-radius: 14px;
            width: 202px;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 24px;
        }

        .schedule-header-text {
            font-size: 20px;
            color: #1a0f0a;
            font-weight: 700;
        }

        .schedule-card {
            background-color: #1a0f0a;
            border: 1px solid #ff6b00;
            border-radius: 14px;
            padding: 25px;
            margin-bottom: 24px;
        }

        .date-label {
            background-color: #ff6b00;
            color: white;
            font-size: 12px;
            padding: 3px 9px;
            border-radius: 8px;
            display: inline-block;
            margin-bottom: 12px;
        }

        .date-input-container {
            background-color: #2d1810;
            border: 1px solid #ff6b00;
            border-radius: 6px;
            height: 48px;
            width: 100%;
            padding: 0 16px;
            display: flex;
            align-items: center;
            gap: 8px;
            margin-bottom: 12px;
        }

        .date-input-container input {
            background: transparent;
            border: none;
            color: #ffa366;
            font-size: 14px;
            width: 100%;
            cursor: pointer;
            outline: none;
        }

        .date-input-container input::placeholder {
            color: #8a6a50;
        }

        .selected-info {
            display: flex;
            gap: 24px;
            align-items: center;
            font-size: 14px;
            color: #8a6a50;
        }

        .selected-info .time {
            color: #ff6b00;
        }

        .info-item {
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .info-icon {
            width: 16px;
            height: 16px;
            color: #8a6a50;
        }

        .time-slots-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 16px;
            margin-bottom: 24px;
        }

        .time-slot {
            background-color: #2d1810;
            height: 54px;
            border-radius: 10px;
            padding: 12px 16px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            cursor: pointer;
            transition: opacity 0.2s;
            border: 1px solid transparent;
        }

        .time-slot:hover:not(.booked) {
            opacity: 0.8;
            border-color: #ff6b00;
        }

        .time-slot.booked {
            background-color: #ff6b00;
            cursor: not-allowed;
        }

        .time-slot-info {
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .time-icon {
            width: 30px;
            height: 30px;
            background-color: #1a0f0a;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            flex-shrink: 0;
            font-size: 16px;
            color: #ff6b00;
        }

        .time-text-container {
            display: flex;
            flex-direction: column;
            gap: 2px;
        }

        .time-status {
            font-size: 12px;
            color: #ffa366;
            line-height: 1;
        }

        .time-slot.booked .time-status {
            color: #1a0f0a;
        }

        .time-range {
            font-size: 11px;
            color: #8a6a50;
            line-height: 1;
        }

        .time-slot.booked .time-range {
            color: #5a3820;
        }

        .add-button {
            width: 32px;
            height: 18px;
            border-radius: 6px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 14px;
            color: #ffa366;
            border: 1px solid #ff6b00;
            flex-shrink: 0;
            background-color: #ff6b00;
        }

        .time-slot.booked .add-button {
            background-color: #2d1810;
            color: #1a0f0a;
            border-color: #5a3820;
        }

        .submit-container {
            display: flex;
            justify-content: flex-end;
        }

        .submit-button {
            background-color: #ff6b00;
            border: 1px solid #ff6b00;
            border-radius: 8px;
            width: 123px;
            height: 51px;
            font-size: 20px;
            color: black;
            cursor: pointer;
            transition: opacity 0.2s;
            font-weight: 700;
        }

        .submit-button:hover {
            opacity: 0.9;
        }

        .modal {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background-color: rgba(0, 0, 0, 0.8);
            align-items: center;
            justify-content: center;
            z-index: 1000;
        }

        .modal.show {
            display: flex;
        }

        .modal-content {
            background-color: #1a0f0a;
            border: 1px solid #ff6b00;
            border-radius: 10px;
            padding: 24px;
            max-width: 510px;
            width: 90%;
        }

        .modal-header {
            margin-bottom: 16px;
        }

        .modal-title {
            font-size: 18px;
            font-weight: 700;
            color: #ff6b00;
            margin-bottom: 8px;
        }

        .modal-description {
            font-size: 14px;
            color: #8a6a50;
        }

        .modal-info {
            background-color: #2d1810;
            border: 1px solid #ff6b00;
            border-radius: 6px;
            height: 48px;
            padding: 0 16px;
            display: flex;
            align-items: center;
            gap: 24px;
            margin-bottom: 24px;
        }

        .modal-time-slot {
            background-color: #ff6b00;
            border-radius: 10px;
            height: 70px;
            padding: 13px;
            margin-bottom: 24px;
            display: flex;
            align-items: center;
        }

        .modal-time-slot .time-status {
            color: #1a0f0a;
            font-weight: 700;
        }

        .modal-time-slot .time-range {
            color: #5a3820;
        }

        .modal-actions {
            display: flex;
            gap: 12px;
        }

        .modal-button {
            flex: 1;
            height: 42px;
            border-radius: 10px;
            cursor: pointer;
            transition: opacity 0.2s;
            border: none;
            font-family: 'Noto Sans KR', sans-serif;
        }

        .modal-button:hover {
            opacity: 0.8;
        }

        .modal-button.cancel {
            background-color: #0a0a0a;
            border: 1px solid #8a6a50;
            color: white;
            font-size: 16px;
        }

        .modal-button.confirm {
            background-color: #ff6b00;
            color: #0a0a0a;
            font-size: 16px;
            font-weight: 700;
        }
         .trainer-select-container {
             position: relative;
             width: 100%;
         }

        .trainer-select {
            width: 100%;
            background-color: #2d1810;
            border: 1px solid #ff6b00;
            border-radius: 6px;
            padding: 0 16px;
            height: 64px;
            display: flex;
            align-items: center;
            gap: 16px;
            cursor: pointer;
        }

        .trainer-select:hover {
            opacity: 0.9;
        }

        .trainer-select-arrow {
            margin-left: auto;
            color: #ff6b00;
            font-size: 18px;
        }

        .trainer-dropdown {
            display: none;
            position: absolute;
            top: 100%;
            left: 0;
            right: 0;
            margin-top: 8px;
            background-color: #1a0f0a;
            border: 1px solid #ff6b00;
            border-radius: 6px;
            max-height: 250px;
            overflow-y: auto;
            z-index: 100;
        }

        .trainer-dropdown.show {
            display: block;
        }

        .trainer-option {
            padding: 16px;
            cursor: pointer;
            transition: background-color 0.2s;
            border-bottom: 1px solid #2d1810;
        }

        .trainer-option:last-child {
            border-bottom: none;
        }

        .trainer-option:hover {
            background-color: #2d1810;
        }

        .trainer-option-content {
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .trainer-option-details {
            display: flex;
            flex-direction: column;
            gap: 4px;
        }

        .trainer-option-name {
            font-size: 16px;
            color: #ffa366;
            font-weight: 500;
        }

        .trainer-option-info {
            font-size: 12px;
            color: #8a6a50;
        }
    </style>
</head>
<body>
<div class="app-container">
    <!-- Sidebar Include -->
    <jsp:include page="../common/sidebar/sidebarMember.jsp" />

    <!-- Main Content -->
    <div class="main-content">
        <div class="header">
            <button class="back-button" onclick="history.back()">
                <img src="${pageContext.request.contextPath}/resources/images/icon/arrow.png" alt="회원권 아이콘">
            </button>
            <div class="header-title">
                <h1>PT 예약</h1>
                <div class="header-subtitle">나의 퍼스널 트레이닝 일정을 관리하세요</div>
            </div>
        </div>

        <div class="trainer-card">
            <div class="card-title">희망 트레이너</div>
            <div class="trainer-info">
                <div class="trainer-avatar" id="selectedTrainerAvatar">
                    T
                </div>
                <div class="trainer-select-container">
                    <div class="trainer-select" onclick="toggleTrainerDropdown()">
                        <span class="trainer-name" id="selectedTrainerName">김트레이너</span>
                        <span class="trainer-specialty" id="selectedTrainerSpecialty">전문 분야: 체형교정, 근력강화, 다이어트</span>
                        <span class="trainer-experience" id="selectedTrainerExperience">경력: 5년</span>
                        <span class="trainer-select-arrow">▼</span>
                    </div>
                    <div class="trainer-dropdown" id="trainerDropdown">

                    </div>
                </div>
            </div>
        </div>

        <div class="schedule-header">
            <span class="schedule-header-text">일정 선택</span>
        </div>

        <div class="schedule-card">
            <span class="date-label">날짜를 입력하세요</span>
            <div class="date-input-container">
                <span class="info-icon">
                    <img src="${pageContext.request.contextPath}/resources/images/icon/calendar.png" alt="캘린더 아이콘">
                </span>
                <input type="text" id="dateInput" placeholder="날짜를 선택하세요" readonly onclick="openPtDateCalendar()">
            </div>

            <div class="selected-info">
                <div class="info-item">
                    <span class="info-icon">
                        <img src="${pageContext.request.contextPath}/resources/images/icon/calendar.png" alt="캘린더 아이콘">
                    </span>
                    <span id="selectedDateDisplay">날짜를 선택하세요</span>
                </div>
                <div class="info-item time" id="selectedTimeDisplay" style="display: none;">
                    <span class="info-icon">
                        <img src="${pageContext.request.contextPath}/resources/images/icon/clock.png" alt="시계 아이콘">
                    </span>
                    <span id="selectedTimeText"></span>
                </div>
                <div class="info-item">
                    <span class="info-icon">
                        <img src="${pageContext.request.contextPath}/resources/images/icon/person.png" alt="시계 아이콘">
                    </span>
                    <span id="selectedTrainerName">김트레이너</span>
                </div>
            </div>
        </div>

        <div class="time-slots-grid" id="timeSlotsGrid"></div>

        <div class="submit-container">
            <button class="submit-button" onclick="submitBooking()">신청하기</button>
        </div>
    </div>

    <!-- Modal -->
    <div class="modal" id="bookingModal">
        <div class="modal-content">
            <div class="modal-header">
                <div class="modal-title">PT 신청</div>
                <div class="modal-description">선택한 시간으로 PT를 신청하시겠습니까?</div>
            </div>

            <div class="modal-info">
                <div class="info-item">
                    <span class="info-icon">
                        <img src="${pageContext.request.contextPath}/resources/images/icon/calendar.png" alt="캘린더 아이콘">
                    </span>
                    <span id="modalDateDisplay">2025년 11월 4일</span>
                </div>
                <div class="info-item">
                    <span class="info-icon">
                        <img src="${pageContext.request.contextPath}/resources/images/icon/person.png" alt="사람 아이콘">
                    </span>
                    <span id="modalTrainerName">김트레이너</span>
                </div>
            </div>

            <div class="modal-time-slot">
                <div class="time-slot-info">
                    <div class="time-icon">
                        <img src="${pageContext.request.contextPath}/resources/images/icon/clock.png" alt="시계 아이콘">
                    </div>
                    <div class="time-text-container">
                        <div class="time-status">예약 시간</div>
                        <div class="time-range" id="modalTimeRange">17:00 - 18:00</div>
                    </div>
                </div>
            </div>

            <div class="modal-actions">
                <button class="modal-button cancel" onclick="closeModal()">취소</button>
                <button class="modal-button confirm" onclick="confirmBooking()">신청 확정하기</button>
            </div>
        </div>
    </div>

    <!-- 달력 팝업 -->
    <div class="calendar-overlay" id="ptDateCalendarOverlay" onclick="closePtCalendarOnOverlay(event)">
        <div class="calendar-popup" onclick="event.stopPropagation()">
            <div class="calendar-header">
                <button type="button" class="calendar-nav-btn" onclick="prevMonthPtDate()">◀</button>
                <div class="calendar-month" id="ptDateCalendarMonth"></div>
                <button type="button" class="calendar-nav-btn" onclick="nextMonthPtDate()">▶</button>
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

            <div class="calendar-days" id="ptDateCalendarDays"></div>

            <button type="button" class="calendar-close-btn" onclick="closePtDateCalendar()">확인</button>
        </div>
    </div>
</div>

<script>
    let selectedTime = '';
    let selectedDate = null;
    let ptDateCurrentMonth = new Date();
    let ptDateTempSelected = null;

    const timeSlots = [
        { time: "10:00 - 11:00", isBooked: true },
        { time: "11:00 - 12:00", isBooked: false },
        { time: "12:00 - 13:00", isBooked: false },
        { time: "13:00 - 14:00", isBooked: false },
        { time: "14:00 - 15:00", isBooked: false },
        { time: "15:00 - 16:00", isBooked: false },
        { time: "16:00 - 17:00", isBooked: true },
        { time: "17:00 - 18:00", isBooked: false },
        { time: "18:00 - 19:00", isBooked: false },
        { time: "19:00 - 20:00", isBooked: false },
        { time: "20:00 - 21:00", isBooked: false },
        { time: "21:00 - 22:00", isBooked: false }
    ];

    function renderTimeSlots() {
        const grid = document.getElementById('timeSlotsGrid');
        grid.innerHTML = '';

        timeSlots.forEach(function(slot) {
            const timeSlot = document.createElement('div');
            timeSlot.className = 'time-slot' + (slot.isBooked ? ' booked' : '');
            timeSlot.onclick = function() {
                selectTime(slot.time, slot.isBooked);
            };

            const timeSlotInfo = document.createElement('div');
            timeSlotInfo.className = 'time-slot-info';

            const timeIcon = document.createElement('div');
            timeIcon.className = 'time-icon';

            const clockImg = document.createElement('img');
            clockImg.src = '../../../resources/images/icon/clock.png';  // 경로 주의! (현재 JS 기준 상대경로)
            clockImg.alt = '시계 아이콘';     // 접근성용 (선택)
            clockImg.style.width = '20px';     // 원하는 크기
            clockImg.style.height = '20px';
            timeIcon.appendChild(clockImg);

            const timeTextContainer = document.createElement('div');
            timeTextContainer.className = 'time-text-container';

            const timeStatus = document.createElement('div');
            timeStatus.className = 'time-status';
            timeStatus.textContent = slot.isBooked ? '예약된 시간' : '빈 시간';

            const timeRange = document.createElement('div');
            timeRange.className = 'time-range';
            timeRange.textContent = slot.time;

            timeTextContainer.appendChild(timeStatus);
            timeTextContainer.appendChild(timeRange);
            timeSlotInfo.appendChild(timeIcon);
            timeSlotInfo.appendChild(timeTextContainer);

            const addButton = document.createElement('div');
            addButton.className = 'add-button';
            addButton.textContent = '+';

            timeSlot.appendChild(timeSlotInfo);
            timeSlot.appendChild(addButton);
            grid.appendChild(timeSlot);
        });
    }

    function selectTime(time, isBooked) {
        if (isBooked) {
            alert('이미 예약된 시간입니다.');
            return;
        }

        if (confirm(time + ' 시간을 선택하시겠습니까?')) {
            selectedTime = time;
            document.getElementById('selectedTimeDisplay').style.display = 'flex';
            document.getElementById('selectedTimeText').textContent = time;
        }
    }

    function submitBooking() {
        if (!selectedDate) {
            alert('날짜를 먼저 선택해주세요.');
            return;
        }
        
        if (!selectedTime) {
            alert('시간을 먼저 선택해주세요.');
            return;
        }

        document.getElementById('modalTimeRange').textContent = selectedTime;
        document.getElementById('modalDateDisplay').textContent = document.getElementById('selectedDateDisplay').textContent;
        document.getElementById('modalTrainerName').textContent = document.getElementById('selectedTrainerName').textContent;
        document.getElementById('bookingModal').classList.add('show');
    }

    function closeModal() {
        document.getElementById('bookingModal').classList.remove('show');
    }

    function confirmBooking() {
        // 실제 구현 시에는 여기서 서버로 데이터 전송
        alert('PT 예약이 완료되었습니다!');
        closeModal();
        selectedTime = '';
        document.getElementById('selectedTimeDisplay').style.display = 'none';

        // 예약 완료 후 목록 페이지로 이동하거나 새로고침
        // location.href = '${pageContext.request.contextPath}/pt/list';
    }

    // ========================================
    // 달력 관련 함수
    // ========================================

    // 달력 열기
    function openPtDateCalendar() {
        document.getElementById('ptDateCalendarOverlay').classList.add('show');
        renderPtDateCalendar();
    }

    // 달력 닫기
    function closePtDateCalendar() {
        document.getElementById('ptDateCalendarOverlay').classList.remove('show');
        if (ptDateTempSelected) {
            selectedDate = ptDateTempSelected;
            updatePtDateDisplay();
            // 실제 구현 시에는 여기서 해당 날짜의 예약 가능 시간을 조회
            // loadAvailableTimeSlots(selectedDate);
        }
    }

    // 오버레이 클릭 시 닫기
    function closePtCalendarOnOverlay(event) {
        if (event.target === event.currentTarget) {
            closePtDateCalendar();
        }
    }

    // 이전 달
    function prevMonthPtDate() {
        ptDateCurrentMonth.setMonth(ptDateCurrentMonth.getMonth() - 1);
        renderPtDateCalendar();
    }

    // 다음 달
    function nextMonthPtDate() {
        ptDateCurrentMonth.setMonth(ptDateCurrentMonth.getMonth() + 1);
        renderPtDateCalendar();
    }

    // 달력 렌더링
    function renderPtDateCalendar() {
        const year = ptDateCurrentMonth.getFullYear();
        const month = ptDateCurrentMonth.getMonth();

        document.getElementById('ptDateCalendarMonth').textContent =
            year + '년 ' + (month + 1) + '월';

        const firstDay = new Date(year, month, 1).getDay();
        const daysInMonth = new Date(year, month + 1, 0).getDate();
        const today = new Date();

        const daysContainer = document.getElementById('ptDateCalendarDays');
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
                if (ptDateTempSelected &&
                    ptDateTempSelected.getDate() === day &&
                    ptDateTempSelected.getMonth() === month &&
                    ptDateTempSelected.getFullYear() === year) {
                    dayElement.classList.add('selected');
                }

                dayElement.onclick = function() {
                    document.querySelectorAll('#ptDateCalendarDays .calendar-day.selected').forEach(d => {
                        d.classList.remove('selected');
                    });
                    this.classList.add('selected');
                    ptDateTempSelected = new Date(year, month, day);
                };
            }

            daysContainer.appendChild(dayElement);
        }
    }

    // 날짜 표시 업데이트
    function updatePtDateDisplay() {
        if (selectedDate) {
            const year = selectedDate.getFullYear();
            const month = selectedDate.getMonth() + 1;
            const day = selectedDate.getDate();
            const dateText = year + '년 ' + month + '월 ' + day + '일';
            
            document.getElementById('selectedDateDisplay').textContent = dateText;
            document.getElementById('dateInput').value = dateText;
        }
    }

    // 모달 외부 클릭 시 닫기
    document.getElementById('bookingModal').addEventListener('click', function(e) {
        if (e.target === this) {
            closeModal();
        }
    });

    // 페이지 로드 시 타임슬롯 렌더링
    window.onload = function() {
        renderTimeSlots();
    };
    // 트레이너 목록 데이터
    const trainers = [
        {
            id: 1,
            name: '김트레이너',
            avatar: 'K',
            specialty: '체형교정, 근력강화, 다이어트',
            experience: '5년'
        },
        {
            id: 2,
            name: '이트레이너',
            avatar: 'L',
            specialty: '재활운동, 기능성 트레이닝',
            experience: '7년'
        },
        {
            id: 3,
            name: '박트레이너',
            avatar: 'P',
            specialty: '보디빌딩, 근비대',
            experience: '3년'
        },
        {
            id: 4,
            name: '최트레이너',
            avatar: 'C',
            specialty: '필라테스, 요가',
            experience: '4년'
        },
        {
            id: 5,
            name: '정트레이너',
            avatar: 'J',
            specialty: '크로스핏, 기능성 훈련',
            experience: '6년'
        }
    ];

    let selectedTrainer = trainers[0];

    // 트레이너 드롭다운 초기화
    function initTrainerDropdown() {
        const dropdown = document.getElementById('trainerDropdown');
        dropdown.innerHTML = '';

        trainers.forEach(function(trainer) {
            const option = document.createElement('div');
            option.className = 'trainer-option';
            option.onclick = function() {
                selectTrainer(trainer);
            };

            option.innerHTML =
                '<div class="trainer-option-content">' +
                '<div class="trainer-avatar">' + trainer.avatar + '</div>' +
                '<div class="trainer-option-details">' +
                '<span class="trainer-option-name">' + trainer.name + '</span>' +
                '<span class="trainer-option-info">전문 분야: ' + trainer.specialty + '</span>' +
                '<span class="trainer-option-info">경력: ' + trainer.experience + '</span>' +
                '</div>' +
                '</div>';

            dropdown.appendChild(option);
        });
    }

    // 트레이너 선택
    function selectTrainer(trainer) {
        selectedTrainer = trainer;
        document.getElementById('selectedTrainerAvatar').textContent = trainer.avatar;
        document.getElementById('selectedTrainerName').textContent = trainer.name;
        document.getElementById('selectedTrainerSpecialty').textContent = '전문 분야: ' + trainer.specialty;
        document.getElementById('selectedTrainerExperience').textContent = '경력: ' + trainer.experience;

        // 드롭다운 닫기
        document.getElementById('trainerDropdown').classList.remove('show');

        // 실제 구현 시 해당 트레이너의 예약 가능 시간 다시 로드
        // loadAvailableTimeSlots(selectedDate, trainer.id);
    }

    // 트레이너 드롭다운 토글
    function toggleTrainerDropdown() {
        const dropdown = document.getElementById('trainerDropdown');
        dropdown.classList.toggle('show');
    }

    // 드롭다운 외부 클릭 시 닫기
    document.addEventListener('click', function(e) {
        const trainerSelect = document.querySelector('.trainer-select-container');
        if (trainerSelect && !trainerSelect.contains(e.target)) {
            document.getElementById('trainerDropdown').classList.remove('show');
        }
    });

    // 페이지 로드 시 트레이너 드롭다운 초기화
    window.addEventListener('load', function() {
        initTrainerDropdown();
    });
</script>
</body>
</html>