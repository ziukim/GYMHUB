<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>GymHub - 공지사항</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common.css">
    <style>
        .main-content {
            flex: 1;
            width: 100%;
            max-width: 100%;
            padding: 40px 40px 40px 20px;
            margin-left: 0;
        }

        /* Header */
        .page-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 24px;
        }

        .header-left {
            display: flex;
            align-items: center;
            gap: 16px;
        }

        .back-button {
            background: transparent;
            border: none;
            color: #ff6b00;
            font-size: 24px;
            cursor: pointer;
            padding: 8px;
            transition: transform 0.2s;
        }

        .back-button:hover {
            transform: translateX(-3px);
        }

        .page-title-wrapper {
            display: flex;
            flex-direction: column;
        }

        .page-subtitle {
            font-size: 12px;
            color: #b0b0b0;
            margin-top: 4px;
        }

        /* 검색 영역 */
        .search-section {
            margin-bottom: 24px;
        }

        .search-bar {
            width: 100%;
            background-color: #1a0f0a;
            border: 2px solid #ff6b00;
            border-radius: 8px;
            padding: 12px 16px;
            color: white;
            font-size: 14px;
            font-family: 'Noto Sans KR', sans-serif;
            transition: all 0.3s;
        }

        .search-bar:focus {
            outline: none;
            box-shadow: 0 0 15px rgba(255, 107, 0, 0.4);
            border-color: #ff8800;
        }

        .search-bar::placeholder {
            color: #666;
        }

        /* 공지사항 리스트 */
        .notice-section {
            /* 배경 제거 */
        }

        .notice-list {
            display: flex;
            flex-direction: column;
            gap: 16px;
        }

        .notice-card {
            background-color: #1a0f0a;
            border: 2px solid #ff6b00;
            border-radius: 8px;
            padding: 20px;
            transition: all 0.3s;
            cursor: pointer;
        }

        .notice-card:hover {
            background-color: #2d1810;
            box-shadow: 0 0 20px rgba(255, 107, 0, 0.4);
            transform: translateY(-2px);
        }

        .notice-header {
            display: flex;
            align-items: flex-start;
            gap: 12px;
            margin-bottom: 12px;
        }

        .notice-badge {
            padding: 4px 12px;
            border-radius: 8px;
            font-size: 12px;
            font-weight: 600;
            flex-shrink: 0;
        }

        .notice-badge.urgent {
            background-color: rgba(255, 82, 82, 0.2);
            border: 1px solid #ff5252;
            color: #ff5252;
        }

        .notice-badge.event {
            background-color: rgba(255, 107, 0, 0.2);
            border: 1px solid #ff6b00;
            color: #ff6b00;
        }

        .notice-badge.important {
            background-color: rgba(255, 193, 7, 0.2);
            border: 1px solid #ffc107;
            color: #ffc107;
        }

        .notice-badge.general {
            background-color: rgba(176, 176, 176, 0.2);
            border: 1px solid #b0b0b0;
            color: #b0b0b0;
        }

        .notice-title {
            flex: 1;
            font-size: 18px;
            font-weight: 600;
            color: #ffa366;
            line-height: 1.4;
        }

        .notice-content {
            font-size: 14px;
            color: #b0b0b0;
            line-height: 1.6;
            margin-bottom: 16px;
            margin-left: 0;
        }

        .notice-meta {
            display: flex;
            gap: 16px;
            font-size: 12px;
            color: #666;
        }

        .notice-meta-item {
            display: flex;
            align-items: center;
            gap: 6px;
        }

        .notice-icon {
            font-size: 14px;
        }

        /* 빈 상태 */
        .empty-state {
            text-align: center;
            padding: 60px 20px;
            color: #666;
            display: none;
        }

        .empty-state.active {
            display: block;
        }

        .empty-icon {
            font-size: 48px;
            margin-bottom: 16px;
            opacity: 0.5;
        }

        .empty-state h3 {
            font-size: 18px;
            margin-bottom: 8px;
            color: #b0b0b0;
        }

        .empty-state p {
            font-size: 14px;
            color: #666;
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
        <jsp:include page="../common/sidebar/sidebarMember.jsp" />

        <!-- Main Content -->
        <div class="main-content">
            <!-- Header -->
            <div class="page-header">
                <div class="header-left">
                    <button class="back-button" onclick="history.back()">←</button>
                    <div class="page-title-wrapper">
                        <h1 class="page-title">공지사항</h1>
                        <p class="page-subtitle">헬스장의 최신 소식을 확인하세요</p>
                    </div>
                </div>
            </div>

            <!-- Search Section -->
            <div class="search-section">
                <input type="text" class="search-bar" placeholder="공지사항 검색..." id="searchInput">
            </div>

            <!-- Notice List -->
            <div class="notice-section">
                <div class="notice-list" id="noticeList">
                    <!-- 공지사항 예시 데이터 -->
                    <div class="notice-card" onclick="alert('공지사항 상세보기 기능은 추후 구현 예정입니다.')">
                        <div class="notice-header">
                            <span class="notice-badge urgent">긴급</span>
                            <div class="notice-title">연말연시 운영시간 안내</div>
                        </div>
                        <div class="notice-content">12월 31일과 1월 1일은 오전 10시부터 오후 6시까지 운영합니다. 회원 여러분의 양해 부탁드립니다.</div>
                        <div class="notice-meta">
                            <div class="notice-meta-item">
                                <span class="notice-icon">👤</span>
                                <span>관리자 (운영자)</span>
                            </div>
                            <div class="notice-meta-item">
                                <span class="notice-icon">📅</span>
                                <span>2025-10-25</span>
                            </div>
                        </div>
                    </div>

                    <div class="notice-card" onclick="alert('공지사항 상세보기 기능은 추후 구현 예정입니다.')">
                        <div class="notice-header">
                            <span class="notice-badge event">이벤트</span>
                            <div class="notice-title">11월 신규 GX 프로그램 오픈</div>
                        </div>
                        <div class="notice-content">새로운 GX 프로그램이 준비되었습니다!</div>
                        <div class="notice-meta">
                            <div class="notice-meta-item">
                                <span class="notice-icon">👤</span>
                                <span>빅트레이너 (트레이너)</span>
                            </div>
                            <div class="notice-meta-item">
                                <span class="notice-icon">📅</span>
                                <span>2025-10-23</span>
                            </div>
                        </div>
                    </div>

                    <div class="notice-card" onclick="alert('공지사항 상세보기 기능은 추후 구현 예정입니다.')">
                        <div class="notice-header">
                            <span class="notice-badge important">중요</span>
                            <div class="notice-title">시설 점검 안내</div>
                        </div>
                        <div class="notice-content">내일(금)의 오전 2시부터 6시까지 시설 점검이 예정되어 있습니다. 해당 시간에는 이용이 불가합니다.</div>
                        <div class="notice-meta">
                            <div class="notice-meta-item">
                                <span class="notice-icon">👤</span>
                                <span>시설관리 (운영자)</span>
                            </div>
                            <div class="notice-meta-item">
                                <span class="notice-icon">📅</span>
                                <span>2025-10-20</span>
                            </div>
                        </div>
                    </div>

                    <div class="notice-card" onclick="alert('공지사항 상세보기 기능은 추후 구현 예정입니다.')">
                        <div class="notice-header">
                            <span class="notice-badge general">일반</span>
                            <div class="notice-title">신규 운동 기구 입고 완료</div>
                        </div>
                        <div class="notice-content">회원 여러분이 요청하신 최신 스미스머신과 케이블 크로스오버가 입고되었습니다. 2층 프리웨이트존에서 이용하실 수 있습니다.</div>
                        <div class="notice-meta">
                            <div class="notice-meta-item">
                                <span class="notice-icon">👤</span>
                                <span>어트레이너 (트레이너)</span>
                            </div>
                            <div class="notice-meta-item">
                                <span class="notice-icon">📅</span>
                                <span>2025-10-18</span>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Empty State -->
                <div class="empty-state" id="emptyState">
                    <div class="empty-icon">🔍</div>
                    <h3>검색 결과가 없습니다</h3>
                    <p>다른 검색어로 시도해보세요</p>
                </div>
            </div>
        </div>
    </div>

    <script>
        // 검색 기능
        document.getElementById('searchInput').addEventListener('input', function(e) {
            const searchTerm = e.target.value.toLowerCase();
            const noticeCards = document.querySelectorAll('.notice-card');
            const emptyState = document.getElementById('emptyState');
            let hasVisibleCard = false;

            noticeCards.forEach(card => {
                const title = card.querySelector('.notice-title').textContent.toLowerCase();
                const content = card.querySelector('.notice-content').textContent.toLowerCase();
                const author = card.querySelector('.notice-meta-item span:nth-child(2)').textContent.toLowerCase();
                
                if (title.includes(searchTerm) || content.includes(searchTerm) || author.includes(searchTerm)) {
                    card.style.display = 'block';
                    hasVisibleCard = true;
                } else {
                    card.style.display = 'none';
                }
            });

            // 검색 결과가 없는 경우 empty state 표시
            if (!hasVisibleCard && searchTerm !== '') {
                emptyState.classList.add('active');
            } else {
                emptyState.classList.remove('active');
            }
        });

        // 카드 진입 애니메이션
        window.addEventListener('load', function() {
            const cards = document.querySelectorAll('.notice-card');
            cards.forEach((card, index) => {
                card.style.opacity = '0';
                card.style.transform = 'translateY(20px)';
                setTimeout(() => {
                    card.style.transition = 'all 0.5s ease';
                    card.style.opacity = '1';
                    card.style.transform = 'translateY(0)';
                }, index * 100);
            });
        });
    </script>
</body>
</html>
