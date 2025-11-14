<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>회원 대시보드 - GymHub</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common.css">
    <style>
        /* 회원 대시보드 전용 스타일 */
        .main-content {
            margin-left: 255px;
            width: calc(100% - 255px);
            padding: 40px 40px 40px 20px;
            min-height: 100vh;
        }

        /* Welcome Message */
        .welcome-message {
            font-size: 32px;
            color: #ff6b00;
            margin-bottom: 50px;
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .welcome-message img {
            width: 40px;
            height: 40px;
        }

        /* Card Grid */
        .card-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 20px;
            margin-bottom: 40px;
        }

        /* Attendance Card */
        .attendance-display {
            text-align: center;
            margin: 20px 0;
        }

        .attendance-number {
            font-size: 30px;
            color: #ff6b00;
            font-weight: 500;
        }

        .attendance-label {
            font-size: 14px;
            color: #8a6a50;
            margin-top: 8px;
        }

        .progress-bar {
            width: 100%;
            height: 8px;
            background: #2d1810;
            border-radius: 999px;
            overflow: hidden;
            margin: 20px 0;
        }

        .progress-fill {
            height: 100%;
            background: #ff6b00;
            width: 72%;
        }

        /* Two Column Layout */
        .two-column {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
            margin-bottom: 40px;
        }

        .large-card {
            background: #1a0f0a;
            border: 1px solid #ff6b00;
            border-radius: 14px;
            padding: 25px;
            min-height: 380px;
        }

        .center-content {
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            height: 200px;
        }

        .large-text {
            font-size: 30px;
            color: #ff6b00;
            margin: 10px 0;
        }

        .medium-text {
            font-size: 18px;
            color: #8a6a50;
            margin: 8px 0;
        }

        /* Notice */
        .notice-list {
            margin-top: 80px;
        }

        .notice-item {
            background: #2d1810;
            border: 1px solid #ff6b00;
            border-radius: 10px;
            padding: 17px;
            margin-bottom: 16px;
        }

        .notice-badge {
            display: inline-block;
            background: #ff6b00;
            color: #0a0a0a;
            padding: 3px 9px;
            border-radius: 8px;
            font-size: 12px;
            margin-bottom: 8px;
            font-weight: 600;
        }

        .notice-title {
            color: #ffa366;
            font-size: 14px;
            margin-bottom: 4px;
        }

        .notice-date {
            color: #8a6a50;
            font-size: 12px;
        }

        /* Video Library */
        .video-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 20px;
            margin-top: 20px;
        }

        .video-card {
            background: #2d1810;
            border: 1px solid #ff6b00;
            border-radius: 10px;
            overflow: hidden;
            cursor: pointer;
            transition: transform 0.3s;
        }

        .video-card:hover {
            transform: translateY(-5px);
        }

        .video-thumbnail {
            width: 100%;
            height: 151px;
            background: linear-gradient(135deg, #ff6b00 0%, #ff8c00 100%);
            display: flex;
            align-items: center;
            justify-content: center;
            position: relative;
            overflow: hidden;
        }

        .video-thumbnail img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .play-button {
            width: 48px;
            height: 48px;
            background: rgba(10, 10, 10, 0.7);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            color: #ff6b00;
            font-size: 20px;
            transition: background 0.3s;
            position: relative;
            z-index: 1;
        }

        .play-button:hover {
            background: rgba(10, 10, 10, 0.9);
        }

        .video-info {
            padding: 12px;
        }

        .video-title {
            color: #ffa366;
            font-size: 16px;
            margin-bottom: 4px;
        }

        .video-author {
            color: #8a6a50;
            font-size: 14px;
        }

        /* Goals */
        .goals-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 24px;
        }

        .goal-item {
            background: #2d1810;
            border-radius: 10px;
            padding: 12px;
            margin-bottom: 12px;
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .checkbox {
            width: 16px;
            height: 16px;
            appearance: none;
            -webkit-appearance: none;
            border: 1px solid #ff6b00;
            border-radius: 4px;
            background: #2d1810;
            cursor: pointer;
            position: relative;
            flex-shrink: 0;
        }

        .checkbox:checked {
            background: #ff6b00;
        }

        .checkbox:checked::after {
            content: "✓";
            color: #0a0a0a;
            position: absolute;
            top: -1px;
            left: 2px;
            font-size: 14px;
            font-weight: bold;
        }

        .goal-text {
            flex: 1;
        }

        .goal-title {
            font-size: 16px;
            color: #ffa366;
            margin-bottom: 4px;
        }

        .goal-title.completed {
            color: #8a6a50;
            text-decoration: line-through;
        }

        .goal-subtitle {
            font-size: 14px;
            color: #8a6a50;
        }

        /* Modal Content */
        .modal-content {
            background: #1a0f0a;
            border: 2px solid #ff6b00;
            border-radius: 16px;
            width: 520px;
            height: 520px;
            position: relative;
            box-shadow: 0 10px 40px rgba(255, 107, 0, 0.3);
            display: flex;
            flex-direction: column;
        }

        /* Close Button */
        .close-button {
            position: absolute;
            top: 17px;
            right: 16px;
            width: 24px;
            height: 24px;
            background: transparent;
            border: none;
            cursor: pointer;
            padding: 0;
            z-index: 10;
            transition: opacity 0.3s;
        }

        .close-button:hover {
            opacity: 0.7;
        }

        .close-button svg {
            width: 100%;
            height: 100%;
        }

        /* Modal Header */
        .modal-header {
            padding: 25px 53px;
            display: flex;
            flex-direction: column;
            gap: 8px;
        }

        .modal-title {
            font-size: 18px;
            color: #ff6b00;
            font-weight: 700;
        }

        /* Tab List */
        .tab-list {
            display: flex;
            background: #31221b;
            border-radius: 14px;
            height: 36px;
            width: 204px;
            overflow: hidden;
        }

        .tab-button {
            flex: 1;
            min-width: 100px;
            background: transparent;
            border: none;
            color: #8a6a50;
            font-size: 14px;
            cursor: pointer;
            border-radius: 14px;
            transition: all 0.3s;
            font-family: 'Noto Sans KR', sans-serif;
            white-space: nowrap;
            padding: 8px 20px;
            text-align: center;
        }

        .tab-button.active {
            background: #ff6b00;
            color: #0a0a0a;
        }

        .tab-button:hover:not(.active) {
            color: #ffa366;
        }

        /* Modal Body */
        .modal-body {
            padding: 0 49px;
            height: 366px;
            overflow-y: auto;
            flex: 1;
        }

        .modal-body::-webkit-scrollbar {
            width: 8px;
        }

        .modal-body::-webkit-scrollbar-track {
            background: #2d1810;
            border-radius: 4px;
        }

        .modal-body::-webkit-scrollbar-thumb {
            background: #ff6b00;
            border-radius: 4px;
        }

        .modal-body::-webkit-scrollbar-thumb:hover {
            background: #ff8800;
        }

        /* Tab Content */
        .tab-content {
            display: block;
        }

        /* Modal Goal Item */
        .modal-goal-item {
            background: #2d1810;
            border-radius: 10px;
            padding: 12px;
            margin-bottom: 12px;
            display: flex;
            align-items: center;
            gap: 12px;
            min-height: 83px;
        }

        .modal-goal-text {
            flex: 1;
        }

        .modal-goal-title {
            font-size: 16px;
            color: #ffa366;
            margin-bottom: 4px;
        }

        .modal-goal-title.completed {
            color: #8a6a50;
            text-decoration: line-through;
        }

        .modal-goal-date {
            font-size: 14px;
            color: #8a6a50;
        }

        .modal-goal-icon {
            width: 20px;
            height: 20px;
            flex-shrink: 0;
        }

        /* Goal Input */
        .goal-input-wrapper {
            background: #2d1810;
            border: 1px solid #ff6b00;
            border-radius: 8px;
            height: 36px;
        }

        .goal-input {
            width: 100%;
            height: 100%;
            background: transparent;
            border: none;
            outline: none;
            padding: 0 13px;
            font-family: 'Noto Sans KR', sans-serif;
            font-size: 14px;
            color: #ffa366;
        }

        .goal-input::placeholder {
            color: #8a6a50;
        }

        /* Modal Buttons */
        .modal-btn {
            flex: 1;
            height: 36px;
            border-radius: 8px;
            font-family: 'Noto Sans KR', sans-serif;
            font-size: 14px;
            cursor: pointer;
            transition: all 0.3s;
            border: none;
        }

        .modal-btn:hover {
            opacity: 0.85;
        }

        .modal-btn-cancel {
            background: #0a0a0a;
            border: 1px solid #8a6a50;
            color: #8a6a50;
        }

        .modal-btn-cancel:hover {
            background: #2d1810;
        }

        .modal-btn-submit {
            background: #ff6b00;
            color: #0a0a0a;
            font-weight: 600;
        }

        .modal-btn-submit:hover {
            background: #ff8800;
        }

        /* Responsive */
        @media (max-width: 1200px) {
            .card-grid {
                grid-template-columns: 1fr;
            }

            .two-column {
                grid-template-columns: 1fr;
            }

            .video-grid {
                grid-template-columns: repeat(2, 1fr);
            }
        }

        @media (max-width: 768px) {
            .video-grid {
                grid-template-columns: 1fr;
            }

            .welcome-message {
                font-size: 24px;
            }

            .modal-content {
                width: 90%;
                max-width: 520px;
                height: auto;
                max-height: 90vh;
            }

            .modal-body {
                max-height: 400px;
            }
        }
    </style>
</head>
<body>
<div class="app-container">
    <!-- Sidebar Include -->
    <jsp:include page="/WEB-INF/views/common/sidebar/sidebarMember.jsp" />

    <!-- Main Content -->
    <div class="main-content">
        <h1 class="welcome-message">
            ${loginMember.memberName}님 환영합니다! 오늘도 힘차게 운동하세요
            <img src="${pageContext.request.contextPath}/resources/images/icon/logo.png" alt="GymHub 로고 아이콘">
        </h1>

        <!-- Top Cards -->
        <div class="card-grid">
            <c:choose>
                <c:when test="${hasGym}">
                    <!-- 회원권 정보 카드 -->
                    <div class="card">
                        <div class="card-title">
                        <span class="card-icon">
                            <img src="${pageContext.request.contextPath}/resources/images/icon/ticket.png" alt="회원권 아이콘">
                        </span>
                            회원권 정보
                            <c:if test="${not empty membership}">
                                <span style="margin-left: auto; color: #8a6a50; font-size: 14px;">남은 기간</span>
                                <span style="color: #ff6b00; font-size: 14px;">${membership.REMAININGDAYS}일</span>
                            </c:if>
                        </div>
                        <c:choose>
                            <c:when test="${not empty membership}">
                                <div class="info-row">
                                    <span class="info-label">이용권</span>
                                    <span class="info-value">${membership.MEMBERSHIPNAME}</span>
                                </div>
                                <div class="info-row">
                                    <span class="info-label">시작일</span>
                                    <span class="info-value">${membership.STARTDATE}</span>
                                </div>
                                <div class="info-row">
                                    <span class="info-label">종료일</span>
                                    <span class="info-value">${membership.ENDDATE}</span>
                                </div>
                                <div class="info-row">
                                    <span class="info-label">락커 번호</span>
                                    <span class="info-value highlight">${membership.LOCKERNO}번</span>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div style="text-align: center; padding: 60px 20px; color: #8a6a50;">
                                    <p style="margin: 0;">회원권을 등록해주세요</p>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>

                    <!-- 출석 카드 -->
                    <div class="card">
                        <div class="card-title">
                    <span class="card-icon">
                        <img src="${pageContext.request.contextPath}/resources/images/icon/calendar.png" alt="출석 아이콘">
                    </span>
                            이번 달 출석
                        </div>
                        <c:choose>
                            <c:when test="${not empty attendance}">
                                <div class="attendance-display">
                                    <div class="attendance-number">${attendance.ATTENDANCECOUNT}일</div>
                                    <div class="attendance-label">이번 달 총 출석일</div>
                                </div>
                                <div class="progress-bar">
                                    <div class="progress-fill" style="width: ${attendance.ACHIEVEMENTRATE}%;"></div>
                                </div>
                                <div class="info-row">
                                    <span class="info-label">목표 달성률</span>
                                    <span class="info-value highlight">${attendance.ACHIEVEMENTRATE}%</span>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div style="text-align: center; padding: 60px 20px; color: #8a6a50;">
                                    <p style="margin: 0;">출석 기록이 없습니다</p>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>

                    <!-- PT Info Card -->
                    <div class="card">
                        <div class="card-title">
                            <span class="card-icon">
                                <img src="${pageContext.request.contextPath}/resources/images/icon/calendar.png" alt="PT 아이콘">
                            </span>
                            PT 정보
                        </div>
                        <c:choose>
                            <c:when test="${not empty ptInfo}">
                                <div class="info-row">
                                    <span class="info-label">담당 트레이너</span>
                                    <span class="info-value">${ptInfo.TRAINERNAME} 코치</span>
                                </div>
                                <div class="info-row">
                                    <span class="info-label">다음 예약 일정</span>
                                    <span class="info-value">${ptInfo.NEXTSCHEDULE}</span>
                                </div>
                                <div class="info-row">
                                    <span class="info-label">남은 횟수</span>
                                    <span class="info-value highlight">${ptInfo.REMAININGCOUNT}회 / ${ptInfo.TOTALCOUNT}회</span>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div style="text-align: center; padding: 60px 20px; color: #8a6a50;">
                                    <p style="margin: 0;">등록된 PT 정보가 없습니다</p>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </c:when>
                <c:otherwise>
                    <!-- gym_no가 없을 때: 회원권 정보 카드 -->
                    <div class="card" style="position: relative;">
                        <div style="filter: blur(5px);">
                            <div class="card-title">
                        <span class="card-icon">
                            <img src="${pageContext.request.contextPath}/resources/images/icon/ticket.png" alt="회원권 아이콘">
                        </span>
                                회원권 정보
                            </div>
                            <div class="info-row">
                                <span class="info-label">이용권</span>
                                <span class="info-value">정보 없음</span>
                            </div>
                            <div class="info-row">
                                <span class="info-label">시작일</span>
                                <span class="info-value">----</span>
                            </div>
                            <div class="info-row">
                                <span class="info-label">종료일</span>
                                <span class="info-value">----</span>
                            </div>
                        </div>
                        <div style="position: absolute; top: 50%; left: 50%; transform: translate(-50%, -50%);
                            background: rgba(26, 15, 10, 0.95); padding: 20px; border-radius: 10px;
                            border: 1px solid #ff6b00; text-align: center; color: #ff6b00;
                            font-size: 14px; white-space: nowrap;">
                            헬스장을 등록하고<br>헬스장의 정보를 받아보세요!
                        </div>
                    </div>

                    <!-- gym_no가 없을 때: 출석 카드 -->
                    <div class="card" style="position: relative;">
                        <div style="filter: blur(5px);">
                            <div class="card-title">
                        <span class="card-icon">
                            <img src="${pageContext.request.contextPath}/resources/images/icon/calendar.png" alt="출석 아이콘">
                        </span>
                                이번 달 출석
                            </div>
                            <div class="attendance-display">
                                <div class="attendance-number">0일</div>
                                <div class="attendance-label">이번 달 총 출석일</div>
                            </div>
                        </div>
                        <div style="position: absolute; top: 50%; left: 50%; transform: translate(-50%, -50%);
                            background: rgba(26, 15, 10, 0.95); padding: 20px; border-radius: 10px;
                            border: 1px solid #ff6b00; text-align: center; color: #ff6b00;
                            font-size: 14px; white-space: nowrap;">
                            헬스장을 등록하고<br>출석 정보를 확인하세요!
                        </div>
                    </div>

                    <!-- gym_no가 없을 때: PT 정보 카드 -->
                    <div class="card" style="position: relative;">
                        <div style="filter: blur(5px);">
                            <div class="card-title">
                        <span class="card-icon">
                            <img src="${pageContext.request.contextPath}/resources/images/icon/calendar.png" alt="PT 아이콘">
                        </span>
                                PT 정보
                            </div>
                            <div class="info-row">
                                <span class="info-label">담당 트레이너</span>
                                <span class="info-value">정보 없음</span>
                            </div>
                        </div>
                        <div style="position: absolute; top: 50%; left: 50%; transform: translate(-50%, -50%);
                            background: rgba(26, 15, 10, 0.95); padding: 20px; border-radius: 10px;
                            border: 1px solid #ff6b00; text-align: center; color: #ff6b00;
                            font-size: 14px; white-space: nowrap;">
                            헬스장을 등록하고<br>PT 정보를 확인하세요!
                        </div>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>

        <!-- Two Column Section -->
        <div class="two-column">
            <c:choose>
                <c:when test="${hasGym}">
                    <!-- Congestion Card -->
                    <div class="large-card">
                        <div class="card-title">
                    <span class="card-icon">
                        <img src="${pageContext.request.contextPath}/resources/images/icon/people.png" alt="혼잡도 아이콘">
                    </span>
                            현재 혼잡도
                        </div>
                        <c:choose>
                            <c:when test="${not empty congestion}">
                                <div class="center-content">
                                    <div class="large-text">${congestion.CURRENTDATE}</div>
                                    <div class="large-text">${congestion.CURRENTTIME}</div>
                                    <div class="medium-text">현재 이용인원</div>
                                    <div class="large-text">${congestion.CURRENTCOUNT} 명</div>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="center-content">
                                    <div style="color: #8a6a50; text-align: center;">
                                        혼잡도 정보를 불러올 수 없습니다
                                    </div>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>

                    <!-- My Gym Card -->
                    <div class="large-card">
                        <div class="card-title">
                    <span class="card-icon">
                        <img src="${pageContext.request.contextPath}/resources/images/icon/company.png" alt="헬스장 아이콘">
                    </span>
                            나의 헬스장
                        </div>
                        <c:choose>
                            <c:when test="${not empty gymInfo}">
                                <div class="center-content">
                                    <div class="large-text">${gymInfo.GYMNAME}</div>
                                </div>
                                <div class="notice-list">
                                    <c:choose>
                                        <c:when test="${not empty notices}">
                                            <c:forEach var="notice" items="${notices}">
                                                <div class="notice-item">
                                                    <c:if test="${notice.ISIMPORTANT == 'Y'}">
                                                        <span class="notice-badge">중요</span>
                                                    </c:if>
                                                    <div class="notice-title">${notice.NOTICETITLE}</div>
                                                    <div class="notice-date">${notice.NOTICEDATE}</div>
                                                </div>
                                            </c:forEach>
                                        </c:when>
                                        <c:otherwise>
                                            <div style="text-align: center; padding: 20px; color: #8a6a50;">
                                                등록된 공지사항이 없습니다
                                            </div>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="center-content">
                                    <div style="color: #8a6a50; text-align: center;">
                                        헬스장 정보를 불러올 수 없습니다
                                    </div>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </c:when>
                <c:otherwise>
                    <!-- gym_no가 없을 때: Congestion Card -->
                    <div class="large-card" style="position: relative;">
                        <div style="filter: blur(5px);">
                            <div class="card-title">
                        <span class="card-icon">
                            <img src="${pageContext.request.contextPath}/resources/images/icon/people.png" alt="혼잡도 아이콘">
                        </span>
                                현재 혼잡도
                            </div>
                            <div class="center-content">
                                <div class="large-text">2025년 10월 30일</div>
                                <div class="large-text">14:00</div>
                                <div class="medium-text">현재 이용인원</div>
                                <div class="large-text">0 명</div>
                            </div>
                        </div>
                        <div style="position: absolute; top: 50%; left: 50%; transform: translate(-50%, -50%);
                            background: rgba(26, 15, 10, 0.95); padding: 20px; border-radius: 10px;
                            border: 1px solid #ff6b00; text-align: center; color: #ff6b00;
                            font-size: 14px; white-space: nowrap;">
                            헬스장을 등록하고<br>실시간 혼잡도를 확인하세요!
                        </div>
                    </div>

                    <!-- gym_no가 없을 때: My Gym Card -->
                    <div class="large-card" style="position: relative;">
                        <div style="filter: blur(5px);">
                            <div class="card-title">
                        <span class="card-icon">
                            <img src="${pageContext.request.contextPath}/resources/images/icon/company.png" alt="헬스장 아이콘">
                        </span>
                                나의 헬스장
                            </div>
                            <div class="center-content">
                                <div class="large-text">헬스장 이름</div>
                            </div>
                            <div class="notice-list">
                                <div class="notice-item">
                                    <span class="notice-badge">중요</span>
                                    <div class="notice-title">공지사항 제목</div>
                                    <div class="notice-date">2025.10.25</div>
                                </div>
                            </div>
                        </div>
                        <div style="position: absolute; top: 50%; left: 50%; transform: translate(-50%, -50%);
                            background: rgba(26, 15, 10, 0.95); padding: 20px; border-radius: 10px;
                            border: 1px solid #ff6b00; text-align: center; color: #ff6b00;
                            font-size: 14px; white-space: nowrap;">
                            헬스장을 등록하고<br>헬스장 정보와 공지사항을 확인하세요!
                        </div>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>

        <!-- Goals Section -->
        <div class="large-card">
            <div class="goals-header">
                <div class="card-title">
            <span class="card-icon">
                <img src="${pageContext.request.contextPath}/resources/images/icon/target.png" alt="목표 아이콘">
            </span>
                    운동 목표
                </div>
                <div class="btn-group">
                    <button class="search-btn" id="goalManagementBtn">목표 관리</button>
                    <button class="search-btn" id="addGoalBtn">운동 목표 추가</button>
                </div>
            </div>

            <div id="dashboardGoalsList">
                <c:choose>
                    <c:when test="${not empty goals}">
                        <c:forEach var="goal" items="${goals}" varStatus="status">
                            <c:if test="${status.index < 5}">
                                <div class="goal-item">
                                    <div class="goal-text">
                                        <div class="goal-title ${goal.goalStatus eq '달성' ? 'completed' : ''}">${goal.goalTitle}</div>
                                        <div class="goal-subtitle">${goal.goalDate}</div>
                                    </div>
                                </div>
                            </c:if>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <div style="text-align: center; padding: 60px 20px; color: #8a6a50;">
                            <p style="margin: 0;">등록된 운동 목표가 없습니다</p>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>

        <!-- Video Library -->
        <div class="large-card" style="margin-top: 40px;">
            <div class="goals-header">
                <div>
                    <div class="card-title">
                <span class="card-icon">
                    <img src="${pageContext.request.contextPath}/resources/images/icon/book.png" alt="라이브러리 아이콘">
                </span>
                        운동 영상 라이브러리
                    </div>
                </div>
                <c:if test="${hasGym && not empty videos}">
                    <button type="button" class="search-btn" id="videoListBtn">+ 더보기</button>
                </c:if>
            </div>

            <c:choose>
                <c:when test="${hasGym}">
                    <c:choose>
                        <c:when test="${not empty videos}">
                            <div class="video-grid">
                                <c:forEach var="video" items="${videos}">
                                    <div class="video-card" data-video-url="${video.VIDEOURL}">
                                        <div class="video-thumbnail">
                                            <img src="" alt="${video.VIDEOTITLE}" class="video-thumbnail-img" data-video-url="${video.VIDEOURL}" onerror="this.src='https://images.unsplash.com/photo-1571019614242-c5c5dee9f50b?w=400&h=300&fit=crop'" style="width: 100%; height: 100%; object-fit: cover; position: absolute; top: 0; left: 0;">
                                            <div class="play-button" style="position: relative; z-index: 1;">▶</div>
                                        </div>
                                        <div class="video-info">
                                            <div class="video-title">${video.VIDEOTITLE}</div>
                                            <div class="video-author">${video.VIDEOAUTHOR}</div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div style="text-align: center; padding: 60px 20px; color: #8a6a50;">
                                <p style="margin: 0; font-size: 16px;">등록된 운동 영상이 없습니다</p>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </c:when>
                <c:otherwise>
                    <!-- gym_no가 없을 때 블러 처리 -->
                    <div style="position: relative; min-height: 200px;">
                        <div style="filter: blur(5px); pointer-events: none;">
                            <div class="video-grid">
                                <div class="video-card">
                                    <div class="video-thumbnail">
                                        <div class="play-button">▶</div>
                                    </div>
                                    <div class="video-info">
                                        <div class="video-title">올바른 스쿼트 자세</div>
                                        <div class="video-author">김트레이너</div>
                                    </div>
                                </div>

                                <div class="video-card">
                                    <div class="video-thumbnail">
                                        <div class="play-button">▶</div>
                                    </div>
                                    <div class="video-info">
                                        <div class="video-title">데드리프트 마스터</div>
                                        <div class="video-author">이코치</div>
                                    </div>
                                </div>

                                <div class="video-card">
                                    <div class="video-thumbnail">
                                        <div class="play-button">▶</div>
                                    </div>
                                    <div class="video-info">
                                        <div class="video-title">어깨 운동 루틴</div>
                                        <div class="video-author">박강사</div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div style="position: absolute; top: 50%; left: 50%; transform: translate(-50%, -50%);
                            background: rgba(26, 15, 10, 0.95); padding: 25px 30px; border-radius: 10px;
                            border: 1px solid #ff6b00; text-align: center; color: #ff6b00;
                            font-size: 15px; line-height: 1.6; z-index: 10; white-space: nowrap;">
                            헬스장을 등록하고<br>트레이너 추천 영상을 확인하세요!
                        </div>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>

        <!-- 운동 영상 리스트 모달 추가 (기존 모달들 다음에 추가) -->
        <div class="modal-overlay" id="videoListModal">
            <div class="modal-content" style="width: 1200px; max-height: 90vh; overflow-y: auto;">
                <!-- Close Button -->
                <button class="close-button" id="closeVideoListBtn">
                    <svg fill="none" viewBox="0 0 16 16">
                        <path d="M12 4L4 12" stroke="#FFA366" stroke-linecap="round" stroke-linejoin="round" stroke-width="1.33333" />
                        <path d="M4 4L12 12" stroke="#FFA366" stroke-linecap="round" stroke-linejoin="round" stroke-width="1.33333" />
                    </svg>
                </button>

                <!-- Header -->
                <div class="modal-header">
                    <h2 class="modal-title">운동 영상 라이브러리</h2>
                    <p style="color: #8a6a50; font-size: 14px; margin-top: 8px;">트레이너 추천 운동 영상을 확인하세요</p>
                </div>

                <div class="modal-body">
                    <c:choose>
                        <c:when test="${not empty allVideos}">
                            <div class="video-grid" style="grid-template-columns: repeat(4, 1fr); gap: 20px;">
                                <c:forEach var="video" items="${allVideos}">
                                    <div class="video-card" data-video-url="${video.VIDEOURL}">
                                        <div class="video-thumbnail">
                                            <img src="" alt="${video.VIDEOTITLE}" class="video-thumbnail-img" data-video-url="${video.VIDEOURL}" onerror="this.src='https://images.unsplash.com/photo-1571019614242-c5c5dee9f50b?w=400&h=300&fit=crop'" style="width: 100%; height: 100%; object-fit: cover; position: absolute; top: 0; left: 0;">
                                            <div class="play-button" style="position: relative; z-index: 1;">▶</div>
                                        </div>
                                        <div class="video-info">
                                            <div class="video-title">${video.VIDEOTITLE}</div>
                                            <div class="video-author">${video.VIDEOAUTHOR}</div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div style="text-align: center; padding: 60px 20px; color: #8a6a50;">
                                <p style="margin: 0; font-size: 16px;">등록된 운동 영상이 없습니다</p>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
    </div>

    <!-- Goal Management Modal -->
    <div class="modal-overlay" id="goalModal">
        <div class="modal-content">
            <!-- Close Button -->
            <button class="close-button" id="closeModalBtn">
                <svg fill="none" viewBox="0 0 16 16">
                    <path d="M12 4L4 12" stroke="#FFA366" stroke-linecap="round" stroke-linejoin="round" stroke-width="1.33333" />
                    <path d="M4 4L12 12" stroke="#FFA366" stroke-linecap="round" stroke-linejoin="round" stroke-width="1.33333" />
                </svg>
            </button>

            <!-- Header -->
            <div class="modal-header">
                <h2 class="modal-title">목표 관리</h2>
                <div class="tab-list">
                    <button class="tab-button active" data-tab="goals">목표</button>
                    <button class="tab-button" data-tab="completed">달성한 목표</button>
                </div>
            </div>

            <!-- Body -->
            <div class="modal-body">
                <!-- Goals Tab -->
                <div id="goalsTab" class="tab-content">
                    <!-- JavaScript로 동적으로 채워질 영역 -->
                </div>

                <!-- Completed Tab -->
                <div id="completedTab" class="tab-content" style="display: none;">

                </div>
            </div>
        </div>
    </div>

    <!-- Add Goal Modal -->
    <div class="modal-overlay" id="addGoalModal">
        <div class="modal-content" style="width: 512px; height: 252px;">
            <!-- Close Button -->
            <button class="close-button" id="closeAddGoalBtn">
                <svg fill="none" viewBox="0 0 16 16">
                    <path d="M12 4L4 12" stroke="#FFA366" stroke-linecap="round" stroke-linejoin="round" stroke-width="1.33333" />
                    <path d="M4 4L12 12" stroke="#FFA366" stroke-linecap="round" stroke-linejoin="round" stroke-width="1.33333" />
                </svg>
            </button>

            <!-- Header -->
            <div style="padding: 25px 25px 0;">
                <h2 class="modal-title">운동 목표 추가</h2>
                <p style="color: #8a6a50; font-size: 14px; margin-top: 8px;">달성하고싶은 목표를 작성하세요</p>
            </div>

            <!-- Body -->
            <div style="padding: 16px 25px 25px;">
                <!-- Input Container -->
                <div style="margin-bottom: 16px;">
                    <label style="display: block; color: #ffa366; font-size: 14px; margin-bottom: 8px;">목표 입력</label>
                    <div class="goal-input-wrapper">
                        <input
                                type="text"
                                id="goalInput"
                                class="goal-input"
                                placeholder="데드리프트 220KG 달성"
                        />
                    </div>
                </div>

                <!-- Buttons -->
                <div style="display: flex; gap: 12px; padding-top: 16px;">
                    <button class="modal-btn modal-btn-cancel" id="cancelAddGoalBtn">취소</button>
                    <button class="modal-btn modal-btn-submit" id="submitAddGoalBtn">목표 설정!</button>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- Video Detail Modal -->
<div class="modal-overlay" id="videoDetailModal">
    <div class="modal-content" style="width: 800px; height: auto; max-height: 90vh;">
        <!-- Close Button -->
        <button class="close-button" id="closeVideoDetailBtn">
            <svg fill="none" viewBox="0 0 16 16">
                <path d="M12 4L4 12" stroke="#FFA366" stroke-linecap="round" stroke-linejoin="round" stroke-width="1.33333" />
                <path d="M4 4L12 12" stroke="#FFA366" stroke-linecap="round" stroke-linejoin="round" stroke-width="1.33333" />
            </svg>
        </button>

        <!-- Header -->
        <div style="padding: 25px 25px 0;">
            <h2 class="modal-title" id="videoModalTitle">올바른 스쿼트 자세</h2>
            <p style="color: #8a6a50; font-size: 14px; margin-top: 8px;" id="videoModalAuthor">김트레이너</p>
        </div>

        <!-- Body -->
        <div style="padding: 16px 25px 25px;">
            <!-- Video Player -->
            <div style="position: relative; padding-bottom: 56.25%; height: 0; overflow: hidden; border-radius: 10px; background: #1a0f0a;">
                <iframe id="videoPlayerFrame" style="position: absolute; top: 0; left: 0; width: 100%; height: 100%; border: none;" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
            </div>
        </div>
    </div>
</div>

<script>
    // 기존 스크립트에 추가할 내용
    document.addEventListener('DOMContentLoaded', function() {
        // ========== 기존 코드 시작 ==========
        // Modal 관련 요소
        const modal = document.getElementById('goalModal');
        const openBtn = document.getElementById('goalManagementBtn');
        const closeBtn = document.getElementById('closeModalBtn');
        const tabButtons = document.querySelectorAll('.tab-button');
        const goalsTab = document.getElementById('goalsTab');
        const completedTab = document.getElementById('completedTab');

        // Add Goal Modal 관련 요소
        const addGoalModal = document.getElementById('addGoalModal');
        const addGoalBtn = document.getElementById('addGoalBtn');
        const closeAddGoalBtn = document.getElementById('closeAddGoalBtn');
        const cancelAddGoalBtn = document.getElementById('cancelAddGoalBtn');
        const submitAddGoalBtn = document.getElementById('submitAddGoalBtn');
        const goalInput = document.getElementById('goalInput');

        // Video Detail Modal 관련 요소
        const videoDetailModal = document.getElementById('videoDetailModal');
        const closeVideoDetailBtn = document.getElementById('closeVideoDetailBtn');
        const videoCards = document.querySelectorAll('.video-card');

        // 목표 관리 모달 열기
        if (openBtn) {
            openBtn.addEventListener('click', function() {
                modal.classList.add('active');
            });
        }

        // 목표 관리 모달 닫기
        if (closeBtn) {
            closeBtn.addEventListener('click', function() {
                modal.classList.remove('active');
            });
        }

        // 목표 관리 모달 오버레이 클릭시 닫기
        if (modal) {
            modal.addEventListener('click', function(e) {
                if (e.target === modal) {
                    modal.classList.remove('active');
                }
            });
        }

        // 탭 전환
        tabButtons.forEach(function(button) {
            button.addEventListener('click', function() {
                tabButtons.forEach(function(btn) {
                    btn.classList.remove('active');
                });
                button.classList.add('active');

                const tab = button.getAttribute('data-tab');
                if (tab === 'goals') {
                    goalsTab.style.display = 'block';
                    completedTab.style.display = 'none';
                } else {
                    goalsTab.style.display = 'none';
                    completedTab.style.display = 'block';
                }
            });
        });

        // 목표 추가 모달 열기
        if (addGoalBtn) {
            addGoalBtn.addEventListener('click', function() {
                addGoalModal.classList.add('active');
                if (goalInput) {
                    goalInput.focus();
                }
            });
        }

        // 목표 추가 모달 닫기
        if (closeAddGoalBtn) {
            closeAddGoalBtn.addEventListener('click', function() {
                addGoalModal.classList.remove('active');
                if (goalInput) {
                    goalInput.value = '';
                }
            });
        }

        if (cancelAddGoalBtn) {
            cancelAddGoalBtn.addEventListener('click', function() {
                addGoalModal.classList.remove('active');
                if (goalInput) {
                    goalInput.value = '';
                }
            });
        }

        // 목표 추가 모달 오버레이 클릭시 닫기
        if (addGoalModal) {
            addGoalModal.addEventListener('click', function(e) {
                if (e.target === addGoalModal) {
                    addGoalModal.classList.remove('active');
                    if (goalInput) {
                        goalInput.value = '';
                    }
                }
            });
        }

        // 목표 제출
        if (submitAddGoalBtn) {
            submitAddGoalBtn.addEventListener('click', function() {
                if (goalInput) {
                    const goal = goalInput.value.trim();
                    if (goal) {
                        console.log('새 목표:', goal);
                        alert('목표가 추가되었습니다: ' + goal);
                        addGoalModal.classList.remove('active');
                        goalInput.value = '';
                    } else {
                        alert('목표를 입력해주세요.');
                    }
                }
            });
        }

        // Enter 키로 제출
        if (goalInput) {
            goalInput.addEventListener('keypress', function(e) {
                if (e.key === 'Enter') {
                    submitAddGoalBtn.click();
                }
            });
        }

        // 비디오 카드 클릭시 모달 열기
        videoCards.forEach(function(card) {
            card.addEventListener('click', function() {
                var title = card.querySelector('.video-title').textContent;
                var author = card.querySelector('.video-author').textContent;
                var videoUrl = card.getAttribute('data-video-url');

                document.getElementById('videoModalTitle').textContent = title;
                document.getElementById('videoModalAuthor').textContent = author;

                // YouTube 영상 재생
                var embedUrl = convertToEmbedUrl(videoUrl);
                if (embedUrl) {
                    document.getElementById('videoPlayerFrame').src = embedUrl;
                } else {
                    alert('유효하지 않은 YouTube URL입니다.');
                    return;
                }

                videoDetailModal.classList.add('active');
            });
        });

        // 비디오 상세 모달 닫기
        if (closeVideoDetailBtn) {
            closeVideoDetailBtn.addEventListener('click', function() {
                videoDetailModal.classList.remove('active');
                // iframe 비워서 영상 중지
                document.getElementById('videoPlayerFrame').src = '';
            });
        }

        // 비디오 상세 모달 오버레이 클릭시 닫기
        if (videoDetailModal) {
            videoDetailModal.addEventListener('click', function(e) {
                if (e.target === videoDetailModal) {
                    videoDetailModal.classList.remove('active');
                    // iframe 비워서 영상 중지
                    document.getElementById('videoPlayerFrame').src = '';
                }
            });
        }

        // 목표 체크박스 기능
        const goalCheckboxes = document.querySelectorAll('.goal-checkbox');
        goalCheckboxes.forEach(function(checkbox) {
            checkbox.addEventListener('click', function(e) {
                e.stopPropagation();

                const circlePath = this.querySelector('.circle-path');
                const checkPath = this.querySelector('.check-path');
                const goalItem = this.closest('.modal-goal-item');
                const goalTitle = goalItem.querySelector('.modal-goal-title');
                const goalsTab = document.getElementById('goalsTab');
                const completedTab = document.getElementById('completedTab');

                const isChecked = checkPath.style.display === 'block';

                if (isChecked) {
                    // 체크 해제
                    checkPath.style.display = 'none';
                    circlePath.setAttribute('stroke', '#8A6A50');
                    goalTitle.classList.remove('completed');

                    // 달성한 목표 탭에서 해당 목표 찾아서 삭제
                    const completedItems = completedTab.querySelectorAll('.modal-goal-item');
                    completedItems.forEach(function(item) {
                        if (item.querySelector('.modal-goal-title').textContent === goalTitle.textContent) {
                            item.remove();
                        }
                    });
                } else {
                    // 체크 (목표 달성)
                    checkPath.style.display = 'block';
                    circlePath.setAttribute('stroke', '#FF6B00');
                    goalTitle.classList.add('completed');
                    goalsTab.appendChild(goalItem);

                    // 달성한 목표 탭으로 복사
                    const clonedItem = goalItem.cloneNode(true);
                    completedTab.appendChild(clonedItem);

                    // 복사된 항목의 체크박스에 이벤트 리스너 추가
                    const newCheckbox = clonedItem.querySelector('.goal-checkbox');
                    addCheckboxEvent(newCheckbox);
                }
            });
        });

        // 체크박스 이벤트를 추가하는 함수 (달성한 목표 탭용)
        function addCheckboxEvent(checkbox) {
            checkbox.addEventListener('click', function(e) {
                e.stopPropagation();

                const goalItem = this.closest('.modal-goal-item');
                const goalTitle = goalItem.querySelector('.modal-goal-title');

                // 달성한 목표에서 삭제
                if (confirm('이 목표를 삭제하시겠습니까?')) {
                    goalItem.remove();

                    // 목표 탭에서도 완전히 삭제
                    const goalsTab = document.getElementById('goalsTab');
                    const goalItems = goalsTab.querySelectorAll('.modal-goal-item');
                    goalItems.forEach(function(item) {
                        const title = item.querySelector('.modal-goal-title');
                        if (title.textContent === goalTitle.textContent) {
                            item.remove();
                        }
                    });
                }
            });
        }
        // ========== 기존 코드 끝 ==========

        // ========== 추가된 코드: 운동 영상 리스트 모달 ==========
        const videoListModal = document.getElementById('videoListModal');
        const videoListBtn = document.getElementById('videoListBtn');
        const closeVideoListBtn = document.getElementById('closeVideoListBtn');

        // 운동 영상 리스트 모달 열기
        if (videoListBtn) {
            videoListBtn.addEventListener('click', function() {
                videoListModal.classList.add('active');
            });
        }

        // 운동 영상 리스트 모달 닫기
        if (closeVideoListBtn) {
            closeVideoListBtn.addEventListener('click', function() {
                videoListModal.classList.remove('active');
            });
        }

        // 운동 영상 리스트 모달 오버레이 클릭시 닫기
        if (videoListModal) {
            videoListModal.addEventListener('click', function(e) {
                if (e.target === videoListModal) {
                    videoListModal.classList.remove('active');
                }
            });
        }

        // 리스트 모달 안의 비디오 카드 클릭시 상세 모달 열기
        var videoListModalCards = videoListModal.querySelectorAll('.video-card');
        videoListModalCards.forEach(function(card) {
            card.addEventListener('click', function() {
                var title = card.querySelector('.video-title').textContent;
                var author = card.querySelector('.video-author').textContent;
                var videoUrl = card.getAttribute('data-video-url');

                document.getElementById('videoModalTitle').textContent = title;
                document.getElementById('videoModalAuthor').textContent = author;

                // YouTube 영상 재생
                var embedUrl = convertToEmbedUrl(videoUrl);
                if (embedUrl) {
                    document.getElementById('videoPlayerFrame').src = embedUrl;
                } else {
                    alert('유효하지 않은 YouTube URL입니다.');
                    return;
                }

                videoListModal.classList.remove('active');
                videoDetailModal.classList.add('active');
            });
        });

        // ESC 키로 모달 닫기 (모든 모달 포함)
        document.addEventListener('keydown', function(e) {
            if (e.key === 'Escape') {
                if (modal && modal.classList.contains('active')) {
                    modal.classList.remove('active');
                }
                if (addGoalModal && addGoalModal.classList.contains('active')) {
                    addGoalModal.classList.remove('active');
                    if (goalInput) {
                        goalInput.value = '';
                    }
                }
                if (videoDetailModal && videoDetailModal.classList.contains('active')) {
                    videoDetailModal.classList.remove('active');
                    document.getElementById('videoPlayerFrame').src = '';
                }
                if (videoListModal && videoListModal.classList.contains('active')) {
                    videoListModal.classList.remove('active');
                }
            }
        });
    });
    // YouTube 썸네일 설정 함수
    function getYouTubeThumbnail(url) {
        if (!url) return 'https://images.unsplash.com/photo-1571019614242-c5c5dee9f50b?w=400&h=300&fit=crop';

        var videoId = '';
        if (url.includes('youtube.com/watch?v=')) {
            videoId = url.split('v=')[1].split('&')[0];
        } else if (url.includes('youtu.be/')) {
            videoId = url.split('youtu.be/')[1].split('?')[0];
        }

        if (videoId) {
            return 'https://img.youtube.com/vi/' + videoId + '/maxresdefault.jpg';
        }
        return 'https://images.unsplash.com/photo-1571019614242-c5c5dee9f50b?w=400&h=300&fit=crop';
    }

    // YouTube URL을 embed URL로 변환
    function convertToEmbedUrl(url) {
        if (!url) return '';

        var videoId = '';
        if (url.includes('youtube.com/watch?v=')) {
            videoId = url.split('v=')[1].split('&')[0];
        } else if (url.includes('youtu.be/')) {
            videoId = url.split('youtu.be/')[1].split('?')[0];
        } else if (url.includes('youtube.com/embed/')) {
            return url;
        }

        if (videoId) {
            return 'https://www.youtube.com/embed/' + videoId;
        }
        return '';
    }

    // 모든 비디오 썸네일 이미지에 대해 YouTube 썸네일 설정
    var thumbnailImgs = document.querySelectorAll('.video-thumbnail-img');
    thumbnailImgs.forEach(function(img) {
        var videoUrl = img.getAttribute('data-video-url');
        if (videoUrl) {
            img.src = getYouTubeThumbnail(videoUrl);
        }
    });
</script>
</body>
</html>
