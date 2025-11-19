<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>GymHub - 대시보드</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common.css">
    <style>
        /* gymDashBoard 전용 스타일 */

        /* Dashboard Grid */
        .dashboard-container {
            display: flex;
            flex-direction: column;
            gap: 24px;
        }

        /* Stats Cards - Top Row */
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 24px;
        }

        .stat-card {
            background-color: #2d1810;
            border: 2px solid #ff6b00;
            border-radius: 8px;
            padding: 26px;
            box-shadow: 0 0 15px rgba(255, 107, 0, 0.3);
            display: flex;
            gap: 16px;
            align-items: center;
            transition: transform 0.3s;
        }

        .stat-card:hover {
            transform: translateY(-5px);
        }

        /* stat-icon, stat-label, stat-value, stat-change는 common.css에 있음 */
        .stat-icon {
            width: 60px;
            height: 60px;
            flex-shrink: 0;
            font-size: 24px;
        }

        .stat-info {
            display: flex;
            flex-direction: column;
            gap: 4px;
        }

        /* 통계 카드 하단 텍스트 색상 통일 */
        .stat-label {
            font-size: 12px;
            color: #b0b0b0;
        }

        .stat-change {
            font-size: 12px;
            color: #b0b0b0;
        }

        .stat-change.negative {
            color: #b0b0b0;
        }

        .stat-change.positive {
            color: #b0b0b0;
        }

        /* Monthly Stats Section */
        .monthly-stats {
            background-color: #2d1810;
            border: 2px solid #ff6b00;
            border-radius: 8px;
            padding: 26px;
            box-shadow: 0 0 15px rgba(255, 107, 0, 0.3);
        }

        /* section-header는 common.css에 있으므로 추가 속성만 정의 */
        .section-header {
            padding-bottom: 16px;
            margin-bottom: 24px;
        }

        .section-title {
            font-size: 18px;
            color: white;
            margin-bottom: 4px;
        }

        .section-subtitle {
            font-size: 12px;
            color: #b0b0b0;
        }

        .monthly-grid {
            display: grid;
            grid-template-columns: repeat(5, 1fr);
            gap: 24px;
        }

        .monthly-card {
            background-color: #2d1810;
            border: 2px solid #ff6b00;
            border-radius: 8px;
            padding: 26px;
            box-shadow: 0 0 15px rgba(255, 107, 0, 0.3);
            display: flex;
            gap: 16px;
            position: relative;
            transition: transform 0.3s;
        }

        .monthly-card:hover {
            transform: translateY(-5px);
        }

        .monthly-removed {
            font-size: 14px;
            color: #ff6467;
            margin-top: 4px;
        }

        .monthly-added {
            font-size: 14px;
            color: #05df72;
            margin-top: 4px;
        }

        /* Bottom Grid - 3 Columns */
        .bottom-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 24px;
        }

        .card {
            background-color: #2d1810;
            border: 2px solid #ff6b00;
            border-radius: 8px;
            padding: 26px;
            box-shadow: 0 0 15px rgba(255, 107, 0, 0.3);
        }

        .card-header {
            padding-bottom: 16px;
            border-bottom: 2px solid #ff6b00;
            margin-bottom: 16px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .card-title {
            font-size: 18px;
            color: #ff6b00;
        }

        .badge {
            background-color: #ff6b00;
            border-radius: 20px;
            padding: 4px 12px;
            box-shadow: 0 0 10px rgba(255, 107, 0, 0.5);
        }

        .badge-text {
            font-size: 12px;
            color: white;
            font-weight: 700;
        }

        /* Reservation Items */
        .reservation-list {
            display: flex;
            flex-direction: column;
            gap: 12px;
            max-height: 400px;
            overflow-y: auto;
            overflow-x: hidden;
            padding-right: 8px;
        }

        .reservation-list::-webkit-scrollbar {
            width: 8px;
        }

        .reservation-list::-webkit-scrollbar-track {
            background: #1a0f0a;
            border-radius: 4px;
        }

        .reservation-list::-webkit-scrollbar-thumb {
            background: #ff6b00;
            border-radius: 4px;
        }

        .reservation-list::-webkit-scrollbar-thumb:hover {
            background: #ff8800;
        }

        .reservation-item {
            background-color: #2d1810;
            border: 2px solid #ff6b00;
            border-radius: 8px;
            padding: 14px;
            box-shadow: 0 0 8px rgba(255, 107, 0, 0.2);
        }

        .reservation-header-info {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 8px;
        }

        .reservation-name {
            font-size: 14px;
            color: white;
            font-weight: 700;
        }

        .reservation-status {
            font-size: 11px;
            padding: 4px 8px;
            border-radius: 4px;
            font-weight: 700;
        }

        .reservation-status.status-completed {
            background-color: #05df72;
            color: white;
        }

        .reservation-status.status-approved {
            background-color: #4caf50;
            color: white;
        }

        .reservation-status.status-pending {
            background-color: #ff6b00;
            color: white;
        }

        .reservation-details {
            display: flex;
            flex-direction: column;
            gap: 6px;
        }

        .reservation-time {
            font-size: 12px;
            color: #b0b0b0;
            font-weight: 700;
            display: flex;
            align-items: center;
        }

        .reservation-phone {
            font-size: 12px;
            color: #b0b0b0;
            font-weight: 500;
            display: flex;
            align-items: center;
        }

        /* PT Reserve Items */
        .pt-reserve-list {
            display: flex;
            flex-direction: column;
            gap: 12px;
        }

        .pt-reserve-item {
            background-color: #2d1810;
            border: 2px solid #ff6b00;
            border-radius: 8px;
            padding: 14px;
            box-shadow: 0 0 8px rgba(255, 107, 0, 0.2);
        }

        .pt-reserve-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 8px;
        }

        .pt-reserve-name {
            font-size: 14px;
            color: white;
            font-weight: 700;
        }

        .pt-reserve-actions {
            display: flex;
            gap: 8px;
        }

        .pt-approve-btn, .pt-reject-btn {
            padding: 6px 12px;
            border: none;
            border-radius: 4px;
            font-size: 12px;
            font-weight: 700;
            cursor: pointer;
            transition: all 0.3s;
        }

        .pt-approve-btn {
            background-color: #ff6b00;
            color: white;
        }

        .pt-approve-btn:hover {
            background-color: #ff8533;
            box-shadow: 0 0 8px rgba(255, 107, 0, 0.5);
        }

        .pt-reject-btn {
            background-color: #fa5546;
            color: white;
        }

        .pt-reject-btn:hover {
            background-color: #ff6467;
            box-shadow: 0 0 8px rgba(250, 85, 70, 0.5);
        }

        .pt-reserve-info {
            display: flex;
            flex-direction: column;
            gap: 4px;
        }

        .pt-reserve-time {
            font-size: 12px;
            color: #b0b0b0;
            font-weight: 700;
        }

        .pt-reserve-trainer {
            font-size: 12px;
            color: #ffa366;
            font-weight: 500;
        }

        .pt-reserve-status {
            font-size: 12px;
            padding: 4px 8px;
            border-radius: 4px;
            font-weight: 700;
        }

        .pt-reserve-status.approved {
            background-color: #4caf50;
            color: white;
        }

        .pt-reserve-status.rejected {
            background-color: #fa5546;
            color: white;
        }

        /* Trainer List Modal */
        .trainer-list {
            display: flex;
            flex-direction: column;
            gap: 12px;
            max-height: 400px;
            overflow-y: auto;
        }

        .trainer-item {
            background-color: #2d1810;
            border: 2px solid #ff6b00;
            border-radius: 8px;
            padding: 14px;
            cursor: pointer;
            transition: all 0.3s;
        }

        .trainer-item:hover {
            background-color: #3a2a1f;
            box-shadow: 0 0 8px rgba(255, 107, 0, 0.3);
        }

        .trainer-item.selected {
            background-color: #ff6b00;
            border-color: #ff8533;
        }

        .trainer-name {
            font-size: 14px;
            color: white;
            font-weight: 700;
        }

        /* Inventory Items */
        .inventory-list {
            display: flex;
            flex-direction: column;
            gap: 16px;
        }

        .inventory-item {
            display: flex;
            flex-direction: column;
            gap: 8px;
        }

        .inventory-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .inventory-name {
            font-size: 14px;
            color: white;
        }

        .inventory-count {
            font-size: 14px;
        }

        .progress-bar {
            background-color: #2d1810;
            height: 8px;
            border: 2px solid #ff6b00;
            border-radius: 8px;
            overflow: hidden;
        }

        .progress-fill {
            height: 4px;
            margin: 2px;
            box-shadow: 0 0 8px rgba(255, 107, 0, 0.5);
            transition: width 0.3s;
        }

        .progress-fill.high {
            background-color: #ff6b00;
        }

        .progress-fill.medium {
            background-color: #fdc700;
        }

        .progress-fill.low {
            background-color: #fa5546;
        }

        .inventory-count.high {
            color: white;
        }

        .inventory-count.medium {
            color: #fdc700;
        }

        .inventory-count.low {
            color: #fa5546;
        }

        /* Locker Status - 시설 관리 페이지와 동일한 디자인 */
        .locker-status {
            display: flex;
            flex-direction: column;
            gap: 12px;
        }

        .status-item {
            background-color: #2d1810;
            border: 2px solid #ff6b00;
            border-radius: 8px;
            padding: 16px;
            box-shadow: 0 0 8px rgba(255, 107, 0, 0.2);
            text-align: center;
        }

        .status-label {
            font-size: 12px;
            color: #b0b0b0;
            margin-bottom: 8px;
        }

        .status-value {
            font-size: 24px;
            color: white;
            font-weight: 600;
        }

        .status-sub-grid {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 12px;
        }

        .status-value.used {
            color: #00c950; /* Green, matching occupied locker-item border */
        }

        .status-value.expiring {
            color: #fdc700;
        }

        .status-value.available {
            color: #b0b0b0; /* Grey, matching other labels */
        }

        .status-value.expired {
            color: #f44336;
        }

        .status-value.broken {
            color: #9e9e9e;
        }

        /* 반응형 */
        @media (max-width: 768px) {
            .main-content {
                width: 100% !important;
                margin-left: 0 !important;
            }
        }
    </style>
</head>
<body>
<div class="app-container">
    <!-- Sidebar Include -->
    <jsp:include page="../common/sidebar/sidebarGym.jsp" />

    <!-- Main Content Area -->
    <div class="main-content">
        <div class="page-intro">
            <h1>헬스장 대시보드</h1>
            <p>헬스장의 전체 현황을 한눈에 확인하세요</p>
        </div>
        <div class="dashboard-container">
            <!-- Top Stats Cards -->
            <div class="stats-grid">
                <!-- 이번 달 매출 -->
                <div class="stat-card">
                    <div class="stat-icon">
                        <img src="${pageContext.request.contextPath}/resources/images/icon/money.png" alt="매출" style="width: 24px; height: 24px;">
                    </div>
                    <div class="stat-info">
                        <div class="stat-label">이번 달 매출</div>
                        <div class="stat-value" id="totalSalesValue">
                            <c:choose>
                                <c:when test="${not empty totalSales}">
                                    <fmt:formatNumber value="${totalSales}" pattern="#,###" />원
                                </c:when>
                                <c:otherwise>0원</c:otherwise>
                            </c:choose>
                        </div>
                        <div class="stat-change positive">${month}월 매출</div>
                    </div>
                </div>

                <!-- 전체 회원 -->
                <div class="stat-card">
                    <div class="stat-icon">
                        <img src="${pageContext.request.contextPath}/resources/images/icon/people.png" alt="회원" style="width: 24px; height: 24px;">
                    </div>
                    <div class="stat-info">
                        <div class="stat-label">전체 회원</div>
                        <div class="stat-value" id="totalMembersValue">
                            <c:choose>
                                <c:when test="${not empty totalMembers}">
                                    <fmt:formatNumber value="${totalMembers}" pattern="#,###" />명
                                </c:when>
                                <c:otherwise>0명</c:otherwise>
                            </c:choose>
                        </div>
                        <div class="stat-change negative">
                            신규 <c:choose><c:when test="${not empty newMembers}"><fmt:formatNumber value="${newMembers}" pattern="#,###" /></c:when><c:otherwise>0</c:otherwise></c:choose>명
                        </div>
                    </div>
                </div>

                <!-- 오늘 출석 -->
                <div class="stat-card">
                    <div class="stat-icon">
                        <img src="${pageContext.request.contextPath}/resources/images/icon/done.png" alt="출석" style="width: 24px; height: 24px;">
                    </div>
                    <div class="stat-info">
                        <div class="stat-label">오늘 출석</div>
                        <div class="stat-value" id="todayAttendanceValue">
                            <c:choose>
                                <c:when test="${not empty todayAttendance}">
                                    <fmt:formatNumber value="${todayAttendance}" pattern="#,###" />명
                                </c:when>
                                <c:otherwise>0명</c:otherwise>
                            </c:choose>
                        </div>
                        <div class="stat-label">현재 헬스장 이용 중</div>
                    </div>
                </div>

                <!-- 만료 예정 -->
                <div class="stat-card">
                    <div class="stat-icon">
                        <img src="${pageContext.request.contextPath}/resources/images/icon/expiration.png" alt="만료 예정" style="width: 24px; height: 24px;">
                    </div>
                    <div class="stat-info">
                        <div class="stat-label">만료 예정</div>
                        <div class="stat-value" id="expiringMembersValue">
                            <c:choose>
                                <c:when test="${not empty expiringMembers}">
                                    <fmt:formatNumber value="${expiringMembers}" pattern="#,###" />명
                                </c:when>
                                <c:otherwise>0명</c:otherwise>
                            </c:choose>
                        </div>
                        <div class="stat-label">7일 이내 만료</div>
                    </div>
                </div>
            </div>

            <!-- Monthly Stats Section -->
            <div class="monthly-stats">
                <div class="section-header">
                    <div class="section-title">최근 5개월 회원수 통계</div>
                    <div class="section-subtitle">월별 회원수 현황</div>
                </div>
                <div class="monthly-grid">
                    <c:choose>
                        <c:when test="${not empty monthlyStats}">
                            <c:forEach var="stat" items="${monthlyStats}" varStatus="status">
                                <div class="monthly-card">
                                    <div class="stat-icon">
                                        <img src="${pageContext.request.contextPath}/resources/images/icon/people.png" alt="통계" style="width: 24px; height: 24px;">
                                    </div>
                                    <div class="stat-info">
                                        <div class="stat-label">${stat.month}월 회원수</div>
                                        <div class="stat-value">
                                            <fmt:formatNumber value="${stat.memberCount}" pattern="#,###" />명
                                        </div>
                                        <div class="monthly-added">등록 <fmt:formatNumber value="${stat.newCount}" pattern="#,###" />명</div>
                                        <div class="monthly-removed">만료 <fmt:formatNumber value="${stat.expiredCount}" pattern="#,###" />명</div>
                                    </div>
                                </div>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <!-- 데이터가 없을 때 기본 표시 -->
                            <c:forEach var="i" begin="1" end="5">
                                <div class="monthly-card">
                                    <div class="stat-icon">
                                        <img src="${pageContext.request.contextPath}/resources/images/icon/people.png" alt="통계" style="width: 24px; height: 24px;">
                                    </div>
                                    <div class="stat-info">
                                        <div class="stat-label">-</div>
                                        <div class="stat-value">0명</div>
                                        <div class="monthly-added">등록 0명</div>
                                        <div class="monthly-removed">만료 0명</div>
                                    </div>
                                </div>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>

            <!-- Bottom Grid - 3 Columns -->
            <div class="bottom-grid">
                <!-- 예약 상담 -->
                <div class="card">
                    <div class="card-header">
                        <div class="card-title">오늘의 예약 상담</div>
                        <div class="badge">
                            <div class="badge-text">
                                <c:choose>
                                    <c:when test="${not empty reservationList}">
                                        ${reservationList.size()}건
                                    </c:when>
                                    <c:otherwise>0건</c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                    </div>
                    <div class="reservation-list">
                        <c:choose>
                            <c:when test="${not empty reservationList}">
                                <c:forEach var="reservation" items="${reservationList}">
                                    <div class="reservation-item">
                                        <div class="reservation-header-info">
                                            <div class="reservation-name">${reservation.memberName}</div>
                                            <c:if test="${not empty reservation.inquiryStatus}">
                                                <div class="reservation-status ${reservation.inquiryStatus == '완료' ? 'status-completed' : reservation.inquiryStatus == '승인됨' ? 'status-approved' : 'status-pending'}">
                                                    ${reservation.inquiryStatus}
                                                </div>
                                            </c:if>
                                        </div>
                                        <div class="reservation-details">
                                            <div class="reservation-time">
                                                <img src="${pageContext.request.contextPath}/resources/images/icon/calendar.png" alt="날짜" style="width: 14px; height: 14px; margin-right: 4px;">
                                                <c:choose>
                                                    <c:when test="${not empty reservation.visitDatetime}">
                                                        <fmt:formatDate value="${reservation.visitDatetime}" pattern="MM월 dd일 HH:mm" />
                                                    </c:when>
                                                    <c:otherwise>-</c:otherwise>
                                                </c:choose>
                                            </div>
                                            <c:if test="${not empty reservation.memberPhone}">
                                                <div class="reservation-phone">
                                                    <img src="${pageContext.request.contextPath}/resources/images/icon/call.png" alt="전화" style="width: 14px; height: 14px; margin-right: 4px;">
                                                    ${reservation.memberPhone}
                                                </div>
                                            </c:if>
                                        </div>
                                    </div>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <div style="text-align: center; padding: 20px; color: #b0b0b0;">
                                    문의 예약 현황이 없습니다.
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>

                <!-- 재고 현황 -->
                <div class="card">
                    <div class="card-header">
                        <div class="card-title">재고 현황</div>
                    </div>
                    <div class="inventory-list">
                        <c:choose>
                            <c:when test="${not empty stockList}">
                                <c:forEach var="stock" items="${stockList}">
                                    <c:set var="percentage" value="${stock.targetStockCount > 0 ? (stock.stockCount * 100 / stock.targetStockCount) : 0}" />
                                    <c:set var="finalPercentage" value="${percentage > 100 ? 100 : percentage}" />
                                    <c:choose>
                                        <c:when test="${finalPercentage >= 75}">
                                            <c:set var="progressClass" value="high" />
                                            <c:set var="countClass" value="high" />
                                        </c:when>
                                        <c:when test="${finalPercentage >= 50}">
                                            <c:set var="progressClass" value="medium" />
                                            <c:set var="countClass" value="medium" />
                                        </c:when>
                                        <c:otherwise>
                                            <c:set var="progressClass" value="low" />
                                            <c:set var="countClass" value="low" />
                                        </c:otherwise>
                                    </c:choose>
                                    <div class="inventory-item">
                                        <div class="inventory-header">
                                            <div class="inventory-name">${stock.stockName}</div>
                                            <div class="inventory-count ${countClass}">
                                                <fmt:formatNumber value="${stock.stockCount}" pattern="#,###" /> / <fmt:formatNumber value="${stock.targetStockCount}" pattern="#,###" />개
                                            </div>
                                        </div>
                                        <div class="progress-bar">
                                            <div class="progress-fill ${progressClass}" style="width: ${finalPercentage}%;"></div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <div style="text-align: center; padding: 20px; color: #b0b0b0;">
                                    등록된 재고가 없습니다.
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>

                <!-- 락커 현황 -->
                <div class="card">
                    <div class="card-header">
                        <div class="card-title">락커 현황</div>
                    </div>
                    <div class="locker-status">
                        <div class="status-item">
                            <div class="status-label">전체 락커</div>
                            <div class="status-value">
                                <c:choose>
                                    <c:when test="${not empty totalLockers}">
                                        <fmt:formatNumber value="${totalLockers}" pattern="#,###" />개
                                    </c:when>
                                    <c:otherwise>0개</c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                        <div class="status-sub-grid">
                            <div class="status-item">
                                <div class="status-label">사용중</div>
                                <div class="status-value used">
                                    <c:choose>
                                        <c:when test="${not empty usedLockers}">
                                            <fmt:formatNumber value="${usedLockers}" pattern="#,###" />개
                                        </c:when>
                                        <c:otherwise>0개</c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                            <div class="status-item">
                                <div class="status-label">만료예정</div>
                                <div class="status-value expiring">
                                    <c:choose>
                                        <c:when test="${not empty expiringLockers}">
                                            <fmt:formatNumber value="${expiringLockers}" pattern="#,###" />개
                                        </c:when>
                                        <c:otherwise>0개</c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                            <div class="status-item">
                                <div class="status-label">만료</div>
                                <div class="status-value expired">
                                    <c:choose>
                                        <c:when test="${not empty expiredLockers}">
                                            <fmt:formatNumber value="${expiredLockers}" pattern="#,###" />개
                                        </c:when>
                                        <c:otherwise>0개</c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                            <div class="status-item">
                                <div class="status-label">고장</div>
                                <div class="status-value broken">
                                    <c:choose>
                                        <c:when test="${not empty brokenLockers}">
                                            <fmt:formatNumber value="${brokenLockers}" pattern="#,###" />개
                                        </c:when>
                                        <c:otherwise>0개</c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                        </div>
                        <div class="status-item">
                            <div class="status-label">사용 가능한 락커 수</div>
                            <div class="status-value available">
                                <c:choose>
                                    <c:when test="${not empty availableLockers}">
                                        <fmt:formatNumber value="${availableLockers}" pattern="#,###" />개
                                    </c:when>
                                    <c:otherwise>0개</c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    // 숫자 애니메이션 효과
    function animateValue(element, start, end, duration, suffix) {
        let startTimestamp = null;
        const step = (timestamp) => {
            if (!startTimestamp) startTimestamp = timestamp;
            const progress = Math.min((timestamp - startTimestamp) / duration, 1);
            const value = Math.floor(progress * (end - start) + start);
            
            // 숫자 포맷팅 (천 단위 구분)
            const formattedValue = value.toLocaleString() + suffix;
            element.textContent = formattedValue;
            
            if (progress < 1) {
                window.requestAnimationFrame(step);
            }
        };
        window.requestAnimationFrame(step);
    }

    // 페이지 로드 시 모든 애니메이션 실행
    window.addEventListener('load', function() {
        // 프로그레스 바 애니메이션 (재고 현황)
        const progressBars = document.querySelectorAll('.inventory-list .progress-fill');
        for (var i = 0; i < progressBars.length; i++) {
            var bar = progressBars[i];
            var width = bar.style.width;
            bar.style.width = '0%';
            setTimeout(function(barElement, targetWidth) {
                return function() {
                    barElement.style.width = targetWidth;
                };
            }(bar, width), 100 + (i * 50));
        }

        // 상단 통계 카드의 stat-value들
        const statValues = document.querySelectorAll('.stats-grid .stat-value');
        statValues.forEach((element) => {
            const originalText = element.textContent;
            const match = originalText.match(/([\d,]+)(원|명|개)/);
            
            if (match) {
                const value = parseInt(match[1].replace(/,/g, ''));
                const suffix = match[2];
                animateValue(element, 0, value, 1500, suffix);
            }
        });

        // 월별 통계의 stat-value들
        const monthlyValues = document.querySelectorAll('.monthly-grid .stat-value');
        monthlyValues.forEach((element) => {
            const originalText = element.textContent;
            const match = originalText.match(/([\d,]+)(원|명|개)/);
            
            if (match) {
                const value = parseInt(match[1].replace(/,/g, ''));
                const suffix = match[2];
                animateValue(element, 0, value, 1500, suffix);
            }
        });

        // 락커 현황의 status-value들
        const lockerValues = document.querySelectorAll('.locker-status .status-value');
        lockerValues.forEach((element) => {
            const originalText = element.textContent;
            const match = originalText.match(/([\d,]+)(원|명|개)/);
            
            if (match) {
                const value = parseInt(match[1].replace(/,/g, ''));
                const suffix = match[2];
                animateValue(element, 0, value, 1500, suffix);
            }
        });
    });
</script>
</body>
</html>
