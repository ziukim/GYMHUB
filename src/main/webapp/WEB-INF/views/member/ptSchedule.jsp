<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>GymHub - PT 스케줄</title>

    <!-- Common CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common.css">

    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=ADLaM+Display&family=ABeeZee&family=Noto+Sans+KR:wght@400;900&family=Abhaya+Libre:wght@800&display=swap" rel="stylesheet">

    <style>
        /* ptSchedule 전용 스타일 */
        /* main-content는 common.css에 있으므로 padding만 오버라이드 */
        .main-content {
            padding: 40px 40px 40px 20px;
        }
        
        /* header는 common.css에 있음 */
        
        /* header-title은 common.css에 있으므로 font-family만 추가 */
        .header-title h1 {
            font-family: 'Abhaya Libre', 'Noto Sans KR', sans-serif;
        }
        
        /* btn-primary는 common.css에 있으므로 추가 속성만 정의 */
        .btn-primary {
            display: flex;
            align-items: center;
            gap: 8px;
            padding: 8px 12px;
            color: #0a0a0a;
        }

        /* Stats Cards */
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 24px;
            margin-bottom: 24px;
        }

        .stat-card {
            background-color: #1a0f0a;
            border: 1px solid #ff6b00;
            border-radius: 14px;
            padding: 25px;
            height: 183px;
        }

        .stat-card-header {
            display: flex;
            align-items: center;
            gap: 8px;
            margin-bottom: 30px;
        }

        /* stat-icon, stat-value는 common.css에 있음 */
        
        .stat-title {
            font-size: 16px;
            color: #ff6b00;
        }
        
        /* stat-value는 common.css에 있으므로 margin-bottom만 추가 */
        .stat-value {
            margin-bottom: 8px;
        }

        .progress-bar {
            width: 100%;
            height: 8px;
            background-color: rgba(255, 107, 0, 0.2);
            border-radius: 999px;
            margin-bottom: 8px;
            overflow: hidden;
        }

        .progress-fill {
            height: 100%;
            background-color: #ff6b00;
        }

        .stat-subtitle {
            font-size: 14px;
            color: #8a6a50;
        }

        /* Trainer Card */
        .trainer-card {
            background-color: #1a0f0a;
            border: 1px solid #ff6b00;
            border-radius: 14px;
            padding: 25px;
            margin-bottom: 24px;
            position: relative;
        }

        .card-status {
            position: absolute;
            top: 20px;
            right: 20px;
            padding: 6px 12px;
            border-radius: 6px;
            font-size: 12px;
            font-weight: 600;
        }

        .status-pending {
            background-color: rgba(255, 193, 7, 0.2);
            color: #ffc107;
            border: 1px solid #ffc107;
        }

        .status-approved {
            background-color: rgba(76, 175, 80, 0.2);
            color: #4caf50;
            border: 1px solid #4caf50;
        }

        .status-rejected {
            background-color: rgba(251, 44, 54, 0.2);
            color: #fb2c36;
            border: 1px solid #fb2c36;
        }

        .trainer-card-title {
            font-size: 16px;
            color: #ff6b00;
            margin-bottom: 30px;
        }

        .trainer-info {
            display: flex;
            gap: 16px;
            align-items: flex-start;
        }

        .trainer-avatar {
            width: 64px;
            height: 64px;
            background-color: #2d1810;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            flex-shrink: 0;
        }

        .trainer-avatar img {
            width: 32px;
            height: 32px;
        }

        .trainer-details h3 {
            font-size: 18px;
            color: #ffa366;
            margin-bottom: 4px;
        }

        .trainer-details p {
            font-size: 14px;
            color: #8a6a50;
        }

        .trainer-contact {
            margin-top: 12px;
        }

        .trainer-contact p {
            font-size: 14px;
            color: #8a6a50;
            margin-bottom: 5px;
        }

        /* Tabs */
        .tabs {
            margin-bottom: 24px;
        }

        .tab-list {
            display: flex;
            background-color: #1a0f0a;
            border-radius: 14px;
            padding: 3px;
            margin-bottom: 24px;
            width: fit-content;
        }

        .tab-button {
            padding: 5px 9px;
            background: transparent;
            border: 1px solid transparent;
            border-radius: 14px;
            color: #8a6a50;
            font-size: 14px;
            cursor: pointer;
            transition: all 0.2s;
        }

        .tab-button:hover {
            background-color: rgba(255, 107, 0, 0.1);
        }

        .tab-button.active {
            background-color: #1a0f0a;
            border-color: #ff6b00;
            color: #ffa366;
        }

        /* Schedule Items */
        /* Schedule Items */
        .schedule-list {
            display: flex;
            flex-direction: row;
            gap: 16px;
            flex-wrap: wrap;
        }

        .schedule-item {
            background-color: #1a0f0a;
            border: 1px solid #ff6b00;
            border-radius: 14px;
            padding: 25px;
            flex: 1;
            min-width: 300px;
        }

        /* 완료된 PT 게시판 형식 */
        .pt-history-list {
            display: flex;
            flex-direction: column;
            gap: 12px;
        }

        .pt-history-card {
            background-color: #1a0f0a;
            border: 2px solid #ff6b00;
            border-radius: 8px;
            padding: 20px;
            transition: all 0.3s;
            cursor: pointer;
        }

        .pt-history-card:hover {
            background-color: #2d1810;
            box-shadow: 0 0 20px rgba(255, 107, 0, 0.4);
            transform: translateY(-2px);
        }

        .pt-history-header {
            display: flex;
            align-items: center;
            gap: 12px;
            margin-bottom: 12px;
        }

        .pt-history-badge {
            padding: 4px 12px;
            border-radius: 8px;
            font-size: 12px;
            font-weight: 600;
            flex-shrink: 0;
        }

        .pt-history-badge.scheduled {
            background-color: rgba(255, 82, 82, 0.2);
            border: 1px solid #ff5252;
            color: #ff5252;
        }

        .pt-history-badge.completed {
            background-color: rgba(76, 175, 80, 0.2);
            border: 1px solid #4caf50;
            color: #4caf50;
        }

        .pt-history-time {
            flex: 1;
            font-size: 16px;
            font-weight: 600;
            color: #ffa366;
        }

        .pt-history-meta {
            display: flex;
            gap: 16px;
            font-size: 14px;
            color: #8a6a50;
        }

        .pt-history-meta-item {
            display: flex;
            align-items: center;
            gap: 6px;
        }

        /* 페이징 */
        .pagination {
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 8px;
            margin-top: 24px;
        }

        .pagination button {
            min-width: 32px;
            height: 32px;
            padding: 0 12px;
            background-color: transparent;
            border: 1px solid #ff6b00;
            border-radius: 4px;
            color: #ff6b00;
            cursor: pointer;
            transition: all 0.2s;
            font-size: 14px;
        }

        .pagination button:hover:not(:disabled) {
            background-color: rgba(255, 107, 0, 0.1);
        }

        .pagination button.active {
            background-color: #ff6b00;
            color: #0a0a0a;
            font-weight: 700;
        }

        .pagination button:disabled {
            opacity: 0.3;
            cursor: not-allowed;
        }

        .schedule-header {
            display: flex;
            align-items: center;
            gap: 12px;
            margin-bottom: 12px;
        }

        .badge {
            background-color: #ff6b00;
            color: white;
            padding: 3px 9px;
            border-radius: 8px;
            font-size: 12px;
        }

        .schedule-title {
            font-size: 16px;
            color: #ffa366;
        }

        .schedule-info {
            display: flex;
            gap: 24px;
            align-items: center;
            flex-wrap: wrap;
        }

        .schedule-info-item {
            display: flex;
            align-items: center;
            gap: 8px;
            font-size: 14px;
            color: #8a6a50;
        }

        .schedule-info-item img {
            width: 16px;
            height: 16px;
        }

        .empty-state {
            background-color: #1a0f0a;
            border: 1px solid #ff6b00;
            border-radius: 14px;
            padding: 50px;
            text-align: center;
            color: #8a6a50;
        }

        .hidden {
            display: none;
        }

        @media (max-width: 1024px) {
            .stats-grid {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
<div class="app-container">
    <!-- Sidebar Include -->
    <jsp:include page="../common/sidebar/sidebarMember.jsp" />

    <!-- Main Content -->
    <main class="main-content">
        <div class="page-intro">
            <h1>PT 스케줄</h1>
            <p>나의 퍼스널 트레이닝 일정을 관리하세요</p>
        </div>
        <div class="header">
            <button class="btn-primary" onclick="location.href='${pageContext.request.contextPath}/ptBooking.me'">
                <img src="${pageContext.request.contextPath}/resources/images/icon/add.png" alt="추가" style="width: 16px; height: 16px;">
                <span>PT 예약</span>
            </button>
        </div>

        <!-- Stats Grid -->
        <div class="stats-grid">
            <div class="stat-card">
                <div class="stat-card-header">
                    <img src="${pageContext.request.contextPath}/resources/images/icon/ticket.png" alt="전체 PT" class="stat-icon">
                    <span class="stat-title">전체 PT</span>
                </div>
                <c:choose>
                    <c:when test="${not empty ptSummary and ptSummary.totalCount > 0}">
                        <div class="stat-value">${ptSummary.totalCount}회</div>
                        <div class="progress-bar">
                            <div class="progress-fill" style="width: ${ptSummary.progressRate}%"></div>
                        </div>
                        <div class="stat-subtitle">진행률 ${ptSummary.progressRateLabel}</div>
                    </c:when>
                    <c:otherwise>
                        <div class="stat-value">0회</div>
                        <div class="progress-bar">
                            <div class="progress-fill" style="width: 0%"></div>
                        </div>
                        <div class="stat-subtitle">PT 이용권이 없습니다</div>
                    </c:otherwise>
                </c:choose>
            </div>

            <div class="stat-card">
                <div class="stat-card-header">
                    <img src="${pageContext.request.contextPath}/resources/images/icon/done.png" alt="사용 완료" class="stat-icon">
                    <span class="stat-title">사용 완료</span>
                </div>
                <c:choose>
                    <c:when test="${not empty ptSummary}">
                        <div class="stat-value">${ptSummary.usedCount}회</div>
                        <div class="stat-subtitle">예약 확정 기준</div>
                    </c:when>
                    <c:otherwise>
                        <div class="stat-value">0회</div>
                        <div class="stat-subtitle">예약 확정 기준</div>
                    </c:otherwise>
                </c:choose>
            </div>

            <div class="stat-card">
                <div class="stat-card-header">
                    <img src="${pageContext.request.contextPath}/resources/images/icon/ticket.png" alt="남은 횟수" class="stat-icon">
                    <span class="stat-title">남은 횟수</span>
                </div>
                <c:choose>
                    <c:when test="${not empty ptSummary}">
                        <div class="stat-value">${ptSummary.remainingCount}회</div>
                        <div class="stat-subtitle">만료일: ${ptSummary.endDateLabel}</div>
                    </c:when>
                    <c:otherwise>
                        <div class="stat-value">0회</div>
                        <div class="stat-subtitle">만료일: -</div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>

        <!-- Trainer Card -->
        <div class="trainer-card">
            <c:choose>
                <c:when test="${not empty ptSummary.upcomingReservation}">
                    <c:choose>
                        <c:when test="${ptSummary.upcomingReservation.ptReserveStatus == '대기중'}">
                            <span class="card-status status-pending">대기중</span>
                            <div class="trainer-card-title">예약된 트레이너</div>
                            <div class="trainer-info">
                                <div class="trainer-avatar">
                                    <c:choose>
                                        <c:when test="${not empty ptSummary.upcomingReservation.desiredTrainerPhotoPath}">
                                            <img src="${pageContext.request.contextPath}${ptSummary.upcomingReservation.desiredTrainerPhotoPath}" 
                                                 alt="${ptSummary.upcomingReservation.desiredTrainerName}" 
                                                 style="width: 32px; height: 32px; border-radius: 50%; object-fit: cover;">
                                        </c:when>
                                        <c:otherwise>
                                            <img src="${pageContext.request.contextPath}/resources/images/icon/person.png" 
                                                 alt="트레이너" 
                                                 style="width: 32px; height: 32px;">
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                                <div>
                                    <div class="trainer-details">
                                        <h3>${ptSummary.upcomingReservation.desiredTrainerName}</h3>
                                        <p>예약 시간: ${ptSummary.upcomingReservation.reserveTimeLabel}</p>
                                    </div>
                                    <div class="trainer-contact">
                                        <p>전화번호: ${ptSummary.upcomingReservation.desiredTrainerPhone}</p>
                                        <p>이메일: ${ptSummary.upcomingReservation.desiredTrainerEmail}</p>
                                        <c:if test="${not empty ptSummary.upcomingReservation.desiredTrainerLicense}">
                                            <p>자격: ${ptSummary.upcomingReservation.desiredTrainerLicense}</p>
                                        </c:if>
                                    </div>
                                </div>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <span class="card-status status-approved">승인됨</span>
                            <div class="trainer-card-title">배정된 트레이너</div>
                            <div class="trainer-info">
                                <div class="trainer-avatar">
                                    <c:choose>
                                        <c:when test="${not empty ptSummary.upcomingReservation.confirmedTrainerPhotoPath}">
                                            <img src="${pageContext.request.contextPath}${ptSummary.upcomingReservation.confirmedTrainerPhotoPath}" 
                                                 alt="${ptSummary.upcomingReservation.confirmedTrainerName}" 
                                                 style="width: 32px; height: 32px; border-radius: 50%; object-fit: cover;">
                                        </c:when>
                                        <c:otherwise>
                                            <img src="${pageContext.request.contextPath}/resources/images/icon/person.png" 
                                                 alt="트레이너" 
                                                 style="width: 32px; height: 32px;">
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                                <div>
                                    <div class="trainer-details">
                                        <h3>${ptSummary.upcomingReservation.confirmedTrainerName}</h3>
                                        <p>예약 시간: ${ptSummary.upcomingReservation.reserveTimeLabel}</p>
                                    </div>
                                    <div class="trainer-contact">
                                        <p>전화번호: ${ptSummary.upcomingReservation.confirmedTrainerPhone}</p>
                                        <p>이메일: ${ptSummary.upcomingReservation.confirmedTrainerEmail}</p>
                                        <c:if test="${not empty ptSummary.upcomingReservation.confirmedTrainerLicense}">
                                            <p>자격: ${ptSummary.upcomingReservation.confirmedTrainerLicense}</p>
                                        </c:if>
                                    </div>
                                </div>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </c:when>
                <c:otherwise>
                    <div class="trainer-card-title">예약 정보</div>
                    <div class="trainer-info" style="justify-content: center; padding: 20px;">
                        <p style="color: #8a6a50; text-align: center;">PT 예약을 진행해주세요</p>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>

        <!-- Tabs -->
        <div class="tabs">
            <div class="tab-list">
                <button class="tab-button active" onclick="changeTab('upcoming')">예정된 PT</button>
                <button class="tab-button" onclick="changeTab('completed')">완료된 PT</button>
            </div>
        </div>
        <!-- Upcoming Schedules -->
        <div id="upcoming">
            <c:choose>
                <c:when test="${not empty ptSummary.scheduledPtList}">
                    <div class="pt-history-list" id="upcomingList"></div>
                    <div id="upcomingPagination" class="pagination"></div>
                </c:when>
                <c:otherwise>
                    <div class="empty-state">
                        <p>예정된 PT가 없습니다.</p>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>

        <!-- Completed Schedules -->
        <div id="completed" class="hidden">
            <c:choose>
                <c:when test="${not empty ptSummary.completedPtList}">
                    <div class="pt-history-list" id="completedList"></div>
                    <div id="completedPagination" class="pagination"></div>
                </c:when>
                <c:otherwise>
                    <div class="empty-state">
                        <p>완료된 PT가 없습니다.</p>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>

        <!-- Workout Records -->
        <div id="workout" class="schedule-list hidden">
            <div class="empty-state">
                <p>운동 기록이 없습니다.</p>
            </div>
        </div>
    </main>
</div>

<script>
    // 데이터 저장
    var upcomingData = [];
    var completedData = [];
    
    // 서버에서 전달받은 데이터 초기화
    <c:if test="${not empty ptSummary.scheduledPtList}">
        upcomingData = [
            <c:forEach var="schedule" items="${ptSummary.scheduledPtList}" varStatus="status">
                {
                    reserveTimeLabel: '${schedule.reserveTimeLabel}',
                    reserveDateLabel: '${schedule.reserveDateLabel}',
                    reserveHourLabel: '${schedule.reserveHourLabel}',
                    trainerName: '${schedule.confirmedTrainerName}',
                    trainerPhone: '${schedule.confirmedTrainerPhone}'
                }<c:if test="${!status.last}">,</c:if>
            </c:forEach>
        ];
    </c:if>
    
    <c:if test="${not empty ptSummary.completedPtList}">
        completedData = [
            <c:forEach var="completed" items="${ptSummary.completedPtList}" varStatus="status">
                {
                    reserveTimeLabel: '${completed.reserveTimeLabel}',
                    reserveDateLabel: '${completed.reserveDateLabel}',
                    reserveHourLabel: '${completed.reserveHourLabel}',
                    trainerName: '${completed.confirmedTrainerName}',
                    trainerPhone: '${completed.confirmedTrainerPhone}'
                }<c:if test="${!status.last}">,</c:if>
            </c:forEach>
        ];
    </c:if>
    
    // 페이징 변수
    var upcomingCurrentPage = 1;
    var completedCurrentPage = 1;
    var itemsPerPage = 10;
    
    // 페이지 로드 시 초기화
    window.addEventListener('load', function() {
        if (upcomingData.length > 0) {
            renderPtList('upcoming', upcomingData, upcomingCurrentPage);
        }
        if (completedData.length > 0) {
            renderPtList('completed', completedData, completedCurrentPage);
        }
    });
    
    // PT 목록 렌더링
    function renderPtList(type, data, currentPage) {
        var listId = type === 'upcoming' ? 'upcomingList' : 'completedList';
        var paginationId = type === 'upcoming' ? 'upcomingPagination' : 'completedPagination';
        var badgeText = type === 'upcoming' ? '예정' : '완료';
        
        var listContainer = document.getElementById(listId);
        var paginationContainer = document.getElementById(paginationId);
        
        if (!listContainer || !paginationContainer) return;
        
        // 페이징 계산
        var totalPages = Math.ceil(data.length / itemsPerPage);
        var startIndex = (currentPage - 1) * itemsPerPage;
        var endIndex = Math.min(startIndex + itemsPerPage, data.length);
        var pageData = data.slice(startIndex, endIndex);
        
        // 목록 렌더링
        listContainer.innerHTML = '';
        pageData.forEach(function(item) {
            var card = document.createElement('div');
            card.className = 'pt-history-card';
            
            var phoneHtml = item.trainerPhone 
                ? '<div class="pt-history-meta-item">' +
                  '<img src="${pageContext.request.contextPath}/resources/images/icon/call.png" alt="전화" style="width: 16px; height: 16px;">' +
                  '<span>' + item.trainerPhone + '</span>' +
                  '</div>'
                : '';
            
            var badgeClass = type === 'upcoming' ? 'scheduled' : 'completed';
            
            card.innerHTML = 
                '<div class="pt-history-header">' +
                '<span class="pt-history-badge ' + badgeClass + '">' + badgeText + '</span>' +
                '<div class="pt-history-time">' + item.reserveTimeLabel + '</div>' +
                '</div>' +
                '<div class="pt-history-meta">' +
                '<div class="pt-history-meta-item">' +
                '<img src="${pageContext.request.contextPath}/resources/images/icon/person.png" alt="트레이너" style="width: 16px; height: 16px;">' +
                '<span>' + item.trainerName + '</span>' +
                '</div>' +
                phoneHtml +
                '</div>';
            
            listContainer.appendChild(card);
        });
        
        // 페이징 렌더링
        renderPagination(type, totalPages, currentPage);
    }
    
    // 페이징 버튼 렌더링
    function renderPagination(type, totalPages, currentPage) {
        var paginationId = type === 'upcoming' ? 'upcomingPagination' : 'completedPagination';
        var paginationContainer = document.getElementById(paginationId);
        
        if (!paginationContainer || totalPages <= 1) {
            paginationContainer.innerHTML = '';
            return;
        }
        
        paginationContainer.innerHTML = '';
        
        // 이전 버튼
        var prevBtn = document.createElement('button');
        prevBtn.textContent = '◀';
        prevBtn.disabled = currentPage === 1;
        prevBtn.onclick = function() {
            goToPage(type, currentPage - 1);
        };
        paginationContainer.appendChild(prevBtn);
        
        // 페이지 번호 버튼 (최대 5개 표시)
        var startPage = Math.max(1, currentPage - 2);
        var endPage = Math.min(totalPages, startPage + 4);
        
        if (endPage - startPage < 4) {
            startPage = Math.max(1, endPage - 4);
        }
        
        for (var i = startPage; i <= endPage; i++) {
            var pageBtn = document.createElement('button');
            pageBtn.textContent = i;
            if (i === currentPage) {
                pageBtn.className = 'active';
            }
            pageBtn.onclick = (function(page) {
                return function() {
                    goToPage(type, page);
                };
            })(i);
            paginationContainer.appendChild(pageBtn);
        }
        
        // 다음 버튼
        var nextBtn = document.createElement('button');
        nextBtn.textContent = '▶';
        nextBtn.disabled = currentPage === totalPages;
        nextBtn.onclick = function() {
            goToPage(type, currentPage + 1);
        };
        paginationContainer.appendChild(nextBtn);
    }
    
    // 페이지 이동
    function goToPage(type, page) {
        if (type === 'upcoming') {
            upcomingCurrentPage = page;
            renderPtList('upcoming', upcomingData, page);
        } else {
            completedCurrentPage = page;
            renderPtList('completed', completedData, page);
        }
    }
    
    function changeTab(tabName) {
        // Hide all tabs
        document.getElementById('upcoming').classList.add('hidden');
        document.getElementById('completed').classList.add('hidden');
        document.getElementById('workout').classList.add('hidden');

        // Remove active class from all buttons
        const buttons = document.querySelectorAll('.tab-button');
        buttons.forEach(function(btn) {
            btn.classList.remove('active');
        });

        // Show selected tab
        document.getElementById(tabName).classList.remove('hidden');

        // Add active class to clicked button
        event.target.classList.add('active');
    }
</script>
</body>
</html>