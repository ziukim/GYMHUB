<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>GymHub - 공지사항</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common.css">
    <style>
        /* main-content 가로로 가득 차게 */
        .main-content {
            width: calc(100% - 255px) !important;
            margin-left: 255px !important;
            padding: 24px !important;
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
        /* 고정 아이콘 */
        .pin-button {
            background: transparent;
            border: none;
            cursor: pointer;
            padding: 4px;
            transition: all 0.3s;
            flex-shrink: 0;
            margin-left: auto;
        }

        .pin-button img {
            width: 20px;
            height: 20px;
            opacity: 0.5;
            transition: all 0.3s;
        }

        .pin-button:hover img {
            opacity: 1;
            transform: scale(1.1);
        }

        .pin-button.pinned img {
            opacity: 1;
        }

        .notice-card.pinned {
            border-color: #ffc107;
            background-color: rgba(255, 193, 7, 0.05);
        }

        .notice-header {
            display: flex;
            align-items: center;
        }
    </style>
</head>
<body>
    <div class="app-container">
        <!-- Sidebar Include -->
        <jsp:include page="../common/sidebar/sidebarGym.jsp" />

        <!-- Main Content -->
        <div class="main-content">
            <!-- Header -->
            <div class="page-intro">
                <h1>공지사항</h1>
                <p>헬스장의 최신 소식을 확인하세요</p>
            </div>
            <div class="page-header" style="display: flex; justify-content: flex-end; margin-bottom: 24px;">
                <button class="add-button" onclick="location.href='${pageContext.request.contextPath}/noticeEnrollForm.no'">
                    <img src="${pageContext.request.contextPath}/resources/images/icon/add.png" alt="추가" style="width: 16px; height: 16px; vertical-align: middle; margin-right: 4px;"> 공지사항 작성
                </button>
            </div>

            <!-- Search Section -->
            <div class="search-section">
                <input type="text" class="search-bar" placeholder="공지사항 검색..." id="searchInput">
            </div>

            <!-- Notice List -->
            <div class="notice-section">
                <c:choose>
                    <c:when test="${not empty notices and notices.size() > 0}">
                        <div class="notice-list" id="noticeList">
                            <c:forEach var="notice" items="${notices}">
                                <c:set var="categoryClass" value="general" />
                                <c:set var="categoryLabel" value="일반" />
                                <c:choose>
                                    <c:when test="${notice.noticeCategory == 'urgent' or notice.noticeCategory == '긴급'}">
                                        <c:set var="categoryClass" value="urgent" />
                                        <c:set var="categoryLabel" value="긴급" />
                                    </c:when>
                                    <c:when test="${notice.noticeCategory == 'event' or notice.noticeCategory == '이벤트'}">
                                        <c:set var="categoryClass" value="event" />
                                        <c:set var="categoryLabel" value="이벤트" />
                                    </c:when>
                                    <c:when test="${notice.noticeCategory == 'important' or notice.noticeCategory == '중요'}">
                                        <c:set var="categoryClass" value="important" />
                                        <c:set var="categoryLabel" value="중요" />
                                    </c:when>
                                    <c:otherwise>
                                        <c:set var="categoryClass" value="general" />
                                        <c:set var="categoryLabel" value="일반" />
                                    </c:otherwise>
                                </c:choose>
                                
                                <div class="notice-card <c:if test='${notice.noticeFixStatus == \"Y\"}'>pinned</c:if>" 
                                     onclick="location.href='${pageContext.request.contextPath}/noticeDetail.no?id=${notice.noticeNo}'"
                                     data-notice-id="${notice.noticeNo}">
                                    <div class="notice-header">
                                        <span class="notice-badge ${categoryClass}">${categoryLabel}</span>
                                        <div class="notice-title">${notice.noticeTitle}</div>
                                    </div>
                                    <div class="notice-content">${notice.noticeContent}</div>
                                    <div class="notice-meta">
                                        <div class="notice-meta-item">
                                            <img src="${pageContext.request.contextPath}/resources/images/icon/person.png" alt="작성자" class="notice-icon" style="width: 16px; height: 16px;">
                                            <span>${notice.noticeWriter}</span>
                                        </div>
                                        <div class="notice-meta-item">
                                            <img src="${pageContext.request.contextPath}/resources/images/icon/calendar.png" alt="날짜" class="notice-icon" style="width: 16px; height: 16px;">
                                            <span><fmt:formatDate value="${notice.noticeDate}" pattern="yyyy-MM-dd" /></span>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <!-- Empty State -->
                        <div class="empty-state active" id="emptyState">
                            <div class="empty-icon">
                                <img src="${pageContext.request.contextPath}/resources/images/icon/output.png" alt="공지사항 없음" style="width: 48px; height: 48px;">
                            </div>
                            <h3>공지사항이 없습니다</h3>
                            <p>등록된 공지사항이 없습니다</p>
                        </div>
                    </c:otherwise>
                </c:choose>

                <!-- Empty State for Search -->
                <div class="empty-state" id="searchEmptyState">
                    <div class="empty-icon">
                        <img src="${pageContext.request.contextPath}/resources/images/icon/output.png" alt="검색" style="width: 48px; height: 48px;">
                    </div>
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
            const searchEmptyState = document.getElementById('searchEmptyState');
            const noticeList = document.getElementById('noticeList');
            let hasVisibleCard = false;

            noticeCards.forEach(function(card) {
                const title = card.querySelector('.notice-title').textContent.toLowerCase();
                const content = card.querySelector('.notice-content').textContent.toLowerCase();
                const author = card.querySelector('.notice-meta-item span').textContent.toLowerCase();
                
                if (title.includes(searchTerm) || content.includes(searchTerm) || author.includes(searchTerm)) {
                    card.style.display = 'block';
                    hasVisibleCard = true;
                } else {
                    card.style.display = 'none';
                }
            });

            // 검색 결과가 없는 경우 empty state 표시
            if (!hasVisibleCard && searchTerm !== '') {
                if (noticeList) noticeList.style.display = 'none';
                searchEmptyState.classList.add('active');
            } else {
                if (noticeList) noticeList.style.display = 'flex';
                searchEmptyState.classList.remove('active');
            }
        });
        
        // 페이지 로드 시 모든 게시글에 핀 버튼 추가
        window.addEventListener('load', function() {
            const noticeCards = document.querySelectorAll('.notice-card');
            
            if (noticeCards.length === 0) {
                return; // 공지사항이 없으면 실행하지 않음
            }

            noticeCards.forEach(function(card) {
                const noticeId = card.getAttribute('data-notice-id');
                if (!noticeId) return; // data-notice-id가 없으면 스킵
                
                const header = card.querySelector('.notice-header');
                if (!header) return;

                // 핀 버튼이 없으면 추가
                if (!header.querySelector('.pin-button')) {
                    const pinButton = document.createElement('button');
                    pinButton.className = 'pin-button';
                    
                    // 고정 상태 확인 (서버에서 받은 데이터 기반)
                    const isPinned = card.classList.contains('pinned');
                    const pinIconSrc = isPinned 
                        ? '${pageContext.request.contextPath}/resources/images/icon/onpin.png'
                        : '${pageContext.request.contextPath}/resources/images/icon/pin.png';
                    
                    pinButton.innerHTML = '<img src="' + pinIconSrc + '" alt="고정">';
                    
                    if (isPinned) {
                        pinButton.classList.add('pinned');
                    }
                    
                    pinButton.onclick = function(e) {
                        e.stopPropagation();
                        togglePin(this, noticeId);
                    };
                    header.appendChild(pinButton);
                }
            });

            sortNotices();

            // 카드 진입 애니메이션
            const cards = document.querySelectorAll('.notice-card');
            cards.forEach(function(card, index) {
                card.style.opacity = '0';
                card.style.transform = 'translateY(20px)';
                setTimeout(function() {
                    card.style.transition = 'all 0.5s ease';
                    card.style.opacity = '1';
                    card.style.transform = 'translateY(0)';
                }, index * 100);
            });
        });

        // 고정 토글 함수 (AJAX로 DB 업데이트)
        function togglePin(button, noticeId) {
            const card = button.closest('.notice-card');
            const isPinned = card.classList.contains('pinned');
            const pinImg = button.querySelector('img');

            // AJAX 요청
            fetch('${pageContext.request.contextPath}/notice/toggleFix.ajax', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded',
                },
                body: 'noticeNo=' + noticeId
            })
            .then(function(response) {
                return response.json();
            })
            .then(function(data) {
                if (data.success) {
                    // UI 업데이트
                    if (data.fixStatus === 'Y') {
                        // 고정
                        card.classList.add('pinned');
                        button.classList.add('pinned');
                        pinImg.src = '${pageContext.request.contextPath}/resources/images/icon/onpin.png';
                    } else {
                        // 고정 해제
                        card.classList.remove('pinned');
                        button.classList.remove('pinned');
                        pinImg.src = '${pageContext.request.contextPath}/resources/images/icon/pin.png';
                    }
                    
                    // 정렬 다시 실행
                    sortNotices();
                } else {
                    alert(data.message || '고정 상태 변경에 실패했습니다.');
                }
            })
            .catch(function(error) {
                console.error('Error:', error);
                alert('오류가 발생했습니다.');
            });
        }

        // 공지사항 정렬 (고정된 것이 위로)
        function sortNotices() {
            const noticeList = document.getElementById('noticeList');
            if (!noticeList) return; // noticeList가 없으면 실행하지 않음
            
            const notices = Array.from(noticeList.querySelectorAll('.notice-card'));
            if (notices.length === 0) return;

            notices.sort(function(a, b) {
                const aPinned = a.classList.contains('pinned');
                const bPinned = b.classList.contains('pinned');

                if (aPinned && !bPinned) return -1;
                if (!aPinned && bPinned) return 1;
                return 0;
            });

            notices.forEach(function(notice) {
                noticeList.appendChild(notice);
            });
        }

    </script>
</body>
</html>
