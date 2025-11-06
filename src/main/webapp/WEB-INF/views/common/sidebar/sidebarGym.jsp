<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- 사이드바 스타일 (include 시 함께 포함) -->
<style>
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
            <a href="${pageContext.request.contextPath}/dashboard.gym" class="nav-item">
                <img src="${pageContext.request.contextPath}/resources/images/icon/home.png" alt="대시보드" class="nav-icon">
                <span>대시보드</span>
            </a>

            <a href="${pageContext.request.contextPath}/member.gym" class="nav-item">
                <img src="${pageContext.request.contextPath}/resources/images/icon/people.png" alt="회원 관리" class="nav-icon">
                <span>회원 관리</span>
            </a>

            <a href="${pageContext.request.contextPath}/sales.gym" class="nav-item">
                <img src="${pageContext.request.contextPath}/resources/images/icon/ticket.png" alt="매출 현황" class="nav-icon">
                <span>매출 현황</span>
            </a>

            <a href="${pageContext.request.contextPath}/facility.gym" class="nav-item">
                <img src="${pageContext.request.contextPath}/resources/images/icon/target.png" alt="시설 관리" class="nav-icon">
                <span>시설 관리</span>
            </a>

            <a href="${pageContext.request.contextPath}/reservation.gym" class="nav-item">
                <img src="${pageContext.request.contextPath}/resources/images/icon/calendar.png" alt="예약 상담 관리" class="nav-icon">
                <span>예약 상담 관리</span>
            </a>

            <a href="${pageContext.request.contextPath}/product.gym" class="nav-item">
                <img src="${pageContext.request.contextPath}/resources/images/icon/book.png" alt="물품관리" class="nav-icon">
                <span>물품관리</span>
            </a>

            <a href="${pageContext.request.contextPath}/video.gym" class="nav-item">
                <img src="${pageContext.request.contextPath}/resources/images/icon/clock.png" alt="영상관리" class="nav-icon">
                <span>영상관리</span>
            </a>

            <a href="${pageContext.request.contextPath}/gym/info.gym" class="nav-item">
                <img src="${pageContext.request.contextPath}/resources/images/icon/company.png" alt="헬스장 정보 관리" class="nav-icon">
                <span>헬스장 정보 관리</span>
            </a>

            <a href="${pageContext.request.contextPath}/notice.no" class="nav-item">
                <img src="${pageContext.request.contextPath}/resources/images/icon/campaign.png" alt="공지사항" class="nav-icon">
                <span>공지사항</span>
            </a>

            <a href="${pageContext.request.contextPath}/trainer.gym" class="nav-item">
                <img src="${pageContext.request.contextPath}/resources/images/icon/person.png" alt="트레이너 관리" class="nav-icon">
                <span>트레이너 관리</span>
            </a>

            <a href="${pageContext.request.contextPath}/ptBoard.gym" class="nav-item">
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
        const contextPath = '${pageContext.request.contextPath}';
        const navItems = document.querySelectorAll('.nav-item:not(.logout)');

        navItems.forEach(item => {
            const href = item.getAttribute('href');
            if(href && !href.startsWith('javascript:')) {
                // href에서 contextPath 제거하여 실제 경로만 추출
                let hrefPath = href;
                if (contextPath && hrefPath.startsWith(contextPath)) {
                    hrefPath = hrefPath.substring(contextPath.length);
                }
                
                // .gym 또는 .no로 끝나는 경로는 간단하게 비교
                // 현재 경로가 해당 hrefPath로 끝나거나, 시설 관리 관련 페이지인 경우
                if (currentPath.endsWith(hrefPath)) {
                    item.classList.add('active');
                }
                // 시설 관리: 기구 등록 페이지도 시설 관리 메뉴 활성화
                else if (hrefPath === '/facility.gym' && currentPath.includes('/facility/machine/enroll.gym')) {
                    item.classList.add('active');
                }
            }
        });
    });
</script>
