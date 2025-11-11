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
            <img src="https://images.unsplash.com/photo-1534438327276-14e5300c3a48?w=550" alt="헬스장 이미지" id="gymDetailImage" style="width: 100%; height: 100%; object-fit: cover; display: block;">
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

        <!-- 시설 정보 -->
        <div class="section">
            <h3 class="section-title">시설 정보</h3>

            <div class="facility-grid">
                <div class="facility-item">
                    <img src="${pageContext.request.contextPath}/resources/images/icon/parking.png" alt="주차" style="width: 24px; height: 24px;">
                    <span>주차</span>
                </div>
                <div class="facility-item">
                    <img src="${pageContext.request.contextPath}/resources/images/icon/shower.png" alt="샤워실" style="width: 24px; height: 24px;">
                    <span>샤워실</span>
                </div>
                <div class="facility-item">
                    <img src="${pageContext.request.contextPath}/resources/images/icon/locker.png" alt="락커" style="width: 24px; height: 24px;">
                    <span>락커</span>
                </div>
                <div class="facility-item">
                    <img src="${pageContext.request.contextPath}/resources/images/icon/machine.png" alt="최신기구" style="width: 24px; height: 24px;">
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
                    <img src="${pageContext.request.contextPath}/resources/images/icon/money.png" alt="가격 정보" style="width: 20px; height: 20px;">
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
                    <img src="${pageContext.request.contextPath}/resources/images/icon/clock.png" alt="운영시간" style="width: 20px; height: 20px;">
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
            <!-- 기구 카드들이 여기에 동적으로 추가됩니다 -->
            <div class="equipment-card">
                <div class="equipment-card-image">
                    <img src="https://images.unsplash.com/photo-1517836357463-d25dfeac3438?w=300" alt="로우로우">
                </div>
                <div class="equipment-card-content">
                    <h3 class="equipment-card-title">로우로우 - 스머트헬스</h3>
                </div>
            </div>

            <div class="equipment-card">
                <div class="equipment-card-image">
                    <img src="https://images.unsplash.com/photo-1540497077202-7c8a3999166f?w=300" alt="레그 프레스">
                </div>
                <div class="equipment-card-content">
                    <h3 class="equipment-card-title">레그 프레스 - 스텍</h3>
                </div>
            </div>

            <div class="equipment-card">
                <div class="equipment-card-image">
                    <img src="https://images.unsplash.com/photo-1571902943202-507ec2618e8f?w=300" alt="체스트 프레스">
                </div>
                <div class="equipment-card-content">
                    <h3 class="equipment-card-title">체스트 프레스 - 스크짐</h3>
                </div>
            </div>

            <div class="equipment-card">
                <div class="equipment-card-image">
                    <img src="https://images.unsplash.com/photo-1581009146145-b5ef050c2e1e?w=300" alt="스미스머신">
                </div>
                <div class="equipment-card-content">
                    <h3 class="equipment-card-title">스미스머신 - 스텍</h3>
                </div>
            </div>

            <div class="equipment-card">
                <div class="equipment-card-image">
                    <img src="https://images.unsplash.com/photo-1517836357463-d25dfeac3438?w=300" alt="랫 풀다운">
                </div>
                <div class="equipment-card-content">
                    <h3 class="equipment-card-title">랫 풀다운 - 스텍</h3>
                </div>
            </div>

            <div class="equipment-card">
                <div class="equipment-card-image">
                    <img src="https://images.unsplash.com/photo-1540497077202-7c8a3999166f?w=300" alt="레그 익스텐션">
                </div>
                <div class="equipment-card-content">
                    <h3 class="equipment-card-title">레그 익스텐션 - 스텍</h3>
                </div>
            </div>

            <div class="equipment-card">
                <div class="equipment-card-image">
                    <img src="https://images.unsplash.com/photo-1571902943202-507ec2618e8f?w=300" alt="인클라인 벤치">
                </div>
                <div class="equipment-card-content">
                    <h3 class="equipment-card-title">인클라인 벤치 - 스텍</h3>
                </div>
            </div>

            <div class="equipment-card">
                <div class="equipment-card-image">
                    <img src="https://images.unsplash.com/photo-1581009146145-b5ef050c2e1e?w=300" alt="케이블 크로스">
                </div>
                <div class="equipment-card-content">
                    <h3 class="equipment-card-title">케이블 크로스 - 스크짐</h3>
                </div>
            </div>

            <div class="equipment-card">
                <div class="equipment-card-image">
                    <img src="https://images.unsplash.com/photo-1517836357463-d25dfeac3438?w=300" alt="시티드 로우">
                </div>
                <div class="equipment-card-content">
                    <h3 class="equipment-card-title">시티드 로우 - 스텍</h3>
                </div>
            </div>

            <div class="equipment-card">
                <div class="equipment-card-image">
                    <img src="https://images.unsplash.com/photo-1540497077202-7c8a3999166f?w=300" alt="레그 컬">
                </div>
                <div class="equipment-card-content">
                    <h3 class="equipment-card-title">레그 컬 - 스텍</h3>
                </div>
            </div>

            <div class="equipment-card">
                <div class="equipment-card-image">
                    <img src="https://images.unsplash.com/photo-1571902943202-507ec2618e8f?w=300" alt="숄더 프레스">
                </div>
                <div class="equipment-card-content">
                    <h3 class="equipment-card-title">숄더 프레스 - 스텍</h3>
                </div>
            </div>

            <div class="equipment-card">
                <div class="equipment-card-image">
                    <img src="https://images.unsplash.com/photo-1581009146145-b5ef050c2e1e?w=300" alt="덤벨 플라이">
                </div>
                <div class="equipment-card-content">
                    <h3 class="equipment-card-title">덤벨 플라이 - 스크짐</h3>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    // 전역 변수로 contextPath 설정
    window.contextPath = '${pageContext.request.contextPath}';
    
    // 이미지 로드 확인 및 디버깅
    document.addEventListener('DOMContentLoaded', function() {
        const gymDetailImage = document.getElementById('gymDetailImage');
        if (gymDetailImage) {
            gymDetailImage.addEventListener('load', function() {
                console.log('이미지 로드 성공:', this.src);
            });
            gymDetailImage.addEventListener('error', function() {
                console.error('이미지 로드 실패:', this.src);
                // 대체 이미지로 변경
                this.src = 'https://images.unsplash.com/photo-1540497077202-7c8a3999166f?w=550';
            });
        }

        // 로그인 성공/실패 메시지 표시
        <c:if test="${not empty alertMsg}">
            alert('${alertMsg}');
            <c:remove var="alertMsg" scope="session"/>
        </c:if>
        <c:if test="${not empty errorMsg}">
            alert('${errorMsg}');
            <c:remove var="errorMsg" scope="session"/>
        </c:if>
        
        // 로그아웃 메시지 표시 (URL 파라미터 확인)
        const urlParams = new URLSearchParams(window.location.search);
        if (urlParams.get('logout') === 'success') {
            alert('로그아웃되었습니다.');
            // URL에서 파라미터 제거
            window.history.replaceState({}, document.title, window.location.pathname);
        }

    });

    // ============================= 아이디 중복 체크 (AJAX) =============================
    document.querySelectorAll('input[name="id"]').forEach(function(input) {
        let typingTimer;
        const doneTypingInterval = 500; // 0.5초 대기 후 체크

        input.addEventListener('input', function() {
            clearTimeout(typingTimer);
            const helperText = this.nextElementSibling;
            const idValue = this.value.trim();

            // 아이디가 4자 미만이면 메시지 숨기기
            if (idValue.length < 4) {
                helperText.classList.add('hidden');
                helperText.textContent = '';
                return;
            }

            // 입력 멈춘 후 0.5초 뒤 중복 체크 실행
            typingTimer = setTimeout(function() {
                fetch('${pageContext.request.contextPath}/signup/checkId?checkId=' + encodeURIComponent(idValue))
                    .then(response => response.text())
                    .then(data => {
                        console.log('아이디 중복 체크 결과:', data);

                        if (data === 'NNNNY') {
                            // 사용 가능한 아이디
                            helperText.classList.remove('error');
                            helperText.classList.add('success');
                            helperText.textContent = '사용 가능한 아이디입니다';
                            helperText.classList.remove('hidden');
                        } else {
                            // 이미 사용중인 아이디
                            helperText.classList.remove('success');
                            helperText.classList.add('error');
                            helperText.textContent = '사용 불가능한 아이디입니다';
                            helperText.classList.remove('hidden');
                        }
                    })
                    .catch(error => {
                        console.error('아이디 중복 체크 오류:', error);
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
            const idHelperText = idInput.nextElementSibling;
            if (!idHelperText.classList.contains('success')) {
                e.preventDefault();
                alert('사용 가능한 아이디로 입력해주세요.');
                idInput.focus();
                return false;
            }

            return true;
        });
    });
</script>
<script src="${pageContext.request.contextPath}/resources/js/loginform.js"></script>
</body>
</html>
