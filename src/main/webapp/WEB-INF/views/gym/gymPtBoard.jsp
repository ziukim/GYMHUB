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
                    <button class="back-btn" onclick="history.back()">←</button>
                    <div class="pt-title">
                        <h1>PT 신청 관리</h1>
                        <p>회원들의 PT 신청을 관리하세요</p>
                    </div>
                </div>
            </div>

            <!-- Tabs -->
            <div class="tabs-container">
                <button class="tab-btn active" data-tab="pending">
                    대기중 <span class="tab-count">(2)</span>
                </button>
                <button class="tab-btn" data-tab="completed">
                    완성 내역 <span class="tab-count">(2)</span>
                </button>
            </div>

            <!-- 대기중 탭 -->
            <div class="tab-panel active" id="pending-panel">
                <!-- PT 신청 카드 1 -->
                <div class="pt-request-card">
                    <div class="card-header-section">
                        <div class="user-icon">👤</div>
                        <div class="card-user-info">
                            <div class="card-user-name">김영희</div>
                            <div class="card-user-id">회원 ID: M002</div>
                        </div>
                        <span class="card-status status-pending">대기중</span>
                    </div>

                    <div class="card-details">
                        <div class="detail-item">
                            <span class="detail-label">📅 신청일:</span>
                            <span class="detail-value">2025.10.28</span>
                        </div>
                        <div class="detail-item">
                            <span class="detail-label">👨‍🏫 희망 트레이너:</span>
                            <span class="detail-value">이코치</span>
                        </div>
                        <div class="detail-item">
                            <span class="detail-label">🕐 희망 시간:</span>
                            <span class="detail-value">14:00</span>
                        </div>
                        <div class="detail-item">
                            <span class="detail-label">📆 희망 날짜:</span>
                            <span class="detail-value">2025-11-08</span>
                        </div>
                        <div class="detail-item">
                            <span class="detail-label">📞 연락처:</span>
                            <span class="detail-value">010-1111-2222</span>
                        </div>
                    </div>

                    <div class="card-actions">
                        <button class="action-btn approve-btn" onclick="handleApprove(this)">✓ 승인</button>
                        <button class="action-btn reject-btn" onclick="handleReject(this)">✕ 거절</button>
                    </div>
                </div>

                <!-- PT 신청 카드 2 -->
                <div class="pt-request-card">
                    <div class="card-header-section">
                        <div class="user-icon">👤</div>
                        <div class="card-user-info">
                            <div class="card-user-name">정수진</div>
                            <div class="card-user-id">회원 ID: M005</div>
                        </div>
                        <span class="card-status status-pending">대기중</span>
                    </div>

                    <div class="card-details">
                        <div class="detail-item">
                            <span class="detail-label">📅 신청일:</span>
                            <span class="detail-value">2025.10.28</span>
                        </div>
                        <div class="detail-item">
                            <span class="detail-label">👨‍🏫 희망 트레이너:</span>
                            <span class="detail-value">최트레이너</span>
                        </div>
                        <div class="detail-item">
                            <span class="detail-label">🕐 희망 시간:</span>
                            <span class="detail-value">18:00</span>
                        </div>
                        <div class="detail-item">
                            <span class="detail-label">📆 희망 날짜:</span>
                            <span class="detail-value">2025-11-10</span>
                        </div>
                        <div class="detail-item">
                            <span class="detail-label">📞 연락처:</span>
                            <span class="detail-value">010-1111-2222</span>
                        </div>
                    </div>

                    <div class="card-actions">
                        <button class="action-btn approve-btn" onclick="handleApprove(this)">✓ 승인</button>
                        <button class="action-btn reject-btn" onclick="handleReject(this)">✕ 거절</button>
                    </div>
                </div>
            </div>

            <!-- 완성 내역 탭 -->
            <div class="tab-panel" id="completed-panel">
                <!-- PT 신청 카드 1 (완료) -->
                <div class="pt-request-card">
                    <div class="card-header-section">
                        <div class="user-icon">👤</div>
                        <div class="card-user-info">
                            <div class="card-user-name">홍길동</div>
                            <div class="card-user-id">회원 ID: M001</div>
                        </div>
                        <span class="card-status status-completed">승인됨</span>
                    </div>

                    <div class="card-details">
                        <div class="detail-item">
                            <span class="detail-label">📅 신청일:</span>
                            <span class="detail-value">2025.10.28</span>
                        </div>
                        <div class="detail-item">
                            <span class="detail-label">👨‍🏫 배정 트레이너:</span>
                            <span class="detail-value">박강사</span>
                        </div>
                        <div class="detail-item">
                            <span class="detail-label">🕐 희망 시간:</span>
                            <span class="detail-value">10:00</span>
                        </div>
                        <div class="detail-item">
                            <span class="detail-label">📆 희망 날짜:</span>
                            <span class="detail-value">2025-11-05</span>
                        </div>
                        <div class="detail-item">
                            <span class="detail-label">📞 연락처:</span>
                            <span class="detail-value">010-1111-2222</span>
                        </div>
                    </div>
                </div>

                <!-- PT 신청 카드 2 (완료) -->
                <div class="pt-request-card">
                    <div class="card-header-section">
                        <div class="user-icon">👤</div>
                        <div class="card-user-info">
                            <div class="card-user-name">박철수</div>
                            <div class="card-user-id">회원 ID: M003</div>
                        </div>
                        <span class="card-status status-cancelled">거절됨</span>
                    </div>

                    <div class="card-details">
                        <div class="detail-item">
                            <span class="detail-label">📅 신청일:</span>
                            <span class="detail-value">2025.10.25</span>
                        </div>
                        <div class="detail-item">
                            <span class="detail-label">👨‍🏫 희망 트레이너:</span>
                            <span class="detail-value">김트레이너</span>
                        </div>
                        <div class="detail-item">
                            <span class="detail-label">🕐 희망 시간:</span>
                            <span class="detail-value">16:00</span>
                        </div>
                        <div class="detail-item">
                            <span class="detail-label">📆 희망 날짜:</span>
                            <span class="detail-value">2025-11-03</span>
                        </div>
                        <div class="detail-item">
                            <span class="detail-label">📞 연락처:</span>
                            <span class="detail-value">010-1111-2222</span>
                        </div>
                    </div>
                </div>
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
        let currentCard = null;

        // 탭 전환 기능
        const tabButtons = document.querySelectorAll('.tab-btn');
        const tabPanels = document.querySelectorAll('.tab-panel');

        tabButtons.forEach(button => {
            button.addEventListener('click', () => {
                const targetTab = button.getAttribute('data-tab');

                // 모든 탭 버튼과 패널에서 active 클래스 제거
                tabButtons.forEach(btn => btn.classList.remove('active'));
                tabPanels.forEach(panel => panel.classList.remove('active'));

                // 클릭된 탭 버튼과 해당 패널에 active 클래스 추가
                button.classList.add('active');
                document.getElementById(`${targetTab}-panel`).classList.add('active');
            });
        });

        // 승인 버튼 클릭
        function handleApprove(btn) {
            currentCard = btn.closest('.pt-request-card');
            document.getElementById('trainerModal').classList.add('active');
        }

        // 거절 버튼 클릭
        function handleReject(btn) {
            const card = btn.closest('.pt-request-card');
            const userName = card.querySelector('.card-user-name').textContent;

            if (confirm(userName + '님의 PT 신청을 거절하시겠습니까?')) {
                alert('거절되었습니다.');
                // 여기에 실제 거절 처리 로직 추가
            }
        }

        // 모달 닫기
        function closeModal() {
            document.getElementById('trainerModal').classList.remove('active');
            document.getElementById('trainerSelect').value = '';
            currentCard = null;
        }

        // 트레이너 배정 확인
        function confirmAssign() {
            const trainerSelect = document.getElementById('trainerSelect');
            const selectedTrainer = trainerSelect.value;

            if (!selectedTrainer) {
                alert('트레이너를 선택해주세요.');
                return;
            }

            const userName = currentCard.querySelector('.card-user-name').textContent;
            alert(userName + '님의 PT 신청이 승인되었습니다.\n배정 트레이너: ' + selectedTrainer);

            closeModal();
            // 여기에 실제 승인 처리 로직 추가
        }

        // 모달 오버레이 클릭시 닫기
        document.getElementById('trainerModal').addEventListener('click', function(e) {
            if (e.target === this) {
                closeModal();
            }
        });
    </script>
</body>
</html>
