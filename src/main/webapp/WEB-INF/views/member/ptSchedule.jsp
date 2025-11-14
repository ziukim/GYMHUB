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

        .trainer-avatar svg {
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

        .schedule-info-item svg {
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
        <div class="header">
            <div class="header-title">
                <h1>PT 스케줄</h1>
                <p>나의 퍼스널 트레이닝 일정을 관리하세요</p>
            </div>
            <button class="btn-primary" onclick="location.href='${pageContext.request.contextPath}/schedule/ptbooking'">
                <svg width="16" height="16" viewBox="0 0 16 16" fill="none">
                    <path d="M3.33333 8H12.6667" stroke="#0A0A0A" stroke-width="1.333" stroke-linecap="round" stroke-linejoin="round"/>
                    <path d="M8 3.33333V12.6667" stroke="#0A0A0A" stroke-width="1.333" stroke-linecap="round" stroke-linejoin="round"/>
                </svg>
                <span>PT 예약</span>
            </button>
        </div>

        <!-- Stats Grid -->
        <div class="stats-grid">
            <div class="stat-card">
                <div class="stat-card-header">
                    <svg class="stat-icon" viewBox="0 0 20 20" fill="none">
                        <path d="M16.6667 5L7.50004 14.1667L3.33337 10" stroke="#FF6B00" stroke-width="1.667" stroke-linecap="round" stroke-linejoin="round"/>
                        <path d="M18.3334 10V16.6667C18.3334 17.1087 18.1578 17.5326 17.8453 17.8452C17.5327 18.1577 17.1088 18.3333 16.6667 18.3333H3.33337C2.89135 18.3333 2.46742 18.1577 2.1549 17.8452C1.84234 17.5326 1.66671 17.1087 1.66671 16.6667V3.33333C1.66671 2.89131 1.84234 2.46738 2.1549 2.15482C2.46742 1.84226 2.89135 1.66667 3.33337 1.66667H13.3334" stroke="#FF6B00" stroke-width="1.667" stroke-linecap="round" stroke-linejoin="round"/>
                    </svg>
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
                    <svg class="stat-icon" viewBox="0 0 20 20" fill="none">
                        <path d="M16.6667 9.16667L10 15.8333L6.66667 12.5L1.66667 17.5" stroke="#FF6B00" stroke-width="1.667" stroke-linecap="round" stroke-linejoin="round"/>
                        <path d="M12.5 9.16667H16.6667V13.3333" stroke="#FF6B00" stroke-width="1.667" stroke-linecap="round" stroke-linejoin="round"/>
                    </svg>
                    <span class="stat-title">사용 완료</span>
                </div>
                <div class="stat-value">8회</div>
                <div class="stat-subtitle">10월 기준</div>
            </div>

            <div class="stat-card">
                <div class="stat-card-header">
                    <svg class="stat-icon" viewBox="0 0 20 20" fill="none">
                        <path d="M10 18.3333C14.6024 18.3333 18.3333 14.6024 18.3333 10C18.3333 5.39763 14.6024 1.66667 10 1.66667C5.39763 1.66667 1.66667 5.39763 1.66667 10C1.66667 14.6024 5.39763 18.3333 10 18.3333Z" stroke="#FF6B00" stroke-width="1.667" stroke-linecap="round" stroke-linejoin="round"/>
                        <path d="M10 5V10L13.3333 11.6667" stroke="#FF6B00" stroke-width="1.667" stroke-linecap="round" stroke-linejoin="round"/>
                    </svg>
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
                    <svg viewBox="0 0 32 32" fill="none">
                        <path d="M26.6667 28V25.3333C26.6667 23.9188 26.1048 22.5623 25.1046 21.5621C24.1044 20.5619 22.7479 20 21.3333 20H10.6667C9.25218 20 7.89562 20.5619 6.89543 21.5621C5.89524 22.5623 5.33333 23.9188 5.33333 25.3333V28" stroke="#FF6B00" stroke-width="2.667" stroke-linecap="round" stroke-linejoin="round"/>
                        <path d="M16 14.6667C18.9455 14.6667 21.3333 12.2789 21.3333 9.33333C21.3333 6.38781 18.9455 4 16 4C13.0545 4 10.6667 6.38781 10.6667 9.33333C10.6667 12.2789 13.0545 14.6667 16 14.6667Z" stroke="#FF6B00" stroke-width="2.667" stroke-linecap="round" stroke-linejoin="round"/>
                    </svg>
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
                <button class="tab-button" onclick="changeTab('workout')">운동 기록</button>
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
                        <svg viewBox="0 0 16 16" fill="none">
                            <path d="M5.33333 1.33333V4" stroke="#8A6A50" stroke-width="1.333" stroke-linecap="round" stroke-linejoin="round"/>
                            <path d="M10.6667 1.33333V4" stroke="#8A6A50" stroke-width="1.333" stroke-linecap="round" stroke-linejoin="round"/>
                            <path d="M2 6.66667H14" stroke="#8A6A50" stroke-width="1.333" stroke-linecap="round" stroke-linejoin="round"/>
                            <path d="M2 4.66667C2 4.31304 2.14048 3.97391 2.39052 3.72386C2.64057 3.47381 2.97971 3.33333 3.33333 3.33333H12.6667C13.0203 3.33333 13.3594 3.47381 13.6095 3.72386C13.8595 3.97391 14 4.31304 14 4.66667V13.3333C14 13.687 13.8595 14.0261 13.6095 14.2761C13.3594 14.5262 13.0203 14.6667 12.6667 14.6667H3.33333C2.97971 14.6667 2.64057 14.5262 2.39052 14.2761C2.14048 14.0261 2 13.687 2 13.3333V4.66667Z" stroke="#8A6A50" stroke-width="1.333" stroke-linecap="round" stroke-linejoin="round"/>
                        </svg>
                        <span>2025. 10. 28.</span>
                    </div>
                    <div class="schedule-info-item">
                        <svg viewBox="0 0 16 16" fill="none">
                            <path d="M8 4V8L10.6667 9.33333" stroke="#8A6A50" stroke-width="1.333" stroke-linecap="round" stroke-linejoin="round"/>
                            <path d="M8 14.6667C11.6819 14.6667 14.6667 11.6819 14.6667 8C14.6667 4.3181 11.6819 1.33333 8 1.33333C4.3181 1.33333 1.33333 4.3181 1.33333 8C1.33333 11.6819 4.3181 14.6667 8 14.6667Z" stroke="#8A6A50" stroke-width="1.333" stroke-linecap="round" stroke-linejoin="round"/>
                        </svg>
                        <span>14:00 - 15:00</span>
                    </div>
                    <div class="schedule-info-item">
                        <svg viewBox="0 0 16 16" fill="none">
                            <path d="M13.3333 14V12.6667C13.3333 11.9594 13.0524 11.2811 12.5523 10.781C12.0522 10.281 11.3739 10 10.6667 10H5.33333C4.62609 10 3.94781 10.281 3.44772 10.781C2.94762 11.2811 2.66667 11.9594 2.66667 12.6667V14" stroke="#8A6A50" stroke-width="1.333" stroke-linecap="round" stroke-linejoin="round"/>
                            <path d="M8 7.33333C9.47276 7.33333 10.6667 6.13943 10.6667 4.66667C10.6667 3.19391 9.47276 2 8 2C6.52724 2 5.33333 3.19391 5.33333 4.66667C5.33333 6.13943 6.52724 7.33333 8 7.33333Z" stroke="#8A6A50" stroke-width="1.333" stroke-linecap="round" stroke-linejoin="round"/>
                        </svg>
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
                        <svg viewBox="0 0 16 16" fill="none">
                            <path d="M5.33333 1.33333V4" stroke="#8A6A50" stroke-width="1.333" stroke-linecap="round" stroke-linejoin="round"/>
                            <path d="M10.6667 1.33333V4" stroke="#8A6A50" stroke-width="1.333" stroke-linecap="round" stroke-linejoin="round"/>
                            <path d="M2 6.66667H14" stroke="#8A6A50" stroke-width="1.333" stroke-linecap="round" stroke-linejoin="round"/>
                            <path d="M2 4.66667C2 4.31304 2.14048 3.97391 2.39052 3.72386C2.64057 3.47381 2.97971 3.33333 3.33333 3.33333H12.6667C13.0203 3.33333 13.3594 3.47381 13.6095 3.72386C13.8595 3.97391 14 4.31304 14 4.66667V13.3333C14 13.687 13.8595 14.0261 13.6095 14.2761C13.3594 14.5262 13.0203 14.6667 12.6667 14.6667H3.33333C2.97971 14.6667 2.64057 14.5262 2.39052 14.2761C2.14048 14.0261 2 13.687 2 13.3333V4.66667Z" stroke="#8A6A50" stroke-width="1.333" stroke-linecap="round" stroke-linejoin="round"/>
                        </svg>
                        <span>2025. 10. 30.</span>
                    </div>
                    <div class="schedule-info-item">
                        <svg viewBox="0 0 16 16" fill="none">
                            <path d="M8 4V8L10.6667 9.33333" stroke="#8A6A50" stroke-width="1.333" stroke-linecap="round" stroke-linejoin="round"/>
                            <path d="M8 14.6667C11.6819 14.6667 14.6667 11.6819 14.6667 8C14.6667 4.3181 11.6819 1.33333 8 1.33333C4.3181 1.33333 1.33333 4.3181 1.33333 8C1.33333 11.6819 4.3181 14.6667 8 14.6667Z" stroke="#8A6A50" stroke-width="1.333" stroke-linecap="round" stroke-linejoin="round"/>
                        </svg>
                        <span>16:00 - 17:00</span>
                    </div>
                    <div class="schedule-info-item">
                        <svg viewBox="0 0 16 16" fill="none">
                            <path d="M13.3333 14V12.6667C13.3333 11.9594 13.0524 11.2811 12.5523 10.781C12.0522 10.281 11.3739 10 10.6667 10H5.33333C4.62609 10 3.94781 10.281 3.44772 10.781C2.94762 11.2811 2.66667 11.9594 2.66667 12.6667V14" stroke="#8A6A50" stroke-width="1.333" stroke-linecap="round" stroke-linejoin="round"/>
                            <path d="M8 7.33333C9.47276 7.33333 10.6667 6.13943 10.6667 4.66667C10.6667 3.19391 9.47276 2 8 2C6.52724 2 5.33333 3.19391 5.33333 4.66667C5.33333 6.13943 6.52724 7.33333 8 7.33333Z" stroke="#8A6A50" stroke-width="1.333" stroke-linecap="round" stroke-linejoin="round"/>
                        </svg>
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
                        <svg viewBox="0 0 16 16" fill="none">
                            <path d="M5.33333 1.33333V4" stroke="#8A6A50" stroke-width="1.333" stroke-linecap="round" stroke-linejoin="round"/>
                            <path d="M10.6667 1.33333V4" stroke="#8A6A50" stroke-width="1.333" stroke-linecap="round" stroke-linejoin="round"/>
                            <path d="M2 6.66667H14" stroke="#8A6A50" stroke-width="1.333" stroke-linecap="round" stroke-linejoin="round"/>
                            <path d="M2 4.66667C2 4.31304 2.14048 3.97391 2.39052 3.72386C2.64057 3.47381 2.97971 3.33333 3.33333 3.33333H12.6667C13.0203 3.33333 13.3594 3.47381 13.6095 3.72386C13.8595 3.97391 14 4.31304 14 4.66667V13.3333C14 13.687 13.8595 14.0261 13.6095 14.2761C13.3594 14.5262 13.0203 14.6667 12.6667 14.6667H3.33333C2.97971 14.6667 2.64057 14.5262 2.39052 14.2761C2.14048 14.0261 2 13.687 2 13.3333V4.66667Z" stroke="#8A6A50" stroke-width="1.333" stroke-linecap="round" stroke-linejoin="round"/>
                        </svg>
                        <span>2025. 10. 21.</span>
                    </div>
                    <div class="schedule-info-item">
                        <svg viewBox="0 0 16 16" fill="none">
                            <path d="M8 4V8L10.6667 9.33333" stroke="#8A6A50" stroke-width="1.333" stroke-linecap="round" stroke-linejoin="round"/>
                            <path d="M8 14.6667C11.6819 14.6667 14.6667 11.6819 14.6667 8C14.6667 4.3181 11.6819 1.33333 8 1.33333C4.3181 1.33333 1.33333 4.3181 1.33333 8C1.33333 11.6819 4.3181 14.6667 8 14.6667Z" stroke="#8A6A50" stroke-width="1.333" stroke-linecap="round" stroke-linejoin="round"/>
                        </svg>
                        <span>14:00 - 15:00</span>
                    </div>
                    <div class="schedule-info-item">
                        <svg viewBox="0 0 16 16" fill="none">
                            <path d="M13.3333 14V12.6667C13.3333 11.9594 13.0524 11.2811 12.5523 10.781C12.0522 10.281 11.3739 10 10.6667 10H5.33333C4.62609 10 3.94781 10.281 3.44772 10.781C2.94762 11.2811 2.66667 11.9594 2.66667 12.6667V14" stroke="#8A6A50" stroke-width="1.333" stroke-linecap="round" stroke-linejoin="round"/>
                            <path d="M8 7.33333C9.47276 7.33333 10.6667 6.13943 10.6667 4.66667C10.6667 3.19391 9.47276 2 8 2C6.52724 2 5.33333 3.19391 5.33333 4.66667C5.33333 6.13943 6.52724 7.33333 8 7.33333Z" stroke="#8A6A50" stroke-width="1.333" stroke-linecap="round" stroke-linejoin="round"/>
                        </svg>
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
                        <svg viewBox="0 0 16 16" fill="none">
                            <path d="M5.33333 1.33333V4" stroke="#8A6A50" stroke-width="1.333" stroke-linecap="round" stroke-linejoin="round"/>
                            <path d="M10.6667 1.33333V4" stroke="#8A6A50" stroke-width="1.333"stroke-linecap="round" stroke-linejoin="round"/>
                            <path d="M2 6.66667H14" stroke="#8A6A50" stroke-width="1.333" stroke-linecap="round" stroke-linejoin="round"/>
                            <path d="M2 4.66667C2 4.31304 2.14048 3.97391 2.39052 3.72386C2.64057 3.47381 2.97971 3.33333 3.33333 3.33333H12.6667C13.0203 3.33333 13.3594 3.47381 13.6095 3.72386C13.8595 3.97391 14 4.31304 14 4.66667V13.3333C14 13.687 13.8595 14.0261 13.6095 14.2761C13.3594 14.5262 13.0203 14.6667 12.6667 14.6667H3.33333C2.97971 14.6667 2.64057 14.5262 2.39052 14.2761C2.14048 14.0261 2 13.687 2 13.3333V4.66667Z" stroke="#8A6A50" stroke-width="1.333" stroke-linecap="round" stroke-linejoin="round"/>
                        </svg>
                        <span>2025. 10. 19.</span>
                    </div>
                    <div class="schedule-info-item">
                        <svg viewBox="0 0 16 16" fill="none">
                            <path d="M8 4V8L10.6667 9.33333" stroke="#8A6A50" stroke-width="1.333" stroke-linecap="round" stroke-linejoin="round"/>
                            <path d="M8 14.6667C11.6819 14.6667 14.6667 11.6819 14.6667 8C14.6667 4.3181 11.6819 1.33333 8 1.33333C4.3181 1.33333 1.33333 4.3181 1.33333 8C1.33333 11.6819 4.3181 14.6667 8 14.6667Z" stroke="#8A6A50" stroke-width="1.333" stroke-linecap="round" stroke-linejoin="round"/>
                        </svg>
                        <span>10:00 - 11:00</span>
                    </div>
                    <div class="schedule-info-item">
                        <svg viewBox="0 0 16 16" fill="none">
                            <path d="M13.3333 14V12.6667C13.3333 11.9594 13.0524 11.2811 12.5523 10.781C12.0522 10.281 11.3739 10 10.6667 10H5.33333C4.62609 10 3.94781 10.281 3.44772 10.781C2.94762 11.2811 2.66667 11.9594 2.66667 12.6667V14" stroke="#8A6A50" stroke-width="1.333" stroke-linecap="round" stroke-linejoin="round"/>
                            <path d="M8 7.33333C9.47276 7.33333 10.6667 6.13943 10.6667 4.66667C10.6667 3.19391 9.47276 2 8 2C6.52724 2 5.33333 3.19391 5.33333 4.66667C5.33333 6.13943 6.52724 7.33333 8 7.33333Z" stroke="#8A6A50" stroke-width="1.333" stroke-linecap="round" stroke-linejoin="round"/>
                        </svg>
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
                        <svg viewBox="0 0 16 16" fill="none">
                            <path d="M5.33333 1.33333V4" stroke="#8A6A50" stroke-width="1.333" stroke-linecap="round" stroke-linejoin="round"/>
                            <path d="M10.6667 1.33333V4" stroke="#8A6A50" stroke-width="1.333" stroke-linecap="round" stroke-linejoin="round"/>
                            <path d="M2 6.66667H14" stroke="#8A6A50" stroke-width="1.333" stroke-linecap="round" stroke-linejoin="round"/>
                            <path d="M2 4.66667C2 4.31304 2.14048 3.97391 2.39052 3.72386C2.64057 3.47381 2.97971 3.33333 3.33333 3.33333H12.6667C13.0203 3.33333 13.3594 3.47381 13.6095 3.72386C13.8595 3.97391 14 4.31304 14 4.66667V13.3333C14 13.687 13.8595 14.0261 13.6095 14.2761C13.3594 14.5262 13.0203 14.6667 12.6667 14.6667H3.33333C2.97971 14.6667 2.64057 14.5262 2.39052 14.2761C2.14048 14.0261 2 13.687 2 13.3333V4.66667Z" stroke="#8A6A50" stroke-width="1.333" stroke-linecap="round" stroke-linejoin="round"/>
                        </svg>
                        <span>2025. 10. 16.</span>
                    </div>
                    <div class="schedule-info-item">
                        <svg viewBox="0 0 16 16" fill="none">
                            <path d="M8 4V8L10.6667 9.33333" stroke="#8A6A50" stroke-width="1.333" stroke-linecap="round" stroke-linejoin="round"/>
                            <path d="M8 14.6667C11.6819 14.6667 14.6667 11.6819 14.6667 8C14.6667 4.3181 11.6819 1.33333 8 1.33333C4.3181 1.33333 1.33333 4.3181 1.33333 8C1.33333 11.6819 4.3181 14.6667 8 14.6667Z" stroke="#8A6A50" stroke-width="1.333" stroke-linecap="round" stroke-linejoin="round"/>
                        </svg>
                        <span>16:00 - 17:00</span>
                    </div>
                    <div class="schedule-info-item">
                        <svg viewBox="0 0 16 16" fill="none">
                            <path d="M13.3333 14V12.6667C13.3333 11.9594 13.0524 11.2811 12.5523 10.781C12.0522 10.281 11.3739 10 10.6667 10H5.33333C4.62609 10 3.94781 10.281 3.44772 10.781C2.94762 11.2811 2.66667 11.9594 2.66667 12.6667V14" stroke="#8A6A50" stroke-width="1.333" stroke-linecap="round" stroke-linejoin="round"/>
                            <path d="M8 7.33333C9.47276 7.33333 10.6667 6.13943 10.6667 4.66667C10.6667 3.19391 9.47276 2 8 2C6.52724 2 5.33333 3.19391 5.33333 4.66667C5.33333 6.13943 6.52724 7.33333 8 7.33333Z" stroke="#8A6A50" stroke-width="1.333" stroke-linecap="round" stroke-linejoin="round"/>
                        </svg>
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