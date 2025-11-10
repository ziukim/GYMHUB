<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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

        /* 페이지 헤더 */
        .page-header {
            margin-bottom: 2rem;
        }

        .page-header h1 {
            font-size: 28px;
            color: #ff6b00;
            margin-bottom: 0.5rem;
        }

        .page-header p {
            font-size: 14px;
            color: #b0b0b0;
        }
    </style>
</head>
<body>
<div class="app-container">
    <!-- Sidebar Include -->
    <jsp:include page="../common/sidebar/sidebarGym.jsp" />

    <!-- Main Content Area -->
    <div class="main-content">
        <div class="page-header">
            <h1>매출 현황</h1>
            <p>헬스장 매출을 확인해보세요</p>
        </div>

        <div class="dashboard-container">
            <!-- Top Stats Cards -->
            <div class="top-stats">
                <!-- 이번 달 총매출 -->
                <div class="stat-card">
                    <div class="stat-icon">
                        <span style="font-size: 24px;">💰</span>
                    </div>
                    <div class="stat-info">
                        <div class="stat-label">이번 달 총매출</div>
                        <div class="stat-value">17,200,000원</div>
                        <div class="stat-change positive">+7.5%</div>
                    </div>
                </div>

                <!-- 전체 회원 -->
                <div class="stat-card">
                    <div class="stat-icon">
                        <span style="font-size: 24px;">👥</span>
                    </div>
                    <div class="stat-info">
                        <div class="stat-label">전체 회원</div>
                        <div class="stat-value">205명</div>
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
                            <div class="detail-amount">17,200,000원</div>
                        </div>
                        <div class="detail-right">
                            <svg class="trend-icon" fill="none" viewBox="0 0 16 16">
                                <path d="M10.6667 4.66667H14.6667V8.66667" stroke="#05DF72" stroke-linecap="round" stroke-linejoin="round" stroke-width="1.33333" />
                                <path d="M14.6667 4.66667L9 10.3333L5.66667 7L1.33333 11.3333" stroke="#05DF72" stroke-linecap="round" stroke-linejoin="round" stroke-width="1.33333" />
                            </svg>
                            <div class="trend-text positive">+7.5%</div>
                        </div>
                    </div>

                    <!-- 물품 판매 -->
                    <div class="detail-item">
                        <div class="detail-left">
                            <div class="detail-name">물품 판매</div>
                            <div class="detail-amount">890,000원</div>
                        </div>
                        <div class="detail-right">
                            <svg class="trend-icon" fill="none" viewBox="0 0 16 16">
                                <path d="M10.6667 11.3333H14.6667V7.33333" stroke="#FF6467" stroke-linecap="round" stroke-linejoin="round" stroke-width="1.33333" />
                                <path d="M14.6667 11.3333L9 5.66667L5.66667 9L1.33333 4.66667" stroke="#FF6467" stroke-linecap="round" stroke-linejoin="round" stroke-width="1.33333" />
                            </svg>
                            <div class="trend-text negative">-2.1%</div>
                        </div>
                    </div>

                    <!-- 총 매출 -->
                    <div class="detail-item total">
                        <div class="detail-left">
                            <div class="detail-name total">총 매출</div>
                            <div class="detail-amount total">20,700,000원</div>
                        </div>
                        <div class="detail-right">
                            <svg class="trend-icon large" fill="none" viewBox="0 0 20 20">
                                <path d="M13.3333 5.83333H18.3333V10.8333" stroke="#05DF72" stroke-linecap="round" stroke-linejoin="round" stroke-width="1.66667" />
                                <path d="M18.3333 5.83333L11.25 12.9167L7.08333 8.75L1.66667 14.1667" stroke="#05DF72" stroke-linecap="round" stroke-linejoin="round" stroke-width="1.66667" />
                            </svg>
                            <div class="trend-text positive large">+6.8%</div>
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
        const amounts = [
            { element: document.querySelectorAll('.stat-value')[0], value: 17200000 },
            { element: document.querySelectorAll('.detail-amount')[0], value: 17200000 },
            { element: document.querySelectorAll('.detail-amount')[1], value: 890000 },
            { element: document.querySelectorAll('.detail-amount')[2], value: 20700000 }
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
