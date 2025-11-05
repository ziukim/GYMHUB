<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style>
    /* 네온 효과만 추가 (common.css에 없는 스타일) */
    .logo-text {
        font-family: 'ADLaM Display', cursive;
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