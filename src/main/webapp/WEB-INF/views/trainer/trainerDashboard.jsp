<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>트레이너 대시보드</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common.css">

    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'ABeeZee', 'Noto Sans KR', sans-serif;
            background-color: #0a0a0a;
            color: #ffa366;
            min-height: 100vh;
            overflow-x: hidden;
        }

        .app-container {
            display: flex;
            min-height: 100vh;
        }

        /* Sidebar */
        .sidebar {
            position: fixed;
            left: 0;
            top: 0;
            width: 255px;
            height: 100vh;
            background-color: #1a0f0a;
            border-right: 1px solid #ff6b00;
            z-index: 100;
        }

        .logo-container {
            padding: 24px 33px;
            display: flex;
            align-items: center;
            gap: 7px;
        }

        .icon {
            width: 48px;
            height: 48px;
            flex-shrink: 0;
        }

        .icon svg {
            display: block;
            width: 100%;
            height: 100%;
        }

        .logo-text {
            font-size: 24px;
            line-height: 24px;
            color: #ff6b00;
            font-weight: 400;
            text-shadow:
                    0 0 10px #ff8800,
                    0 0 20px #ff8800,
                    0 0 30px #ff8800,
                    0 0 40px #ffaa00,
                    0 0 60px #ffdd00;
            animation: neonBuzz 3s ease-in-out infinite;
        }

        @keyframes neonBuzz {
            0%, 100% {
                text-shadow:
                        0 0 10px #ff8800,
                        0 0 20px #ff8800,
                        0 0 30px #ff8800,
                        0 0 40px #ffaa00,
                        0 0 60px #ffdd00;
            }
            10% {
                text-shadow:
                        0 0 5px #ff8800,
                        0 0 10px #ff8800;
            }
            20% {
                text-shadow:
                        0 0 15px #ff8800,
                        0 0 25px #ff8800,
                        0 0 40px #ffaa00,
                        0 0 70px #ffdd00;
            }
            30% {
                text-shadow:
                        0 0 10px #ff8800,
                        0 0 20px #ff8800,
                        0 0 30px #ff8800;
            }
        }

        .divider {
            width: 100%;
            height: 1px;
            background-color: #ff6b00;
        }

        .navigation {
            padding: 16px;
            display: flex;
            flex-direction: column;
            gap: 8px;
        }

        .nav-button {
            width: 100%;
            height: 36px;
            border-radius: 6px;
            border: 1px solid transparent;
            background: transparent;
            cursor: pointer;
            transition: all 0.2s;
            display: flex;
            align-items: center;
            gap: 12px;
            padding: 0 12px;
        }

        .nav-button:hover {
            border-color: #ff6b00;
            background-color: rgba(255, 107, 0, 0.1);
        }

        .nav-button.active {
            border-color: #ff6b00;
        }

        .nav-button svg {
            width: 16px;
            height: 16px;
            flex-shrink: 0;
        }

        .nav-button span {
            font-size: 14px;
            line-height: 20px;
            color: #ffa366;
            white-space: nowrap;
        }

        .nav-button.logout {
            border-radius: 8px;
        }

        .nav-button.logout span {
            color: #ff5252;
        }

        /* Main Content - 최대 너비 제한 추가 */
        .main-content {
            margin-left: 255px;
            padding: 29px;
            width: calc(100% - 255px);
            min-height: 100vh;
            background-color: #0a0a0a;
        }

        .page-title {
            font-size: 32px;
            color: #ff6b00;
            margin-bottom: 56px;
        }

        /* Cards Container */
        .cards-row {
            display: flex;
            gap: 17px;
            margin-bottom: 15px;
            flex-wrap: wrap;
        }

        .card {
            background-color: #1a0f0a;
            border: 1px solid #ff6b00;
            border-radius: 14px;
            padding: 25px;
            position: relative;
        }

        .card-title {
            display: flex;
            align-items: center;
            gap: 8px;
            margin-bottom: 18px;
            justify-content: space-between;
            height: 30px;
        }

        .card-title-left {
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .card-title svg {
            width: 20px;
            height: 20px;
        }

        .card-title span {
            color: white;
            font-size: 16px;
        }

        /* 트레이너 정보 Card - flex로 균등 분배 */
        .trainer-card {
            flex: 1;
            min-width: 0;
            min-height: 232px;
        }

        .trainer-buttons {
            display: flex;
            gap: 8px;
            align-items: center;
        }

        .trainer-buttons .btn-edit,
        .trainer-buttons .btn-password {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            height: 36px;
            border-radius: 8px;
            font-size: 14px;
            line-height: 1;
            cursor: pointer;
            gap: 8px;
        }

        .info-row {
            display: flex;
            justify-content: space-between;
            margin-bottom: 12px;
        }

        .info-label {
            color: #8a6a50;
            font-size: 14px;
        }

        .info-value {
            color: #ffa366;
            font-size: 14px;
        }

        .btn-edit {
            background-color: #ff6b00;
            border: none;
            color: white;
            padding: 0 16px;
        }

        .btn-password {
            background-color: #0a0a0a;
            border: 1px solid #ff6b00;
            padding: 0 12px;
            color: #ffa366;
        }

        .btn-password svg,
        .trainer-buttons .btn-edit svg {
            display: block;
            width: 16px;
            height: 16px;
            flex-shrink: 0;
            vertical-align: middle;
        }

        .btn-password span,
        .btn-edit span {
            color: inherit;
            display: inline-block;
        }

        .badge {
            background-color: #0a0a0a;
            border: 1px solid #ff6b00;
            border-radius: 15px;
            padding: 2px 5px;
            color: #ffa366;
            font-size: 14px;
            display: inline-block;
            margin-bottom: 8px;
        }

        /* 이번 달 출석 Card - flex로 균등 분배 */
        .attendance-card {
            flex: 1;
            min-width: 0;
            height: 232px;
        }

        .attendance-card .card-title {
            /*margin-bottom: 50px;*/
        }

        .attendance-card .card-title span {
            color: #ff6b00;
        }

        .attendance-content {
            padding: 0 24px;
        }

        .attendance-days {
            color: #ff6b00;
            font-size: 30px;
            text-align: center;
            margin-bottom: 8px;
        }

        .attendance-label {
            color: #8a6a50;
            font-size: 14px;
            text-align: center;
            margin-bottom: 12px;
        }

        .progress-bar {
            background-color: #2d1810;
            border-radius: 999px;
            height: 8px;
            width: 100%;
            overflow: hidden;
            margin-bottom: 12px;
        }

        .progress-fill {
            background-color: #ff6b00;
            height: 100%;
            transition: width 0.3s ease;
        }

        .progress-info {
            display: flex;
            justify-content: space-between;
        }

        .progress-info .label {
            color: #8a6a50;
            font-size: 14px;
        }

        .progress-info .value {
            color: #ff6b00;
            font-size: 14px;
        }

        /* 나의 헬스장 Card - max-width 제거로 전체 너비 사용 */
        .gym-card {
            width: 100%;
            min-height: 317px;
        }

        .gym-card .card-title span {
            color: #ff6b00;
        }

        .gym-name {
            color: #ff6b00;
            font-size: 30px;
            text-align: center;
            margin-bottom: 60px;
        }

        .notices {
            padding: 0 21px;
            display: flex;
            flex-direction: column;
            gap: 16px;
        }

        .notice-item {
            background-color: #2d1810;
            border-radius: 10px;
            padding: 17px;
        }

        .notice-item.important {
            border: 1px solid #ff6b00;
        }

        .notice-header {
            display: flex;
            gap: 8px;
            align-items: flex-start;
        }

        .notice-badge {
            background-color: #ff6b00;
            border-radius: 8px;
            padding: 3px 9px;
            color: #0a0a0a;
            font-size: 12px;
            flex-shrink: 0;
        }

        .notice-content {
            flex: 1;
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

        .btn-notice {
            position: absolute;
            top: 26px;
            right: 26px;
            background-color: #ff6b00;
            border: none;
            border-radius: 8px;
            padding: 8px 16px;
            color: white;
            font-size: 14px;
            cursor: pointer;
        }

        /* Modal Styles */
        .modal-overlay {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background-color: rgba(0, 0, 0, 0.8);
            justify-content: center;
            align-items: center;
            z-index: 1000;
        }

        .modal-overlay.active {
            display: flex;
        }

        .modal-content {
            background-color: #1a0f0a;
            border: 1px solid #ff6b00;
            border-radius: 14px;
            padding: 25px;
            position: relative;
            max-width: 90vw;
            max-height: 90vh;
            overflow-y: auto;
        }

        .modal-close {
            position: absolute;
            right: 25px;
            top: 25px;
            background: none;
            border: none;
            cursor: pointer;
            opacity: 0.7;
            transition: opacity 0.2s;
        }

        .modal-close:hover {
            opacity: 1;
        }

        .modal-close svg {
            width: 16px;
            height: 16px;
        }

        .modal-title {
            color: #ff6b00;
            font-size: 18px;
            font-weight: 700;
            margin-bottom: 34px;
        }

        .form-group {
            display: flex;
            flex-direction: column;
            gap: 8px;
            margin-bottom: 16px;
        }

        .form-label {
            color: #ffa366;
            font-size: 14px;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .form-label svg {
            width: 12px;
            height: 12px;
        }

        .form-label.secondary {
            color: #8a6a50;
        }

        .form-input {
            background-color: #2d1810;
            border: 1px solid #ff6b00;
            border-radius: 8px;
            height: 36px;
            padding: 0 12px;
            color: #ffa366;
            font-size: 14px;
            outline: none;
            width: 100%;
        }

        .form-input::placeholder {
            color: #8a6a50;
        }

        .form-buttons {
            display: flex;
            gap: 8px;
            justify-content: flex-end;
            margin-top: 8px;
        }

        .btn-cancel {
            background-color: #0a0a0a;
            border: 1px solid #ff6b00;
            border-radius: 8px;
            height: 36px;
            padding: 0 17px;
            color: #ffa366;
            font-size: 14px;
            cursor: pointer;
        }

        .btn-submit {
            background-color: #ff6b00;
            border: none;
            border-radius: 8px;
            height: 36px;
            padding: 0 16px;
            color: #0a0a0a;
            font-size: 14px;
            cursor: pointer;
        }

        .btn-submit:disabled {
            opacity: 0.5;
            cursor: not-allowed;
        }

        .form-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 16px;
        }

        .info-modal .modal-content {
            width: 1220px;
        }

        /* Responsive */
        @media (max-width: 1200px) {
            .main-content {
                max-width: none;
            }

            .cards-row {
                flex-direction: column;
            }

            .trainer-card,
            .attendance-card {
                width: 100%;
            }

            .trainer-buttons {
                flex-wrap: wrap;
            }
        }

        @media (max-width: 768px) {
            .sidebar {
                width: 200px;
            }

            .main-content {
                margin-left: 200px;
                width: calc(100% - 200px);
                padding: 15px;
            }

            .form-grid {
                grid-template-columns: 1fr;
            }

            .info-modal .modal-content {
                width: 95vw;
            }
        }

        @media (max-width: 576px) {
            .sidebar {
                width: 60px;
            }

            .logo-text,
            .nav-button span {
                display: none;
            }

            .main-content {
                margin-left: 60px;
                width: calc(100% - 60px);
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
        <div class="page-intro">
            <h1>트레이너님 환영합니다!</h1>
            <p>오늘도 힘차게 운동하세요</p>
        </div>

        <!-- Cards Row 1 -->
        <div class="cards-row">
            <!-- 트레이너 정보 Card -->
            <div class="card trainer-card">
                <div class="card-title">
                    <div class="card-title-left">
                        <svg fill="none" viewBox="0 0 20 20">
                            <path d="M15.8333 17.5V15.8333C15.8333 14.9493 15.4821 14.1014 14.857 13.4763C14.2319 12.8512 13.3841 12.5 12.5 12.5H7.5C6.61594 12.5 5.7681 12.8512 5.14298 13.4763C4.51786 14.1014 4.16667 14.9493 4.16667 15.8333V17.5" stroke="#FF6B00" stroke-linecap="round" stroke-linejoin="round" stroke-width="1.66667"/>
                            <path d="M10 9.16667C11.8409 9.16667 13.3333 7.67428 13.3333 5.83333C13.3333 3.99238 11.8409 2.5 10 2.5C8.15905 2.5 6.66667 3.99238 6.66667 5.83333C6.66667 7.67428 8.15905 9.16667 10 9.16667Z" stroke="#FF6B00" stroke-linecap="round" stroke-linejoin="round" stroke-width="1.66667"/>
                        </svg>
                        <span>트레이너 정보</span>
                    </div>
                    <div class="trainer-buttons">
                        <button class="btn-password" onclick="openPasswordModal()">비밀번호 변경</button>
                        <button class="btn-edit" onclick="openInfoModal()">수정하기</button>
                    </div>
                </div>

                <div style="padding: 0 24px; margin-top: 20px;">
                    <div class="info-row">
                        <span class="info-label">경력</span>
                        <span class="info-value">3년</span>
                    </div>
                    <div style="margin-bottom: 8px; margin-top: 12px;">
                        <p class="info-label">자격정보</p>
                    </div>
                    <div style="display: flex; gap: 8px; flex-wrap: wrap; margin-bottom: 16px;">
                        <span class="badge">헬스트레이너지도사</span>
                        <span class="badge">물리치료사 자격증</span>
                    </div>
                    <div style="margin-bottom: 8px;">
                        <p class="info-label">수상이력</p>
                    </div>
                    <div style="display: flex; gap: 8px; flex-wrap: wrap;">
                        <span class="badge">OLYMPIA 1위</span>
                    </div>
                </div>
            </div>

            <!-- 이번 달 출석 Card -->
            <div class="card trainer-card">
                <div class="card-title">
                    <svg fill="none" viewBox="0 0 20 20">
                        <path d="M6.66667 1.66667V5" stroke="#FF6B00" stroke-linecap="round" stroke-linejoin="round" stroke-width="1.66667"/>
                        <path d="M13.3333 1.66667V5" stroke="#FF6B00" stroke-linecap="round" stroke-linejoin="round" stroke-width="1.66667"/>
                        <path d="M15.8333 3.33333H4.16667C3.24619 3.33333 2.5 4.07953 2.5 5V16.6667C2.5 17.5871 3.24619 18.3333 4.16667 18.3333H15.8333C16.7538 18.3333 17.5 17.5871 17.5 16.6667V5C17.5 4.07953 16.7538 3.33333 15.8333 3.33333Z" stroke="#FF6B00" stroke-linecap="round" stroke-linejoin="round" stroke-width="1.66667"/>
                        <path d="M2.5 8.33333H17.5" stroke="#FF6B00" stroke-linecap="round" stroke-linejoin="round" stroke-width="1.66667"/>
                    </svg>
                    <span>이번 달 출석</span>
                </div>

                <div class="attendance-content">
                    <p class="attendance-days">18일</p>
                    <p class="attendance-label">이번 달 총 출석일</p>

                    <div class="progress-bar">
                        <div class="progress-fill" style="width: 72%"></div>
                    </div>

                    <div class="progress-info">
                        <span class="label">이번 달 출석률</span>
                        <span class="value">72%</span>
                    </div>
                </div>
            </div>
        </div>

        <!-- 나의 헬스장 Card -->
        <div class="card gym-card">
            <div class="card-title">
                <svg fill="none" viewBox="0 0 20 20">
                    <path d="M13.3333 5.83333H18.3333V10.8333" stroke="#FF6B00" stroke-linecap="round" stroke-linejoin="round" stroke-width="1.66667"/>
                    <path d="M18.3333 5.83333L11.25 12.9167L7.08333 8.75L1.66667 14.1667" stroke="#FF6B00" stroke-linecap="round" stroke-linejoin="round" stroke-width="1.66667"/>
                </svg>
                <span>나의 헬스장</span>
            </div>

            <p class="gym-name">헬스보이짐 판교역점</p>

            <div class="notices">
                <!-- 중요 공지 -->
                <div class="notice-item important">
                    <div class="notice-header">
                        <span class="notice-badge">중요</span>
                        <div class="notice-content">
                            <p class="notice-title">추석 연휴 운영시간 안내</p>
                            <p class="notice-date">2025.10.25</p>
                        </div>
                    </div>
                </div>

                <!-- 일반 공지 -->
                <div class="notice-item">
                    <div class="notice-content">
                        <p class="notice-title">신규 GX 프로그램 오픈</p>
                        <p class="notice-date">2025.10.23</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- 비밀번호 변경 Modal -->
<div id="passwordModal" class="modal-overlay">
    <div class="modal-content" style="width: 512px;">
        <button class="modal-close" onclick="closePasswordModal()">
            <svg fill="none" viewBox="0 0 16 16">
                <path d="M12 4L4 12" stroke="#FFA366" stroke-linecap="round" stroke-linejoin="round" stroke-width="1.33333"/>
                <path d="M4 4L12 12" stroke="#FFA366" stroke-linecap="round" stroke-linejoin="round" stroke-width="1.33333"/>
            </svg>
        </button>

        <h2 class="modal-title">비밀번호 변경</h2>

        <div class="form-group">
            <label class="form-label">현재 비밀번호</label>
            <input type="password" id="currentPassword" class="form-input">
        </div>

        <div class="form-group">
            <label class="form-label">새 비밀번호</label>
            <input type="password" id="newPassword" class="form-input">
        </div>

        <div class="form-group">
            <label class="form-label">새 비밀번호 확인</label>
            <input type="password" id="confirmPassword" class="form-input">
        </div>

        <div class="form-buttons">
            <button class="btn-cancel" onclick="closePasswordModal()">취소</button>
            <button class="btn-submit" id="passwordSubmit" disabled onclick="submitPassword()">변경</button>
        </div>
    </div>
</div>

<!-- 정보 수정 Modal -->
<div id="infoModal" class="modal-overlay info-modal">
    <div class="modal-content">
        <button class="modal-close" onclick="closeInfoModal()">
            <svg fill="none" viewBox="0 0 16 16">
                <path d="M12 4L4 12" stroke="#FFA366" stroke-linecap="round" stroke-linejoin="round" stroke-width="1.33333"/>
                <path d="M4 4L12 12" stroke="#FFA366" stroke-linecap="round" stroke-linejoin="round" stroke-width="1.33333"/>
            </svg>
        </button>

        <h2 class="modal-title">정보 수정</h2>

        <div class="form-grid">
            <div class="form-group">
                <label class="form-label secondary">이름</label>
                <input type="text" class="form-input" value="홍길동">
            </div>
            <div class="form-group">
                <label class="form-label secondary">생년월일</label>
                <input type="text" class="form-input" placeholder="YYYY-MM-DD">
            </div>
        </div>

        <div class="form-grid">
            <div class="form-group">
                <label class="form-label secondary">
                    <svg fill="none" viewBox="0 0 12 12">
                        <path d="M6.916 8.284C7.01926 8.33142 7.1356 8.34226 7.24585 8.31472C7.35609 8.28718 7.45367 8.22291 7.5225 8.1325L7.7 7.9C7.79315 7.7758 7.91393 7.675 8.05279 7.60557C8.19164 7.53614 8.34475 7.5 8.5 7.5H10C10.2652 7.5 10.5196 7.60536 10.7071 7.79289C10.8946 7.98043 11 8.23478 11 8.5V10C11 10.2652 10.8946 10.5196 10.7071 10.7071C10.5196 10.8946 10.2652 11 10 11C7.61305 11 5.32387 10.0518 3.63604 8.36396C1.94821 6.67613 1 4.38695 1 2C1 1.73478 1.10536 1.48043 1.29289 1.29289C1.48043 1.10536 1.73478 1 2 1H3.5C3.76522 1 4.01957 1.10536 4.20711 1.29289C4.39464 1.48043 4.5 1.73478 4.5 2V3.5C4.5 3.65525 4.46386 3.80836 4.39443 3.94721C4.325 4.08607 4.2242 4.20685 4.1 4.3L3.866 4.4755C3.77421 4.54559 3.70951 4.64529 3.6829 4.75768C3.65628 4.87006 3.66939 4.98819 3.72 5.092C4.40334 6.47993 5.52721 7.6024 6.916 8.284Z" stroke="#8A6A50" stroke-linecap="round" stroke-linejoin="round"/>
                    </svg>
                    연락처
                </label>
                <input type="text" class="form-input" value="010-1234-5678">
            </div>
            <div class="form-group">
                <label class="form-label secondary">
                    <svg fill="none" viewBox="0 0 12 12">
                        <path d="M11 3.5L6.5045 6.3635C6.35195 6.45211 6.17867 6.49878 6.00225 6.49878C5.82583 6.49878 5.65255 6.45211 5.5 6.3635L1 3.5" stroke="#8A6A50" stroke-linecap="round" stroke-linejoin="round"/>
                        <path d="M10 2H2C1.44772 2 1 2.44772 1 3V9C1 9.55228 1.44772 10 2 10H10C10.5523 10 11 9.55228 11 9V3C11 2.44772 10.5523 2 10 2Z" stroke="#8A6A50" stroke-linecap="round" stroke-linejoin="round"/>
                    </svg>
                    이메일
                </label>
                <input type="email" class="form-input" value="hong@example.com">
            </div>
        </div>

        <div class="form-group">
            <label class="form-label secondary">
                <svg fill="none" viewBox="0 0 12 12">
                    <path d="M10 5C10 7.4965 7.2305 10.0965 6.3005 10.8995C6.21386 10.9646 6.1084 10.9999 6 10.9999C5.8916 10.9999 5.78614 10.9646 5.6995 10.8995C4.7695 10.0965 2 7.4965 2 5C2 3.93913 2.42143 2.92172 3.17157 2.17157C3.92172 1.42143 4.93913 1 6 1C7.06087 1 8.07828 1.42143 8.82843 2.17157C9.57857 2.92172 10 3.93913 10 5Z" stroke="#8A6A50" stroke-linecap="round" stroke-linejoin="round"/>
                    <path d="M6 6.5C6.82843 6.5 7.5 5.82843 7.5 5C7.5 4.17157 6.82843 3.5 6 3.5C5.17157 3.5 4.5 4.17157 4.5 5C4.5 5.82843 5.17157 6.5 6 6.5Z" stroke="#8A6A50" stroke-linecap="round" stroke-linejoin="round"/>
                </svg>
                주소
            </label>
            <input type="text" class="form-input" value="서울시 강남구 테헤란로 123">
        </div>

        <div class="form-group">
            <label class="form-label">경력</label>
            <input type="text" class="form-input" placeholder="경력을 입력하세요.">
        </div>

        <div class="form-group">
            <label class="form-label">자격정보</label>
            <input type="text" class="form-input" placeholder="자격정보를 입력하세요.">
        </div>

        <div class="form-group">
            <label class="form-label">수상이력</label>
            <input type="text" class="form-input" placeholder="수상이력을 입력하세요.">
        </div>

        <div class="form-buttons">
            <button class="btn-cancel" onclick="closeInfoModal()">취소</button>
            <button class="btn-submit" onclick="submitInfo()">저장</button>
        </div>
    </div>
</div>

<script>
    // 비밀번호 변경 모달
    function openPasswordModal() {
        document.getElementById('passwordModal').classList.add('active');
    }

    function closePasswordModal() {
        document.getElementById('passwordModal').classList.remove('active');
        document.getElementById('currentPassword').value = '';
        document.getElementById('newPassword').value = '';
        document.getElementById('confirmPassword').value = '';
        document.getElementById('passwordSubmit').disabled = true;
    }

    // 정보 수정 모달
    function openInfoModal() {
        document.getElementById('infoModal').classList.add('active');
    }

    function closeInfoModal() {
        document.getElementById('infoModal').classList.remove('active');
    }

    // 비밀번호 유효성 검사
    function validatePassword() {
        const current = document.getElementById('currentPassword').value;
        const newPass = document.getElementById('newPassword').value;
        const confirm = document.getElementById('confirmPassword').value;
        const submitBtn = document.getElementById('passwordSubmit');

        if (current && newPass && confirm && newPass === confirm) {
            submitBtn.disabled = false;
        } else {
            submitBtn.disabled = true;
        }
    }

    // 비밀번호 입력 이벤트
    document.getElementById('currentPassword').addEventListener('input', validatePassword);
    document.getElementById('newPassword').addEventListener('input', validatePassword);
    document.getElementById('confirmPassword').addEventListener('input', validatePassword);

    // 비밀번호 변경 제출
    function submitPassword() {
        alert('비밀번호가 변경되었습니다.');
        closePasswordModal();
    }

    // 정보 수정 제출
    function submitInfo() {
        alert('정보가 저장되었습니다.');
        closeInfoModal();
    }

    // 로그아웃
    function handleLogout() {
        if (confirm('로그아웃 하시겠습니까?')) {
            alert('로그아웃되었습니다.');
            // 실제로는 로그인 페이지로 리다이렉트
        }
    }

    // 모달 외부 클릭시 닫기
    document.getElementById('passwordModal').addEventListener('click', function(e) {
        if (e.target === this) {
            closePasswordModal();
        }
    });

    document.getElementById('infoModal').addEventListener('click', function(e) {
        if (e.target === this) {
            closeInfoModal();
        }
    });

    // 네비게이션 활성화
    document.querySelectorAll('.nav-button:not(.logout)').forEach(button => {
        button.addEventListener('click', function() {
            document.querySelectorAll('.nav-button').forEach(btn => {
                btn.classList.remove('active');
            });
            this.classList.add('active');
        });
    });
</script>
</body>
</html>