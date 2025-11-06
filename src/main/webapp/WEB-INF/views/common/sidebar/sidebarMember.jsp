<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<style>
    * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
    }

    /* Sidebar */
    .sidebar {
        position: relative;
        width: 255px;
        height: 100vh;
        background-color: #1a0f0a;
        border-right: 1px solid #ff6b00;
    }

    /* Logo Container */
    .logo-container {
        position: absolute;
        left: 33px;
        top: 1px;
        width: 221px;
        height: 108px;
        display: flex;
        align-items: center;
        gap: 7px;
        padding: 24px 22px 24px 0;
        box-sizing: border-box;
    }

    .icon {
        width: 48px;
        height: 48px;
        flex-shrink: 0;
    }

    .icon img {
        display: block;
        width: 100%;
        height: 100%;
        object-fit: contain;
    }

    .logo-text-container {
        width: 143px;
        height: 62px;
        flex-shrink: 0;
        position: relative;
    }

    .logo-text {
        position: absolute;
        left: 7px;
        top: 19px;
        width: 129px;
        line-height: 24px;
    }

    /* Divider */
    .divider {
        position: absolute;
        left: 0;
        top: 108px;
        width: 255px;
        height: 1px;
        background-color: #ff6b00;
    }

    /* Navigation */
    .navigation {
        position: absolute;
        left: 0;
        top: 109px;
        width: 255px;
        height: 726px;
        padding: 16px;
        box-sizing: border-box;
        display: flex;
        flex-direction: column;
        gap: 8px;
    }

    .nav-button {
        position: relative;
        width: 100%;
        height: 36px;
        border-radius: 6px;
        border: 1px solid transparent;
        background: transparent;
        cursor: pointer;
        transition: border-color 0.2s;
        flex-shrink: 0;
    }

    .nav-button:hover {
        border-color: #ff6b00;
    }

    .nav-button.logout {
        border-radius: 8px;
        width: 223px;
    }

    .nav-button img {
        position: absolute;
        left: 12px;
        top: 10px;
        width: 16px;
        height: 16px;
        object-fit: contain;
    }

    .nav-button span {
        position: absolute;
        left: 40px;
        top: 7px;
        font-family: 'ABeeZee', 'Noto Sans KR', sans-serif;
        font-size: 14px;
        line-height: 20px;
        color: #ffa366;
        white-space: nowrap;
        font-weight: 400;
    }

    .nav-button.logout span {
        color: #ff5252;
    }
</style>

<div class="sidebar">
    <!-- Logo Container -->
    <div class="logo-container">
        <div class="icon">
            <img src="${pageContext.request.contextPath}/resources/images/icon/logo.png" alt="GymHub 로고 아이콘">
        </div>
        <div class="logo-text-container">
            <p class="logo-text">GymHub</p>
        </div>
    </div>

    <div class="divider"></div>

    <!-- Navigation -->
    <nav class="navigation">
        <button class="nav-button" onclick="location.href='${pageContext.request.contextPath}/dashboard'">
            <img src="${pageContext.request.contextPath}/resources/images/icon/home.png" alt="대시보드 아이콘">
            <span>대시보드</span>
        </button>

        <button class="nav-button" onclick="location.href='${pageContext.request.contextPath}/myinfo'">
            <img src="${pageContext.request.contextPath}/resources/images/icon/person.png" alt="내 정보 아이콘">
            <span>내 정보</span>
        </button>

        <button class="nav-button" onclick="location.href='${pageContext.request.contextPath}/notice'">
            <img src="${pageContext.request.contextPath}/resources/images/icon/campaign.png" alt="공지사항 아이콘">
            <span>공지사항</span>
        </button>

        <button class="nav-button" onclick="location.href='${pageContext.request.contextPath}/schedule'">
            <img src="${pageContext.request.contextPath}/resources/images/icon/calendar.png" alt="PT스케줄 아이콘">
            <span>PT 스케줄</span>
        </button>

        <button class="nav-button logout" onclick="location.href='${pageContext.request.contextPath}/logout'">
            <img src="${pageContext.request.contextPath}/resources/images/icon/output.png" alt="로그아웃 아이콘">
            <span>로그아웃</span>
        </button>
    </nav>
</div>

<script>
    document.querySelectorAll('.nav-button').forEach(button => {
        button.addEventListener('click', function() {
            console.log(this.querySelector('span').textContent + ' 클릭됨');
        });
    });
</script>