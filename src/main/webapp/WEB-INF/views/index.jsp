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
            color: white;
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
           로그인 필요 모달 전용 스타일
           ======================================== */
        #loginRequiredModal .modal-container {
            max-width: 440px;
            padding: 40px;
            background: linear-gradient(180deg, #1a0f0a 0%, #0a0a0a 100%);
            border: 2px solid #ff6b00;
            border-radius: 12px;
            position: relative;
            box-shadow: 0 0 30px rgba(255, 107, 0, 0.3);
        }

        #loginRequiredModal .modal-close {
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

        #loginRequiredModal .modal-close:hover {
            color: #ffa366;
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
        .gym-detail-modal .main-image {
            width: 100%;
            max-width: 550px;
            height: 300px;
            min-height: 300px;
            border-radius: 10px;
            overflow: hidden;
            margin-bottom: 24px;
            background-color: #2d1810;
            border: 1px solid #ff6b00;
        }

        .gym-detail-modal .main-image img {
            width: 100%;
            height: 100%;
            min-height: 300px;
            object-fit: cover;
            display: block;
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
            color: white;
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
            color: #fff;
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

        /* ========================================
           기구 목록 모달 스타일
           ======================================== */
        .equipment-list-modal {
            z-index: 3000;
        }

        .equipment-list-modal .modal-container {
            max-width: 1200px;
            width: 90%;
            max-height: 90vh;
            padding: 30px;
            overflow-y: auto;
        }

        .equipment-list-modal .modal-title {
            font-size: 24px;
            color: white;
            font-weight: bold;
            margin-bottom: 30px;
        }

        .equipment-list-modal .close-btn {
            background: none;
            border: none;
            cursor: pointer;
            padding: 0;
            width: 16px;
            height: 16px;
            opacity: 0.7;
            transition: opacity 0.3s;
        }

        .equipment-list-modal .close-btn:hover {
            opacity: 1;
        }

        .equipment-list-grid {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 20px;
        }

        /* ========================================
           헬스장 운영자 선택 모달 스타일 (원래 adminSelect 디자인)
           ======================================== */
        .gym-select-modal .modal-container {
            background: linear-gradient(145deg, #2D1810 0%, #1a0f0a 100%);
            border: 3px solid #FF6B00;
            border-radius: 30px;
            padding: 60px 50px;
            max-width: 700px;
            width: 100%;
            text-align: center;
            position: relative;
        }

        .gym-select-modal .logo-section {
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 20px;
            margin-bottom: 40px;
        }

        .gym-select-modal .welcome-title {
            font-size: 32px;
            color: #FF6B00;
            margin-bottom: 15px;
            font-weight: 700;
        }

        .gym-select-modal .welcome-subtitle {
            font-size: 18px;
            color: #FFA366;
            margin-bottom: 50px;
            font-weight: 500;
        }

        .gym-select-menu-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 30px;
            margin-bottom: 40px;
        }

        .gym-select-menu-card {
            background: linear-gradient(145deg, rgba(255, 107, 0, 0.1) 0%, rgba(45, 24, 16, 0.3) 100%);
            border: 3px solid #FF6B00;
            border-radius: 20px;
            padding: 40px 30px;
            cursor: pointer;
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
        }

        .gym-select-menu-card:hover {
            transform: translateY(-10px);
            background: linear-gradient(145deg, rgba(255, 107, 0, 0.2) 0%, rgba(45, 24, 16, 0.5) 100%);
        }

        .gym-select-menu-icon {
            width: 80px;
            height: 80px;
            margin: 0 auto 25px;
            background: rgba(138, 106, 80, 0.2);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            transition: all 0.3s ease;
        }

        .gym-select-menu-card:hover .gym-select-menu-icon {
            background: rgba(255, 107, 0, 0.3);
            transform: scale(1.1) rotate(5deg);
        }

        .gym-select-menu-icon svg {
            color: #8A6A50;
            transition: all 0.3s ease;
        }

        .gym-select-menu-card:hover .gym-select-menu-icon svg {
            color: #FF6B00;
        }

        .gym-select-menu-title {
            font-size: 24px;
            color: #FFA366;
            margin-bottom: 12px;
            font-weight: 700;
            transition: all 0.3s ease;
        }

        .gym-select-menu-card:hover .gym-select-menu-title {
            color: #FF6B00;
        }

        .gym-select-menu-description {
            font-size: 15px;
            color: #8A6A50;
            line-height: 1.5;
        }

        .gym-select-logout-btn {
            background: transparent;
            border: 2px solid #FF6B00;
            color: #8A6A50;
            padding: 16px 50px;
            border-radius: 14px;
            font-size: 17px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            margin-top: 20px;
        }

        .gym-select-logout-btn:hover {
            background: rgba(255, 107, 0, 0.1);
            color: #FF6B00;
            transform: translateY(-2px);
        }

        @media (max-width: 768px) {
            .gym-select-modal .modal-container {
                padding: 40px 30px;
            }

            .gym-select-menu-grid {
                grid-template-columns: 1fr;
                gap: 20px;
            }

            .gym-select-modal .welcome-title {
                font-size: 26px;
            }
        }

        .equipment-card {
            background-color: #1a0f0a;
            border: 1px solid #ff6b00;
            border-radius: 12px;
            overflow: hidden;
            cursor: pointer;
            transition: all 0.3s;
            display: flex;
            flex-direction: column;
        }

        .equipment-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 30px rgba(255, 107, 0, 0.3);
            border-color: #ff8533;
        }

        .equipment-card-image {
            width: 100%;
            height: 200px;
            position: relative;
            overflow: hidden;
            background-color: #2d1810;
        }

        .equipment-card-image img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }


        .equipment-card-content {
            padding: 16px;
            display: flex;
            flex-direction: column;
            gap: 8px;
        }

        .equipment-card-title {
            font-size: 16px;
            color: #8a6a50;
            font-weight: 600;
            margin: 0;
            line-height: 1.4;
            text-align: center;
        }

        /* 반응형 (모달용) */
        @media (max-width: 1200px) {
            .equipment-list-grid {
                grid-template-columns: repeat(3, 1fr);
            }
        }

        @media (max-width: 900px) {
            .equipment-list-grid {
                grid-template-columns: repeat(2, 1fr);
            }
        }

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

            .equipment-list-grid {
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
                <span class="welcome-message">${loginMember.memberName}님 환영합니다</span>
                <c:choose>
                    <c:when test="${loginMember.memberType == 1}">
                        <a href="${pageContext.request.contextPath}/dashboard.me" class="btn btn-secondary">마이페이지</a>
                    </c:when>
                    <c:when test="${loginMember.memberType == 2}">
                        <a href="${pageContext.request.contextPath}/dashboard.tr" class="btn btn-secondary">대시보드</a>
                    </c:when>
                    <c:when test="${loginMember.memberType == 3}">
                        <a href="${pageContext.request.contextPath}/dashboard.gym" class="btn btn-secondary">대시보드</a>
                    </c:when>
                </c:choose>
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
                <option value="price-low">가격 낮은 순</option>
                <option value="price-high">가격 높은 순</option>
            </select>
        </div>
        <input type="text" class="search-input" placeholder="원하는 헬스장 이름을 검색해보세요">
        <button class="search-btn">검색</button>
    </div>
</section>

<!-- 카드 섹션 -->
<section class="cards-section">
    <div class="cards-grid">
        <c:choose>
            <c:when test="${not empty gymList}">
                <c:forEach var="gym" items="${gymList}" varStatus="status">
                    <div class="gym-card" onclick="openGymDetailModal(${gym.gymNo})">
                        <div class="gym-image">
                            <c:choose>
                                <c:when test="${not empty gym.gymPhotoPath}">
                                    <img src="${pageContext.request.contextPath}${gym.gymPhotoPath}"
                                         alt="${gym.gymName}"
                                         style="width: 100%; height: 100%; object-fit: cover;">
                                </c:when>
                                <c:otherwise>
                                    헬스장 썸네일 이미지
                                </c:otherwise>
                            </c:choose>
                        </div>
                        <div class="gym-info">
                            <div class="gym-header">
                                <div>
                                    <div class="gym-title">${gym.gymName}</div>
                                    <div class="gym-location">
                                        <c:choose>
                                            <c:when test="${not empty gym.detailAddress}">
                                                ${gym.detailAddress}
                                            </c:when>
                                            <c:otherwise>
                                                ${gym.gymAddress}
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </div>
                            </div>
                            <div class="gym-tags">
                                <c:if test="${not empty gym.facilitiesInfo}">
                                    <c:forTokens var="tag" items="${gym.facilitiesInfo}" delims=",">
                                        <span class="tag">${tag}</span>
                                    </c:forTokens>
                                </c:if>
                            </div>
                            <div class="gym-description">
                                <c:choose>
                                    <c:when test="${not empty gym.intro}">
                                        ${gym.intro}
                                    </c:when>
                                    <c:otherwise>
                                        소개 정보가 없습니다.
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <!-- 데이터가 없을 때 표시할 메시지 -->
                <div style="grid-column: 1 / -1; text-align: center; padding: 60px 20px;">
                    <h3 style="color: #8a6a50; font-size: 24px; margin-bottom: 10px;">등록된 헬스장이 없습니다.</h3>
                    <p style="color: #8a6a50; font-size: 16px;">곧 새로운 헬스장이 추가될 예정입니다.</p>
                </div>
            </c:otherwise>
        </c:choose>
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
            <form class="login-form" id="loginForm" action="${pageContext.request.contextPath}/login.me" method="post">
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
                            <label class="form-label">이메일</label>
                            <input type="email" name="email" placeholder="이메일을 입력하세요">
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
                <img src="${pageContext.request.contextPath}/resources/images/icon/close.png" alt="닫기" style="width: 16px; height: 16px;">
            </button>
        </div>

        <!-- 메인 이미지 -->
        <div class="main-image" style="width: 100%; max-width: 550px; height: 300px; border-radius: 10px; overflow: hidden; margin-bottom: 24px; background-color: #2d1810; border: 1px solid #ff6b00;">
            <img src="${pageContext.request.contextPath}/resources/images/icon/logo.png"
                 alt="헬스장 이미지"
                 id="gymDetailImage"
                 style="width: 100%; height: 100%; object-fit: cover; display: block;">
        </div>

        <!-- 뱃지 (facilitiesInfo에서 동적으로 생성) -->
        <div class="badges" id="gymDetailBadges">
            <!-- JavaScript로 동적 생성 -->
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
                    <img src="${pageContext.request.contextPath}/resources/images/icon/location.png" alt="주소" style="width: 20px; height: 20px;">
                </div>
                <div class="info-content">
                    <div class="info-label">주소</div>
                    <div class="info-value" id="gymDetailAddress">서울 강남구</div>
                </div>
            </div>

            <div class="info-card">
                <div class="info-icon">
                    <img src="${pageContext.request.contextPath}/resources/images/icon/call.png" alt="전화번호" style="width: 20px; height: 20px;">
                </div>
                <div class="info-content">
                    <div class="info-label">전화번호</div>
                    <a href="tel:02-1234-5678" class="info-link" id="gymDetailPhone">02-1234-5678</a>
                </div>
            </div>
        </div>

        <!-- 시설 정보 (facilitiesInfo에서 동적으로 생성) -->
        <div class="section">
            <h3 class="section-title">시설 정보</h3>
            <div class="facility-grid" id="facilityGrid">
                <!-- JavaScript로 동적 생성 -->
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

                    <!-- 바 차트는 JavaScript로 동적 생성됩니다 -->

                    <!-- X축 레이블 (시간대별) -->
                    <text x="31" y="210" fill="#8A6A50" font-size="12" text-anchor="middle">06</text>
                    <text x="69" y="210" fill="#8A6A50" font-size="12" text-anchor="middle">08</text>
                    <text x="107" y="210" fill="#8A6A50" font-size="12" text-anchor="middle">10</text>
                    <text x="145" y="210" fill="#8A6A50" font-size="12" text-anchor="middle">12</text>
                    <text x="183" y="210" fill="#8A6A50" font-size="12" text-anchor="middle">14</text>
                    <text x="221" y="210" fill="#8A6A50" font-size="12" text-anchor="middle">16</text>
                    <text x="259" y="210" fill="#8A6A50" font-size="12" text-anchor="middle">18</text>
                    <text x="297" y="210" fill="#8A6A50" font-size="12" text-anchor="middle">20</text>
                    <text x="335" y="210" fill="#8A6A50" font-size="12" text-anchor="middle">22</text>

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
                    <img src="${pageContext.request.contextPath}/resources/images/icon/money.png" alt="가격 정보" style="width: 20px; height: 20px;">
                    <span>가격 정보</span>
                </div>
                <div class="card-content" id="gymDetailPrice">

                </div>
            </div>

            <div class="info-card-box">
                <div class="card-header">
                    <img src="${pageContext.request.contextPath}/resources/images/icon/clock.png" alt="운영시간" style="width: 20px; height: 20px;">
                    <span>운영시간</span>
                </div>
                <div class="card-content" id="gymDetailHours">

                </div>
            </div>
        </div>

        <!-- 기구 목록 -->
        <div class="section">
            <h3 class="section-title">기구 목록</h3>
            <button class="more-text">+더보기</button>
            <div class="equipment-grid">
                <!-- JavaScript로 동적 생성됩니다 -->
            </div>

        </div>

        <!-- 방문 예약 버튼 -->
        <button class="booking-btn" id="bookingBtn">
            <img src="${pageContext.request.contextPath}/resources/images/icon/calendar.png" alt="방문 예약" style="width: 16px; height: 16px;">
            방문 예약
        </button>
    </div>
</div>

<!-- 헬스장 운영자 선택 모달 (원래 adminSelect 디자인) -->
<div class="modal-overlay gym-select-modal" id="gymSelectModal">
    <div class="modal-container">
        <button class="modal-close" id="closeGymSelectModal" style="position: absolute; top: 20px; right: 20px; background: none; border: none; color: #ff6b00; font-size: 24px; cursor: pointer; width: 30px; height: 30px; display: flex; align-items: center; justify-content: center; z-index: 10;">×</button>
        
        <div class="logo-section">
            <span class="logo-text" style="font-size: 42px; color: #FF6B00; font-weight: 900;">GYMHub</span>
        </div>

        <h1 class="welcome-title">관리자 메뉴</h1>
        <p class="welcome-subtitle">
            <c:choose>
                <c:when test="${not empty loginMember && loginMember.memberType == 3}">
                    <c:choose>
                        <c:when test="${not empty loginMember.memberName}">
                            ${loginMember.memberName}님, 환영합니다!
                        </c:when>
                        <c:otherwise>
                            헬스장 운영자님, 환영합니다!
                        </c:otherwise>
                    </c:choose>
                </c:when>
                <c:otherwise>
                    헬스장 운영자님, 환영합니다!
                </c:otherwise>
            </c:choose>
        </p>

        <div class="gym-select-menu-grid">
            <div class="gym-select-menu-card" id="attendanceCard">
                <div class="gym-select-menu-icon">
                    <svg width="48" height="48" viewBox="0 0 24 24" fill="none">
                        <path d="M9 11L12 14L22 4" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"/>
                        <path d="M21 12V19C21 19.5304 20.7893 20.0391 20.4142 20.4142C20.0391 20.7893 19.5304 21 19 21H5C4.46957 21 3.96086 20.7893 3.58579 20.4142C3.21071 20.0391 3 19.5304 3 19V5C3 4.46957 3.21071 3.96086 3.58579 3.58579C3.96086 3.21071 4.46957 3 5 3H16" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"/>
                    </svg>
                </div>
                <h3 class="gym-select-menu-title">출석 관리</h3>
                <p class="gym-select-menu-description">회원 출석체크 및<br>퇴실 처리</p>
            </div>

            <div class="gym-select-menu-card" id="adminDashboardCard">
                <div class="gym-select-menu-icon">
                    <svg width="48" height="48" viewBox="0 0 24 24" fill="none">
                        <path d="M3 9L12 2L21 9V20C21 20.5304 20.7893 21.0391 20.4142 21.4142C20.0391 21.7893 19.5304 22 19 22H5C4.46957 22 3.96086 21.7893 3.58579 21.4142C3.21071 21.0391 3 20.5304 3 20V9Z" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"/>
                        <path d="M9 22V12H15V22" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"/>
                    </svg>
                </div>
                <h3 class="gym-select-menu-title">관리자 페이지</h3>
                <p class="gym-select-menu-description">헬스장 운영 관리 및<br>통계 확인</p>
            </div>
        </div>

        <button class="gym-select-logout-btn" id="gymSelectLogoutBtn">로그아웃</button>
    </div>
</div>

<!-- 기구 목록 모달 -->
<div class="modal-overlay equipment-list-modal" id="equipmentListModal">
    <div class="modal-container">
        <div class="modal-header">
            <h2 class="modal-title">기구 목록</h2>
            <button class="close-btn" id="closeEquipmentListModal">
                <img src="${pageContext.request.contextPath}/resources/images/icon/close.png" alt="닫기" style="width: 16px; height: 16px;">
            </button>
        </div>

        <div class="equipment-list-grid" id="equipmentListGrid">
            <!-- JavaScript로 동적으로 채워집니다 -->
        </div>
    </div>
</div>

<!-- 로그인 필요 모달 -->
<%@ include file="/WEB-INF/views/common/LoginRequiredModal.jsp" %>

<script>
    // 전역 변수로 contextPath 설정
    window.contextPath = '${pageContext.request.contextPath}';
    
    // 로그인 상태 확인 (서버에서 전달)
    <c:choose>
        <c:when test="${not empty loginMember}">
            window.isLoggedIn = true;
        </c:when>
        <c:otherwise>
            window.isLoggedIn = false;
        </c:otherwise>
    </c:choose>
    
    // 이미지 로드 확인 및 디버깅
    document.addEventListener('DOMContentLoaded', function() {
        const gymDetailImage = document.getElementById('gymDetailImage');
        if (gymDetailImage) {
            gymDetailImage.addEventListener('error', function() {
                console.error('이미지 로드 실패:', this.src);
                // 대체 이미지로 변경
                this.src = 'https://images.unsplash.com/photo-1540497077202-7c8a3999166f?w=550';
            });
        }

        // 로그아웃 메시지 표시 (URL 파라미터 확인)
        const urlParams = new URLSearchParams(window.location.search);
        if (urlParams.get('logout') === 'success') {
            alert('로그아웃되었습니다.');
            // URL에서 파라미터 제거
            window.history.replaceState({}, document.title, window.location.pathname);
        }

    });

    // ============================= 아이디 중복 체크 (AJAX) - 회원가입 폼에만 적용 =============================
    document.querySelectorAll('.registration-form input[name="id"]').forEach(function(input) {
        let typingTimer;
        const doneTypingInterval = 500; // 0.5초 대기 후 체크

        input.addEventListener('input', function() {
            clearTimeout(typingTimer);
            const helperText = this.nextElementSibling;
            const idValue = this.value.trim();

            // helperText가 없거나 helper-text 클래스가 없으면 중단
            if (!helperText || !helperText.classList.contains('helper-text')) {
                return;
            }

            // 아이디가 4자 미만이면 메시지 숨기기
            if (idValue.length < 4) {
                helperText.classList.add('hidden');
                helperText.textContent = '';
                return;
            }

            // 입력 멈춘 후 0.5초 뒤 중복 체크 실행
            typingTimer = setTimeout(function() {
                fetch('${pageContext.request.contextPath}/signup/checkId?checkId=' + encodeURIComponent(idValue))
                    .then(response => {
                        // HTTP 응답 상태 확인
                        if (!response.ok) {
                            throw new Error('서버 응답 오류: ' + response.status);
                        }
                        return response.text();
                    })
                    .then(data => {
                        // 응답 데이터 trim 처리 (공백/줄바꿈 제거)
                        const trimmedData = data.trim();

                        // 응답 형식 검증
                        if (trimmedData === 'NNNNY') {
                            // 사용 가능한 아이디
                            helperText.classList.remove('error');
                            helperText.classList.add('success');
                            helperText.textContent = '사용 가능한 아이디입니다';
                            helperText.classList.remove('hidden');
                        } else if (trimmedData === 'NNNNN') {
                            // 이미 사용중인 아이디
                            helperText.classList.remove('success');
                            helperText.classList.add('error');
                            helperText.textContent = '사용 불가능한 아이디입니다';
                            helperText.classList.remove('hidden');
                        } else {
                            // 예상하지 못한 응답 형식
                            console.error('예상하지 못한 응답 형식:', trimmedData);
                            helperText.classList.remove('success');
                            helperText.classList.add('error');
                            helperText.textContent = '아이디 확인 중 오류가 발생했습니다';
                            helperText.classList.remove('hidden');
                        }
                    })
                    .catch(error => {
                        console.error('아이디 중복 체크 오류:', error);
                        helperText.classList.remove('success');
                        helperText.classList.add('error');
                        helperText.textContent = '아이디 확인 중 오류가 발생했습니다';
                        helperText.classList.remove('hidden');
                    });
            }, doneTypingInterval);
        });
    });

    // ============================= 비밀번호 확인 검증 =============================
    document.querySelectorAll('.password-confirm').forEach(function(input) {
        input.addEventListener('input', function() {
            const form = this.closest('form');
            const password = form.querySelector('.password').value;
            const confirmPassword = this.value;
            const helperText = this.nextElementSibling;

            if (confirmPassword === '') {
                helperText.classList.add('hidden');
            } else if (password === confirmPassword) {
                helperText.classList.remove('error');
                helperText.classList.add('success');
                helperText.textContent = '비밀번호가 일치합니다';
                helperText.classList.remove('hidden');
            } else {
                helperText.classList.remove('success');
                helperText.classList.add('error');
                helperText.textContent = '비밀번호가 일치하지 않습니다';
                helperText.classList.remove('hidden');
            }
        });
    });

    // ============================= 폼 제출 전 최종 검증 =============================
    document.querySelectorAll('.registration-form').forEach(function(form) {
        form.addEventListener('submit', function(e) {
            // 비밀번호 확인
            const password = this.querySelector('.password').value;
            const confirmPassword = this.querySelector('.password-confirm').value;

            if (password !== confirmPassword) {
                e.preventDefault();
                alert('비밀번호가 일치하지 않습니다.');
                return false;
            }

            // 아이디 중복 체크 확인
            const idInput = this.querySelector('input[name="id"]');
            if (idInput) {
                const idValue = idInput.value.trim();
                
                // 아이디가 입력되었는지 확인
                if (!idValue) {
                    e.preventDefault();
                    alert('아이디를 입력해주세요.');
                    idInput.focus();
                    return false;
                }
                
                // 아이디 최소 길이 확인
                if (idValue.length < 4) {
                    e.preventDefault();
                    alert('아이디는 최소 4자 이상 입력해주세요.');
                    idInput.focus();
                    return false;
                }
                
                // 중복 체크 완료 여부 확인
                const idHelperText = idInput.nextElementSibling;
                if (idHelperText && idHelperText.classList.contains('helper-text')) {
                    // 중복 체크가 완료되지 않았거나, 사용 불가능한 경우
                    if (idHelperText.classList.contains('hidden') || 
                        !idHelperText.classList.contains('success')) {
                        e.preventDefault();
                        if (idHelperText.classList.contains('error')) {
                            alert('사용 불가능한 아이디입니다. 다른 아이디를 입력해주세요.');
                        } else {
                            alert('아이디 중복 체크를 완료해주세요.');
                        }
                        idInput.focus();
                        return false;
                    }
                }
            }

            return true;
        });
    });
    // 헬스장 상세 모달 열기
    function openGymDetailModal(gymNo) {
        // gymNo를 모달의 data-gym-no 속성에 저장
        document.getElementById('gymDetailModal').dataset.gymNo = gymNo;

        // AJAX로 헬스장 상세 정보 조회
        fetch('${pageContext.request.contextPath}/gym/detail.ajax?gymNo=' + gymNo)
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    const gym = data.gym;
                    const gymDetail = data.gymDetail || {};

                    // 모달에 데이터 설정
                    document.getElementById('gymDetailTitle').textContent = gym.gymName || '헬스장';
                    document.getElementById('gymDetailDescription').textContent = gymDetail.intro || gym.intro || '소개 정보가 없습니다.';

                    // 주소 설정 (detailAddress가 있으면 우선, 없으면 gymAddress)
                    const address = gymDetail.detailAddress || gym.gymAddress || '주소 정보 없음';
                    document.getElementById('gymDetailAddress').textContent = address;

                    // 가격 설정
                    const priceContainer = document.getElementById('gymDetailPrice');
                    priceContainer.innerHTML = ''; // 초기화
                    const products = data.products || gym.products || [];
                    if (products && products.length > 0) {

                        // 상품 타입별로 분류
                        const membershipProducts = products.filter(p => p.productType === '회원권');

                        // 회원권 가격 표시
                        if (membershipProducts.length > 0) {
                            const membershipHTML = '<p style="margin-bottom: 8px; color: #ff6b00; font-weight: 600;">회원권</p>';
                            priceContainer.innerHTML += membershipHTML;

                            membershipProducts.forEach(function(product) {
                                const durationValue = Number(product.durationMonths);
                                const priceValue = Number(product.productPrice);

                                const duration = durationValue >= 30
                                    ? Math.floor(durationValue / 30) + '개월'
                                    : durationValue + '일';
                                const price = priceValue.toLocaleString('ko-KR');

                                // 문자열 연결 방식 사용 (템플릿 리터럴 대신)
                                const priceHTML = '<p>' + duration + ': ' + price + '원</p>';
                                priceContainer.innerHTML += priceHTML;
                            });
                        } else {
                            priceContainer.innerHTML = '<p>가격 정보가 없습니다.</p>';
                        }
                    } else {
                        priceContainer.innerHTML = '<p>가격 정보가 없습니다.</p>';
                    }

                    // 전화번호 설정
                    const phone = gym.gymPhone || '전화번호 없음';
                    document.getElementById('gymDetailPhone').textContent = phone;
                    document.getElementById('gymDetailPhone').href = 'tel:' + phone;

                    // 운영시간 설정
                    const weekHour = gymDetail.weekBusinessHour || '정보 없음';
                    const weekendHour = gymDetail.weekendBusinessHour || '정보 없음';
                    document.getElementById('gymDetailHours').innerHTML =
                        '<p>평일: ' + weekHour + '</p>' +
                        '<p>주말: ' + weekendHour + '</p>';

                    // 이미지 설정 - 수정된 부분
                    const gymImage = document.getElementById('gymDetailImage');
                    const mainImageContainer = gymImage.parentElement;

                    if (gym.gymPhotoPath) {
                        // 이미지가 있는 경우
                        gymImage.style.display = 'block';
                        // 슬래시가 이미 있으면 contextPath만, 없으면 contextPath + /
                        if (gym.gymPhotoPath.startsWith('/')) {
                            gymImage.src = '${pageContext.request.contextPath}' + gym.gymPhotoPath;
                        } else {
                            gymImage.src = '${pageContext.request.contextPath}/' + gym.gymPhotoPath;
                        }
                    } else {
                        // 이미지가 없는 경우
                        gymImage.style.display = 'none';
                        mainImageContainer.innerHTML = '<div style="width: 100%; height: 100%; display: flex; align-items: center; justify-content: center; color: #8a6a50; font-size: 14px;">헬스장 이미지가 없습니다</div>';
                    }

                    // 시설 정보를 뱃지와 시설 아이콘으로 표시
                    const badgesContainer = document.getElementById('gymDetailBadges');
                    const facilityGrid = document.getElementById('facilityGrid');
                    badgesContainer.innerHTML = ''; // 기존 뱃지 초기화
                    facilityGrid.innerHTML = ''; // 기존 시설 아이콘 초기화

                    // 시설 아이콘 매핑 (facilitiesInfo의 값에 따라 아이콘 선택)
                    // gymInfoManagement.jsp의 data-facility 값과 일치시킴
                    const facilityIcons = {
                        '24시간': 'clock.png',
                        '주차가능': 'parking.png',
                        '주차': 'parking.png', // 호환성을 위해 유지
                        '샤워실': 'shower.png',
                        '락커실': 'locker.png',
                        '락커': 'locker.png', // 호환성을 위해 유지
                        '무료 WiFi': 'wifi.png',
                        '와이파이': 'wifi.png', // 호환성을 위해 유지
                        'PT': 'person.png',
                        'GX 프로그램': 'people.png',
                        'GX': 'people.png', // 호환성을 위해 유지
                        '카페': 'people.png',
                        '수영장': 'people.png',
                        '필라테스': 'people.png',
                        '사우나': 'people.png',
                        '최신기구': 'machine.png',
                        '운동복': 'locker.png',
                        '수건': 'shower.png'
                    };

                    const facilitiesInfo = gymDetail.facilitiesInfo || gym.facilitiesInfo;
                    if (facilitiesInfo) {
                        const facilities = facilitiesInfo.split(',');

                        facilities.forEach(facility => {
                            const trimmedFacility = facility.trim();

                            // 뱃지 생성
                            const badge = document.createElement('span');
                            badge.className = 'badge';
                            badge.textContent = trimmedFacility;
                            badgesContainer.appendChild(badge);

                            // 시설 아이콘 생성
                            const facilityItem = document.createElement('div');
                            facilityItem.className = 'facility-item';

                            const iconName = facilityIcons[trimmedFacility] || 'machine.png'; // 기본 아이콘

                            facilityItem.innerHTML =
                                '<img src="' + window.contextPath + '/resources/images/icon/' + iconName + '"' +
                                '     alt="' + trimmedFacility + '" style="width: 24px; height: 24px;">' +
                                '<span>' + trimmedFacility + '</span>';

                            facilityGrid.appendChild(facilityItem);
                        });
                    } else {
                        // 시설 정보가 없는 경우
                        badgesContainer.innerHTML = '<span class="badge">정보 없음</span>';
                        facilityGrid.innerHTML = '<p style="color: #8a6a50; text-align: center; grid-column: 1 / -1;">시설 정보가 없습니다.</p>';
                    }

                    loadGymMachines(gymNo);

                    // 혼잡도 데이터 로드 및 차트 업데이트
                    loadCongestionChart(gymNo);

                    // 모달 열기
                    document.getElementById('gymDetailModal').style.display = 'flex';
                } else {
                    alert(data.message || '헬스장 정보를 불러올 수 없습니다.');
                }
            })
            .catch(error => {
                console.error('헬스장 상세 정보 조회 오류:', error);
                alert('헬스장 정보를 불러오는 중 오류가 발생했습니다.');
            });
    }

    // 모달 닫기
    document.getElementById('closeGymDetailModal').addEventListener('click', function() {
        document.getElementById('gymDetailModal').style.display = 'none';
    });

    // 기구 목록 로드 함수
    function loadGymMachines(gymNo) {
        fetch('${pageContext.request.contextPath}/gym/machines.ajax?gymNo=' + gymNo)
            .then(response => response.json())
            .then(data => {
                const equipmentGrid = document.querySelector('.gym-detail-modal .equipment-grid');
                const moreButton = document.querySelector('.more-text');

                if (data.success && data.machines && data.machines.length > 0) {
                    // 기존 기구 목록 초기화
                    equipmentGrid.innerHTML = '';

                    // 전체 기구 데이터 저장 (더보기 기능용)
                    equipmentGrid.dataset.allMachines = JSON.stringify(data.machines);

                    // 처음 4개만 표시
                    const displayMachines = data.machines.slice(0, 4);

                    displayMachines.forEach(machine => {
                        const equipmentItem = document.createElement('div');
                        equipmentItem.className = 'equipment-item';

                        const imagePath = machine.machinePhotoPath
                            ? '${pageContext.request.contextPath}' + machine.machinePhotoPath
                            : 'https://images.unsplash.com/photo-1517836357463-d25dfeac3438?w=300';

                        const displayName = machine.machineName +
                            (machine.brand ? ' - ' + machine.brand : '');

                        equipmentItem.innerHTML =
                            '<div class="equipment-image">' +
                            '    <img src="' + imagePath + '" alt="' + machine.machineName + '" ' +
                            '         onerror="this.src=\'https://images.unsplash.com/photo-1517836357463-d25dfeac3438?w=300\'">' +
                            '</div>' +
                            '<p class="equipment-name">' + displayName + '</p>';

                        equipmentGrid.appendChild(equipmentItem);
                    });

                    // 더보기 버튼 표시/숨김 및 상태 관리
                    if (data.machines.length > 4) {
                        moreButton.style.display = 'block';
                        moreButton.textContent = '+더보기';
                        moreButton.dataset.expanded = 'false';

                        // 기존 이벤트 리스너 제거 후 새로 추가
                        moreButton.onclick = function() {
                            toggleEquipmentList(this);
                        };
                    } else {
                        moreButton.style.display = 'none';
                    }
                } else {
                    // 기구가 없는 경우
                    equipmentGrid.innerHTML =
                        '<div style="grid-column: 1 / -1; text-align: center; padding: 20px; color: #8a6a50;">' +
                        '등록된 기구가 없습니다.' +
                        '</div>';
                    moreButton.style.display = 'none';
                }
            })
            .catch(error => {
                console.error('기구 목록 조회 오류:', error);
                const equipmentGrid = document.querySelector('.gym-detail-modal .equipment-grid');
                equipmentGrid.innerHTML =
                    '<div style="grid-column: 1 / -1; text-align: center; padding: 20px; color: #fb2c36;">' +
                    '기구 목록을 불러오는 중 오류가 발생했습니다.' +
                    '</div>';
            });
    }

    // 기구 목록 로드 함수 (수정)
    function loadGymMachines(gymNo) {
        fetch('${pageContext.request.contextPath}/gym/machines.ajax?gymNo=' + gymNo)
            .then(response => response.json())
            .then(data => {
                const equipmentGrid = document.querySelector('.gym-detail-modal .equipment-grid');
                const moreButton = document.querySelector('.more-text');

                if (data.success && data.machines && data.machines.length > 0) {
                    // 기존 기구 목록 초기화
                    equipmentGrid.innerHTML = '';

                    // 전체 기구 데이터 저장 (더보기 기능용)
                    equipmentGrid.dataset.allMachines = JSON.stringify(data.machines);

                    // 처음 4개만 표시
                    const displayMachines = data.machines.slice(0, 4);

                    displayMachines.forEach(machine => {
                        const equipmentItem = document.createElement('div');
                        equipmentItem.className = 'equipment-item';

                        const imagePath = machine.machinePhotoPath
                            ? '${pageContext.request.contextPath}' + machine.machinePhotoPath
                            : 'https://images.unsplash.com/photo-1517836357463-d25dfeac3438?w=300';

                        const displayName = machine.machineName +
                            (machine.brand ? ' - ' + machine.brand : '');

                        equipmentItem.innerHTML =
                            '<div class="equipment-image">' +
                            '    <img src="' + imagePath + '" alt="' + machine.machineName + '" ' +
                            '         onerror="this.src=\'https://images.unsplash.com/photo-1517836357463-d25dfeac3438?w=300\'">' +
                            '</div>' +
                            '<p class="equipment-name">' + displayName + '</p>';

                        equipmentGrid.appendChild(equipmentItem);
                    });

                    // 더보기 버튼 표시/숨김
                    if (data.machines.length > 4) {
                        moreButton.style.display = 'block';

                        // 기존 이벤트 리스너 제거 후 새로 추가
                        moreButton.onclick = function() {
                            showAllMachines();
                        };
                    } else {
                        moreButton.style.display = 'none';
                    }
                } else {
                    // 기구가 없는 경우
                    equipmentGrid.innerHTML =
                        '<div style="grid-column: 1 / -1; text-align: center; padding: 20px; color: #8a6a50;">' +
                        '등록된 기구가 없습니다.' +
                        '</div>';
                    moreButton.style.display = 'none';
                }
            })
            .catch(error => {
                console.error('기구 목록 조회 오류:', error);
                const equipmentGrid = document.querySelector('.gym-detail-modal .equipment-grid');
                equipmentGrid.innerHTML =
                    '<div style="grid-column: 1 / -1; text-align: center; padding: 20px; color: #fb2c36;">' +
                    '기구 목록을 불러오는 중 오류가 발생했습니다.' +
                    '</div>';
            });
    }
    // 전체 기구 목록 모달 표시
    function showAllMachines() {
        const equipmentGrid = document.querySelector('.gym-detail-modal .equipment-grid');
        const allMachines = JSON.parse(equipmentGrid.dataset.allMachines || '[]');

        if (allMachines.length === 0) {
            alert('표시할 기구가 없습니다.');
            return;
        }

        // 기구 목록 모달 그리드 초기화
        const equipmentListGrid = document.getElementById('equipmentListGrid');
        equipmentListGrid.innerHTML = '';

        // 모든 기구 표시
        allMachines.forEach(machine => {
            const equipmentCard = document.createElement('div');
            equipmentCard.className = 'equipment-card';

            const imagePath = machine.machinePhotoPath
                ? '${pageContext.request.contextPath}' + machine.machinePhotoPath
                : 'https://images.unsplash.com/photo-1517836357463-d25dfeac3438?w=300';

            const displayName = machine.machineName +
                (machine.brand ? ' - ' + machine.brand : '');

            equipmentCard.innerHTML =
                '<div class="equipment-card-image">' +
                '    <img src="' + imagePath + '" alt="' + machine.machineName + '" ' +
                '         onerror="this.src=\'https://images.unsplash.com/photo-1517836357463-d25dfeac3438?w=300\'">' +
                '</div>' +
                '<div class="equipment-card-content">' +
                '    <h3 class="equipment-card-title">' + displayName + '</h3>' +
                '</div>';

            equipmentListGrid.appendChild(equipmentCard);
        });

        // 기구 목록 모달 열기
        document.getElementById('equipmentListModal').style.display = 'flex';
    }

    // 기구 목록 모달 닫기
    document.getElementById('closeEquipmentListModal').addEventListener('click', function() {
        document.getElementById('equipmentListModal').style.display = 'none';
    });

    // 모달 외부 클릭 시 닫기
    document.getElementById('equipmentListModal').addEventListener('click', function(e) {
        if (e.target === this) {
            this.style.display = 'none';
        }
    });

    // 혼잡도 차트 로드 및 업데이트 함수
    function loadCongestionChart(gymNo) {
        fetch(window.contextPath + '/gym/congestion.ajax?gymNo=' + gymNo + '&days=7')
            .then(function(response) {
                return response.json();
            })
            .then(function(data) {
                if (data.success && data.congestionData && data.congestionData.length > 0) {
                    updateCongestionChart(data.congestionData);
                } else {
                    // 데이터가 없을 경우 기본값으로 차트 초기화
                    updateCongestionChart([]);
                }
            })
            .catch(function(error) {
                console.error('혼잡도 데이터 조회 오류:', error);
                // 오류 발생 시 기본값으로 차트 초기화
                updateCongestionChart([]);
            });
    }

    // 혼잡도 차트 업데이트 함수
    function updateCongestionChart(congestionData) {
        const svg = document.querySelector('.chart-container svg');
        if (!svg) return;

        // 시간대별 데이터 맵 생성 (빠른 조회를 위해)
        const dataMap = {};
        if (congestionData && congestionData.length > 0) {
            congestionData.forEach(function(item) {
                dataMap[item.TIME_SLOT] = item.AVG_COUNT || 0;
            });
        }

        // 시간대 목록 (순서대로)
        const timeSlots = ['06-08', '08-10', '10-12', '12-14', '14-16', '16-18', '18-20', '20-22', '22-24'];

        // 최대값 계산 (차트 스케일링을 위해)
        let maxValue = 0;
        timeSlots.forEach(function(timeSlot) {
            const value = dataMap[timeSlot] || 0;
            if (value > maxValue) {
                maxValue = value;
            }
        });

        // 최대값이 0이면 기본값 100으로 설정
        if (maxValue === 0) {
            maxValue = 100;
        }

        // 차트 높이 설정 (SVG viewBox 기준)
        const chartHeight = 184; // 224 - 40 (하단 여백)
        const chartBaseY = 184; // 바 차트의 기준 Y 좌표

        // 바 차트 X 위치 (9개)
        const barPositions = [16, 54, 92, 130, 168, 206, 244, 282, 320];
        const barWidth = 30;
        const barRadius = 8;

        // 기존 바 차트 제거
        const existingBars = svg.querySelectorAll('rect[data-bar="true"]');
        existingBars.forEach(function(bar) {
            bar.remove();
        });

        // 새로운 바 차트 생성
        timeSlots.forEach(function(timeSlot, index) {
            const value = dataMap[timeSlot] || 0;
            const barHeight = maxValue > 0 ? Math.round((value / maxValue) * chartHeight) : 0;
            const barY = chartBaseY - barHeight;
            const barX = barPositions[index];

            // 바 차트 생성
            const rect = document.createElementNS('http://www.w3.org/2000/svg', 'rect');
            rect.setAttribute('x', barX);
            rect.setAttribute('y', barY);
            rect.setAttribute('width', barWidth);
            rect.setAttribute('height', barHeight);
            rect.setAttribute('rx', barRadius);
            rect.setAttribute('fill', '#FF6B00');
            rect.setAttribute('data-bar', 'true');
            rect.setAttribute('data-time-slot', timeSlot);
            rect.setAttribute('data-value', value);

            // 툴팁을 위한 title 추가
            const title = document.createElementNS('http://www.w3.org/2000/svg', 'title');
            title.textContent = timeSlot + ': 평균 ' + value + '명';
            rect.appendChild(title);

            // 그리드 라인 다음에 삽입 (그리드 라인 위에 표시되도록)
            const gridLines = svg.querySelectorAll('line[stroke="#4A3020"]');
            if (gridLines.length > 0) {
                svg.insertBefore(rect, gridLines[0]);
            } else {
                svg.appendChild(rect);
            }
        });

        // Y축 레이블 업데이트 (최대값에 맞게 조정)
        const yAxisLabels = svg.querySelectorAll('text[text-anchor="end"]');
        if (yAxisLabels.length >= 5) {
            // Y축 레이블 위치: 380, y=190, 145, 97, 50, 10
            const yPositions = [190, 145, 97, 50, 10];
            const yValues = [
                0,
                Math.round(maxValue * 0.25),
                Math.round(maxValue * 0.5),
                Math.round(maxValue * 0.75),
                maxValue
            ];

            yAxisLabels.forEach(function(label, index) {
                if (index < yValues.length) {
                    label.textContent = yValues[index];
                }
            });
        }
    }


</script>

<!-- 로그인 성공/실패 메시지 표시 -->
<script>
    <c:if test="${not empty alertMsg}">
        alert('${alertMsg}');
        <c:remove var="alertMsg" scope="session"/>
    </c:if>
    <c:if test="${not empty errorMsg}">
        alert('${errorMsg}');
        <c:remove var="errorMsg" scope="session"/>
    </c:if>

    window.addEventListener('load', function() {
        if (sessionStorage.getItem('visitReserved') === 'true') {
            alert('방문 예약이 완료되었습니다!');
            sessionStorage.removeItem('visitReserved');
        }
    });

    var filterSelect = document.querySelector('.filter-select');

    // 정렬 변경 시 서버에 재요청
    if (filterSelect) {
        filterSelect.addEventListener('change', function() {
            var sortType = this.value;

            if (sortType) {
                // 정렬 파라미터와 함께 페이지 새로고침
                window.location.href = '${pageContext.request.contextPath}/?sort=' + sortType;
            } else {
                // 정렬 없이 기본 페이지로
                window.location.href = '${pageContext.request.contextPath}/';
            }
        });

        // 페이지 로드 시 현재 정렬 상태 유지
        var currentSort = '${currentSort}';
        if (currentSort && currentSort !== 'null' && currentSort !== '') {
            filterSelect.value = currentSort;
        }
    }
</script>

<script src="${pageContext.request.contextPath}/resources/js/loginform.js"></script>
</body>
</html>
