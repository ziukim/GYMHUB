<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>관리자 메뉴 - GymHub</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Pretendard', -apple-system, BlinkMacSystemFont, system-ui, Roboto, sans-serif;
            background: linear-gradient(135deg, #0a0a0a 0%, #1a0f0a 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }

        body::before {
            content: '';
            position: fixed;
            width: 600px;
            height: 600px;
            background: radial-gradient(circle, rgba(255, 107, 0, 0.15) 0%, transparent 70%);
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            animation: pulse 4s ease-in-out infinite;
            z-index: 0;
        }

        @keyframes pulse {
            0%, 100% {
                opacity: 0.5;
                transform: translate(-50%, -50%) scale(1);
            }
            50% {
                opacity: 1;
                transform: translate(-50%, -50%) scale(1.1);
            }
        }

        .select-container {
            background: linear-gradient(145deg, #1a0f0a 0%, #2d1810 100%);
            border: 3px solid #ff6b00;
            border-radius: 30px;
            padding: 70px 60px;
            max-width: 800px;
            width: 100%;
            text-align: center;
            box-shadow: 0 0 80px rgba(255, 107, 0, 0.5);
            position: relative;
            z-index: 1;
            animation: slideUp 0.5s ease-out;
        }

        @keyframes slideUp {
            from {
                opacity: 0;
                transform: translateY(50px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .logo-section {
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 20px;
            margin-bottom: 50px;
            animation: logoGlow 3s ease-in-out infinite;
        }

        @keyframes logoGlow {
            0%, 100% {
                filter: drop-shadow(0 0 15px rgba(255, 107, 0, 0.5));
            }
            50% {
                filter: drop-shadow(0 0 25px rgba(255, 107, 0, 0.8));
            }
        }

        .logo-section img {
            width: 90px;
            height: 90px;
        }

        .logo-text {
            font-size: 48px;
            color: #ff6b00;
            font-weight: 900;
            text-shadow: 0 0 30px rgba(255, 107, 0, 0.6);
        }

        .welcome-title {
            font-size: 32px;
            color: #ff6b00;
            margin-bottom: 15px;
            font-weight: 700;
        }

        .welcome-subtitle {
            font-size: 18px;
            color: #ffa366;
            margin-bottom: 60px;
        }

        .menu-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 35px;
            margin-bottom: 40px;
        }

        .menu-card {
            background: linear-gradient(145deg, rgba(255, 107, 0, 0.1) 0%, rgba(255, 107, 0, 0.05) 100%);
            border: 3px solid #ff6b00;
            border-radius: 24px;
            padding: 50px 40px;
            text-decoration: none;
            transition: all 0.3s;
            cursor: pointer;
            position: relative;
            overflow: hidden;
        }

        .menu-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.1), transparent);
            transition: left 0.5s;
        }

        .menu-card:hover::before {
            left: 100%;
        }

        .menu-card:hover {
            transform: translateY(-12px);
            box-shadow: 0 25px 60px rgba(255, 107, 0, 0.5);
            border-color: #ff8800;
            background: linear-gradient(145deg, rgba(255, 107, 0, 0.2) 0%, rgba(255, 107, 0, 0.1) 100%);
        }

        .menu-icon {
            width: 90px;
            height: 90px;
            margin: 0 auto 30px;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 50%;
            background: rgba(255, 107, 0, 0.2);
            transition: all 0.3s;
        }

        .menu-card:hover .menu-icon {
            transform: scale(1.15) rotate(5deg);
            background: rgba(255, 107, 0, 0.35);
        }

        .menu-icon svg {
            color: #ff6b00;
            filter: drop-shadow(0 0 12px rgba(255, 107, 0, 0.6));
        }

        .menu-title {
            font-size: 26px;
            color: #ff6b00;
            margin-bottom: 15px;
            font-weight: 700;
        }

        .menu-description {
            font-size: 16px;
            color: #ffa366;
            margin: 0;
        }

        .logout-btn {
            background: transparent;
            border: 2px solid #ff6b00;
            color: #ff6b00;
            padding: 16px 50px;
            border-radius: 14px;
            font-size: 17px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
        }

        .logout-btn:hover {
            background: rgba(255, 107, 0, 0.15);
            border-color: #ff8800;
            color: #ff8800;
        }

        @media (max-width: 768px) {
            .menu-grid {
                grid-template-columns: 1fr;
            }

            .select-container {
                padding: 50px 40px;
            }

            .logo-text {
                font-size: 38px;
            }

            .welcome-title {
                font-size: 26px;
            }
        }
    </style>
</head>
<body>
<div class="select-container">
    <div class="logo-section">
        <img src="${pageContext.request.contextPath}/resources/images/icon/logo.png" alt="GymHub">
        <span class="logo-text">GYMHub</span>
    </div>

    <h1 class="welcome-title">관리자 메뉴</h1>
    <p class="welcome-subtitle">
        <c:choose>
            <c:when test="${not empty loginMember.gymName}">
                ${loginMember.gymName} 관리자님, 환영합니다!
            </c:when>
            <c:otherwise>
                관리자님, 환영합니다!
            </c:otherwise>
        </c:choose>
    </p>

    <div class="menu-grid">
        <!-- 출석 관리 -->
        <a href="${pageContext.request.contextPath}/admin/attendanceCheck" class="menu-card">
            <div class="menu-icon">
                <svg width="54" height="54" viewBox="0 0 48 48" fill="none">
                    <path d="M38 8H10C8.89543 8 8 8.89543 8 10V38C8 39.1046 8.89543 40 10 40H38C39.1046 40 40 39.1046 40 38V10C40 8.89543 39.1046 8 38 8Z" stroke="currentColor" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"/>
                    <path d="M32 4V12" stroke="currentColor" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"/>
                    <path d="M16 4V12" stroke="currentColor" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"/>
                    <path d="M8 20H40" stroke="currentColor" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"/>
                    <path d="M20 28L24 32L32 24" stroke="currentColor" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"/>
                </svg>
            </div>
            <h3 class="menu-title">출석 관리</h3>
            <p class="menu-description">회원 출석체크 관리</p>
        </a>

        <!-- 관리자 페이지 -->
        <a href="${pageContext.request.contextPath}/admin/adminMain" class="menu-card">
            <div class="menu-icon">
                <svg width="54" height="54" viewBox="0 0 48 48" fill="none">
                    <path d="M6 18L24 6L42 18V38C42 39.0609 41.5786 40.0783 40.8284 40.8284C40.0783 41.5786 39.0609 42 38 42H10C8.93913 42 7.92172 41.5786 7.17157 40.8284C6.42143 40.0783 6 39.0609 6 38V18Z" stroke="currentColor" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"/>
                    <path d="M18 42V24H30V42" stroke="currentColor" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"/>
                </svg>
            </div>
            <h3 class="menu-title">관리자 페이지</h3>
            <p class="menu-description">헬스장 운영 관리</p>
        </a>
    </div>

    <button class="logout-btn" onclick="logout()">로그아웃</button>
</div>

<script>
    function logout() {
        if (confirm('로그아웃 하시겠습니까?')) {
            location.href = '${pageContext.request.contextPath}/logout.do';
        }
    }
</script>
</body>
</html>