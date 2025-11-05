<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>GYMHub - 나에게 맞는 헬스 찾기</title>

    <!-- Common CSS 링크 (필수) -->
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/common.css">

    <!-- 구글 폰트 (선택) -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;700&family=ABeeZee&family=ADLaM+Display&display=swap" rel="stylesheet">
    
    <!-- Index 페이지 전용 스타일 -->
    <style>
        /* ========================================
           Index 페이지 전용
           ======================================== */

        /* 헤더 */
        header {
            background: linear-gradient(180deg, #3a2820 0%, #2a1810 100%);
            padding: 15px 40px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            border-bottom: 2px solid #ff6b00;
        }

        header .logo {
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .logo-icon {
            width: 35px;
            height: 35px;
            object-fit: contain;
        }

        .logo-text {
            color: #ff6b00;
            font-size: 22px;
            font-weight: bold;
        }

        header .header-buttons {
            display: flex;
            gap: 10px;
            align-items: center;
        }

        .welcome-message {
            color: #ff6b00;
            font-size: 16px;
            font-weight: bold;
            margin-right: 10px;
        }

        /* 히어로 섹션 */
        .hero {
            background: linear-gradient(180deg, #2a1810 0%, #000 100%);
            padding: 80px 40px;
            text-align: center;
        }

        .hero h1 {
            font-size: 42px;
            margin-bottom: 20px;
            color: #fff;
        }

        .hero p {
            font-size: 18px;
            color: #8a6a50;
            margin-bottom: 40px;
        }

        .search-container {
            max-width: 800px;
            margin: 0 auto;
            display: flex;
            gap: 10px;
        }

        .filter-wrapper {
            flex-shrink: 0;
        }

        .search-input {
            flex: 1;
            padding: 15px 20px;
            background: #2d1810;
            border: 2px solid #ff6b00;
            border-radius: 8px;
            color: #fff;
            font-size: 16px;
        }

        .search-input::placeholder {
            color: #8a6a50;
        }

        .search-input:focus {
            outline: none;
            border-color: #ffa366;
        }

        .filter-select {
            width: 200px;
            padding: 15px 40px 15px 20px;
            background: #2d1810;
            border: 2px solid #8a6a50;
            border-radius: 8px;
            color: #fff;
            font-size: 16px;
            cursor: pointer;
            appearance: none;
            position: relative;
        }

        .filter-select:focus {
            outline: none;
            border-color: #ff6b00;
        }

        .filter-select option {
            background: #2d1810;
            color: #fff;
        }

        .search-btn {
            padding: 15px 40px;
            background: #ff6b00;
            border: none;
            border-radius: 8px;
            color: #fff;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
            transition: all 0.3s;
        }

        .search-btn:hover {
            background: #ffa366;
            transform: translateY(-2px);
            box-shadow: 0 5px 20px rgba(255, 107, 0, 0.5);
        }

        /* 카드 섹션 */
        .cards-section {
            padding: 60px 40px;
            max-width: 1200px;
            margin: 0 auto;
        }

        .search-result-message {
            display: none;
            color: #ff6b00;
            font-size: 18px;
            margin-bottom: 30px;
            text-align: center;
            padding: 15px;
            background: rgba(255, 107, 0, 0.1);
            border-radius: 8px;
            border: 1px solid #ff6b00;
        }

        .cards-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(320px, 1fr));
            gap: 30px;
        }

        .gym-card {
            background: linear-gradient(180deg, #1a1a1a 0%, #0a0a0a 100%);
            border: 2px solid #ff6b00;
            border-radius: 12px;
            overflow: hidden;
            transition: all 0.3s;
        }

        .gym-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 30px rgba(255, 107, 0, 0.4);
        }

        .gym-image {
            width: 100%;
            height: 200px;
            background: #2d1810;
            display: flex;
            align-items: center;
            justify-content: center;
            color: #8a6a50;
            font-size: 14px;
        }

        .gym-info {
            padding: 20px;
        }

        .gym-header {
            display: flex;
            justify-content: space-between;
            align-items: start;
            margin-bottom: 10px;
        }

        .gym-title {
            font-size: 18px;
            color: #ff6b00;
            font-weight: bold;
            margin-bottom: 5px;
        }

        .gym-rating {
            display: flex;
            align-items: center;
            gap: 5px;
            color: #ffa366;
            font-size: 14px;
        }

        .gym-location {
            color: #8a6a50;
            font-size: 14px;
            margin-bottom: 15px;
            display: flex;
            align-items: center;
            gap: 5px;
        }

        .gym-tags {
            display: flex;
            gap: 8px;
            margin-bottom: 15px;
            flex-wrap: wrap;
        }

        .tag {
            padding: 5px 12px;
            background: transparent;
            border: 1px solid #8a6a50;
            border-radius: 15px;
            color: #8a6a50;
            font-size: 12px;
        }

        .gym-description {
            color: #8a6a50;
            font-size: 14px;
            line-height: 1.6;
            margin-bottom: 15px;
        }

        .gym-price {
            color: #ff6b00;
            font-size: 18px;
            font-weight: bold;
            text-align: right;
        }

        /* ========================================
           모달 스타일 - Index 페이지용
           ======================================== */

        /* 로그인/회원가입 모달 */
        .modal-overlay .modal-container {
            background: linear-gradient(180deg, #1a0f0a 0%, #0a0a0a 100%);
            border: 2px solid #ff6b00;
            border-radius: 12px;
            padding: 40px;
            width: 100%;
            max-width: 540px;
            max-height: 90vh;
            position: relative;
            box-shadow: 0 0 30px rgba(255, 107, 0, 0.3);
            display: flex;
            flex-direction: column;
        }

        .modal-overlay .modal-close {
            position: absolute;
            top: 20px;
            right: 20px;
            background: none;
            border: none;
            color: #ff6b00;
            font-size: 24px;
            cursor: pointer;
            width: 30px;
            height: 30px;
            display: flex;
            align-items: center;
            justify-content: center;
            transition: color 0.3s;
            z-index: 10;
        }

        .modal-overlay .modal-close:hover {
            color: #ffa366;
        }

        .modal-logo {
            display: flex;
            align-items: center;
            gap: 10px;
            margin-bottom: 30px;
        }

        .modal-logo-icon {
            width: 40px;
            height: 40px;
            object-fit: contain;
        }

        .modal-logo-text {
            color: #ff6b00;
            font-size: 24px;
            font-weight: bold;
        }

        .modal-overlay .tabs {
            display: flex;
            gap: 10px;
            margin-bottom: 30px;
        }

        .modal-overlay .tab-button {
            flex: 1;
            padding: 10px 10px;
            background-color: transparent;
            border: 1px solid #8a6a50;
            color: #8a6a50;
            border-radius: 6px;
            cursor: pointer;
            font-size: 12px;
            transition: all 0.3s;
        }

        .modal-overlay .tab-button.active {
            background-color: #ff6b00;
            color: #ffffff;
            border-color: #ff6b00;
        }

        .modal-overlay .tab-button:hover:not(.active) {
            background-color: rgba(255, 107, 0, 0.1);
            border-color: #ff6b00;
        }

        .form-container {
            flex: 1;
            overflow-y: auto;
            overflow-x: hidden;
            padding-right: 10px;
            margin-bottom: 20px;
        }

        .form-container::-webkit-scrollbar {
            width: 8px;
        }

        .form-container::-webkit-scrollbar-track {
            background: #2d1810;
            border-radius: 4px;
        }

        .form-container::-webkit-scrollbar-thumb {
            background: #ffffff;
            border-radius: 4px;
        }

        .form-container::-webkit-scrollbar-thumb:hover {
            background: #ffa366;
        }

        .login-form,
        .registration-form {
            width: 100%;
        }

        .login-form .form-group,
        .registration-form .form-group {
            margin-bottom: 20px;
        }

        .login-form label,
        .registration-form label,
        .form-label {
            display: block;
            color: #ff6b00;
            font-size: 14px;
            margin-bottom: 8px;
        }

        .form-label .required {
            color: #ff6b00;
        }

        .login-form input,
        .login-form textarea,
        .registration-form input,
        .registration-form textarea {
            width: 100%;
            padding: 12px 15px;
            background-color: #2d1810;
            border: 1px solid #ff6b00;
            border-radius: 6px;
            color: #ffffff;
            font-size: 14px;
            transition: all 0.3s;
        }

        .login-form input:focus,
        .login-form textarea:focus,
        .registration-form input:focus,
        .registration-form textarea:focus {
            outline: none;
            border-color: #ff6b00;
            background-color: #3a1f14;
        }

        .login-form input::placeholder,
        .login-form textarea::placeholder,
        .registration-form input::placeholder,
        .registration-form textarea::placeholder {
            color: #8a6a50;
        }

        .login-footer {
            margin-top: 20px;
            text-align: center;
            color: #8a6a50;
            font-size: 14px;
        }

        .login-footer p {
            margin: 10px 0;
        }

        .link-text {
            color: #ff6b00;
            cursor: pointer;
            text-decoration: underline;
        }

        .link-text:hover {
            color: #ffa366;
        }

        .helper-text {
            font-size: 12px;
            color: #8a6a50;
            margin-top: 5px;
        }

        .helper-text.success {
            color: #4caf50;
        }

        .helper-text.error {
            color: #fb2c36;
        }

        .helper-text.hidden {
            display: none;
        }

        .submit-btn {
            width: 100%;
            padding: 14px;
            background-color: #ff6b00;
            border: none;
            border-radius: 6px;
            color: #ffffff;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
            transition: all 0.3s;
            box-shadow: 0 4px 15px rgba(255, 107, 0, 0.4);
        }

        .submit-btn:hover {
            background-color: #ffa366;
            box-shadow: 0 6px 20px rgba(255, 107, 0, 0.6);
            transform: translateY(-2px);
        }

        .icon-input {
            position: relative;
        }

        .icon-input::before {
            content: '📄';
            position: absolute;
            left: 15px;
            top: 50%;
            transform: translateY(-50%);
            z-index: 1;
        }

        .icon-input input {
            padding-left: 40px;
        }

        /* ========================================
           헬스장 상세 모달 전용 스타일
           ======================================== */

        /* 헬스장 상세 모달 컨테이너 */
        .gym-detail-modal .modal-container {
            max-width: 600px;
            padding: 25px;
        }

        .gym-detail-modal .modal-header {
            margin-bottom: 24px;
        }

        .gym-detail-modal .modal-title {
            font-size: 18px;
            color: white;
            font-weight: bold;
        }

        .gym-detail-modal .close-btn {
            background: none;
            border: none;
            cursor: pointer;
            padding: 0;
            width: 16px;
            height: 16px;
            opacity: 0.7;
            transition: opacity 0.3s;
        }

        .gym-detail-modal .close-btn:hover {
            opacity: 1;
        }

        /* 메인 이미지 */
        .main-image {
            width: 100%;
            height: 251px;
            border-radius: 10px;
            overflow: hidden;
            margin-bottom: 24px;
        }

        .main-image img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        /* 뱃지 그룹 */
        .badges {
            display: flex;
            gap: 8px;
            flex-wrap: wrap;
            margin-bottom: 24px;
        }

        .badges .badge {
            background-color: #ff6b00;
            color: #0a0a0a;
            padding: 3px 9px;
            border-radius: 8px;
            font-size: 12px;
            font-weight: 600;
            border: none;
        }

        /* 섹션 (모달용) */
        .gym-detail-modal .section {
            margin-bottom: 24px;
        }

        .gym-detail-modal .section-title {
            font-size: 18px;
            color: #ff6b00;
            margin-bottom: 12px;
            font-weight: bold;
        }

        .gym-detail-modal .section-text {
            font-size: 16px;
            color: #8a6a50;
            line-height: 1.5;
        }

        /* 정보 카드 (모달용) */
        .gym-detail-modal .info-card {
            background-color: #2d1810;
            border-radius: 10px;
            padding: 12px;
            display: flex;
            gap: 12px;
            margin-bottom: 12px;
            border: none;
        }

        .info-icon {
            width: 20px;
            height: 20px;
            flex-shrink: 0;
        }

        .info-content {
            display: flex;
            flex-direction: column;
            gap: 4px;
        }

        .info-label {
            font-size: 14px;
            color: #ffa366;
            font-weight: 600;
        }

        .info-value {
            font-size: 14px;
            color: #8a6a50;
        }

        .info-link {
            font-size: 14px;
            color: #ff6b00;
            text-decoration: none;
        }

        .info-link:hover {
            text-decoration: underline;
        }

        /* 시설 그리드 */
        .facility-grid {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 16px;
        }

        .facility-item {
            background-color: #2d1810;
            border: 1px solid #ffa366;
            border-radius: 10px;
            padding: 17px 8px;
            display: flex;
            flex-direction: column;
            align-items: center;
            gap: 8px;
        }

        .facility-item svg {
            width: 24px;
            height: 24px;
        }

        .facility-item span {
            font-size: 14px;
            color: #ffa366;
            text-align: center;
        }

        /* 차트 컨테이너 */
        .chart-container {
            background-color: #2d1810;
            border-radius: 10px;
            padding: 16px;
        }

        .chart-container svg {
            width: 100%;
            height: auto;
        }

        /* 카드 그리드 (모달용) */
        .gym-detail-modal .cards-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 16px;
            margin-bottom: 24px;
        }

        .info-card-box {
            background-color: #2d1810;
            border: 1px solid #ff6b00;
            border-radius: 14px;
            padding: 25px 24px;
            display: flex;
            flex-direction: column;
            gap: 20px;
        }

        .info-card-box .card-header {
            display: flex;
            align-items: center;
            gap: 8px;
            margin-bottom: 0;
        }

        .info-card-box .card-header svg {
            width: 20px;
            height: 20px;
        }

        .info-card-box .card-header span {
            font-size: 16px;
            color: #ff6b00;
            font-weight: 600;
        }

        .info-card-box .card-content {
            display: flex;
            flex-direction: column;
            gap: 4px;
        }

        .info-card-box .card-content p {
            font-size: 16px;
            color: #8a6a50;
            margin: 0;
            line-height: 1.5;
        }

        /* 기구 그리드 */
        .equipment-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 20px;
            margin-bottom: 12px;
        }

        .equipment-item {
            display: flex;
            flex-direction: column;
            gap: 8px;
        }

        .equipment-image {
            width: 100%;
            height: 188px;
            border-radius: 30px;
            overflow: hidden;
        }

        .equipment-image img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .equipment-name {
            font-size: 16px;
            color: #8a6a50;
            margin: 0;
        }

        .more-text {
            font-size: 12px;
            color: #b8b8b8;
            text-align: left;
            margin-bottom: 24px;
            background-color: #ff6b00;
            border: none;
            border-radius: 8px;
            padding: 8px 16px;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        .more-text:hover {
            background-color: #ff8533;
        }

        /* 방문 예약 버튼 */
        .booking-btn {
            background-color: #ff6b00;
            color: #0a0a0a;
            border: none;
            border-radius: 8px;
            padding: 8px 16px;
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            width: 100%;
            height: 36px;
            transition: background-color 0.3s;
        }

        .booking-btn:hover {
            background-color: #ff8533;
        }

        .booking-btn:active {
            background-color: #e65f00;
        }

        /* 반응형 (모달용) */
        @media (max-width: 600px) {
            .facility-grid {
                grid-template-columns: repeat(2, 1fr);
            }
            
            .gym-detail-modal .cards-grid {
                grid-template-columns: 1fr;
            }

            .equipment-grid {
                grid-template-columns: 1fr;
            }

            .gym-detail-modal .modal-container {
                padding: 20px;
            }

            .gym-detail-modal .modal-title {
                font-size: 16px;
            }

            .gym-detail-modal .section-title {
                font-size: 16px;
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
    <div class="header-buttons">
        <c:choose>
            <c:when test="${not empty loginMember}">
                <span class="welcome-message">${loginMember.name}님 환영합니다</span>
                <button class="btn btn-secondary" id="logoutBtn">로그아웃</button>
            </c:when>
            <c:otherwise>
                <button class="btn btn-secondary" id="loginBtn">로그인</button>
                <button class="btn btn-primary" id="signupBtn">회원가입</button>
            </c:otherwise>
        </c:choose>
    </div>
</header>

<!-- 히어로 섹션 -->
<section class="hero">
    <h1>나에게 맞는 헬스 찾기</h1>
    <p>원하는 조건에 맞는 헬스장을 검색해보세요</p>
    <div class="search-container">
        <div class="filter-wrapper">
            <select class="filter-select">
                <option value="">정렬 기준</option>
                <option value="rating">평점 높은 순</option>
                <option value="price-low">가격 낮은 순</option>
                <option value="price-high">가격 높은 순</option>
                <option value="distance">거리 가까운 순</option>
                <option value="review">리뷰 많은 순</option>
            </select>
        </div>
        <input type="text" class="search-input" placeholder="원하는 헬스장 이름을 검색해보세요">
        <button class="search-btn">검색</button>
    </div>
</section>

<!-- 카드 섹션 -->
<section class="cards-section">
    <div class="cards-grid">
        <c:forEach var="gym" items="${gymList}" varStatus="status">
            <div class="gym-card">
                <div class="gym-image">헬스장 썸네일 이미지</div>
                <div class="gym-info">
                    <div class="gym-header">
                        <div>
                            <div class="gym-title">${gym.name}</div>
                            <div class="gym-location">${gym.location}</div>
                        </div>
                        <div class="gym-rating">★ ${gym.rating} (${gym.reviewCount})</div>
                    </div>
                    <div class="gym-tags">
                        <c:forEach var="tag" items="${gym.tags}">
                            <span class="tag">${tag}</span>
                        </c:forEach>
                    </div>
                    <div class="gym-description">
                            ${gym.description}
                    </div>
                    <div class="gym-price">월 ${gym.price}원</div>
                </div>
            </div>
        </c:forEach>

        <!-- 테스트용 샘플 데이터 (실제 데이터가 없을 때) -->
        <c:if test="${empty gymList}">
            <div class="gym-card">
                <div class="gym-image">헬스장 썸네일 이미지</div>
                <div class="gym-info">
                    <div class="gym-header">
                        <div>
                            <div class="gym-title">파워 헬스 클럽 대교점</div>
                            <div class="gym-location">경기 남양주</div>
                        </div>
                        <div class="gym-rating">★ 4.8 (324)</div>
                    </div>
                    <div class="gym-tags">
                        <span class="tag">GX</span>
                        <span class="tag">파워</span>
                        <span class="tag">주차</span>
                    </div>
                    <div class="gym-description">
                        최신 시설을 갖춘 파워 헬스 클럽입니다
                    </div>
                    <div class="gym-price">월 85,000원</div>
                </div>
            </div>

            <div class="gym-card">
                <div class="gym-image">헬스장 썸네일 이미지</div>
                <div class="gym-info">
                    <div class="gym-header">
                        <div>
                            <div class="gym-title">파워 헬스 클럽 강동점</div>
                            <div class="gym-location">서울 강동</div>
                        </div>
                        <div class="gym-rating">★ 4.9 (356)</div>
                    </div>
                    <div class="gym-tags">
                        <span class="tag">GX</span>
                        <span class="tag">파워</span>
                        <span class="tag">주차</span>
                    </div>
                    <div class="gym-description">
                        깨끗한 헬스 클럽입니다
                    </div>
                    <div class="gym-price">월 75,000원</div>
                </div>
            </div>

            <div class="gym-card">
                <div class="gym-image">헬스장 썸네일 이미지</div>
                <div class="gym-info">
                    <div class="gym-header">
                        <div>
                            <div class="gym-title">운동하는 헬스 클럽 강남점</div>
                            <div class="gym-location">서울 강남구</div>
                        </div>
                        <div class="gym-rating">★ 4.7 (462)</div>
                    </div>
                    <div class="gym-tags">
                        <span class="tag">GX</span>
                        <span class="tag">파워</span>
                        <span class="tag">주차</span>
                    </div>
                    <div class="gym-description">
                        깔끔한 헬스 클럽입니다
                    </div>
                    <div class="gym-price">월 90,000원</div>
                </div>
            </div>
        </c:if>
    </div>
</section>

<!-- 로그인 모달 -->
<div class="modal-overlay" id="loginModal">
    <div class="modal-container">
        <div class="modal-header">
            <div class="modal-logo">
                <img src="${pageContext.request.contextPath}/resources/images/icon/logo.png" class="modal-logo-icon" alt="GYMHub">
                <span class="modal-logo-text">GYMHub</span>
            </div>
            <button class="modal-close" id="closeLoginModal">×</button>
        </div>

        <div class="modal-body">
            <form class="login-form" id="loginForm" action="${pageContext.request.contextPath}/login.do" method="post">
                <div class="form-group">
                    <label class="form-label">아이디</label>
                    <input type="text" id="loginId" name="id" placeholder="아이디" required>
                </div>

                <div class="form-group">
                    <label class="form-label">비밀번호</label>
                    <input type="password" id="loginPassword" name="password" placeholder="비밀번호" required>
                </div>

                <button type="submit" class="submit-btn">로그인</button>

                <div class="login-footer">
                    <p>아이디나 비밀번호를 잊으셨나요?</p>
                    <p>회원이 아니신가요? <span class="link-text" id="goToSignup">회원가입 하기</span></p>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- 회원가입 모달 -->
<div class="modal-overlay" id="signupModal">
    <div class="modal-container">
        <div class="modal-header">
            <div class="modal-logo">
                <img src="${pageContext.request.contextPath}/resources/images/icon/logo.png" class="modal-logo-icon" alt="GYMHub">
                <span class="modal-logo-text">GYMHub</span>
            </div>
            <button class="modal-close" id="closeModal">×</button>
        </div>

        <div class="modal-body">
            <div class="tabs">
                <button class="tab-button active" data-tab="member">일반 회원</button>
                <button class="tab-button" data-tab="trainer">트레이너</button>
                <button class="tab-button" data-tab="gym">헬스장 운영</button>
            </div>

            <div class="form-container">
                <!-- 일반 회원 폼 -->
                <div class="tab-content active" id="member">
                    <form class="registration-form" action="${pageContext.request.contextPath}/signup/member.do" method="post">
                        <div class="form-group">
                            <label class="form-label">아이디<span class="required">*</span></label>
                            <input type="text" name="id" placeholder="아이디를 입력하세요" required>
                            <div class="helper-text success">사용 가능한 아이디입니다</div>
                        </div>

                        <div class="form-group">
                            <label class="form-label">비밀번호 <span class="required">*</span></label>
                            <input type="password" name="password" class="password" placeholder="비밀번호를 입력하세요" required>
                        </div>

                        <div class="form-group">
                            <label class="form-label">비밀번호 확인 <span class="required">*</span></label>
                            <input type="password" class="password-confirm" placeholder="비밀번호를 다시 입력하세요" required>
                            <div class="helper-text error hidden">비밀번호가 일치하지 않습니다</div>
                        </div>

                        <div class="form-group">
                            <label class="form-label">이름 <span class="required">*</span></label>
                            <input type="text" name="name" placeholder="이름을 입력하세요" required>
                        </div>

                        <div class="form-group">
                            <label class="form-label">주소</label>
                            <input type="text" name="address" placeholder="주소를 입력하세요">
                        </div>

                        <div class="form-group">
                            <label class="form-label">전화번호 <span class="required">*</span></label>
                            <input type="tel" name="phone" placeholder="전화번호를 입력하세요(- 제외 숫자만 입력)" required>
                        </div>

                        <div class="form-group">
                            <label class="form-label">생년월일 <span class="required">*</span></label>
                            <div class="icon-input">
                                <input type="text" name="birthDate" placeholder="생년월일 8자리를 입력하세요(- 제외 숫자만 입력)" required>
                            </div>
                        </div>

                        <button type="submit" class="submit-btn">회원가입</button>
                    </form>
                </div>

                <!-- 트레이너 폼 -->
                <div class="tab-content" id="trainer">
                    <form class="registration-form" action="${pageContext.request.contextPath}/signup/trainer.do" method="post">
                        <div class="form-group">
                            <label class="form-label">아이디<span class="required">*</span></label>
                            <input type="text" name="id" placeholder="아이디를 입력하세요" required>
                            <div class="helper-text success">사용 가능한 아이디입니다</div>
                        </div>

                        <div class="form-group">
                            <label class="form-label">비밀번호 <span class="required">*</span></label>
                            <input type="password" name="password" class="password" placeholder="비밀번호를 입력하세요" required>
                        </div>

                        <div class="form-group">
                            <label class="form-label">비밀번호 확인 <span class="required">*</span></label>
                            <input type="password" class="password-confirm" placeholder="비밀번호를 다시 입력하세요" required>
                            <div class="helper-text error hidden">비밀번호가 일치하지 않습니다</div>
                        </div>

                        <div class="form-group">
                            <label class="form-label">이름 <span class="required">*</span></label>
                            <input type="text" name="name" placeholder="이름을 입력하세요" required>
                        </div>

                        <div class="form-group">
                            <label class="form-label">주소</label>
                            <input type="text" name="address" placeholder="주소를 입력하세요">
                        </div>

                        <div class="form-group">
                            <label class="form-label">전화번호 <span class="required">*</span></label>
                            <input type="tel" name="phone" placeholder="전화번호를 입력하세요(- 제외 숫자만 입력)" required>
                        </div>

                        <div class="form-group">
                            <label class="form-label">생년월일 <span class="required">*</span></label>
                            <div class="icon-input">
                                <input type="text" name="birthDate" placeholder="생년월일 8자리를 입력하세요(- 제외 숫자만 입력)" required>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="form-label">이메일</label>
                            <input type="email" name="email" placeholder="이메일을 입력하세요">
                        </div>

                        <div class="form-group">
                            <label class="form-label">경력</label>
                            <input type="text" name="career" placeholder="경력을 입력하세요">
                        </div>

                        <div class="form-group">
                            <label class="form-label">자격정보</label>
                            <input type="text" name="certification" placeholder="자격정보를 입력하세요">
                        </div>

                        <div class="form-group">
                            <label class="form-label">상세경력</label>
                            <input type="text" name="detailCareer" placeholder="상세경력을 입력하세요">
                        </div>

                        <button type="submit" class="submit-btn">회원가입</button>
                    </form>
                </div>

                <!-- 헬스장 운영 폼 -->
                <div class="tab-content" id="gym">
                    <form class="registration-form" action="${pageContext.request.contextPath}/signup/gym.do" method="post">
                        <div class="form-group">
                            <label class="form-label">아이디<span class="required">*</span></label>
                            <input type="text" name="id" placeholder="아이디를 입력하세요" required>
                            <div class="helper-text success">사용 가능한 아이디입니다</div>
                        </div>

                        <div class="form-group">
                            <label class="form-label">비밀번호 <span class="required">*</span></label>
                            <input type="password" name="password" class="password" placeholder="비밀번호를 입력하세요" required>
                        </div>

                        <div class="form-group">
                            <label class="form-label">비밀번호 확인 <span class="required">*</span></label>
                            <input type="password" class="password-confirm" placeholder="비밀번호를 다시 입력하세요" required>
                            <div class="helper-text error hidden">비밀번호가 일치하지 않습니다</div>
                        </div>

                        <div class="form-group">
                            <label class="form-label">대표자 명</label>
                            <input type="text" name="representative" placeholder="대표자 명을 입력하세요">
                        </div>

                        <div class="form-group">
                            <label class="form-label">전화번호 <span class="required">*</span></label>
                            <input type="tel" name="phone" placeholder="전화번호를 입력하세요(- 제외 숫자만 입력)" required>
                        </div>

                        <div class="form-group">
                            <label class="form-label">주소</label>
                            <input type="text" name="address" placeholder="주소를 입력하세요">
                        </div>

                        <div class="form-group">
                            <label class="form-label">상호명</label>
                            <input type="text" name="gymName" placeholder="상호명을 입력하세요">
                        </div>

                        <div class="form-group">
                            <label class="form-label">이메일</label>
                            <input type="email" name="email" placeholder="이메일을 입력하세요">
                        </div>

                        <button type="submit" class="submit-btn">회원가입</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- 헬스장 상세 모달 -->
<div class="modal-overlay gym-detail-modal" id="gymDetailModal">
    <div class="modal-container">
        <div class="modal-header">
            <h2 class="modal-title" id="gymDetailTitle">헬스 클럽 강남점</h2>
            <button class="close-btn" id="closeGymDetailModal">
                <svg width="16" height="16" viewBox="0 0 16 16" fill="none">
                    <path d="M12 4L4 12" stroke="#FFA366" stroke-width="1.33333" stroke-linecap="round" stroke-linejoin="round"/>
                    <path d="M4 4L12 12" stroke="#FFA366" stroke-width="1.33333" stroke-linecap="round" stroke-linejoin="round"/>
                </svg>
            </button>
        </div>

        <!-- 메인 이미지 -->
        <div class="main-image">
            <img src="https://images.unsplash.com/photo-1534438327276-14e5300c3a48?w=800" alt="헬스장 이미지" id="gymDetailImage">
        </div>

        <!-- 뱃지 -->
        <div class="badges" id="gymDetailBadges">
            <span class="badge">24시간</span>
            <span class="badge">주차가능</span>
            <span class="badge">샤워실</span>
            <span class="badge">PT</span>
        </div>

        <!-- 소개 -->
        <div class="section">
            <h3 class="section-title">소개</h3>
            <p class="section-text" id="gymDetailDescription">최신 시설을 갖춘 프리미엄 헬스장</p>
        </div>

        <!-- 주소 & 연락처 -->
        <div class="section">
            <h3 class="section-title">주소 & 연락처</h3>
            
            <div class="info-card">
                <div class="info-icon">
                    <svg width="20" height="20" viewBox="0 0 20 20" fill="none">
                        <path d="M16.6667 8.33333C16.6667 12.4942 12.0508 16.8275 10.5008 18.1658C10.3564 18.2744 10.1807 18.3331 10 18.3331C9.81933 18.3331 9.64356 18.2744 9.49917 18.1658C7.94917 16.8275 3.33333 12.4942 3.33333 8.33333C3.33333 6.56522 4.03571 4.86953 5.28595 3.61929C6.5362 2.36905 8.23189 1.66667 10 1.66667C11.7681 1.66667 13.4638 2.36905 14.714 3.61929C15.9643 4.86953 16.6667 6.56522 16.6667 8.33333Z" stroke="#FF6B00" stroke-width="1.66667" stroke-linecap="round" stroke-linejoin="round"/>
                        <path d="M10 10.8333C11.3807 10.8333 12.5 9.71405 12.5 8.33333C12.5 6.95262 11.3807 5.83333 10 5.83333C8.61929 5.83333 7.5 6.95262 7.5 8.33333C7.5 9.71405 8.61929 10.8333 10 10.8333Z" stroke="#FF6B00" stroke-width="1.66667" stroke-linecap="round" stroke-linejoin="round"/>
                    </svg>
                </div>
                <div class="info-content">
                    <div class="info-label">주소</div>
                    <div class="info-value" id="gymDetailAddress">서울 강남구</div>
                </div>
            </div>

            <div class="info-card">
                <div class="info-icon">
                    <svg width="20" height="20" viewBox="0 0 20 20" fill="none">
                        <path d="M11.5267 13.8067C11.6988 13.8857 11.8927 13.9038 12.0764 13.8579C12.2602 13.812 12.4228 13.7049 12.5375 13.5542L12.8333 13.1667C12.9886 12.9597 13.1899 12.7917 13.4213 12.676C13.6527 12.5602 13.9079 12.5 14.1667 12.5H16.6667C17.1087 12.5 17.5326 12.6756 17.8452 12.9882C18.1577 13.3007 18.3333 13.7246 18.3333 14.1667V16.6667C18.3333 17.1087 18.1577 17.5326 17.8452 17.8452C17.5326 18.1577 17.1087 18.3333 16.6667 18.3333C12.6884 18.3333 8.87311 16.753 6.06006 13.9399C3.24702 11.1269 1.66667 7.31158 1.66667 3.33333C1.66667 2.89131 1.84226 2.46738 2.15482 2.15482C2.46738 1.84226 2.89131 1.66667 3.33333 1.66667H5.83333C6.27536 1.66667 6.69928 1.84226 7.01184 2.15482C7.3244 2.46738 7.5 2.89131 7.5 3.33333V5.83333C7.5 6.09208 7.43976 6.34726 7.32405 6.57869C7.20833 6.81011 7.04033 7.01142 6.83333 7.16667L6.44333 7.45917C6.29035 7.57598 6.18252 7.74215 6.13816 7.92946C6.0938 8.11676 6.11565 8.31365 6.2 8.48667C7.3389 10.7999 9.21202 12.6707 11.5267 13.8067Z" stroke="#FF6B00" stroke-width="1.66667" stroke-linecap="round" stroke-linejoin="round"/>
                    </svg>
                </div>
                <div class="info-content">
                    <div class="info-label">전화번호</div>
                    <a href="tel:02-1234-5678" class="info-link" id="gymDetailPhone">02-1234-5678</a>
                </div>
            </div>
        </div>

        <!-- 시설 정보 -->
        <div class="section">
            <h3 class="section-title">시설 정보</h3>
            
            <div class="facility-grid">
                <div class="facility-item">
                    <svg width="24" height="24" viewBox="0 0 24 24" fill="none">
                        <path d="M18 11H20C20.6 11 21 10.6 21 10V7C21 6.1 20.3 5.3 19.5 5.1C17.7 4.6 15 4 15 4C15 4 13.7 2.6 12.8 1.7C12.3 1.3 11.7 1 11 1H4C3.4 1 2.9 1.4 2.6 1.9L1.2 4.8C1.06758 5.18623 1 5.5917 1 6V10C1 10.6 1.4 11 2 11H4" stroke="#FF6B00" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                    </svg>
                    <span>주차</span>
                </div>
                <div class="facility-item">
                    <svg width="24" height="24" viewBox="0 0 24 24" fill="none">
                        <path d="M8 20C9.85652 20 11.637 19.2625 12.9497 17.9497C14.2625 16.637 15 14.8565 15 13C15 11 14 9.1 12 7.5C10 5.9 8.5 3.5 8 1C7.5 3.5 6 5.9 4 7.5C2 9.1 1 11 1 13C1 14.8565 1.7375 16.637 3.05025 17.9497C4.36301 19.2625 6.14348 20 8 20Z" stroke="#FF6B00" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                    </svg>
                    <span>샤워실</span>
                </div>
                <div class="facility-item">
                    <svg width="24" height="24" viewBox="0 0 24 24" fill="none">
                        <path d="M1 4.5L3.3 6.8C3.48693 6.98323 3.73825 7.08586 4 7.08586C4.26175 7.08586 4.51307 6.98323 4.7 6.8L6.8 4.7C6.98323 4.51307 7.08586 4.26175 7.08586 4C7.08586 3.73825 6.98323 3.48693 6.8 3.3L4.5 1" stroke="#FF6B00" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                    </svg>
                    <span>락커</span>
                </div>
                <div class="facility-item">
                    <svg width="24" height="24" viewBox="0 0 24 24" fill="none">
                        <path d="M7.94991 11.8391C8.32505 12.2142 8.83386 12.425 9.3644 12.425C9.89495 12.425 10.4038 12.2142 10.7789 11.8391C11.1541 11.4639 11.3648 10.9551 11.3648 10.4246C11.3648 9.89401 11.1541 9.3852 10.7789 9.01005L9.0109 7.24305C9.38605 7.61807 9.89481 7.8287 10.4253 7.8286C10.6879 7.82856 10.948 7.77678 11.1906 7.67622C11.4333 7.57567 11.6537 7.42831 11.8394 7.24255C12.0251 7.0568 12.1724 6.83629 12.2728 6.59361C12.3733 6.35094 12.425 6.09085 12.425 5.8282C12.4249 5.56555 12.3731 5.30548 12.2726 5.06284C12.172 4.8202 12.0247 4.59974 11.8389 4.41405L9.0109 1.58605C8.63589 1.2109 8.1272 1.00009 7.59676 1C7.06631 0.999906 6.55755 1.21054 6.1824 1.58555C5.80726 1.96057 5.59645 2.46925 5.59635 2.9997C5.59626 3.53014 5.80689 4.0389 6.1819 4.41405L4.4149 2.64605C4.22915 2.4603 4.00863 2.31295 3.76593 2.21242C3.52323 2.11189 3.2631 2.06015 3.0004 2.06015C2.73771 2.06015 2.47758 2.11189 2.23488 2.21242C1.99218 2.31295 1.77166 2.4603 1.58591 2.64605C1.40015 2.83181 1.2528 3.05233 1.15227 3.29503C1.05174 3.53773 1 3.79785 1 4.06055C1 4.32325 1.05174 4.58337 1.15227 4.82607C1.2528 5.06877 1.40015 5.2893 1.58591 5.47505L7.94991 11.8391Z" stroke="#FF6B00" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                    </svg>
                    <span>최신기구</span>
                </div>
            </div>
        </div>

        <!-- 시간대별 혼잡도 -->
        <div class="section">
            <h3 class="section-title">시간대별 혼잡도</h3>
            
            <div class="chart-container">
                <svg width="100%" height="224" viewBox="0 0 415 224" fill="none" preserveAspectRatio="xMidYMid meet">
                    <!-- 그리드 라인 -->
                    <line x1="0" y1="184.5" x2="345" y2="184.5" stroke="#4A3020" stroke-dasharray="3 3"/>
                    <line x1="0" y1="138.5" x2="345" y2="138.5" stroke="#4A3020" stroke-dasharray="3 3"/>
                    <line x1="0" y1="92.5" x2="345" y2="92.5" stroke="#4A3020" stroke-dasharray="3 3"/>
                    <line x1="0" y1="46.5" x2="345" y2="46.5" stroke="#4A3020" stroke-dasharray="3 3"/>
                    <line x1="0" y1="0.5" x2="345" y2="0.5" stroke="#4A3020" stroke-dasharray="3 3"/>
                    
                    <!-- 바 차트 -->
                    <rect x="16" y="152" width="30" height="37" rx="8" fill="#FF6B00"/>
                    <rect x="54" y="105" width="30" height="83" rx="8" fill="#FF6B00"/>
                    <rect x="92" y="133" width="30" height="56" rx="8" fill="#FF6B00"/>
                    <rect x="130" y="87" width="30" height="102" rx="8" fill="#FF6B00"/>
                    <rect x="168" y="124" width="30" height="65" rx="8" fill="#FF6B00"/>
                    <rect x="206" y="115" width="30" height="74" rx="8" fill="#FF6B00"/>
                    <rect x="244" y="32" width="30" height="157" rx="8" fill="#FF6B00"/>
                    <rect x="282" y="51" width="30" height="138" rx="8" fill="#FF6B00"/>
                    <rect x="320" y="97" width="30" height="92" rx="8" fill="#FF6B00"/>
                    
                    <!-- X축 레이블 -->
                    <text x="30" y="210" fill="#8A6A50" font-size="12" text-anchor="middle">06:00</text>
                    <text x="106" y="210" fill="#8A6A50" font-size="12" text-anchor="middle">10:00</text>
                    <text x="183" y="210" fill="#8A6A50" font-size="12" text-anchor="middle">14:00</text>
                    <text x="259" y="210" fill="#8A6A50" font-size="12" text-anchor="middle">18:00</text>
                    <text x="335" y="210" fill="#8A6A50" font-size="12" text-anchor="middle">22:00</text>
                    
                    <!-- Y축 레이블 -->
                    <text x="380" y="190" fill="#8A6A50" font-size="12" text-anchor="end">0</text>
                    <text x="380" y="145" fill="#8A6A50" font-size="12" text-anchor="end">25</text>
                    <text x="380" y="97" fill="#8A6A50" font-size="12" text-anchor="end">50</text>
                    <text x="380" y="50" fill="#8A6A50" font-size="12" text-anchor="end">75</text>
                    <text x="380" y="10" fill="#8A6A50" font-size="12" text-anchor="end">100</text>
                </svg>
            </div>
        </div>

        <!-- 가격 & 운영시간 -->
        <div class="cards-grid">
            <div class="info-card-box">
                <div class="card-header">
                    <svg width="20" height="20" viewBox="0 0 20 20" fill="none">
                        <path d="M13.3333 17.5V15.8333C13.3333 14.9493 12.9821 14.1014 12.357 13.4763C11.7319 12.8512 10.8841 12.5 10 12.5H5C4.11595 12.5 3.2681 12.8512 2.64298 13.4763C2.01786 14.1014 1.66667 14.9493 1.66667 15.8333V17.5" stroke="#FF6B00" stroke-width="1.66667" stroke-linecap="round" stroke-linejoin="round"/>
                        <path d="M18.3333 17.5V15.8333C18.3328 15.0948 18.087 14.3773 17.6345 13.7936C17.182 13.2099 16.5484 12.793 15.8333 12.6083" stroke="#FF6B00" stroke-width="1.66667" stroke-linecap="round" stroke-linejoin="round"/>
                        <path d="M13.3333 2.60671C14.0481 2.79202 14.6812 3.20943 15.1331 3.79343C15.585 4.37743 15.8302 5.09495 15.8302 5.83338C15.8302 6.5718 15.585 7.28933 15.1331 7.87332C14.6812 8.45732 14.0481 8.87473 13.3333 9.06004" stroke="#FF6B00" stroke-width="1.66667" stroke-linecap="round" stroke-linejoin="round"/>
                        <path d="M7.5 9.16667C9.34095 9.16667 10.8333 7.67428 10.8333 5.83333C10.8333 3.99238 9.34095 2.5 7.5 2.5C5.65905 2.5 4.16667 3.99238 4.16667 5.83333C4.16667 7.67428 5.65905 9.16667 7.5 9.16667Z" stroke="#FF6B00" stroke-width="1.66667" stroke-linecap="round" stroke-linejoin="round"/>
                    </svg>
                    <span>가격 정보</span>
                </div>
                <div class="card-content" id="gymDetailPrice">
                    <p>1개월: ₩89,000</p>
                    <p>3개월: ₩79,000</p>
                    <p>6개월: ₩69,000</p>
                </div>
            </div>

            <div class="info-card-box">
                <div class="card-header">
                    <svg width="20" height="20" viewBox="0 0 20 20" fill="none">
                        <path d="M10 5V10L13.3333 11.6667" stroke="#FF6B00" stroke-width="1.66667" stroke-linecap="round" stroke-linejoin="round"/>
                        <path d="M10 18.3333C14.6024 18.3333 18.3333 14.6024 18.3333 10C18.3333 5.39763 14.6024 1.66667 10 1.66667C5.39763 1.66667 1.66667 5.39763 1.66667 10C1.66667 14.6024 5.39763 18.3333 10 18.3333Z" stroke="#FF6B00" stroke-width="1.66667" stroke-linecap="round" stroke-linejoin="round"/>
                    </svg>
                    <span>운영시간</span>
                </div>
                <div class="card-content" id="gymDetailHours">
                    <p>평일: 00:00 - 23:59</p>
                    <p>주말: 00:00 - 23:59</p>
                </div>
            </div>
        </div>

        <!-- 기구 목록 -->
        <div class="section">
            <h3 class="section-title">기구 목록</h3>
            <button class="more-text">+더보기</button>
            <div class="equipment-grid">
                <div class="equipment-item">
                    <div class="equipment-image">
                        <img src="https://images.unsplash.com/photo-1517836357463-d25dfeac3438?w=300" alt="로우로우">
                    </div>
                    <p class="equipment-name">로우로우 - 스머트헬스</p>
                </div>
                <div class="equipment-item">
                    <div class="equipment-image">
                        <img src="https://images.unsplash.com/photo-1540497077202-7c8a3999166f?w=300" alt="레그 프레스">
                    </div>
                    <p class="equipment-name">레그 프레스 - 스텍</p>
                </div>
                <div class="equipment-item">
                    <div class="equipment-image">
                        <img src="https://images.unsplash.com/photo-1571902943202-507ec2618e8f?w=300" alt="체스트 프레스">
                    </div>
                    <p class="equipment-name">체스트 프레스 - 스크짐</p>
                </div>
                <div class="equipment-item">
                    <div class="equipment-image">
                        <img src="https://images.unsplash.com/photo-1581009146145-b5ef050c2e1e?w=300" alt="스미스머신">
                    </div>
                    <p class="equipment-name">스미스머신 - 스텍</p>
                </div>
            </div>
        </div>

        <!-- 방문 예약 버튼 -->
        <button class="booking-btn" id="bookingBtn">
            <svg width="16" height="16" viewBox="0 0 16 16" fill="none">
                <path d="M5.33333 1.33333V4" stroke="#0A0A0A" stroke-width="1.33333" stroke-linecap="round" stroke-linejoin="round"/>
                <path d="M10.6667 1.33333V4" stroke="#0A0A0A" stroke-width="1.33333" stroke-linecap="round" stroke-linejoin="round"/>
                <path d="M12.6667 2.66667H3.33333C2.59695 2.66667 2 3.26362 2 4V13.3333C2 14.0697 2.59695 14.6667 3.33333 14.6667H12.6667C13.403 14.6667 14 14.0697 14 13.3333V4C14 3.26362 13.403 2.66667 12.6667 2.66667Z" stroke="#0A0A0A" stroke-width="1.33333" stroke-linecap="round" stroke-linejoin="round"/>
                <path d="M2 6.66667H14" stroke="#0A0A0A" stroke-width="1.33333" stroke-linecap="round" stroke-linejoin="round"/>
            </svg>
            방문 예약
        </button>
    </div>
</div>

<script>
    // 전역 변수로 contextPath 설정
    window.contextPath = '${pageContext.request.contextPath}';
</script>
<script src="${pageContext.request.contextPath}/resources/js/loginform.js"></script>
</body>
</html>
