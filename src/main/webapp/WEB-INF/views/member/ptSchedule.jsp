<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>GymHub - PT 스케줄</title>

    <!-- Common CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common.css">

    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=ADLaM+Display&family=ABeeZee&family=Noto+Sans+KR:wght@400;900&family=Abhaya+Libre:wght@800&display=swap" rel="stylesheet">

    <style>
        .main-content {
            flex: 1;
            width: 100%;
            max-width: 100%;
            padding: 40px 40px 40px 20px;
            margin-left: 0;
        }
        /* Main Content 추가 스타일 */
        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 24px;
        }

        .header-title h1 {
            font-family: 'Abhaya Libre', 'Noto Sans KR', sans-serif;
            font-size: 30px;
            font-weight: 900;
            color: #ff6b00;
            margin-bottom: 8px;
        }

        .header-title p {
            font-size: 16px;
            color: #8a6a50;
        }

        .btn-primary {
            display: flex;
            align-items: center;
            gap: 8px;
            padding: 8px 12px;
            background-color: #ff6b00;
            border: none;
            border-radius: 8px;
            color: #0a0a0a;
            font-size: 14px;
            cursor: pointer;
            transition: background-color 0.2s;
        }

        .btn-primary:hover {
            background-color: #ff7b10;
        }

        /* Stats Cards */
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 24px;
            margin-bottom: 24px;
        }

        .stat-card {
            background-color: #1a0f0a;
            border: 1px solid #ff6b00;
            border-radius: 14px;
            padding: 25px;
            height: 183px;
        }

        .stat-card-header {
            display: flex;
            align-items: center;
            gap: 8px;
            margin-bottom: 30px;
        }

        .stat-icon {
            width: 20px;
            height: 20px;
        }

        .stat-title {
            font-size: 16px;
            color: #ff6b00;
        }

        .stat-value {
            font-size: 30px;
            color: #ffa366;
            margin-bottom: 8px;
        }

        .progress-bar {
            width: 100%;
            height: 8px;
            background-color: rgba(255, 107, 0, 0.2);
            border-radius: 999px;
            margin-bottom: 8px;
            overflow: hidden;
        }

        .progress-fill {
            height: 100%;
            background-color: #ff6b00;
        }

        .stat-subtitle {
            font-size: 14px;
            color: #8a6a50;
        }

        /* Trainer Card */
        .trainer-card {
            background-color: #1a0f0a;
            border: 1px solid #ff6b00;
            border-radius: 14px;
            padding: 25px;
            margin-bottom: 24px;
        }

        .trainer-card-title {
            font-size: 16px;
            color: #ff6b00;
            margin-bottom: 30px;
        }

        .trainer-info {
            display: flex;
            gap: 16px;
            align-items: flex-start;
        }

        .trainer-avatar {
            width: 64px;
            height: 64px;
            background-color: #2d1810;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            flex-shrink: 0;
        }

        .trainer-avatar img {
            width: 32px;
            height: 32px;
        }

        .trainer-details h3 {
            font-size: 18px;
            color: #ffa366;
            margin-bottom: 4px;
        }

        .trainer-details p {
            font-size: 14px;
            color: #8a6a50;
        }

        .trainer-contact {
            margin-top: 12px;
        }

        .trainer-contact p {
            font-size: 14px;
            color: #8a6a50;
            margin-bottom: 5px;
        }

        /* Tabs */
        .tabs {
            margin-bottom: 24px;
        }

        .tab-list {
            display: flex;
            background-color: #1a0f0a;
            border-radius: 14px;
            padding: 3px;
            margin-bottom: 24px;
            width: fit-content;
        }

        .tab-button {
            padding: 5px 9px;
            background: transparent;
            border: 1px solid transparent;
            border-radius: 14px;
            color: #8a6a50;
            font-size: 14px;
            cursor: pointer;
            transition: all 0.2s;
        }

        .tab-button:hover {
            background-color: rgba(255, 107, 0, 0.1);
        }

        .tab-button.active {
            background-color: #1a0f0a;
            border-color: #ff6b00;
            color: #ffa366;
        }

        /* Schedule Items */
        /* Schedule Items */
        .schedule-list {
            display: flex;
            flex-direction: row;
            gap: 16px;
            flex-wrap: wrap;
        }

        .schedule-item {
            background-color: #1a0f0a;
            border: 1px solid #ff6b00;
            border-radius: 14px;
            padding: 25px;
            flex: 1;
            min-width: 300px;
        }

        .schedule-header {
            display: flex;
            align-items: center;
            gap: 12px;
            margin-bottom: 12px;
        }

        .badge {
            background-color: #ff6b00;
            color: white;
            padding: 3px 9px;
            border-radius: 8px;
            font-size: 12px;
        }

        .schedule-title {
            font-size: 16px;
            color: #ffa366;
        }

        .schedule-info {
            display: flex;
            gap: 24px;
            align-items: center;
            flex-wrap: wrap;
        }

        .schedule-info-item {
            display: flex;
            align-items: center;
            gap: 8px;
            font-size: 14px;
            color: #8a6a50;
        }

        .schedule-info-item img {
            width: 16px;
            height: 16px;
        }

        .empty-state {
            background-color: #1a0f0a;
            border: 1px solid #ff6b00;
            border-radius: 14px;
            padding: 50px;
            text-align: center;
            color: #8a6a50;
        }

        .hidden {
            display: none;
        }

        @media (max-width: 1024px) {
            .stats-grid {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
<div class="app-container">
    <!-- Sidebar Include -->
    <jsp:include page="../common/sidebar/sidebarMember.jsp" />

    <!-- Main Content -->
    <main class="main-content">
        <div class="page-intro">
            <h1>PT 스케줄</h1>
            <p>나의 퍼스널 트레이닝 일정을 관리하세요</p>
        </div>
        <div class="header">
            <button class="btn-primary" onclick="location.href='${pageContext.request.contextPath}/schedule/ptbooking'">
                <img src="${pageContext.request.contextPath}/resources/images/icon/add.png" alt="추가" style="width: 16px; height: 16px;">
                <span>PT 예약</span>
            </button>
        </div>

        <!-- Stats Grid -->
        <div class="stats-grid">
            <div class="stat-card">
                <div class="stat-card-header">
                    <img src="${pageContext.request.contextPath}/resources/images/icon/ticket.png" alt="전체 PT" class="stat-icon">
                    <span class="stat-title">전체 PT</span>
                </div>
                <div class="stat-value">20회</div>
                <div class="progress-bar">
                    <div class="progress-fill" style="width: 60%"></div>
                </div>
                <div class="stat-subtitle">진행률 60%</div>
            </div>

            <div class="stat-card">
                <div class="stat-card-header">
                    <img src="${pageContext.request.contextPath}/resources/images/icon/done.png" alt="사용 완료" class="stat-icon">
                    <span class="stat-title">사용 완료</span>
                </div>
                <div class="stat-value">8회</div>
                <div class="stat-subtitle">10월 기준</div>
            </div>

            <div class="stat-card">
                <div class="stat-card-header">
                    <img src="${pageContext.request.contextPath}/resources/images/icon/ticket.png" alt="남은 횟수" class="stat-icon">
                    <span class="stat-title">남은 횟수</span>
                </div>
                <div class="stat-value">12회</div>
                <div class="stat-subtitle">만료일: 2025.12.31</div>
            </div>
        </div>

        <!-- Trainer Card -->
        <div class="trainer-card">
            <div class="trainer-card-title">예약된 트레이너</div>
            <div class="trainer-info">
                <div class="trainer-avatar">
                    <img src="${pageContext.request.contextPath}/resources/images/icon/person.png" alt="트레이너" style="width: 32px; height: 32px;">
                </div>
                <div>
                    <div class="trainer-details">
                        <h3>김트레이너</h3>
                        <p>경력: 5년</p>
                    </div>
                    <div class="trainer-contact">
                        <p>전화번호: 010-1111-2222</p>
                        <p>이메일: asdf@asdf.com</p>
                    </div>
                </div>
            </div>
        </div>

        <!-- Tabs -->
        <div class="tabs">
            <div class="tab-list">
                <button class="tab-button active" onclick="changeTab('upcoming')">예정된 PT</button>
                <button class="tab-button" onclick="changeTab('completed')">완료된 PT</button>
            </div>
        </div>
        <!-- Upcoming Schedules -->
        <div id="upcoming" class="schedule-list">
            <div class="schedule-item">
                <div class="schedule-header">
                    <span class="badge">예정</span>
                    <span class="schedule-title">하체 집중</span>
                </div>
                <div class="schedule-info">
                    <div class="schedule-info-item">
                        <img src="${pageContext.request.contextPath}/resources/images/icon/calendar.png" alt="날짜">
                        <span>2025. 10. 28.</span>
                    </div>
                    <div class="schedule-info-item">
                        <img src="${pageContext.request.contextPath}/resources/images/icon/clock.png" alt="시간">
                        <span>14:00 - 15:00</span>
                    </div>
                    <div class="schedule-info-item">
                        <img src="${pageContext.request.contextPath}/resources/images/icon/person.png" alt="트레이너">
                        <span>김트레이너</span>
                    </div>
                </div>
            </div>

            <div class="schedule-item">
                <div class="schedule-header">
                    <span class="badge">예정</span>
                    <span class="schedule-title">상체 운동</span>
                </div>
                <div class="schedule-info">
                    <div class="schedule-info-item">
                        <img src="${pageContext.request.contextPath}/resources/images/icon/calendar.png" alt="날짜">
                        <span>2025. 10. 30.</span>
                    </div>
                    <div class="schedule-info-item">
                        <img src="${pageContext.request.contextPath}/resources/images/icon/clock.png" alt="시간">
                        <span>16:00 - 17:00</span>
                    </div>
                    <div class="schedule-info-item">
                        <img src="${pageContext.request.contextPath}/resources/images/icon/person.png" alt="트레이너">
                        <span>김트레이너</span>
                    </div>
                </div>
            </div>
        </div>

        <!-- Completed Schedules -->
        <div id="completed" class="schedule-list hidden">
            <div class="schedule-item">
                <div class="schedule-header">
                    <span class="badge">완료</span>
                    <span class="schedule-title">전신 운동</span>
                </div>
                <div class="schedule-info">
                    <div class="schedule-info-item">
                        <img src="${pageContext.request.contextPath}/resources/images/icon/calendar.png" alt="날짜">
                        <span>2025. 10. 21.</span>
                    </div>
                    <div class="schedule-info-item">
                        <img src="${pageContext.request.contextPath}/resources/images/icon/clock.png" alt="시간">
                        <span>14:00 - 15:00</span>
                    </div>
                    <div class="schedule-info-item">
                        <img src="${pageContext.request.contextPath}/resources/images/icon/person.png" alt="트레이너">
                        <span>김트레이너</span>
                    </div>
                </div>
            </div>

            <div class="schedule-item">
                <div class="schedule-header">
                    <span class="badge">완료</span>
                    <span class="schedule-title">코어 강화</span>
                </div>
                <div class="schedule-info">
                    <div class="schedule-info-item">
                        <img src="${pageContext.request.contextPath}/resources/images/icon/calendar.png" alt="날짜">
                        <span>2025. 10. 19.</span>
                    </div>
                    <div class="schedule-info-item">
                        <img src="${pageContext.request.contextPath}/resources/images/icon/clock.png" alt="시간">
                        <span>10:00 - 11:00</span>
                    </div>
                    <div class="schedule-info-item">
                        <img src="${pageContext.request.contextPath}/resources/images/icon/person.png" alt="트레이너">
                        <span>김트레이너</span>
                    </div>
                </div>
            </div>

            <div class="schedule-item">
                <div class="schedule-header">
                    <span class="badge">완료</span>
                    <span class="schedule-title">유연성 향상</span>
                </div>
                <div class="schedule-info">
                    <div class="schedule-info-item">
                        <img src="${pageContext.request.contextPath}/resources/images/icon/calendar.png" alt="날짜">
                        <span>2025. 10. 16.</span>
                    </div>
                    <div class="schedule-info-item">
                        <img src="${pageContext.request.contextPath}/resources/images/icon/clock.png" alt="시간">
                        <span>16:00 - 17:00</span>
                    </div>
                    <div class="schedule-info-item">
                        <img src="${pageContext.request.contextPath}/resources/images/icon/person.png" alt="트레이너">
                        <span>김트레이너</span>
                    </div>
                </div>
            </div>
        </div>

        <!-- Workout Records -->
        <div id="workout" class="schedule-list hidden">
            <div class="empty-state">
                <p>운동 기록이 없습니다.</p>
            </div>
        </div>
    </main>
</div>

<script>
    function changeTab(tabName) {
        // Hide all tabs
        document.getElementById('upcoming').classList.add('hidden');
        document.getElementById('completed').classList.add('hidden');
        document.getElementById('workout').classList.add('hidden');

        // Remove active class from all buttons
        const buttons = document.querySelectorAll('.tab-button');
        buttons.forEach(btn => btn.classList.remove('active'));

        // Show selected tab
        document.getElementById(tabName).classList.remove('hidden');

        // Add active class to clicked button
        event.target.classList.add('active');
    }
</script>
</body>
</html>