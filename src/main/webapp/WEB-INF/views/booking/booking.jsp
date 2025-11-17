<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
            flex-wrap: wrap;
        }

        .gym-badge {
            background-color: #2d1810;
            border: 1px solid #ff6b00;
            color: #ffa366;
            padding: 3px 9px;
            border-radius: 8px;
            font-size: 12px;
        }

        /* 선택된 날짜 표시 */
        .selected-date-display {
            display: flex;
            gap: 24px;
            align-items: center;
            margin-top: 12px;
        }

        .date-info {
            display: flex;
            align-items: center;
            gap: 8px;
            color: #8a6a50;
            font-size: 13px;
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
            gap: 12px;
            margin-bottom: 20px;
            padding-bottom: 12px;
            border-bottom: 1px solid #ff6b00;
        }

        .section-title {
            font-size: 15px;
            color: #ff6b00;
            font-weight: 600;
        }

        /* 날짜 선택 */
        .date-selector {
            display: flex;
            align-items: center;
            gap: 12px;
            padding: 14px 18px;
            background-color: #2d1810;
            border: 1px solid #ff6b00;
            border-radius: 10px;
            cursor: pointer;
            transition: background-color 0.2s;
        }

        .date-selector:hover {
            background-color: #3a2820;
        }

        .date-text {
            flex: 1;
            color: #8a6a50;
            font-size: 14px;
        }

        /* 입력 필드 */
        .input-group {
            margin-bottom: 16px;
        }

        .input-label {
            display: block;
            color: #8a6a50;
            font-size: 13px;
            margin-bottom: 8px;
        }

        .required {
            color: #ff6b00;
            margin-left: 4px;
        }

        .optional {
            color: #8a6a50;
            font-size: 12px;
            margin-left: 4px;
        }

        .input-field {
            width: 100%;
            padding: 12px 16px;
            background-color: #2d1810;
            border: 1px solid #ff6b00;
            border-radius: 10px;
            color: #fff;
            font-size: 14px;
            transition: border-color 0.2s;
        }

        .input-field:focus {
            outline: none;
            border-color: #ffa366;
        }

        .input-field::placeholder {
            color: #8a6a50;
        }

        .input-field:read-only {
            background-color: #1a0f0a;
            cursor: not-allowed;
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
            flex-shrink: 0;
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

        /* 버튼 */
        .button-group {
            display: flex;
            gap: 12px;
        }

        .button-group.justify-end {
            justify-content: flex-end;
        }

        .cancel-btn {
            padding: 14px 32px;
            background-color: transparent;
            border: 1px solid #ff6b00;
            border-radius: 10px;
            color: #ffa366;
            font-size: 14px;
            cursor: pointer;
            transition: all 0.2s;
        }

        .cancel-btn:hover {
            background-color: rgba(255, 107, 0, 0.1);
        }

        .submit-btn {
            padding: 14px 32px;
            background-color: #ff6b00;
            border: none;
            border-radius: 10px;
            color: #0a0a0a;
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
            transition: background-color 0.2s;
        }

        .submit-btn:hover {
            background-color: #ff8533;
        }

        /* 달력 팝업 */
        .calendar-overlay {
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: rgba(0, 0, 0, 0.7);
            display: none;
            align-items: center;
            justify-content: center;
            z-index: 1000;
        }

        .calendar-overlay.show {
            display: flex;
        }

        .calendar-popup {
            background-color: #1a0f0a;
            border: 2px solid #ff6b00;
            border-radius: 14px;
            padding: 24px;
            width: 400px;
            max-width: 90%;
        }

        .calendar-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }

        .calendar-month {
            font-size: 16px;
            color: #ff6b00;
            font-weight: 600;
        }

        .calendar-nav-btn {
            background: none;
            border: none;
            color: #ffa366;
            font-size: 18px;
            cursor: pointer;
            padding: 4px 12px;
        }

        .calendar-weekdays {
            display: grid;
            grid-template-columns: repeat(7, 1fr);
            gap: 8px;
            margin-bottom: 8px;
        }

        .calendar-weekday {
            text-align: center;
            color: #8a6a50;
            font-size: 13px;
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
            font-size: 14px;
            cursor: pointer;
            transition: all 0.2s;
        }

        .calendar-day.current-month {
            color: #fff;
            background-color: #2d1810;
        }

        .calendar-day.other-month {
            color: #4a3a30;
        }

        .calendar-day.today {
            border: 1px solid #ff6b00;
        }

        .calendar-day.selected {
            background-color: #ff6b00;
            color: #0a0a0a;
            font-weight: 600;
        }

        .calendar-day.current-month:hover {
            background-color: #3a2820;
        }

        .calendar-day.disabled {
            color: #4a3a30;
            cursor: not-allowed;
            background-color: #1a0f0a;
        }

        .calendar-close-btn {
            width: 100%;
            padding: 12px;
            background-color: #ff6b00;
            border: none;
            border-radius: 10px;
            color: #0a0a0a;
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
            margin-top: 16px;
        }

        /* 확인 모달 */
        .confirm-overlay {
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: rgba(0, 0, 0, 0.7);
            display: none;
            align-items: center;
            justify-content: center;
            z-index: 2000;
        }

        .confirm-overlay.show {
            display: flex;
        }

        .confirm-modal {
            background-color: #1a0f0a;
            border: 2px solid #ff6b00;
            border-radius: 14px;
            padding: 30px;
            width: 480px;
            max-width: 90%;
        }

        .confirm-title {
            font-size: 18px;
            color: #ff6b00;
            font-weight: 600;
            margin-bottom: 24px;
            text-align: center;
        }

        .confirm-content {
            background-color: #2d1810;
            border-radius: 10px;
            padding: 20px;
            margin-bottom: 24px;
        }

        .confirm-section {
            margin-bottom: 20px;
        }

        .confirm-section:last-child {
            margin-bottom: 0;
        }

        .confirm-section-title {
            font-size: 13px;
            color: #ffa366;
            margin-bottom: 12px;
            font-weight: 600;
        }

        .confirm-row {
            display: flex;
            justify-content: space-between;
            padding: 10px 0;
            border-bottom: 1px solid #3a2820;
        }

        .confirm-row:last-child {
            border-bottom: none;
        }

        .confirm-label {
            color: #8a6a50;
            font-size: 13px;
        }

        .confirm-value {
            color: #fff;
            font-size: 14px;
            font-weight: 500;
        }

        .confirm-buttons {
            display: flex;
            gap: 12px;
        }

        .confirm-cancel-btn {
            flex: 1;
            padding: 14px;
            background-color: transparent;
            border: 1px solid #ff6b00;
            border-radius: 10px;
            color: #ffa366;
            font-size: 14px;
            cursor: pointer;
        }

        .confirm-submit-btn {
            flex: 1;
            padding: 14px;
            background-color: #ff6b00;
            border: none;
            border-radius: 10px;
            color: #0a0a0a;
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 6px;
        }

        .confirm-submit-btn:hover {
            background-color: #ff8533;
        }

        /* 기존 예약 알림 모달 */
        .existing-reserve-overlay {
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: rgba(0, 0, 0, 0.8);
            display: none;
            align-items: center;
            justify-content: center;
            z-index: 3000;
        }

        .existing-reserve-overlay.show {
            display: flex;
        }

        .existing-reserve-modal {
            background-color: #1a0f0a;
            border: 2px solid #ff6b00;
            border-radius: 14px;
            padding: 30px;
            width: 480px;
            max-width: 90%;
            text-align: center;
        }

        .existing-reserve-icon {
            width: 60px;
            height: 60px;
            margin: 0 auto 20px;
            background-color: #ff6b00;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .existing-reserve-title {
            font-size: 18px;
            color: #ff6b00;
            font-weight: 600;
            margin-bottom: 16px;
        }

        .existing-reserve-message {
            font-size: 14px;
            color: #8a6a50;
            line-height: 1.6;
            margin-bottom: 24px;
        }

        .existing-reserve-info {
            background-color: #2d1810;
            border-radius: 10px;
            padding: 20px;
            margin-bottom: 24px;
            text-align: left;
        }

        .existing-reserve-btn {
            width: 100%;
            padding: 14px;
            background-color: #ff6b00;
            border: none;
            border-radius: 10px;
            color: #0a0a0a;
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
        }

        /* 반응형 */
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
    <div class="logo" onclick="goToIndex()" style="cursor: pointer;">
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
                <div class="gym-name">${gym.gymName}</div>
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
                        <span>${gym.gymName}</span>
                    </div>
                </div>
            </div>
            <div class="gym-badges">
                <!-- FACILITIES_INFO를 ","로 split하여 배지 표시 -->
                <c:if test="${not empty gymDetail and not empty gymDetail.facilitiesInfo}">
                    <c:forEach var="facility" items="${fn:split(gymDetail.facilitiesInfo, ',')}">
                        <span class="gym-badge">${fn:trim(facility)}</span>
                    </c:forEach>
                </c:if>
                <c:if test="${empty gymDetail or empty gymDetail.facilitiesInfo}">
                    <span class="gym-badge">정보 없음</span>
                </c:if>
            </div>
        </div>
    </div>

    <!-- 예약 폼 -->
    <form id="bookingForm" action="${pageContext.request.contextPath}/booking/submit.me" method="post">
        <!-- Hidden 필드 -->
        <input type="hidden" name="gymNo" value="${gym.gymNo}">
        <input type="hidden" name="visitDate" id="hiddenDate">
        <input type="hidden" name="visitTime" id="hiddenTime">

        <div class="form-container">
            <!-- 일정 선택 -->
            <div class="section">
                <div class="section-header">
                    <svg width="20" height="20" viewBox="0 0 20 20" fill="none">
                        <path d="M6.66667 1.66667V5" stroke="#FF6B00" stroke-width="1.66667" stroke-linecap="round" stroke-linejoin="round"/>
                        <path d="M13.3333 1.66667V5" stroke="#FF6B00" stroke-width="1.66667" stroke-linecap="round" stroke-linejoin="round"/>
                        <path d="M15.8333 3.33334H4.16667C3.24619 3.33334 2.5 4.07953 2.5 5V16.6667C2.5 17.5872 3.24619 18.3333 4.16667 18.3333H15.8333C16.7538 18.3333 17.5 17.5872 17.5 16.6667V5C17.5 4.07953 16.7538 3.33334 15.8333 3.33334Z" stroke="#FF6B00" stroke-width="1.66667" stroke-linecap="round" stroke-linejoin="round"/>
                        <path d="M2.5 8.33334H17.5" stroke="#FF6B00" stroke-width="1.66667" stroke-linecap="round" stroke-linejoin="round"/>
                    </svg>
                    <div class="section-title">일정 선택</div>
                </div>

                <div class="date-selector" onclick="openCalendar()">
                    <svg width="20" height="20" viewBox="0 0 20 20" fill="none">
                        <path d="M6.66667 1.66667V5" stroke="#8A6A50" stroke-width="1.66667" stroke-linecap="round" stroke-linejoin="round"/>
                        <path d="M13.3333 1.66667V5" stroke="#8A6A50" stroke-width="1.66667" stroke-linecap="round" stroke-linejoin="round"/>
                        <path d="M15.8333 3.33334H4.16667C3.24619 3.33334 2.5 4.07953 2.5 5V16.6667C2.5 17.5872 3.24619 18.3333 4.16667 18.3333H15.8333C16.7538 18.3333 17.5 17.5872 17.5 16.6667V5C17.5 4.07953 16.7538 3.33334 15.8333 3.33334Z" stroke="#8A6A50" stroke-width="1.66667" stroke-linecap="round" stroke-linejoin="round"/>
                        <path d="M2.5 8.33334H17.5" stroke="#8A6A50" stroke-width="1.66667" stroke-linecap="round" stroke-linejoin="round"/>
                    </svg>
                    <span class="date-text" id="selectedDateText">날짜를 선택하세요</span>
                    <svg width="20" height="20" viewBox="0 0 20 20" fill="none">
                        <path d="M5 7.5L10 12.5L15 7.5" stroke="#8A6A50" stroke-width="1.66667" stroke-linecap="round" stroke-linejoin="round"/>
                    </svg>
                </div>
            </div>

            <!-- 예약자 정보 -->
            <div class="section">
                <div class="section-header">
                    <svg width="20" height="20" viewBox="0 0 20 20" fill="none">
                        <path d="M16.6667 17.5V15.8333C16.6667 14.9493 16.3155 14.1014 15.6904 13.4763C15.0652 12.8512 14.2174 12.5 13.3333 12.5H6.66667C5.78261 12.5 4.93476 12.8512 4.30964 13.4763C3.68452 14.1014 3.33333 14.9493 3.33333 15.8333V17.5" stroke="#FF6B00" stroke-width="1.66667" stroke-linecap="round" stroke-linejoin="round"/>
                        <path d="M10 9.16667C11.8409 9.16667 13.3333 7.67428 13.3333 5.83333C13.3333 3.99238 11.8409 2.5 10 2.5C8.15905 2.5 6.66667 3.99238 6.66667 5.83333C6.66667 7.67428 8.15905 9.16667 10 9.16667Z" stroke="#FF6B00" stroke-width="1.66667" stroke-linecap="round" stroke-linejoin="round"/>
                    </svg>
                    <div class="section-title">예약자 정보</div>
                </div>

                <div class="input-group">
                    <label class="input-label">이름<span class="required">*</span></label>
                    <input type="text" class="input-field" value="${loginMember.memberName}" readonly>
                </div>

                <div class="input-group">
                    <label class="input-label">전화번호<span class="required">*</span></label>
                    <input type="tel" class="input-field" value="${loginMember.memberPhone}" readonly>
                </div>

                <div class="input-group">
                    <label class="input-label">이메일<span class="optional">(선택)</span></label>
                    <input type="email" class="input-field" value="${loginMember.memberEmail}" readonly>
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

<!-- 예약 정보 확인 모달 -->
<div class="confirm-overlay" id="confirmOverlay">
    <div class="confirm-modal">
        <div class="confirm-title">예약 정보 확인</div>

        <div class="confirm-content">
            <!-- 헬스장 정보 -->
            <div class="confirm-section">
                <div class="confirm-section-title">헬스장 정보</div>
                <div class="confirm-row">
                    <span class="confirm-label">헬스장</span>
                    <span class="confirm-value">${gym.gymName}</span>
                </div>
            </div>

            <!-- 예약 일정 -->
            <div class="confirm-section">
                <div class="confirm-section-title">예약 일정</div>
                <div class="confirm-row">
                    <span class="confirm-label">날짜</span>
                    <span class="confirm-value" id="confirmDate"></span>
                </div>
                <div class="confirm-row">
                    <span class="confirm-label">시간</span>
                    <span class="confirm-value" id="confirmTime"></span>
                </div>
            </div>

            <!-- 예약자 정보 -->
            <div class="confirm-section">
                <div class="confirm-section-title">예약자 정보</div>
                <div class="confirm-row">
                    <span class="confirm-label">이름</span>
                    <span class="confirm-value">${loginMember.memberName}</span>
                </div>
                <div class="confirm-row">
                    <span class="confirm-label">전화번호</span>
                    <span class="confirm-value">${loginMember.memberPhone}</span>
                </div>
                <c:if test="${not empty loginMember.memberEmail}">
                    <div class="confirm-row">
                        <span class="confirm-label">이메일</span>
                        <span class="confirm-value">${loginMember.memberEmail}</span>
                    </div>
                </c:if>
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

<!-- 기존 예약 확인 모달 -->
<c:if test="${not empty existingReserve}">
    <div class="existing-reserve-overlay show" id="existingReserveOverlay">
        <div class="existing-reserve-modal">
            <div class="existing-reserve-icon">
                <svg width="32" height="32" viewBox="0 0 32 32" fill="none">
                    <path d="M16 10.6667V16" stroke="#0A0A0A" stroke-width="2.66667" stroke-linecap="round" stroke-linejoin="round"/>
                    <path d="M16 21.3333H16.0133" stroke="#0A0A0A" stroke-width="2.66667" stroke-linecap="round" stroke-linejoin="round"/>
                    <path d="M16 28C22.6274 28 28 22.6274 28 16C28 9.37258 22.6274 4 16 4C9.37258 4 4 9.37258 4 16C4 22.6274 9.37258 28 16 28Z" stroke="#0A0A0A" stroke-width="2.66667" stroke-linecap="round" stroke-linejoin="round"/>
                </svg>
            </div>

            <div class="existing-reserve-title">이미 예약이 존재합니다</div>

            <div class="existing-reserve-message">
                해당 헬스장에 이미 예약이 있습니다.<br>
                기존 예약을 확인해주세요.
            </div>

            <div class="existing-reserve-info">
                <div class="confirm-row">
                    <span class="confirm-label">헬스장</span>
                    <span class="confirm-value">${gym.gymName}</span>
                </div>
                <div class="confirm-row">
                    <span class="confirm-label">예약 상태</span>
                    <span class="confirm-value">${existingReserve.inquiryStatus}</span>
                </div>
            </div>

            <button type="button" class="existing-reserve-btn" onclick="goToIndex()">확인</button>
        </div>
    </div>
</c:if>

<script>
    // 서버에서 전달받은 예약된 시간대 (JSTL로 JavaScript 배열 생성)
    var reservedTimesFromServer = [
        <c:forEach var="time" items="${reservedTimes}" varStatus="status">
        '${time}'<c:if test="${!status.last}">,</c:if>
        </c:forEach>
    ];

    // 시간대 생성
    var timeSlots = [
        '10:00 - 11:00', '11:00 - 12:00', '12:00 - 13:00',
        '13:00 - 14:00', '14:00 - 15:00', '15:00 - 16:00',
        '16:00 - 17:00', '17:00 - 18:00', '18:00 - 19:00',
        '19:00 - 20:00', '20:00 - 21:00', '21:00 - 22:00'
    ];

    var selectedTime = null;
    var selectedDate = null;
    var currentMonth = new Date();
    var tempSelectedDate = null;

    // 시간대 렌더링
    function renderTimeSlots() {
        var container = document.getElementById('timeSlotsContainer');
        container.innerHTML = '';

        // 날짜가 선택되지 않았으면 메시지 표시
        if (!selectedDate) {
            container.innerHTML = '<p style="color: #8a6a50; text-align: center; grid-column: 1 / -1;">날짜를 먼저 선택해주세요.</p>';
            return;
        }

        // 선택된 날짜를 'YYYY-MM-DD' 형식으로 변환
        var year = selectedDate.getFullYear();
        var month = ('0' + (selectedDate.getMonth() + 1)).slice(-2);
        var day = ('0' + selectedDate.getDate()).slice(-2);
        var selectedDateString = year + '-' + month + '-' + day;

        for (var i = 0; i < timeSlots.length; i++) {
            var time = timeSlots[i];
            var startTime = time.split(' - ')[0]; // '10:00'
            var dateTimeToCheck = selectedDateString + ' ' + startTime; // 'YYYY-MM-DD 10:00'

            // 서버에서 받은 예약된 시간과 비교
            var isReserved = reservedTimesFromServer.indexOf(dateTimeToCheck) !== -1;
            var statusClass = isReserved ? 'reserved' : 'available';
            var statusText = isReserved ? '예약 불가 시간' : '빈 시간';

            // 시간대 div 생성
            var slotDiv = document.createElement('div');
            slotDiv.className = 'time-slot ' + statusClass;

            slotDiv.innerHTML =
                '<div class="time-slot-content">' +
                '<div class="time-slot-icon">' +
                '<svg width="20" height="20" viewBox="0 0 17 17" fill="none">' +
                '<path d="M8.33333 4.16671V8.33333L10.8333 10.8333" stroke="#FF6B00" stroke-width="1.66667" stroke-linecap="round" stroke-linejoin="round"/>' +
                '<path d="M8.33333 15.8333C12.4754 15.8333 15.8333 12.4754 15.8333 8.33333C15.8333 4.1912 12.4754 0.833335 8.33333 0.833335C4.1912 0.833335 0.833335 4.1912 0.833335 8.33333C0.833335 12.4754 4.1912 15.8333 8.33333 15.8333Z" stroke="#FF6B00" stroke-width="1.66667" stroke-linecap="round" stroke-linejoin="round"/>' +
                '</svg>' +
                '</div>' +
                '<div class="time-slot-info">' +
                '<div class="time-slot-status">' + statusText + '</div>' +
                '<div class="time-slot-time">' + time + '</div>' +
                '</div>' +
                '<button type="button" class="time-slot-btn" onclick="event.stopPropagation()">+</button>' +
                '</div>';

            // 예약되지 않은 시간만 클릭 가능
            if (!isReserved) {
                slotDiv.onclick = (function(timeValue) {
                    return function() {
                        selectTime(timeValue);
                    };
                })(time);
            }

            container.appendChild(slotDiv);
        }
    }

    // 시간대 선택
    function selectTime(time) {
        // 기존 선택 해제
        var slots = document.querySelectorAll('.time-slot');
        for (var i = 0; i < slots.length; i++) {
            slots[i].classList.remove('selected');
        }

        // 새로운 선택 적용
        var container = document.getElementById('timeSlotsContainer');
        var timeSlots = container.getElementsByClassName('time-slot');

        for (var i = 0; i < timeSlots.length; i++) {
            var slot = timeSlots[i];
            var timeText = slot.querySelector('.time-slot-time');

            if (timeText && timeText.textContent === time) {
                // 예약된 시간이 아닌 경우만 선택
                if (!slot.classList.contains('reserved')) {
                    slot.classList.add('selected');
                    selectedTime = time;
                }
                break;
            }
        }
    }

    // 달력 열기
    function openCalendar() {
        tempSelectedDate = selectedDate ? new Date(selectedDate) : null;
        renderCalendar();
        document.getElementById('calendarOverlay').classList.add('show');
        document.body.style.overflow = 'hidden';
    }

    // 달력 닫기
    function closeCalendar() {
        if (tempSelectedDate) {
            selectedDate = new Date(tempSelectedDate);
            updateSelectedDateDisplay();
            renderTimeSlots(); // 날짜 선택 후 시간대 다시 렌더링
        }
        document.getElementById('calendarOverlay').classList.remove('show');
        document.body.style.overflow = '';
    }

    // 오버레이 클릭 시 달력 닫기
    function closeCalendarOnOverlay(event) {
        if (event.target.id === 'calendarOverlay') {
            closeCalendar();
        }
    }

    // 달력 렌더링
    function renderCalendar() {
        var year = currentMonth.getFullYear();
        var month = currentMonth.getMonth();

        // 월 표시
        var monthNames = ['1월', '2월', '3월', '4월', '5월', '6월',
            '7월', '8월', '9월', '10월', '11월', '12월'];
        document.getElementById('calendarMonth').textContent = year + '년 ' + monthNames[month];

        // 날짜 계산
        var firstDay = new Date(year, month, 1).getDay();
        var lastDate = new Date(year, month + 1, 0).getDate();
        var today = new Date();
        today.setHours(0, 0, 0, 0);

        var daysContainer = document.getElementById('calendarDays');
        daysContainer.innerHTML = '';

        // 이전 달 빈 칸
        for (var i = 0; i < firstDay; i++) {
            var emptyDay = document.createElement('div');
            emptyDay.className = 'calendar-day other-month';
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

            // 과거 날짜 비활성화
            if (currentDate < today) {
                dayElement.classList.add('disabled');
            } else {
                // 날짜 선택 이벤트
                dayElement.onclick = (function(d) {
                    return function() {
                        selectDate(new Date(year, month, d));
                    };
                })(date);

                // 선택된 날짜 표시
                if (tempSelectedDate &&
                    tempSelectedDate.getFullYear() === year &&
                    tempSelectedDate.getMonth() === month &&
                    tempSelectedDate.getDate() === date) {
                    dayElement.classList.add('selected');
                }
            }

            daysContainer.appendChild(dayElement);
        }
    }

    // 날짜 선택
    function selectDate(date) {
        tempSelectedDate = date;
        renderCalendar();
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

    // 선택된 날짜 표시 업데이트
    function updateSelectedDateDisplay() {
        if (selectedDate) {
            var weekdays = ['일요일', '월요일', '화요일', '수요일', '목요일', '금요일', '토요일'];
            var year = selectedDate.getFullYear();
            var month = selectedDate.getMonth() + 1;
            var day = selectedDate.getDate();
            var weekday = weekdays[selectedDate.getDay()];

            var dateString = year + '년 ' + month + '월 ' + day + '일 ' + weekday;
            document.getElementById('selectedDateText').textContent = dateString;
            document.getElementById('displaySelectedDate').textContent = dateString;

            // Hidden 필드에 저장 (YYYY-MM-DD 형식)
            var monthStr = month < 10 ? '0' + month : month;
            var dayStr = day < 10 ? '0' + day : day;
            document.getElementById('hiddenDate').value = year + '-' + monthStr + '-' + dayStr;
        }
    }

    // 예약하기 버튼 클릭
    function submitBooking() {
        // 1. 날짜 선택 확인
        if (!selectedDate) {
            alert('날짜를 선택해주세요.');
            return;
        }

        // 2. 시간 선택 확인
        if (!selectedTime) {
            alert('시간대를 선택해주세요.');
            return;
        }

        // 3. 예약 확인 모달 표시
        showConfirmModal();
    }

    // 예약 확인 모달 열기
    function showConfirmModal() {
        // 날짜 포맷 변환
        var weekdays = ['일요일', '월요일', '화요일', '수요일', '목요일', '금요일', '토요일'];
        var year = selectedDate.getFullYear();
        var month = selectedDate.getMonth() + 1;
        var day = selectedDate.getDate();
        var weekday = weekdays[selectedDate.getDay()];

        var formattedDate = year + '년 ' + month + '월 ' + day + '일 ' + weekday;

        // 시간 포맷 (전체 시간 표시)
        var timeDisplay = selectedTime;

        // 모달에 정보 표시
        document.getElementById('confirmDate').textContent = formattedDate;
        document.getElementById('confirmTime').textContent = timeDisplay;

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

    // 예약 확정 (폼 제출)
    function confirmBooking() {
        // sessionStorage에 예약 완료 플래그 저장
        sessionStorage.setItem('visitReserved', 'true');

        // 폼 제출
        document.getElementById('bookingForm').submit();
    }

    // 인덱스로 이동
    function goToIndex() {
        window.location.href = '${pageContext.request.contextPath}/';
    }

    // 초기화
    document.addEventListener('DOMContentLoaded', function() {
        // 페이지 로드 시 오늘 날짜로 기본 설정
        selectedDate = new Date();
        selectedDate.setHours(0, 0, 0, 0);
        tempSelectedDate = new Date(selectedDate);
        updateSelectedDateDisplay();
        renderTimeSlots();
    });
    
    function goToIndex() {
        window.location.href = '${pageContext.request.contextPath}/';
    }

</script>
</body>
</html>
