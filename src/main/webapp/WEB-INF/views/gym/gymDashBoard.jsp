<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>GymHub - 대시보드</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common.css">
    <style>
        /* main-content 가로로 가득 차게 - !important로 common.css 오버라이드 */
        .main-content {
            width: calc(100% - 255px) !important;
            margin-left: 255px !important;
            padding: 24px 24px 24px 24px !important;
            margin-right: 0 !important;
        }

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
            font-size: 24px;
        }

        .stat-info {
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

        .stat-change.negative {
            color: #ff6467;
        }

        /* Monthly Stats Section */
        .monthly-stats {
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
        }

        .reservation-item {
            background-color: #2d1810;
            border: 2px solid #ff6b00;
            border-radius: 8px;
            padding: 14px;
            box-shadow: 0 0 8px rgba(255, 107, 0, 0.2);
        }

        .reservation-name {
            font-size: 14px;
            color: white;
            font-weight: 700;
            margin-bottom: 8px;
        }

        .reservation-time {
            font-size: 12px;
            color: #b0b0b0;
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

        /* Locker Status */
        .locker-grid {
            display: flex;
            flex-direction: column;
            gap: 10px;
        }

        .locker-card {
            background-color: #2d1810;
            border: 2px solid #ff6b00;
            border-radius: 8px;
            padding: 14px;
            box-shadow: 0 0 8px rgba(255, 107, 0, 0.2);
            text-align: center;
        }

        .locker-label {
            font-size: 12px;
            color: #b0b0b0;
            margin-bottom: 4px;
        }

        .locker-value {
            font-size: 20px;
        }

        .locker-split {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 10px;
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
                        <div class="stat-value">17,200,000원</div>
                        <div class="stat-change positive">+4.2%</div>
                    </div>
                </div>

                <!-- 전체 회원 -->
                <div class="stat-card">
                    <div class="stat-icon">
                        <img src="${pageContext.request.contextPath}/resources/images/icon/people.png" alt="회원" style="width: 24px; height: 24px;">
                    </div>
                    <div class="stat-info">
                        <div class="stat-label">전체 회원</div>
                        <div class="stat-value">205명</div>
                        <div class="stat-change negative">신규 13명</div>
                    </div>
                </div>

                <!-- 오늘 출석 -->
                <div class="stat-card">
                    <div class="stat-icon">
                        <img src="${pageContext.request.contextPath}/resources/images/icon/done.png" alt="출석" style="width: 24px; height: 24px;">
                    </div>
                    <div class="stat-info">
                        <div class="stat-label">오늘 출석</div>
                        <div class="stat-value">156명</div>
                        <div class="stat-label">평균 출석률 76%</div>
                    </div>
                </div>

                <!-- 만료 예정 -->
                <div class="stat-card">
                    <div class="stat-icon">
                        <img src="${pageContext.request.contextPath}/resources/images/icon/expiration.png" alt="만료 예정" style="width: 24px; height: 24px;">
                    </div>
                    <div class="stat-info">
                        <div class="stat-label">만료 예정</div>
                        <div class="stat-value">25명</div>
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
                    <!-- 1월 -->
                    <div class="monthly-card">
                        <div class="stat-icon">
                            <img src="${pageContext.request.contextPath}/resources/images/icon/people.png" alt="통계" style="width: 24px; height: 24px;">
                        </div>
                        <div class="stat-info">
                            <div class="stat-label">1월 회원수</div>
                            <div class="stat-value">205명</div>
                            <div class="stat-change positive">등록 13명</div>
                            <div class="monthly-removed">탈퇴 2명</div>
                        </div>
                    </div>

                    <!-- 2월 -->
                    <div class="monthly-card">
                        <div class="stat-icon">
                            <img src="${pageContext.request.contextPath}/resources/images/icon/breakdown.png" alt="통계" style="width: 24px; height: 24px;">
                        </div>
                        <div class="stat-info">
                            <div class="stat-label">2월 회원수</div>
                            <div class="stat-value">210명</div>
                            <div class="stat-change positive">등록 5명</div>
                            <div class="monthly-removed">탈퇴 0명</div>
                        </div>
                    </div>

                    <!-- 3월 -->
                    <div class="monthly-card">
                        <div class="stat-icon">
                            <img src="${pageContext.request.contextPath}/resources/images/icon/breakdown.png" alt="통계" style="width: 24px; height: 24px;">
                        </div>
                        <div class="stat-info">
                            <div class="stat-label">3월 회원수</div>
                            <div class="stat-value">211명</div>
                            <div class="stat-change positive">등록 3명</div>
                            <div class="monthly-removed">탈퇴 2명</div>
                        </div>
                    </div>

                    <!-- 4월 -->
                    <div class="monthly-card">
                        <div class="stat-icon">
                            <img src="${pageContext.request.contextPath}/resources/images/icon/breakdown.png" alt="통계" style="width: 24px; height: 24px;">
                        </div>
                        <div class="stat-info">
                            <div class="stat-label">4월 회원수</div>
                            <div class="stat-value">212명</div>
                            <div class="stat-change positive">등록 10명</div>
                            <div class="monthly-removed">탈퇴 1명</div>
                        </div>
                    </div>

                    <!-- 5월 -->
                    <div class="monthly-card">
                        <div class="stat-icon">
                            <img src="${pageContext.request.contextPath}/resources/images/icon/breakdown.png" alt="통계" style="width: 24px; height: 24px;">
                        </div>
                        <div class="stat-info">
                            <div class="stat-label">5월 회원수</div>
                            <div class="stat-value">210명</div>
                            <div class="stat-change positive">등록 4명</div>
                            <div class="monthly-removed">탈퇴 2명</div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Bottom Grid - 3 Columns -->
            <div class="bottom-grid">
                <!-- 예약 상담 -->
                <div class="card">
                    <div class="card-header">
                        <div class="card-title">예약 상담</div>
                        <div class="badge">
                            <div class="badge-text">5건</div>
                        </div>
                    </div>
                    <div class="reservation-list">
                        <div class="reservation-item">
                            <div class="reservation-name">홍길지</div>
                            <div class="reservation-time">10월 29일 15:00</div>
                        </div>
                        <div class="reservation-item">
                            <div class="reservation-name">김민현</div>
                            <div class="reservation-time">10월 30일 10:00</div>
                        </div>
                        <div class="reservation-item">
                            <div class="reservation-name">박서준</div>
                            <div class="reservation-time">10월 31일 14:00</div>
                        </div>
                    </div>
                </div>

                <!-- 재고 관리 -->
                <div class="card">
                    <div class="card-header">
                        <div class="card-title">재고 관리</div>
                    </div>
                    <div class="inventory-list">
                        <div class="inventory-item">
                            <div class="inventory-header">
                                <div class="inventory-name">수건</div>
                                <div class="inventory-count" style="color: white;">150 / 200개</div>
                            </div>
                            <div class="progress-bar">
                                <div class="progress-fill" style="width: 75%; background-color: #ff6b00;"></div>
                            </div>
                        </div>
                        <div class="inventory-item">
                            <div class="inventory-header">
                                <div class="inventory-name">운동복</div>
                                <div class="inventory-count" style="color: #fdc700;">35 / 100개</div>
                            </div>
                            <div class="progress-bar">
                                <div class="progress-fill" style="width: 35%; background-color: #fdc700;"></div>
                            </div>
                        </div>
                        <div class="inventory-item">
                            <div class="inventory-header">
                                <div class="inventory-name">물수건</div>
                                <div class="inventory-count" style="color: white;">120 / 200개</div>
                            </div>
                            <div class="progress-bar">
                                <div class="progress-fill" style="width: 60%; background-color: #ff6b00;"></div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- 락커 현황 -->
                <div class="card">
                    <div class="card-header">
                        <div class="card-title">락커 현황</div>
                    </div>
                    <div class="locker-grid">
                        <div class="locker-card">
                            <div class="locker-label">전체 락커</div>
                            <div class="locker-value" style="color: white;">30개</div>
                        </div>
                        <div class="locker-split">
                            <div class="locker-card">
                                <div class="locker-label">사용중</div>
                                <div class="locker-value" style="color: #fa5546;">17개</div>
                            </div>
                            <div class="locker-card">
                                <div class="locker-label">만료예정</div>
                                <div class="locker-value" style="color: #fdc700;">6개</div>
                            </div>
                        </div>
                        <div class="locker-card">
                            <div class="locker-label">사용 가능한 락커 수</div>
                            <div class="locker-value" style="color: #05df72;">13개</div>
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
        // 프로그레스 바 애니메이션
        const progressBars = document.querySelectorAll('.progress-fill');
        progressBars.forEach(bar => {
            const width = bar.style.width;
            bar.style.width = '0%';
            setTimeout(() => {
                bar.style.width = width;
            }, 100);
        });

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

        // 락커 현황의 locker-value들
        const lockerValues = document.querySelectorAll('.locker-value');
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
