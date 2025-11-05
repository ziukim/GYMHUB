<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style>
    /* 로고 아이콘 네온 효과 */
    .icon img {
        filter: drop-shadow(0 0 4px #e67000) 
                drop-shadow(0 0 8px #e67000) 
                drop-shadow(0 0 12px #e68900);
        animation: iconNeonBuzz 3s ease-in-out infinite;
    }

    @keyframes iconNeonBuzz {
        0%, 100% {
            filter: drop-shadow(0 0 4px #e67000) 
                    drop-shadow(0 0 8px #e67000) 
                    drop-shadow(0 0 12px #e68900);
        }
        10% {
            filter: drop-shadow(0 0 2px #e67000) 
                    drop-shadow(0 0 4px #e67000);
        }
        20% {
            filter: drop-shadow(0 0 6px #e67000) 
                    drop-shadow(0 0 10px #e67000) 
                    drop-shadow(0 0 14px #e68900);
        }
        30% {
            filter: drop-shadow(0 0 4px #e67000) 
                    drop-shadow(0 0 8px #e67000);
        }
    }

    /* 로고 텍스트 스타일 */
    .logo-text {
        font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, "Helvetica Neue", Arial, sans-serif;
        font-size: 1.2rem;
        font-weight: 800;
        font-style: italic;
        color: #ff6b00;
        text-transform: uppercase;
        letter-spacing: 0.08em;
        text-shadow:
                0 0 5px #e67000,
                0 0 10px #e67000,
                0 0 15px #e68900;
        animation: neonBuzz 3s ease-in-out infinite;
    }

    @keyframes neonBuzz {
        0%, 100% {
            text-shadow:
                    0 0 5px #e67000,
                    0 0 10px #e67000,
                    0 0 15px #e68900;
        }
        10% {
            text-shadow:
                    0 0 3px #e67000,
                    0 0 5px #e67000;
        }
        20% {
            text-shadow:
                    0 0 7px #e67000,
                    0 0 12px #e67000,
                    0 0 18px #e68900;
        }
        30% {
            text-shadow:
                    0 0 5px #e67000,
                    0 0 10px #e67000;
        }
    }

    /* main-content 배경색 조정 */
    .main-content {
        background-color: #000;
    }
</style>

<!-- Sidebar (Trainer) -->
<div class="sidebar">
    <!-- Logo Container -->
    <div class="logo-container">
        <div class="icon">
            <img src="${pageContext.request.contextPath}/resources/images/icon/logo.png" alt="GymHub 로고 아이콘">
        </div>
        <div class="logo-text">GymHub</div>
    </div>

    <div class="divider"></div>

    <!-- Navigation -->
    <nav class="sidebar-nav">
        <a href="${pageContext.request.contextPath}/trainer/dashboard" class="nav-item">
            <img src="${pageContext.request.contextPath}/resources/images/icon/home.png" alt="대시보드" class="nav-icon">
            <span>대시보드</span>
        </a>
        <a href="${pageContext.request.contextPath}/notice/list" class="nav-item">
            <img src="${pageContext.request.contextPath}/resources/images/icon/campaign.png" alt="공지사항" class="nav-icon">
            <span>공지사항</span>
        </a>
        <button class="nav-button logout" onclick="logout()">
            <img src="${pageContext.request.contextPath}/resources/images/icon/output.png" alt="로그아웃" class="nav-icon">
            <span>로그아웃</span>
        </button>
    </nav>
</div>

<script>
    // 로그아웃 처리
    function logout() {
        if(confirm('로그아웃 하시겠습니까?')) {
            location.href = '${pageContext.request.contextPath}/logout';
        }
    }
</script>