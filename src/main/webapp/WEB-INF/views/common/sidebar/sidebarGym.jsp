<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>GymHub</title>

    <!-- Common CSS 로드 -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common.css">

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
</head>
<body>
<c:if test="${not empty alertMsg}">
    <script>
        alert("${alertMsg}");
    </script>
    <c:remove var="alertMsg"/>
</c:if>

<div class="app-container">
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

            <a href="${pageContext.request.contextPath}/pt/list.do" class="nav-item">
                <img src="${pageContext.request.contextPath}/resources/images/icon/target.png" alt="PT 관리" class="nav-icon">
                <span>PT 관리</span>
            </a>

            <a href="javascript:void(0);" onclick="logout()" class="nav-item logout">
                <img src="${pageContext.request.contextPath}/resources/images/icon/output.png" alt="로그아웃" class="nav-icon">
                <span>로그아웃</span>
            </a>
        </nav>
    </div>

    <!-- Main Content Area -->
    <div class="main-content">
        <!-- 여기에 각 페이지의 콘텐츠가 들어갑니다 -->
    </div>
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
</body>
</html>
