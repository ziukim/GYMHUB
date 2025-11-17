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
            padding: 24px;
        }

        .page-header {
            margin-bottom: 24px;
        }

        .header-left {
            display: flex;
            align-items: center;
            gap: 16px;
        }

        .back-button {
            width: 40px;
            height: 40px;
            background-color: transparent;
            border: 1px solid #ff6b00;
            border-radius: 8px;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            font-size: 20px;
            color: #ff6b00;
            transition: all 0.2s;
            flex-shrink: 0;
        }

        .back-button:hover {
            background-color: rgba(255, 107, 0, 0.1);
        }

        .page-title-wrapper h1 {
            font-size: 30px;
            font-weight: 900;
            color: #ff6b00;
            margin: 0;
        }

        .page-subtitle {
            font-size: 14px;
            color: #8a6a50;
            margin-top: 4px;
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
            transition: all 0.2s;
            border: 1px solid transparent;
        }

        .time-slot:hover:not(.booked):not(.selected) {
            opacity: 0.8;
            border-color: #ff6b00;
        }

        .time-slot.booked {
            background-color: #1a0f0a;
            cursor: not-allowed;
            opacity: 0.6;
        }

        .time-slot.selected {
            background-color: #ff6b00;
            cursor: pointer;
            border-color: #ff6b00;
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
            color: #8a6a50;
        }

        .time-slot.selected .time-status {
            color: #1a0f0a;
            font-weight: 700;
        }

        .time-range {
            font-size: 11px;
            color: #8a6a50;
            line-height: 1;
        }

        .time-slot.booked .time-range {
            color: #6a5a50;
        }

        .time-slot.selected .time-range {
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
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .submit-button:hover {
            opacity: 0.9;
        }

        .modal-content {
            display: none;
            position: fixed;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            background: linear-gradient(180deg, #1a0f0a 0%, #0a0a0a 100%);
            border: 2px solid #ff6b00;
            border-radius: 12px;
            padding: 25px;
            max-width: 600px;
            width: 90vw;
            max-height: 90vh;
            overflow-y: auto;
            box-shadow: 0 0 30px rgba(255, 107, 0, 0.3);
            z-index: 3000;
        }

        .modal-content.show {
            display: block;
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
        <!-- Header -->
        <div class="page-header">
            <div class="header-left">
                <button class="back-button" onclick="history.back()">←</button>
                <div class="page-title-wrapper">
                    <h1 class="page-title">PT 예약</h1>
                    <div class="page-subtitle">나의 퍼스널 트레이닝 일정을 관리하세요</div>
                </div>
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
                    <span id="scheduleTrainerName">트레이너를 선택하세요</span>
                </div>
            </div>
        </div>

        <div class="time-slots-grid" id="timeSlotsGrid"></div>

        <div class="submit-container">
            <button class="submit-button" onclick="submitBooking()">신청하기</button>
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

<!-- Modal (app-container 밖으로 이동) -->
<div class="modal-content" id="bookingModal">
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
            <span id="modalTrainerName">트레이너</span>
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

<script>
    let selectedTime = '';
    let selectedDate = null;
    let ptDateCurrentMonth = new Date();
    let ptDateTempSelected = null;

    const timeSlots = [
        { time: "10:00 - 11:00", isBooked: false },
        { time: "11:00 - 12:00", isBooked: false },
        { time: "12:00 - 13:00", isBooked: false },
        { time: "13:00 - 14:00", isBooked: false },
        { time: "14:00 - 15:00", isBooked: false },
        { time: "15:00 - 16:00", isBooked: false },
        { time: "16:00 - 17:00", isBooked: false },
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

            // 클래스 설정: 예약된 시간, 선택된 시간, 빈 시간 구분
            var slotClass = 'time-slot';

            // 날짜가 선택되지 않았으면 비활성화
            if (!selectedDate) {
                slotClass += ' booked';
                timeSlot.style.cursor = 'not-allowed';
            } else {
                if (slot.isBooked) {
                    slotClass += ' booked';
                }
                if (selectedTime === slot.time) {
                    slotClass += ' selected';
                }

                timeSlot.onclick = function() {
                    selectTime(slot.time, slot.isBooked);
                };
            }

            timeSlot.className = slotClass;

            const timeSlotInfo = document.createElement('div');
            timeSlotInfo.className = 'time-slot-info';

            const timeIcon = document.createElement('div');
            timeIcon.className = 'time-icon';

            const clockImg = document.createElement('img');
            clockImg.src = '../../../resources/images/icon/clock.png';
            clockImg.alt = '시계 아이콘';
            clockImg.style.width = '20px';
            clockImg.style.height = '20px';
            timeIcon.appendChild(clockImg);

            const timeTextContainer = document.createElement('div');
            timeTextContainer.className = 'time-text-container';

            const timeStatus = document.createElement('div');
            timeStatus.className = 'time-status';

            // 선택된 시간인 경우 '선택한 시간', 예약된 시간은 '예약된 시간', 나머지는 '빈 시간'
            if (selectedTime === slot.time) {
                timeStatus.textContent = '선택한 시간';
            } else if (slot.isBooked) {
                timeStatus.textContent = '예약된 시간';
            } else {
                timeStatus.textContent = '빈 시간';
            }

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

            // 시간 슬롯 다시 렌더링하여 선택된 시간 하이라이트
            renderTimeSlots();
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
        document.getElementById('modalTrainerName').textContent = selectedTrainer ? selectedTrainer.name : '트레이너 없음';
        document.getElementById('bookingModal').classList.add('show');
    }

    function closeModal() {
        document.getElementById('bookingModal').classList.remove('show');
    }

    function confirmBooking() {
        if (!selectedTrainer || !selectedDate || !selectedTime) {
            alert('모든 정보를 선택해주세요.');
            return;
        }

        // 날짜 포맷 (yyyy-MM-dd)
        var year = selectedDate.getFullYear();
        var month = String(selectedDate.getMonth() + 1).padStart(2, '0');
        var day = String(selectedDate.getDate()).padStart(2, '0');
        var dateStr = year + '-' + month + '-' + day;

        // 시간 추출 ("10:00 - 11:00" -> "10:00")
        var timeOnly = selectedTime.split(' - ')[0];

        // 예약 날짜시간 조합
        var reserveDateTime = dateStr + ' ' + timeOnly;

        // AJAX로 PT 예약 신청
        fetch('${pageContext.request.contextPath}/pt/reserve.do', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded'
            },
            body: 'trainerNo=' + selectedTrainer.id + '&reserveDateTime=' + encodeURIComponent(reserveDateTime)
        })
            .then(function(response) {
                return response.json();
            })
            .then(function(data) {
                if (data.success) {
                    alert('PT 예약이 신청되었습니다!');
                    closeModal();
                    location.href = '${pageContext.request.contextPath}/schedule.me';
                } else {
                    alert(data.message || 'PT 예약 신청에 실패했습니다.');
                }
            })
            .catch(function(error) {
                console.error('PT 예약 신청 오류:', error);
                alert('예약 처리 중 오류가 발생했습니다.');
            });
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
            // 예약된 시간 조회
            loadBookedTimeSlots();
        }
    }

    // 예약된 시간 조회 함수
    function loadBookedTimeSlots() {
        if (!selectedTrainer || !selectedDate) {
            console.log('loadBookedTimeSlots 취소: 트레이너 또는 날짜 미선택');
            return;
        }

        var year = selectedDate.getFullYear();
        var month = String(selectedDate.getMonth() + 1).padStart(2, '0');
        var day = String(selectedDate.getDate()).padStart(2, '0');
        var dateStr = year + '-' + month + '-' + day;

        console.log('예약 시간 조회 요청:', {
            trainerNo: selectedTrainer.id,
            trainerName: selectedTrainer.name,
            date: dateStr
        });

        fetch('${pageContext.request.contextPath}/pt/bookedSlots.ajax?trainerNo=' + selectedTrainer.id + '&date=' + dateStr)
            .then(function(response) {
                return response.json();
            })
            .then(function(data) {
                console.log('서버 응답:', data);
                if (data.success) {
                    var bookedSlots = data.bookedSlots || [];
                    console.log('예약된 시간:', bookedSlots);
                    updateTimeSlots(bookedSlots);
                }
            })
            .catch(function(error) {
                console.error('예약 시간 조회 오류:', error);
            });
    }

    // 시간 슬롯 예약 상태 업데이트
    function updateTimeSlots(bookedSlots) {
        console.log('updateTimeSlots 실행, bookedSlots:', bookedSlots);
        timeSlots.forEach(function(slot) {
            var slotTime = slot.time.split(' - ')[0];
            slot.isBooked = bookedSlots.indexOf(slotTime) >= 0;
            console.log('  슬롯:', slotTime, '→', slot.isBooked ? '예약됨' : '빈 시간');
        });
        renderTimeSlots();
        console.log('화면 재렌더링 완료');
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

    // 페이지 로드 시 타임슬롯 렌더링
    window.onload = function() {
        renderTimeSlots();
    };
    // 트레이너 목록 데이터 (DB에서 가져오기)
    var trainers = [];
    <c:choose>
    <c:when test="${not empty bookingData and not empty bookingData.trainerList}">
    <c:forEach var="trainer" items="${bookingData.trainerList}">
    trainers.push({
        id: ${trainer.memberNo},
        name: '${trainer.memberName}',
        avatar: 'T',
        specialty: '${not empty trainer.trainerLicense ? trainer.trainerLicense : "-"}',
        experience: '${not empty trainer.trainerCareer ? trainer.trainerCareer : "-"}'
    });
    </c:forEach>
    </c:when>
    </c:choose>

    // 트레이너가 없으면 기본값
    if (trainers.length === 0) {
        trainers = [{
            id: 0,
            name: '트레이너 없음',
            avatar: 'X',
            specialty: '-',
            experience: '-'
        }];
    }

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

        // 일정 선택 카드의 트레이너 이름도 업데이트
        document.getElementById('scheduleTrainerName').textContent = trainer.name;

        // 드롭다운 닫기
        document.getElementById('trainerDropdown').classList.remove('show');

        // 날짜가 선택되어 있으면 예약된 시간 다시 조회
        if (selectedDate) {
            loadBookedTimeSlots();
        }
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

    // 페이지 로드 시 트레이너 드롭다운 초기화 및 첫 번째 트레이너 표시
    window.addEventListener('load', function() {
        initTrainerDropdown();

        // 첫 번째 트레이너 정보를 화면에 표시
        if (selectedTrainer && selectedTrainer.id !== 0) {
            document.getElementById('selectedTrainerName').textContent = selectedTrainer.name;
            document.getElementById('selectedTrainerAvatar').textContent = selectedTrainer.avatar;
            document.getElementById('selectedTrainerSpecialty').textContent = '전문 분야: ' + selectedTrainer.specialty;
            document.getElementById('selectedTrainerExperience').textContent = '경력: ' + selectedTrainer.experience;

            // 일정 선택 카드의 트레이너 이름도 업데이트
            document.getElementById('scheduleTrainerName').textContent = selectedTrainer.name;
        }
    });
</script>
</body>
</html>