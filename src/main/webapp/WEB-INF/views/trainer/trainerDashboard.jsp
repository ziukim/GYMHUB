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
            font-size: 14px;
            color: #8a6a50;
        }

        .info-value {
            font-size: 16px;
            color: #ffa366;
            margin: 0;
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
        }

        /* 프로필 섹션 스타일 (회원 프로필과 동일) */
        .profile-section {
            display: flex;
            gap: 24px;
            align-items: flex-start;
            margin-bottom: 24px;
        }

        .profile-image-container {
            position: relative;
            width: 96px;
            height: 96px;
            flex-shrink: 0;
        }

        .profile-image {
            width: 96px;
            height: 96px;
            background-color: #2d1810;
            border: 1px solid #ff6b00;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            overflow: hidden;
        }

        .profile-image img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .profile-image svg {
            width: 48px;
            height: 48px;
        }

        .camera-button {
            position: absolute;
            right: 0;
            bottom: 0;
            background: transparent;
            border: none;
            cursor: pointer;
            font-size: 20px;
            padding: 0;
            width: auto;
            height: auto;
            transform: none;
            line-height: 1;
        }

        .camera-button:hover {
            transform: scale(1.2);
            filter: brightness(1.2);
        }

        .profile-info {
            flex: 1;
        }

        .info-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 16px;
            margin-bottom: 16px;
        }

        .info-item {
            display: flex;
            flex-direction: column;
            gap: 4px;
        }

        .info-item.full-width {
            grid-column: 1 / -1;
        }

        .edit-buttons {
            display: flex;
            gap: 8px;
            margin-top: 16px;
        }

        .badge-container {
            display: flex;
            gap: 8px;
            flex-wrap: wrap;
        }

        .badge-container .badge {
            background-color: transparent;
            border: none;
            border-radius: 0;
            padding: 0;
            color: #ffa366;
            font-size: 14px;
            font-weight: 400;
            margin-bottom: 0;
        }

        @media (max-width: 768px) {
            .info-grid {
                grid-template-columns: 1fr;
            }
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

        .modal-container {
            background-color: #1a0f0a;
            border: 2px solid #ff6b00;
            border-radius: 12px;
            padding: 0;
            max-width: 500px;
            width: 90%;
            max-height: 90vh;
            overflow-y: auto;
            box-shadow: 0 0 30px rgba(255, 107, 0, 0.5);
            animation: modalSlideIn 0.3s ease-out;
        }

        @keyframes modalSlideIn {
            from {
                opacity: 0;
                transform: translateY(-50px) scale(0.9);
            }
            to {
                opacity: 1;
                transform: translateY(0) scale(1);
            }
        }

        .modal-header {
            padding: 24px;
            border-bottom: 2px solid #ff6b00;
            position: relative;
        }

        .modal-close {
            position: absolute;
            top: 20px;
            right: 20px;
            background: transparent;
            border: none;
            color: white;
            font-size: 24px;
            cursor: pointer;
            width: 32px;
            height: 32px;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 4px;
            transition: all 0.2s;
        }

        .modal-close:hover {
            background-color: rgba(255, 107, 0, 0.2);
            transform: rotate(90deg);
        }

        .modal-title {
            font-size: 20px;
            color: #ff6b00;
            font-weight: 600;
            margin-bottom: 8px;
        }

        .modal-body {
            padding: 24px;
        }

        .modal-form-group {
            margin-bottom: 20px;
        }

        .modal-label {
            display: block;
            font-size: 14px;
            color: white;
            margin-bottom: 8px;
            font-weight: 500;
        }

        .modal-label .required {
            color: #ff6b00;
            margin-left: 4px;
        }

        .modal-input {
            width: 100%;
            padding: 12px 16px;
            background-color: #2d1810;
            border: 2px solid #ff6b00;
            border-radius: 8px;
            color: white;
            font-size: 14px;
            font-family: 'Noto Sans KR', sans-serif;
            transition: all 0.3s;
            box-sizing: border-box;
        }

        .modal-input:focus {
            outline: none;
            box-shadow: 0 0 15px rgba(255, 107, 0, 0.4);
            border-color: #ff8800;
        }

        .modal-input::placeholder {
            color: #666;
        }

        .modal-footer {
            padding: 24px;
            border-top: 2px solid #ff6b00;
            display: flex;
            gap: 12px;
            justify-content: flex-end;
        }

        .btn {
            padding: 12px 24px;
            border-radius: 8px;
            font-size: 14px;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.3s;
            border: 2px solid transparent;
            font-family: 'Noto Sans KR', sans-serif;
        }

        .btn-primary {
            background-color: #ff6b00;
            color: white;
            border-color: #ff6b00;
        }

        .btn-primary:hover {
            background-color: #ff8800;
            box-shadow: 0 0 20px rgba(255, 107, 0, 0.6);
            transform: translateY(-2px);
        }

        .btn-secondary {
            background-color: transparent;
            border-color: #ff6b00;
            color: #ff6b00;
        }

        .btn-secondary:hover {
            background-color: rgba(255, 107, 0, 0.1);
            box-shadow: 0 0 15px rgba(255, 107, 0, 0.3);
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

        #editModal .modal-container {
            max-width: 800px;
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
            <h1>${loginMember.memberName} 트레이너님 환영합니다!</h1>
            <p>오늘도 힘차게 운동하세요</p>
        </div>

        <!-- 알림 메시지 -->
        <c:if test="${not empty alertMsg}">
            <script>
                alert("${alertMsg}");
            </script>
        </c:if>
        <c:if test="${not empty errorMsg}">
            <script>
                alert("${errorMsg}");
            </script>
        </c:if>

        <!-- Cards Row 1 -->
        <div class="cards-row">
            <!-- 트레이너 정보 Card -->
            <div class="card trainer-card">
                <div class="profile-section">
                    <div class="profile-image-container">
                        <div class="profile-image" id="mainProfileImage">
                            <c:choose>
                                <c:when test="${not empty loginMember.memberPhotoPath}">
                                    <img src="${pageContext.request.contextPath}${loginMember.memberPhotoPath}"
                                         alt="프로필 이미지"
                                         style="width: 100%; height: 100%; object-fit: cover; border-radius: 50%;">
                                </c:when>
                                <c:otherwise>
                                    <svg viewBox="0 0 48 48" fill="none">
                                        <path d="M24 24C28.4183 24 32 20.4183 32 16C32 11.5817 28.4183 8 24 8C19.5817 8 16 11.5817 16 16C16 20.4183 19.5817 24 24 24Z" stroke="#FF6B00" stroke-width="4" stroke-linecap="round" stroke-linejoin="round"/>
                                        <path d="M40 40C40 35.757 38.3143 31.6869 35.3137 28.6863C32.3131 25.6857 28.243 24 24 24C19.757 24 15.6869 25.6857 12.6863 28.6863C9.68571 31.6869 8 35.757 8 40" stroke="#FF6B00" stroke-width="4" stroke-linecap="round" stroke-linejoin="round"/>
                                    </svg>
                                </c:otherwise>
                            </c:choose>
                        </div>
                        <input type="file" id="profileImageInput" accept="image/*" style="display: none;">
                        <button class="camera-button" onclick="document.getElementById('profileImageInput').click()">
                            <img src="${pageContext.request.contextPath}/resources/images/icon/image.png" alt="이미지" style="width: 24px; height: 24px;">
                        </button>
                    </div>

                    <div class="profile-info">
                        <div class="info-grid">
                            <div class="info-item">
                                <label class="info-label">이름</label>
                                <p class="info-value">${loginMember.memberName}</p>
                            </div>
                            <div class="info-item">
                                <label class="info-label">생년월일</label>
                                <p class="info-value">${loginMember.memberBirth}</p>
                            </div>
                        </div>

                        <div class="info-grid">
                            <div class="info-item">
                                <label class="info-label">연락처</label>
                                <p class="info-value">${loginMember.memberPhone}</p>
                            </div>
                            <div class="info-item">
                                <label class="info-label">이메일</label>
                                <p class="info-value">${loginMember.memberEmail}</p>
                            </div>
                        </div>

                        <div class="info-item full-width">
                            <label class="info-label">주소</label>
                            <p class="info-value">${loginMember.memberAddress}</p>
                        </div>
                        <br>
                        <div class="info-grid">
                            <div class="info-item">
                                <label class="info-label">경력</label>
                                <p class="info-value">${loginMember.trainerCareer}</p>
                            </div>
                            <div class="info-item">
                                <label class="info-label">자격정보</label>
                                <div class="badge-container">
                                    <c:choose>
                                        <c:when test="${not empty loginMember.trainerLicense}">
                                            <c:forEach var="license" items="${loginMember.trainerLicense.split(',')}">
                                                <span class="badge">${license}</span>
                                            </c:forEach>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="info-value" style="color: #8a6a50; font-size: 14px;">등록된 자격정보가 없습니다</span>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                        </div>

                        <div class="info-item full-width">
                            <label class="info-label">수상이력</label>
                            <div class="badge-container">
                                <c:choose>
                                    <c:when test="${not empty loginMember.trainerAward}">
                                        <c:forEach var="award" items="${loginMember.trainerAward.split(',')}">
                                            <span class="badge">${award}</span>
                                        </c:forEach>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="info-value" style="color: #8a6a50; font-size: 14px;">등록된 수상이력이 없습니다</span>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>

                        <div class="edit-buttons">
                            <button class="btn btn-primary" onclick="openInfoModal()">정보 수정</button>
                            <button class="btn btn-secondary" onclick="openPasswordModal()">비밀번호 변경</button>
                        </div>
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

<!-- 비밀번호 변경 모달 -->
<div id="passwordModal" class="modal-overlay">
    <div class="modal-container">
        <div class="modal-header">
            <h3 class="modal-title">비밀번호 변경</h3>
            <button class="modal-close" onclick="closeModal('passwordModal')">
                <img src="${pageContext.request.contextPath}/resources/images/icon/close.png" alt="닫기" style="width: 16px; height: 16px;">
            </button>
        </div>
        <div class="modal-body">
            <form id="passwordForm" action="${pageContext.request.contextPath}/updatePassword.tr" method="post">
                <div class="modal-form-group">
                    <label class="modal-label">현재 비밀번호</label>
                    <input type="password" name="currentPassword" id="currentPassword" class="modal-input" required>
                </div>
                <div class="modal-form-group">
                    <label class="modal-label">새 비밀번호</label>
                    <input type="password" name="newPassword" id="newPassword" class="modal-input" required>
                </div>
                <div class="modal-form-group">
                    <label class="modal-label">새 비밀번호 확인</label>
                    <input type="password" id="confirmPassword" class="modal-input" required>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" onclick="closeModal('passwordModal')">취소</button>
                    <button type="submit" class="btn btn-primary">변경</button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- 정보 수정 모달 -->
<div id="editModal" class="modal-overlay">
    <div class="modal-container">
        <div class="modal-header">
            <h3 class="modal-title">정보 수정</h3>
            <button class="modal-close" onclick="closeModal('editModal')">
                <img src="${pageContext.request.contextPath}/resources/images/icon/close.png" alt="닫기" style="width: 16px; height: 16px;">
            </button>
        </div>
        <div class="modal-body">
            <form action="${pageContext.request.contextPath}/updateMemberInfo.tr" method="post">
                <div class="form-grid">
                    <div class="form-group">
                        <label class="form-label">이름</label>
                        <input type="text" name="memberName" class="modal-input" value="${loginMember.memberName}">
                    </div>
                    <div class="form-group">
                        <label class="form-label">생년월일</label>
                        <input type="text" name="birthDate" class="modal-input" value="${loginMember.memberBirth}">
                    </div>
                </div>
                <div class="form-grid">
                    <div class="form-group">
                        <label class="form-label">연락처</label>
                        <input type="text" name="phone" class="modal-input" value="${loginMember.memberPhone}">
                    </div>
                    <div class="form-group">
                        <label class="form-label">이메일</label>
                        <input type="email" name="email" class="modal-input" value="${loginMember.memberEmail}">
                    </div>
                </div>
                <div class="form-grid">
                    <div class="form-group">
                        <label class="modal-label">주소</label>
                        <input type="text" name="address" class="modal-input" value="${loginMember.memberAddress}">
                    </div>
                    <div class="form-group">
                        <label class="form-label">경력</label>
                        <input type="text" name="trainerCareer" class="form-input" placeholder="경력을 입력하세요." value="${loginMember.trainerCareer}">
                    </div>
                </div>
                <div class="form-grid">
                    <div class="form-group">
                        <label class="form-label">자격정보 (쉼표(,)로 구분하여 입력)</label>
                        <input type="text" name="trainerLicense" class="form-input" placeholder="자격정보를 입력하세요." value="${loginMember.trainerLicense}">
                    </div>
                    <div class="form-group">
                        <label class="form-label">수상이력 (쉼표(,)로 구분하여 입력)</label>
                        <input type="text" name="trainerAward" class="form-input" placeholder="수상이력을 입력하세요." value="${loginMember.trainerAward}">
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" onclick="closeModal('editModal')">취소</button>
                    <button type="submit" class="btn btn-primary">저장</button>
                </div>
            </form>
        </div>
    </div>
</div>

<script>
    // 페이지 로드 시 서버로부터 받은 메시지 출력
    document.addEventListener("DOMContentLoaded", function() {
        const message = "${message}";
        if (message) {
            alert(message);
        }
    });

    // 비밀번호 변경 모달 열기
    function openPasswordModal() {
        document.getElementById('passwordModal').classList.add('active');
    }

    // 정보 수정 모달 열기
    function openInfoModal() {
        document.getElementById('editModal').classList.add('active');
    }

    // 모달 닫기
    function closeModal(modalId) {
        document.getElementById(modalId).classList.remove('active');
    }

    // 모달 외부 클릭 시 닫기
    window.onclick = function(event) {
        if (event.target.classList.contains('modal-overlay')) {
            event.target.classList.remove('active');
        }
    }

    // 비밀번호 유효성 검사
    function validatePassword() {
        const current = document.getElementById('currentPassword').value;
        const newPass = document.getElementById('newPassword').value;
        const confirm = document.getElementById('confirmPassword').value;

        if (current && newPass && confirm && newPass.length >= 4 && newPass === confirm) {
            return true;
        }
        return false;
    }

    // 비밀번호 폼 제출 이벤트
    document.addEventListener('DOMContentLoaded', function() {
        const passwordForm = document.getElementById('passwordForm');
        if (passwordForm) {
            passwordForm.addEventListener('submit', function(e) {
                e.preventDefault();

                const newPass = document.getElementById('newPassword').value;
                const confirm = document.getElementById('confirmPassword').value;

                if (newPass !== confirm) {
                    alert('새 비밀번호와 확인 비밀번호가 일치하지 않습니다.');
                    return;
                }

                if (newPass.length < 4) {
                    alert('비밀번호는 최소 4자 이상이어야 합니다.');
                    return;
                }

                if (confirm("정말로 비밀번호를 변경하시겠습니까?")) {
                    this.submit();
                }
            });
        }
    });
    document.getElementById('profileImageInput').addEventListener('change', function(e) {
        if (e.target.files && e.target.files[0]) {
            var file = e.target.files[0];

            // 파일 크기 체크 (5MB 제한)
            if (file.size > 5 * 1024 * 1024) {
                alert('파일 크기는 5MB를 초과할 수 없습니다.');
                return;
            }

            // 이미지 파일 형식 체크
            if (!file.type.startsWith('image/')) {
                alert('이미지 파일만 업로드 가능합니다.');
                return;
            }

            // 미리보기 표시
            var reader = new FileReader();
            reader.onload = function(event) {
                var img = document.createElement('img');
                img.src = event.target.result;
                img.style.width = '100%';
                img.style.height = '100%';
                img.style.objectFit = 'cover';
                img.style.borderRadius = '50%';

                document.getElementById('mainProfileImage').innerHTML = '';
                document.getElementById('mainProfileImage').appendChild(img);
            }
            reader.readAsDataURL(file);

            // 서버에 업로드
            var formData = new FormData();
            formData.append('profileImage', file);

            fetch('${pageContext.request.contextPath}/uploadProfileImage.me', {
                method: 'POST',
                body: formData
            })
                .then(response => response.json())
                .then(data => {
                    if (data.success) {
                        alert(data.message);
                    } else {
                        alert(data.message);
                        // 실패 시 원래 이미지로 복구
                        location.reload();
                    }
                })
                .catch(error => {
                    console.error('Error:', error);
                    alert('이미지 업로드 중 오류가 발생했습니다.');
                    location.reload();
                });
        }
    });
</script>
</body>
</html>