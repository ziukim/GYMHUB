<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>PT 신청 관리 - GymHub</title>

    <!-- Common CSS -->
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/common.css">

    <!-- Page-specific styles -->
    <style>
        /* main-content 가로로 가득 차게 - !important로 common.css 오버라이드 */
        .main-content {
            width: calc(100% - 255px) !important;
            margin-left: 255px !important;
            padding: 24px 24px 24px 24px !important; /* 모든 방향 패딩 (사이드바와 콘텐츠 사이 간격) */
            margin-right: 0 !important;
        }

        /* PT 관리 페이지별 스타일 */
        .pt-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 24px;
        }

        .pt-title-section {
            display: flex;
            align-items: center;
            gap: 16px;
        }

        .back-btn {
            display: flex;
            align-items: center;
            justify-content: center;
            width: 40px;
            height: 40px;
            background-color: transparent;
            border: 1px solid #ff6b00;
            border-radius: 8px;
            cursor: pointer;
            transition: all 0.2s;
            font-size: 20px;
            color: #ff6b00;
        }

        .back-btn:hover {
            background-color: rgba(255, 107, 0, 0.1);
        }

        .pt-title h1 {
            font-size: 32px;
            color: #ff6b00;
            margin-bottom: 4px;
        }

        .pt-title p {
            font-size: 14px;
            color: #b0b0b0;
        }

        /* 탭 버튼 커스텀 (common.css의 .tabs 확장) */
        .tabs-container {
            display: flex;
            gap: 16px;
            margin-bottom: 24px;
        }

        .tab-btn {
            flex: 1;
            padding: 16px 24px;
            background-color: #2d1810;
            border: 2px solid #4a3020;
            border-radius: 8px;
            font-size: 16px;
            font-weight: 600;
            color: #b0b0b0;
            cursor: pointer;
            transition: all 0.2s;
        }

        .tab-btn:hover {
            border-color: #ff6b00;
            color: #ffa366;
        }

        .tab-btn.active {
            background-color: #ff6b00;
            border-color: #ff6b00;
            color: white;
        }

        .tab-count {
            font-size: 14px;
            margin-left: 8px;
        }

        /* 탭 콘텐츠 */
        .tab-panel {
            display: none;
        }

        .tab-panel.active {
            display: block;
        }

        /* PT 신청 카드 */
        .pt-request-card {
            background-color: #2d1810;
            border: 2px solid #ff6b00;
            border-radius: 12px;
            padding: 24px;
            margin-bottom: 16px;
            position: relative;
            transition: all 0.2s;
        }

        .pt-request-card:hover {
            box-shadow: 0 0 20px rgba(255, 107, 0, 0.3);
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

        .status-completed {
            background-color: rgba(76, 175, 80, 0.2);
            color: #4caf50;
            border: 1px solid #4caf50;
        }

        .status-cancelled {
            background-color: rgba(255, 82, 82, 0.2);
            color: #ff5252;
            border: 1px solid #ff5252;
        }

        .card-header-section {
            display: flex;
            align-items: center;
            gap: 12px;
            margin-bottom: 16px;
            padding-bottom: 16px;
            border-bottom: 1px solid #4a3020;
        }

        .user-icon {
            display: flex;
            align-items: center;
            justify-content: center;
            width: 40px;
            height: 40px;
            background-color: rgba(255, 107, 0, 0.1);
            border-radius: 50%;
            font-size: 24px;
        }

        .card-user-info {
            flex: 1;
        }

        .card-user-name {
            font-size: 18px;
            font-weight: 600;
            color: #ff6b00;
            margin-bottom: 4px;
        }

        .card-user-id {
            font-size: 12px;
            color: #b0b0b0;
        }

        .card-details {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 12px;
            margin-bottom: 16px;
        }

        .detail-item {
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .detail-label {
            font-size: 12px;
            color: #b0b0b0;
        }

        .detail-value {
            font-size: 14px;
            color: #ffa366;
            font-weight: 500;
        }

        .card-actions {
            display: flex;
            gap: 8px;
            justify-content: flex-end;
        }

        .action-btn {
            padding: 10px 20px;
            border: none;
            border-radius: 8px;
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.2s;
        }

        .approve-btn {
            background-color: #4caf50;
            color: white;
        }

        .approve-btn:hover {
            background-color: #45a049;
        }

        .reject-btn {
            background-color: #ff5252;
            color: white;
        }

        .reject-btn:hover {
            background-color: #ff3333;
        }

        /* 모달 커스텀 스타일 */
        .modal-description {
            color: #b0b0b0;
            margin-bottom: 24px;
            font-size: 14px;
        }

        .form-select {
            width: 100%;
            background-color: #2d1810;
            border: 2px solid #ff6b00;
            border-radius: 8px;
            padding: 12px 16px;
            color: white;
            font-size: 14px;
            cursor: pointer;
            appearance: none;
            background-image: url("data:image/svg+xml,%3Csvg width='12' height='8' viewBox='0 0 12 8' fill='none' xmlns='http://www.w3.org/2000/svg'%3E%3Cpath d='M1 1L6 6L11 1' stroke='%23FF6B00' stroke-width='2' stroke-linecap='round' stroke-linejoin='round'/%3E%3C/svg%3E");
            background-repeat: no-repeat;
            background-position: right 16px center;
            padding-right: 40px;
        }

        .form-select:focus {
            outline: none;
            border-color: #ff8800;
        }

        .form-select option {
            background-color: #1a0f0a;
            color: white;
        }

        /* 반응형 */
        @media (max-width: 768px) {
            .main-content {
                width: 100% !important;
                margin-left: 0 !important;
            }

            .card-details {
                grid-template-columns: 1fr;
            }

            .tabs-container {
                flex-direction: column;
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
        <div class="pt-header">
            <div class="pt-title-section">
                <div class="pt-title">
                    <h1>PT 신청 관리</h1>
                    <p>회원들의 PT 신청을 관리하세요</p>
                </div>
            </div>
        </div>

        <!-- Tabs -->
        <div class="tabs-container">
            <button class="tab-btn active" data-tab="pending">
                대기중 <span class="tab-count" id="pendingCount">(5)</span>
            </button>
            <button class="tab-btn" data-tab="completed">
                승인/거절 <span class="tab-count" id="completedCount">(5)</span>
            </button>
        </div>

        <!-- 대기중 탭 -->
        <div class="tab-panel active" id="pending-panel">
            <!-- PT 신청 카드들이 동적으로 추가됨 -->
        </div>

        <!-- 완성 내역 탭 -->
        <div class="tab-panel" id="completed-panel">
            <!-- PT 신청 카드들이 동적으로 추가됨 -->
        </div>
    </div>
</div>

<!-- 트레이너 배정 모달 (common.css의 .modal-overlay 사용) -->
<div class="modal-overlay" id="trainerModal">
    <div class="modal-container">
        <div class="modal-header">
            <h2 class="modal-title">트레이너 배정</h2>
            <button class="modal-close" onclick="closeModal()">×</button>
        </div>
        <div class="modal-body">
            <p class="modal-description">트레이너를 배정합니다.</p>

            <div class="form-group">
                <label class="form-label">트레이너 조회</label>
                <select class="form-select" id="trainerSelect">
                    <option value="">선택하세요</option>
                    <option value="김트레이너">김트레이너</option>
                    <option value="이코치">이코치</option>
                    <option value="박강사">박강사</option>
                    <option value="최트레이너">최트레이너</option>
                </select>
            </div>
        </div>
        <div class="modal-footer">
            <button class="btn btn-secondary" onclick="closeModal()">취소</button>
            <button class="btn btn-primary" onclick="confirmAssign()">승인</button>
        </div>
    </div>
</div>

<script>
    // 전역 변수
    let currentCard = null;
    let currentCardId = null;

    // 더미 데이터
    const ptRequests = {
        pending: [
            {
                id: 'pt001',
                userName: '김영희',
                userId: 'M002',
                requestDate: '2025.10.28',
                desiredTrainer: '이코치',
                desiredTime: '14:00',
                desiredDate: '2025-11-08',
                phone: '010-1111-2222'
            },
            {
                id: 'pt002',
                userName: '정수진',
                userId: 'M005',
                requestDate: '2025.10.28',
                desiredTrainer: '최트레이너',
                desiredTime: '18:00',
                desiredDate: '2025-11-10',
                phone: '010-2222-3333'
            },
            {
                id: 'pt003',
                userName: '이민수',
                userId: 'M007',
                requestDate: '2025.10.29',
                desiredTrainer: '박강사',
                desiredTime: '09:00',
                desiredDate: '2025-11-12',
                phone: '010-3333-4444'
            },
            {
                id: 'pt004',
                userName: '최지영',
                userId: 'M008',
                requestDate: '2025.10.30',
                desiredTrainer: '김트레이너',
                desiredTime: '15:00',
                desiredDate: '2025-11-15',
                phone: '010-4444-5555'
            },
            {
                id: 'pt005',
                userName: '강동원',
                userId: 'M009',
                requestDate: '2025.10.31',
                desiredTrainer: '이코치',
                desiredTime: '11:00',
                desiredDate: '2025-11-18',
                phone: '010-5555-6666'
            }
        ],
        completed: [
            {
                id: 'pt101',
                userName: '홍길동',
                userId: 'M001',
                requestDate: '2025.10.28',
                assignedTrainer: '박강사',
                desiredTime: '10:00',
                desiredDate: '2025-11-05',
                phone: '010-6666-7777',
                status: 'approved'
            },
            {
                id: 'pt102',
                userName: '박철수',
                userId: 'M003',
                requestDate: '2025.10.25',
                assignedTrainer: '김트레이너',
                desiredTime: '16:00',
                desiredDate: '2025-11-03',
                phone: '010-7777-8888',
                status: 'rejected'
            },
            {
                id: 'pt103',
                userName: '윤서연',
                userId: 'M004',
                requestDate: '2025.10.26',
                assignedTrainer: '최트레이너',
                desiredTime: '13:00',
                desiredDate: '2025-11-06',
                phone: '010-8888-9999',
                status: 'approved'
            },
            {
                id: 'pt104',
                userName: '장민호',
                userId: 'M006',
                requestDate: '2025.10.27',
                assignedTrainer: '이코치',
                desiredTime: '17:00',
                desiredDate: '2025-11-07',
                phone: '010-9999-0000',
                status: 'rejected'
            },
            {
                id: 'pt105',
                userName: '송혜교',
                userId: 'M010',
                requestDate: '2025.10.24',
                assignedTrainer: '박강사',
                desiredTime: '12:00',
                desiredDate: '2025-11-02',
                phone: '010-0000-1111',
                status: 'approved'
            }
        ]
    };

    // 카드 생성 함수
    function createPendingCard(request) {
        var html = '<div class="pt-request-card" data-id="' + request.id + '">';
        html += '<div class="card-header-section">';
        html += '<div class="user-icon">👤</div>';
        html += '<div class="card-user-info">';
        html += '<div class="card-user-name">' + request.userName + '</div>';
        html += '<div class="card-user-id">회원 ID: ' + request.userId + '</div>';
        html += '</div>';
        html += '<span class="card-status status-pending">대기중</span>';
        html += '</div>';

        html += '<div class="card-details">';
        html += '<div class="detail-item">';
        html += '<span class="detail-label">📅 신청일:</span>';
        html += '<span class="detail-value">' + request.requestDate + '</span>';
        html += '</div>';
        html += '<div class="detail-item">';
        html += '<span class="detail-label">👨‍🏫 희망 트레이너:</span>';
        html += '<span class="detail-value">' + request.desiredTrainer + '</span>';
        html += '</div>';
        html += '<div class="detail-item">';
        html += '<span class="detail-label">🕐 희망 시간:</span>';
        html += '<span class="detail-value">' + request.desiredTime + '</span>';
        html += '</div>';
        html += '<div class="detail-item">';
        html += '<span class="detail-label">📆 희망 날짜:</span>';
        html += '<span class="detail-value">' + request.desiredDate + '</span>';
        html += '</div>';
        html += '<div class="detail-item">';
        html += '<span class="detail-label">📞 연락처:</span>';
        html += '<span class="detail-value">' + request.phone + '</span>';
        html += '</div>';
        html += '</div>';

        html += '<div class="card-actions">';
        html += '<button class="action-btn approve-btn" onclick="handleApprove(this)">✓ 승인</button>';
        html += '<button class="action-btn reject-btn" onclick="handleReject(this)">✕ 거절</button>';
        html += '</div>';
        html += '</div>';

        return html;
    }

    function createCompletedCard(request) {
        var statusClass = request.status === 'approved' ? 'status-completed' : 'status-cancelled';
        var statusText = request.status === 'approved' ? '승인됨' : '거절됨';
        var trainerLabel = request.status === 'approved' ? '배정 트레이너' : '희망 트레이너';

        var html = '<div class="pt-request-card" data-id="' + request.id + '">';
        html += '<div class="card-header-section">';
        html += '<div class="user-icon">👤</div>';
        html += '<div class="card-user-info">';
        html += '<div class="card-user-name">' + request.userName + '</div>';
        html += '<div class="card-user-id">회원 ID: ' + request.userId + '</div>';
        html += '</div>';
        html += '<span class="card-status ' + statusClass + '">' + statusText + '</span>';
        html += '</div>';

        html += '<div class="card-details">';
        html += '<div class="detail-item">';
        html += '<span class="detail-label">📅 신청일:</span>';
        html += '<span class="detail-value">' + request.requestDate + '</span>';
        html += '</div>';
        html += '<div class="detail-item">';
        html += '<span class="detail-label">👨‍🏫 ' + trainerLabel + ':</span>';
        html += '<span class="detail-value">' + request.assignedTrainer + '</span>';
        html += '</div>';
        html += '<div class="detail-item">';
        html += '<span class="detail-label">🕐 희망 시간:</span>';
        html += '<span class="detail-value">' + request.desiredTime + '</span>';
        html += '</div>';
        html += '<div class="detail-item">';
        html += '<span class="detail-label">📆 희망 날짜:</span>';
        html += '<span class="detail-value">' + request.desiredDate + '</span>';
        html += '</div>';
        html += '<div class="detail-item">';
        html += '<span class="detail-label">📞 연락처:</span>';
        html += '<span class="detail-value">' + request.phone + '</span>';
        html += '</div>';
        html += '</div>';
        html += '</div>';

        return html;
    }

    // 페이지 렌더링
    function renderPage() {
        const pendingPanel = document.getElementById('pending-panel');
        const completedPanel = document.getElementById('completed-panel');

        console.log('렌더링 시작');
        console.log('대기중 데이터:', ptRequests.pending);
        console.log('완성 데이터:', ptRequests.completed);

        // 대기중 목록 렌더링
        if (pendingPanel) {
            pendingPanel.innerHTML = ptRequests.pending.map(request => createPendingCard(request)).join('');
            console.log('대기중 패널 렌더링 완료');
        }

        // 완성 내역 렌더링
        if (completedPanel) {
            completedPanel.innerHTML = ptRequests.completed.map(request => createCompletedCard(request)).join('');
            console.log('완성내역 패널 렌더링 완료');
        }

        // 카운트 업데이트
        const pendingCountEl = document.getElementById('pendingCount');
        const completedCountEl = document.getElementById('completedCount');

        if (pendingCountEl) {
            pendingCountEl.textContent = `(${ptRequests.pending.length})`;
        }
        if (completedCountEl) {
            completedCountEl.textContent = `(${ptRequests.completed.length})`;
        }
    }

    // 탭 전환 기능
    function initializeTabs() {
        const tabButtons = document.querySelectorAll('.tab-btn');

        tabButtons.forEach(button => {
            button.addEventListener('click', function() {
                const targetTab = this.getAttribute('data-tab');

                console.log('탭 클릭:', targetTab);

                // 모든 탭 버튼에서 active 제거
                document.querySelectorAll('.tab-btn').forEach(btn => {
                    btn.classList.remove('active');
                });

                // 모든 패널에서 active 제거
                document.querySelectorAll('.tab-panel').forEach(panel => {
                    panel.classList.remove('active');
                });

                // 클릭된 탭 버튼에 active 추가
                this.classList.add('active');

                // 해당 패널에 active 추가
                const targetPanel = document.getElementById(targetTab + '-panel');
                if (targetPanel) {
                    targetPanel.classList.add('active');
                    console.log('패널 활성화:', targetTab + '-panel');
                } else {
                    console.error('패널을 찾을 수 없음:', targetTab + '-panel');
                }
            });
        });
    }

    // 승인 버튼 클릭
    function handleApprove(btn) {
        currentCard = btn.closest('.pt-request-card');
        currentCardId = currentCard.getAttribute('data-id');
        document.getElementById('trainerModal').classList.add('active');
    }

    // 거절 버튼 클릭
    function handleReject(btn) {
        const card = btn.closest('.pt-request-card');
        const cardId = card.getAttribute('data-id');
        const userName = card.querySelector('.card-user-name').textContent;

        if (confirm(userName + '님의 PT 신청을 거절하시겠습니까?')) {
            // 대기중 목록에서 해당 요청 찾기
            const requestIndex = ptRequests.pending.findIndex(req => req.id === cardId);
            if (requestIndex !== -1) {
                const request = ptRequests.pending[requestIndex];

                // 완성 내역으로 이동 (거절 상태)
                ptRequests.completed.unshift({
                    id: request.id,
                    userName: request.userName,
                    userId: request.userId,
                    requestDate: request.requestDate,
                    assignedTrainer: request.desiredTrainer,
                    desiredTime: request.desiredTime,
                    desiredDate: request.desiredDate,
                    phone: request.phone,
                    status: 'rejected'
                });

                // 대기중 목록에서 제거
                ptRequests.pending.splice(requestIndex, 1);

                // 페이지 재렌더링
                renderPage();

                alert('거절되었습니다.');
            }
        }
    }

    // 모달 닫기
    function closeModal() {
        document.getElementById('trainerModal').classList.remove('active');
        document.getElementById('trainerSelect').value = '';
        currentCard = null;
        currentCardId = null;
    }

    // 트레이너 배정 확인
    function confirmAssign() {
        const trainerSelect = document.getElementById('trainerSelect');
        const selectedTrainer = trainerSelect.value;

        if (!selectedTrainer) {
            alert('트레이너를 선택해주세요.');
            return;
        }

        // 대기중 목록에서 해당 요청 찾기
        const requestIndex = ptRequests.pending.findIndex(req => req.id === currentCardId);
        if (requestIndex !== -1) {
            const request = ptRequests.pending[requestIndex];
            const userName = request.userName;

            // 완성 내역으로 이동 (승인 상태)
            ptRequests.completed.unshift({
                id: request.id,
                userName: request.userName,
                userId: request.userId,
                requestDate: request.requestDate,
                assignedTrainer: selectedTrainer,
                desiredTime: request.desiredTime,
                desiredDate: request.desiredDate,
                phone: request.phone,
                status: 'approved'
            });

            // 대기중 목록에서 제거
            ptRequests.pending.splice(requestIndex, 1);

            // 페이지 재렌더링
            renderPage();

            alert(userName + '님의 PT 신청이 승인되었습니다.\n배정 트레이너: ' + selectedTrainer);
        }

        closeModal();
    }

    // 모달 오버레이 클릭시 닫기
    document.getElementById('trainerModal').addEventListener('click', function(e) {
        if (e.target === this) {
            closeModal();
        }
    });

    // 페이지 로드 시 초기화
    document.addEventListener('DOMContentLoaded', function() {
        console.log('페이지 로드 완료');
        renderPage();
        initializeTabs();
    });
</script>
</body>
</html>