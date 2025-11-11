<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>관리자 메뉴 - GYMHub</title>
    <!-- Common CSS 링크 (필수) -->
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/common.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;600;700;900&display=swap" rel="stylesheet">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Noto Sans KR', sans-serif;
            background: linear-gradient(135deg, #0a0a0a 0%, #1a0f0a 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
            position: relative;
            overflow: hidden;
        }

        .admin-modal {
            background: linear-gradient(145deg, #2D1810 0%, #1a0f0a 100%);
            border: 3px solid #FF6B00;
            border-radius: 30px;
            padding: 60px 50px;
            max-width: 700px;
            width: 100%;
            text-align: center;
            position: relative;
            z-index: 1;
        }

        .logo-section {
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 20px;
            margin-bottom: 40px;
        }

        .logo-text {
            font-size: 42px;
            color: #FF6B00;
            font-weight: 900;
        }

        .welcome-title {
            font-size: 32px;
            color: #FF6B00;
            margin-bottom: 15px;
            font-weight: 700;
        }

        .welcome-subtitle {
            font-size: 18px;
            color: #FFA366;
            margin-bottom: 50px;
            font-weight: 500;
        }

        .menu-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 30px;
            margin-bottom: 40px;
        }

        .menu-card {
            background: linear-gradient(145deg, rgba(255, 107, 0, 0.1) 0%, rgba(45, 24, 16, 0.3) 100%);
            border: 3px solid #FF6B00;
            border-radius: 20px;
            padding: 40px 30px;
            cursor: pointer;
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
        }

        .menu-card:hover {
            transform: translateY(-10px);
            background: linear-gradient(145deg, rgba(255, 107, 0, 0.2) 0%, rgba(45, 24, 16, 0.5) 100%);
        }

        .menu-icon {
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

        .menu-card:hover .menu-icon {
            background: rgba(255, 107, 0, 0.3);
            transform: scale(1.1) rotate(5deg);
        }

        .menu-icon svg {
            color: #8A6A50;
            transition: all 0.3s ease;
        }

        .menu-card:hover .menu-icon svg {
            color: #FF6B00;
        }

        .menu-title {
            font-size: 24px;
            color: #FFA366;
            margin-bottom: 12px;
            font-weight: 700;
            transition: all 0.3s ease;
        }

        .menu-card:hover .menu-title {
            color: #FF6B00;
        }

        .menu-description {
            font-size: 15px;
            color: #8A6A50;
            line-height: 1.5;
        }

        .logout-btn {
            background: transparent;
            border: 2px solid #FF6B00;
            color: #8A6A50;
            padding: 16px 50px;
            border-radius: 14px;
            font-size: 17px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .logout-btn:hover {
            background: rgba(255, 107, 0, 0.1);
            color: #FF6B00;
            transform: translateY(-2px);
        }

        @media (max-width: 768px) {
            .admin-modal {
                padding: 40px 30px;
            }

            .menu-grid {
                grid-template-columns: 1fr;
                gap: 20px;
            }

            .logo-text {
                font-size: 36px;
            }

            .welcome-title {
                font-size: 26px;
            }
        }
    </style>
</head>
<body>
<div class="admin-modal">
    <div class="logo-section">
        <span class="logo-text">GYMHub</span>
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
                관리자님, 환영합니다!
            </c:otherwise>
        </c:choose>
    </p>

    <div class="menu-grid">
        <div class="menu-card" onclick="openAttendanceModal()">
            <div class="menu-icon">
                <svg width="48" height="48" viewBox="0 0 24 24" fill="none">
                    <path d="M9 11L12 14L22 4" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"/>
                    <path d="M21 12V19C21 19.5304 20.7893 20.0391 20.4142 20.4142C20.0391 20.7893 19.5304 21 19 21H5C4.46957 21 3.96086 20.7893 3.58579 20.4142C3.21071 20.0391 3 19.5304 3 19V5C3 4.46957 3.21071 3.96086 3.58579 3.58579C3.96086 3.21071 4.46957 3 5 3H16" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"/>
                </svg>
            </div>
            <h3 class="menu-title">출석 관리</h3>
            <p class="menu-description">회원 출석체크 및<br>퇴실 처리</p>
        </div>

        <div class="menu-card" onclick="goToAdminPage()">
            <div class="menu-icon">
                <svg width="48" height="48" viewBox="0 0 24 24" fill="none">
                    <path d="M3 9L12 2L21 9V20C21 20.5304 20.7893 21.0391 20.4142 21.4142C20.0391 21.7893 19.5304 22 19 22H5C4.46957 22 3.96086 21.7893 3.58579 21.4142C3.21071 21.0391 3 20.5304 3 20V9Z" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"/>
                    <path d="M9 22V12H15V22" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"/>
                </svg>
            </div>
            <h3 class="menu-title">관리자 페이지</h3>
            <p class="menu-description">헬스장 운영 관리 및<br>통계 확인</p>
        </div>
    </div>

    <button class="logout-btn" onclick="logout()">로그아웃</button>
</div>

<script>
    function openAttendanceModal() {
        window.location.href = '${pageContext.request.contextPath}/attendanceCheck.gym';
    }

    function goToAdminPage() {
        window.location.href = '${pageContext.request.contextPath}/dashboard.gym';
    }

    function logout() {
        if (confirm('로그아웃 하시겠습니까?')) {
            window.location.href = '${pageContext.request.contextPath}/logout.do';
        }
    }
</script>
</body>
</html>

