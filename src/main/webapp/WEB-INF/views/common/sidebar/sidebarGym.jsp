<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- 사이드바 스타일 (include 시 함께 포함) -->
<style>
    /* 로고 아이콘 네온 효과 */
    .logo-icon img {
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

    /* 사이드바 마진 제거 */
    .sidebar {
        margin: 0;
        padding: 0;
    }
</style>

<c:if test="${not empty alertMsg}">
    <script>
        alert("${alertMsg}");
    </script>
    <c:remove var="alertMsg"/>
</c:if>

<!-- Sidebar (common.css 클래스 사용) -->
<div class="sidebar">
        <!-- Logo Container -->
        <div class="logo-container">
            <div class="logo-icon">
                <img src="${pageContext.request.contextPath}/resources/images/icon/logo.png" alt="GymHub 로고 아이콘">
            </div>
            <p class="logo-text">GymHub</p>
        </div>

        <!-- Navigation -->
        <nav class="sidebar-nav">
            <a href="${pageContext.request.contextPath}/dashboard.do" class="nav-item">
                <img src="${pageContext.request.contextPath}/resources/images/icon/home.png" alt="대시보드" class="nav-icon">
                <span>대시보드</span>
            </a>

            <a href="${pageContext.request.contextPath}/member/list.do" class="nav-item">
                <img src="${pageContext.request.contextPath}/resources/images/icon/people.png" alt="회원 관리" class="nav-icon">
                <span>회원 관리</span>
            </a>

            <a href="${pageContext.request.contextPath}/sales/list.do" class="nav-item">
                <img src="${pageContext.request.contextPath}/resources/images/icon/ticket.png" alt="매출 현황" class="nav-icon">
                <span>매출 현황</span>
            </a>

            <a href="${pageContext.request.contextPath}/facility/list.do" class="nav-item">
                <img src="${pageContext.request.contextPath}/resources/images/icon/target.png" alt="시설 관리" class="nav-icon">
                <span>시설 관리</span>
            </a>

            <a href="${pageContext.request.contextPath}/reservation/list.do" class="nav-item">
                <img src="${pageContext.request.contextPath}/resources/images/icon/calendar.png" alt="예약 상담 관리" class="nav-icon">
                <span>예약 상담 관리</span>
            </a>

            <a href="${pageContext.request.contextPath}/product/list.do" class="nav-item">
                <img src="${pageContext.request.contextPath}/resources/images/icon/book.png" alt="물품관리" class="nav-icon">
                <span>물품관리</span>
            </a>

            <a href="${pageContext.request.contextPath}/video/list.do" class="nav-item">
                <img src="${pageContext.request.contextPath}/resources/images/icon/clock.png" alt="영상관리" class="nav-icon">
                <span>영상관리</span>
            </a>

            <a href="${pageContext.request.contextPath}/gym/info.do" class="nav-item">
                <img src="${pageContext.request.contextPath}/resources/images/icon/company.png" alt="헬스장 정보 관리" class="nav-icon">
                <span>헬스장 정보 관리</span>
            </a>

            <a href="${pageContext.request.contextPath}/notice/list.do" class="nav-item">
                <img src="${pageContext.request.contextPath}/resources/images/icon/campaign.png" alt="공지사항" class="nav-icon">
                <span>공지사항</span>
            </a>

            <a href="${pageContext.request.contextPath}/trainer/list.do" class="nav-item">
                <img src="${pageContext.request.contextPath}/resources/images/icon/person.png" alt="트레이너 관리" class="nav-icon">
                <span>트레이너 관리</span>
            </a>

            <a href="${pageContext.request.contextPath}/ptBoard.bo" class="nav-item">
                <img src="${pageContext.request.contextPath}/resources/images/icon/target.png" alt="PT 관리" class="nav-icon">
                <span>PT 관리</span>
            </a>

            <a href="javascript:void(0);" onclick="logout()" class="nav-item logout">
                <img src="${pageContext.request.contextPath}/resources/images/icon/output.png" alt="로그아웃" class="nav-icon">
                <span>로그아웃</span>
            </a>
        </nav>
</div>

<script>
    // 로그아웃 함수
    function logout() {
        if(confirm('로그아웃 하시겠습니까?')) {
            location.href = '${pageContext.request.contextPath}/logout.do';
        }
    }

    // 현재 페이지에 맞는 메뉴 활성화
    window.addEventListener('DOMContentLoaded', function() {
        const currentPath = window.location.pathname;
        const navItems = document.querySelectorAll('.nav-item:not(.logout)');

        navItems.forEach(item => {
            const href = item.getAttribute('href');
            if(href && currentPath.includes(href.split('/').pop())) {
                item.classList.add('active');
            }
        });
    });
</script>
