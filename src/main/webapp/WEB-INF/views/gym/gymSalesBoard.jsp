<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>GymHub - 매출 현황</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common.css">
    <style>
        /* main-content 가로로 가득 차게 - !important로 common.css 오버라이드 */
        .main-content {
            width: calc(100% - 255px) !important;
            margin-left: 255px !important;
            padding: 24px 24px 24px 24px !important;
            margin-right: 0 !important;
        }

        /* 매출 현황 페이지 전용 스타일 */

        /* Dashboard Container */
        .dashboard-container {
            display: flex;
            flex-direction: column;
            gap: 24px;
        }

        /* Top Stats - 2 Columns */
        .top-stats {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 24px;
        }

        /* Stat Card */
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
            transform: translateY(-3px);
        }

        .stat-icon {
            width: 60px;
            height: 60px;
            background-color: #2d1810;
            border: 2px solid #ff6b00;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(255, 107, 0, 0.3);
            display: flex;
            align-items: center;
            justify-content: center;
            flex-shrink: 0;
        }

        .stat-info {
            flex: 1;
            display: flex;
            flex-direction: column;
            gap: 4px;
        }

        .stat-label {
            font-size: 14px;
            color: #b0b0b0;
        }

        .stat-value {
            font-size: 24px;
            color: white;
        }

        .stat-change {
            font-size: 14px;
        }

        .stat-change.positive {
            color: #05df72;
        }

        /* Details Section */
        .details-section {
            background-color: #2d1810;
            border: 2px solid #ff6b00;
            border-radius: 8px;
            padding: 26px;
            box-shadow: 0 0 15px rgba(255, 107, 0, 0.3);
        }

        .section-header {
            padding-bottom: 16px;
            border-bottom: 2px solid #ff6b00;
            margin-bottom: 24px;
        }

        .section-title {
            font-size: 18px;
            color: #ff6b00;
            margin-bottom: 4px;
        }

        .section-subtitle {
            font-size: 12px;
            color: #b0b0b0;
        }

        /* Detail Items */
        .detail-list {
            display: flex;
            flex-direction: column;
            gap: 16px;
        }

        .detail-item {
            background-color: #2d1810;
            border: 2px solid #ff6b00;
            border-radius: 8px;
            padding: 18px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            transition: transform 0.3s;
        }

        .detail-item:hover {
            transform: translateY(-3px);
        }

        .detail-item.total {
            border-width: 2px;
        }

        .detail-left {
            display: flex;
            flex-direction: column;
            gap: 4px;
        }

        .detail-name {
            font-size: 14px;
            color: #b0b0b0;
        }

        .detail-name.total {
            color: #ff6b00;
        }

        .detail-amount {
            font-size: 20px;
            color: white;
        }

        .detail-amount.total {
            font-size: 24px;
        }

        .detail-right {
            display: flex;
            align-items: center;
            gap: 4px;
        }

        .trend-icon {
            width: 16px;
            height: 16px;
        }

        .trend-icon.large {
            width: 20px;
            height: 20px;
        }

        .trend-text {
            font-size: 14px;
        }

        .trend-text.positive {
            color: #05df72;
        }

        .trend-text.negative {
            color: #ff6467;
        }

        .trend-text.large {
            font-size: 16px;
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
            <h1>매출 현황</h1>
            <p>헬스장의 매출 통계를 확인하세요</p>
        </div>
        <div class="dashboard-container">
            <!-- Top Stats Cards -->
            <div class="top-stats">
                <!-- 이번 달 총매출 -->
                <div class="stat-card">
                    <div class="stat-icon">
                        <img src="${pageContext.request.contextPath}/resources/images/icon/money.png" alt="매출" style="width: 24px; height: 24px;">
                    </div>
                    <div class="stat-info">
                        <div class="stat-label">이번 달 총매출</div>
                        <div class="stat-value"><fmt:formatNumber value="${totalSales}" pattern="#,###"/>원</div>
                    </div>
                </div>

                <!-- 전체 회원 -->
                <div class="stat-card">
                    <div class="stat-icon">
                        <img src="${pageContext.request.contextPath}/resources/images/icon/people.png" alt="회원" style="width: 24px; height: 24px;">
                    </div>
                    <div class="stat-info">
                        <div class="stat-label">전체 회원</div>
                        <div class="stat-value"><fmt:formatNumber value="${totalMembers}" pattern="#,###"/>명</div>
                    </div>
                </div>
            </div>

            <!-- 매출 상세 영역 -->
            <div class="details-section">
                <div class="section-header">
                    <div class="section-title">매출 상세 영역</div>
                    <div class="section-subtitle">이번달 매출 구성</div>
                </div>

                <div class="detail-list">
                    <!-- 회원권 매출 -->
                    <div class="detail-item">
                        <div class="detail-left">
                            <div class="detail-name">회원권 매출</div>
                            <div class="detail-amount"><fmt:formatNumber value="${membershipSales}" pattern="#,###"/>원</div>
                        </div>
                    </div>

                    <!-- 물품 판매 -->
                    <div class="detail-item">
                        <div class="detail-left">
                            <div class="detail-name">물품 판매</div>
                            <div class="detail-amount"><fmt:formatNumber value="${stockSales}" pattern="#,###"/>원</div>
                        </div>
                    </div>

                    <!-- 총 매출 -->
                    <div class="detail-item total">
                        <div class="detail-left">
                            <div class="detail-name total">총 매출</div>
                            <div class="detail-amount total"><fmt:formatNumber value="${totalSales}" pattern="#,###"/>원</div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    // 카드 호버 효과
    document.querySelectorAll('.stat-card, .detail-item').forEach(card => {
        card.addEventListener('mouseenter', function() {
            this.style.transform = 'translateY(-3px)';
            this.style.transition = 'transform 0.3s';
        });
        card.addEventListener('mouseleave', function() {
            this.style.transform = 'translateY(0)';
        });
    });

    // 숫자 애니메이션 효과
    function animateValue(element, start, end, duration) {
        let startTimestamp = null;
        const step = (timestamp) => {
            if (!startTimestamp) startTimestamp = timestamp;
            const progress = Math.min((timestamp - startTimestamp) / duration, 1);
            const value = Math.floor(progress * (end - start) + start);
            element.textContent = value.toLocaleString() + '원';
            if (progress < 1) {
                window.requestAnimationFrame(step);
            }
        };
        window.requestAnimationFrame(step);
    }

    // 페이지 로드 시 숫자 애니메이션 실행
    window.addEventListener('load', function() {
        // 서버에서 받은 값들
        const membershipSales = ${membershipSales != null ? membershipSales : 0};
        const stockSales = ${stockSales != null ? stockSales : 0};
        const totalSales = ${totalSales != null ? totalSales : 0};
        
        const amounts = [
            { element: document.querySelectorAll('.stat-value')[0], value: totalSales },
            { element: document.querySelectorAll('.detail-amount')[0], value: membershipSales },
            { element: document.querySelectorAll('.detail-amount')[1], value: stockSales },
            { element: document.querySelectorAll('.detail-amount')[2], value: totalSales }
        ];

        amounts.forEach(item => {
            if (item.element) {
                animateValue(item.element, 0, item.value, 1500);
            }
        });
    });
</script>
</body>
</html>
