<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>GymHub - 공지사항 상세</title>
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

        /* Notice Detail Card */
        .notice-detail-card {
            background-color: #2d1810;
            border: 2px solid #ff6b00;
            border-radius: 8px;
            padding: 32px;
            box-shadow: 0 0 15px rgba(255, 107, 0, 0.3);
        }

        /* Notice Header */
        .notice-detail-header {
            margin-bottom: 24px;
            padding-bottom: 24px;
            border-bottom: 2px solid #ff6b00;
        }

        .notice-badge {
            display: inline-block;
            padding: 6px 16px;
            border-radius: 8px;
            font-size: 13px;
            font-weight: 600;
            margin-bottom: 16px;
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

        .notice-detail-title {
            font-size: 28px;
            font-weight: 700;
            color: #ff6b00;
            line-height: 1.4;
            margin-bottom: 20px;
        }

        .notice-meta {
            display: flex;
            gap: 24px;
            font-size: 13px;
            color: #666;
        }

        .notice-meta-item {
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .notice-icon {
            font-size: 16px;
        }

        .notice-meta-item strong {
            color: #ffa366;
        }

        /* Notice Content */
        .notice-content-section {
            background-color: #1a0f0a;
            border: 2px solid #ff6b00;
            border-radius: 8px;
            padding: 32px;
            margin-bottom: 24px;
        }

        .notice-content {
            font-size: 15px;
            color: #b0b0b0;
            line-height: 1.8;
            white-space: pre-wrap;
        }

        /* Action Buttons */
        .action-buttons {
            display: flex;
            justify-content: center;
            gap: 16px;
        }

        /* 반응형 */
        @media (max-width: 768px) {
            .main-content {
                width: 100% !important;
                margin-left: 0 !important;
            }
            
            .notice-detail-card {
                padding: 24px;
            }
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
            <div class="page-header">
                <div class="header-left">
                    <button class="back-button" onclick="history.back()">←</button>
                    <div class="page-title-wrapper">
                        <h1 class="page-title">공지사항</h1>
                        <p class="page-subtitle">공지사항 상세 내용</p>
                    </div>
                </div>
            </div>

            <!-- Notice Detail Card -->
            <div class="notice-detail-card">
                <!-- Notice Header -->
                <div class="notice-detail-header">
                    <span class="notice-badge urgent" id="noticeBadge">긴급</span>
                    <h2 class="notice-detail-title" id="noticeTitle">연말연시 운영시간 안내</h2>
                    <div class="notice-meta">
                        <div class="notice-meta-item">
                            <span class="notice-icon">👤</span>
                            <span><strong id="noticeAuthor">관리자 (운영자)</strong></span>
                        </div>
                        <div class="notice-meta-item">
                            <span class="notice-icon">📅</span>
                            <span id="noticeDate">2025-10-25</span>
                        </div>
                    </div>
                </div>

                <!-- Notice Content -->
                <div class="notice-content-section">
                    <div class="notice-content" id="noticeContent">12월 31일과 1월 1일은 오전 10시부터 오후 6시까지 운영합니다. 회원 여러분의 양해 부탁드립니다.</div>
                </div>

                <!-- Action Buttons -->
                <div class="action-buttons">
                    <button class="btn btn-secondary" onclick="location.href='${pageContext.request.contextPath}/notice.no'">목록으로</button>
                    <button class="btn btn-primary" onclick="editNotice()">수정하기</button>
                </div>
            </div>
        </div>
    </div>

    <script>
        // Sample notice data (in a real app, this would come from database)
        const noticeDataMap = {
            '1': {
                type: 'urgent',
                badge: '긴급',
                title: '연말연시 운영시간 안내',
                content: '12월 31일과 1월 1일은 오전 10시부터 오후 6시까지 운영합니다. 회원 여러분의 양해 부탁드립니다.',
                author: '관리자 (운영자)',
                date: '2025-10-25'
            },
            '2': {
                type: 'event',
                badge: '이벤트',
                title: '11월 신규 GX 프로그램 오픈',
                content: '새로운 GX 프로그램이 준비되었습니다!',
                author: '빅트레이너 (트레이너)',
                date: '2025-10-23'
            },
            '3': {
                type: 'important',
                badge: '중요',
                title: '시설 점검 안내',
                content: '내일(금)의 오전 2시부터 6시까지 시설 점검이 예정되어 있습니다. 해당 시간에는 이용이 불가합니다.',
                author: '시설관리 (운영자)',
                date: '2025-10-20'
            },
            '4': {
                type: 'general',
                badge: '일반',
                title: '신규 운동 기구 입고 완료',
                content: '회원 여러분이 요청하신 최신 스미스머신과 케이블 크로스오버가 입고되었습니다. 2층 프리웨이트존에서 이용하실 수 있습니다.',
                author: '어트레이너 (트레이너)',
                date: '2025-10-18'
            }
        };

        // Function to get URL parameters
        function getUrlParameter(name) {
            name = name.replace(/[\[]/, '\\[').replace(/[\]]/, '\\]');
            var regex = new RegExp('[\\?&]' + name + '=([^&#]*)');
            var results = regex.exec(location.search);
            return results === null ? '' : decodeURIComponent(results[1].replace(/\+/g, ' '));
        }

        // Load notice data
        function loadNoticeData() {
            const noticeId = getUrlParameter('id');
            const noticeData = noticeDataMap[noticeId];
            
            if (noticeData) {
                // Update the page with notice data
                document.getElementById('noticeBadge').textContent = noticeData.badge;
                document.getElementById('noticeBadge').className = 'notice-badge ' + noticeData.type;
                document.getElementById('noticeTitle').textContent = noticeData.title;
                document.getElementById('noticeAuthor').textContent = noticeData.author;
                document.getElementById('noticeDate').textContent = noticeData.date;
                document.getElementById('noticeContent').textContent = noticeData.content;
            } else {
                // 데이터가 없을 경우 기본값 유지 또는 에러 처리
                console.log('Notice not found');
            }
        }

        // Edit notice function
        function editNotice() {
            const noticeId = getUrlParameter('id');
            alert('수정하기 기능은 추후 구현 예정입니다.');
            // In a real app: window.location.href = '${pageContext.request.contextPath}/notice/updateForm.do?id=' + noticeId;
        }

        // Initialize page
        loadNoticeData();
    </script>
</body>
</html>

