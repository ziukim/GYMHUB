<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>GymHub - 시설 관리</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common.css">
    <style>
        /* main-content 가로로 가득 차게 - !important로 common.css 오버라이드 */
        .main-content {
            width: calc(100% - 255px) !important;
            margin-left: 255px !important;
            padding: 24px 24px 24px 24px !important;
            margin-right: 0 !important;
        }

        /* 시설 관리 페이지 전용 스타일 */

        /* Stats Cards */
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 16px;
            margin-bottom: 24px;
        }

        .stat-card {
            background-color: #2d1810;
            border: 2px solid #ff6b00;
            border-radius: 8px;
            padding: 20px;
            box-shadow: 0 0 15px rgba(255, 107, 0, 0.3);
            transition: transform 0.3s;
        }

        .stat-card:hover {
            transform: translateY(-5px);
        }

        .stat-card-icon {
            width: 32px;
            height: 32px;
            margin-bottom: 12px;
        }

        .stat-card-label {
            font-size: 12px;
            color: #b0b0b0;
            margin-bottom: 8px;
        }

        .stat-card-value {
            font-size: 24px;
            color: white;
            font-weight: 600;
        }

        .stat-card-sub {
            font-size: 12px;
            color: #b0b0b0;
            margin-top: 4px;
        }

        /* Section Container */
        .section {
            background-color: #2d1810;
            border: 2px solid #ff6b00;
            border-radius: 8px;
            padding: 26px;
            box-shadow: 0 0 15px rgba(255, 107, 0, 0.3);
            margin-bottom: 24px;
        }

        .section-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding-bottom: 16px;
            border-bottom: 2px solid #ff6b00;
            margin-bottom: 24px;
        }

        .section-title-group h2 {
            font-size: 18px;
            color: #ff6b00;
            margin-bottom: 4px;
        }

        .section-title-group p {
            font-size: 12px;
            color: #b0b0b0;
        }

        .add-button {
            background-color: #ff6b00;
            border: none;
            border-radius: 8px;
            padding: 10px 20px;
            color: white;
            font-size: 14px;
            cursor: pointer;
            box-shadow: 0 0 15px rgba(255, 107, 0, 0.4);
            transition: all 0.3s;
        }

        .add-button:hover {
            box-shadow: 0 0 25px rgba(255, 107, 0, 0.6);
            transform: translateY(-2px);
        }

        /* Table */
        table {
            width: 100%;
            border-collapse: collapse;
        }

        thead {
            background-color: #2d1810;
        }

        th {
            text-align: left;
            padding: 12px 16px;
            color: #ff6b00;
            font-size: 14px;
            font-weight: 600;
            border-bottom: 2px solid #ff6b00;
        }

        td {
            padding: 16px;
            color: #b0b0b0;
            font-size: 14px;
            border-bottom: 1px solid #3a3a3a;
        }

        td:first-child {
            color: white;
            font-weight: 500;
        }

        /* Action Button */
        .action-btn {
            background-color: #0a0a0a;
            border: 1px solid #ff6b00;
            border-radius: 8px;
            padding: 6px 16px;
            color: #ffa366;
            font-size: 14px;
            cursor: pointer;
            transition: all 0.3s;
        }

        .action-btn:hover {
            background-color: #ff6b00;
            color: white;
        }

        /* Bottom Grid */
        .bottom-grid {
            display: grid;
            grid-template-columns: 2fr 1fr;
            gap: 24px;
        }

        /* Locker Grid */
        .locker-grid {
            display: grid;
            grid-template-columns: repeat(7, 1fr);
            gap: 12px;
        }

        .locker-item {
            background-color: #2d1810;
            border: 2px solid #ff6b00;
            border-radius: 8px;
            padding: 16px 8px;
            text-align: center;
            box-shadow: 0 0 8px rgba(255, 107, 0, 0.2);
            cursor: pointer;
            transition: all 0.3s;
        }

        .locker-item:hover {
            transform: translateY(-3px);
            box-shadow: 0 0 15px rgba(255, 107, 0, 0.4);
        }

        .locker-number {
            font-size: 14px;
            color: white;
            font-weight: 600;
            margin-bottom: 8px;
        }

        .locker-name {
            font-size: 12px;
            color: #b0b0b0;
            margin-bottom: 4px;
        }

        .locker-date {
            font-size: 11px;
            color: #b0b0b0;
        }

        .locker-item.occupied {
            border-color: #00c950;
        }

        .locker-item.expiring {
            border-color: #fdc700;
        }

        .locker-item.available {
            border-color: #5a5a5a;
            opacity: 0.6;
        }

        /* Locker Status */
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
            grid-template-columns: repeat(2, 1fr);
            gap: 12px;
        }

        .status-value.used {
            color: #fa5546;
        }

        .status-value.expiring {
            color: #fdc700;
        }

        .status-value.available {
            color: #05df72;
        }

        /* Modal Styles */
        .modal-overlay {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.7);
            z-index: 1000;
            align-items: center;
            justify-content: center;
            backdrop-filter: blur(4px);
        }

        .modal-overlay.active {
            display: flex;
        }

        .modal-container {
            background-color: #1a0f0a;
            border: 2px solid #ff6b00;
            border-radius: 12px;
            padding: 0;
            max-width: 500px;
            width: 90%;
            max-height: 90vh;
            overflow-y: auto;
            box-shadow: 0 0 30px rgba(255, 107, 0, 0.5);
            animation: modalSlideIn 0.3s ease-out;
        }

        @keyframes modalSlideIn {
            from {
                opacity: 0;
                transform: translateY(-50px) scale(0.9);
            }
            to {
                opacity: 1;
                transform: translateY(0) scale(1);
            }
        }

        .modal-header {
            padding: 24px;
            border-bottom: 2px solid #ff6b00;
            position: relative;
        }

        .modal-close {
            position: absolute;
            top: 20px;
            right: 20px;
            background: transparent;
            border: none;
            color: white;
            font-size: 24px;
            cursor: pointer;
            width: 32px;
            height: 32px;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 4px;
            transition: all 0.2s;
        }

        .modal-close:hover {
            background-color: rgba(255, 107, 0, 0.2);
            transform: rotate(90deg);
        }

        .modal-title {
            font-size: 20px;
            color: #ff6b00;
            font-weight: 600;
            margin-bottom: 8px;
        }

        .modal-subtitle {
            font-size: 14px;
            color: white;
        }

        .modal-body {
            padding: 24px;
        }

        .modal-form-group {
            margin-bottom: 20px;
        }

        .modal-label {
            display: block;
            font-size: 14px;
            color: white;
            margin-bottom: 8px;
            font-weight: 500;
        }

        .modal-label .required {
            color: #ff6b00;
            margin-left: 4px;
        }

        .modal-input {
            width: 100%;
            padding: 12px 16px;
            background-color: #2d1810;
            border: 2px solid #ff6b00;
            border-radius: 8px;
            color: white;
            font-size: 14px;
            font-family: 'Noto Sans KR', sans-serif;
            transition: all 0.3s;
            box-sizing: border-box;
        }

        .modal-input:focus {
            outline: none;
            box-shadow: 0 0 15px rgba(255, 107, 0, 0.4);
            border-color: #ff8800;
        }

        .modal-input::placeholder {
            color: #666;
        }

        .modal-select {
            width: 100%;
            padding: 12px 16px;
            padding-right: 40px;
            background-color: #2d1810;
            border: 2px solid #ff6b00;
            border-radius: 8px;
            color: white;
            font-size: 14px;
            font-family: 'Noto Sans KR', sans-serif;
            cursor: pointer;
            transition: all 0.3s;
            appearance: none;
            -webkit-appearance: none;
            -moz-appearance: none;
        }

        .modal-select:focus {
            outline: none;
            box-shadow: 0 0 15px rgba(255, 107, 0, 0.4);
            border-color: #ff8800;
        }

        .modal-date-input {
            width: 100%;
            padding: 12px 16px;
            background-color: #2d1810;
            border: 2px solid #ff6b00;
            border-radius: 8px;
            color: white;
            font-size: 14px;
            font-family: 'Noto Sans KR', sans-serif;
            transition: all 0.3s;
            cursor: pointer;
        }

        .modal-date-input:focus {
            outline: none;
            box-shadow: 0 0 15px rgba(255, 107, 0, 0.4);
            border-color: #ff8800;
        }

        .modal-footer {
            padding: 24px;
            border-top: 2px solid #ff6b00;
            display: flex;
            gap: 12px;
            justify-content: flex-end;
        }

        .modal-button {
            padding: 12px 24px;
            border-radius: 8px;
            font-size: 14px;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.3s;
            border: 2px solid transparent;
            font-family: 'Noto Sans KR', sans-serif;
        }

        .modal-button-cancel {
            background-color: transparent;
            border-color: #ff6b00;
            color: #ff6b00;
        }

        .modal-button-cancel:hover {
            background-color: rgba(255, 107, 0, 0.1);
            box-shadow: 0 0 15px rgba(255, 107, 0, 0.3);
        }

        .modal-button-submit {
            background-color: #ff6b00;
            color: white;
            border-color: #ff6b00;
        }

        .modal-button-submit:hover {
            background-color: #ff8800;
            box-shadow: 0 0 20px rgba(255, 107, 0, 0.6);
            transform: translateY(-2px);
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

    <!-- Main Content -->
    <div class="main-content">
        <div class="page-intro">
            <h1>시설 관리</h1>
            <p>헬스장의 시설과 기구를 관리하세요</p>
        </div>
        <!-- Stats Cards -->
        <div class="stats-grid">
            <div class="stat-card">
                <div class="stat-card-icon">
                    <img src="${pageContext.request.contextPath}/resources/images/icon/machine.png" alt="운동 기구" style="width: 24px; height: 24px;">
                </div>
                <div class="stat-card-label">운동 기구</div>
                <div class="stat-card-value">43개</div>
                <div class="stat-card-sub">전체 기구수</div>
            </div>
            <div class="stat-card">
                <div class="stat-card-icon">
                    <img src="${pageContext.request.contextPath}/resources/images/icon/done.png" alt="정상" style="width: 24px; height: 24px;">
                </div>
                <div class="stat-card-value">42개</div>
                <div class="stat-card-sub">정상</div>
            </div>
            <div class="stat-card">
                <div class="stat-card-icon">
                    <img src="${pageContext.request.contextPath}/resources/images/icon/inspection.png" alt="수리" style="width: 24px; height: 24px;">
                </div>
                <div class="stat-card-value">2개</div>
                <div class="stat-card-sub">점검</div>
            </div>
            <div class="stat-card">
                <div class="stat-card-icon">
                    <img src="${pageContext.request.contextPath}/resources/images/icon/breakdown.png" alt="경고" style="width: 24px; height: 24px;">
                </div>
                <div class="stat-card-value">1개</div>
                <div class="stat-card-sub">고장</div>
            </div>
        </div>

        <!-- 기구 관리 -->
        <div class="section">
            <div class="section-header">
                <div class="section-title-group">
                    <h2>기구 관리</h2>
                    <p>전체 4개 기구</p>
                </div>
                <button class="add-button" onclick="addEquipment()">+ 기구 추가</button>
            </div>

            <table>
                <thead>
                <tr>
                    <th>기구명</th>
                    <th>분류명</th>
                    <th>수량</th>
                    <th>최근 점검일</th>
                    <th>다음 점검일</th>
                    <th>관리</th>
                </tr>
                </thead>
                <tbody>
                <tr>
                    <td>트레드밀 #1</td>
                    <td>유산소운동</td>
                    <td>15 대</td>
                    <td>2025.10.20</td>
                    <td>2025.11.20</td>
                    <td><button class="action-btn" onclick="editEquipment(this)">수정</button></td>
                </tr>
                <tr>
                    <td>레그프레스 #2</td>
                    <td>웨이트룸</td>
                    <td>10 대</td>
                    <td>2025.10.05</td>
                    <td>2025.11.05</td>
                    <td><button class="action-btn" onclick="editEquipment(this)">수정</button></td>
                </tr>
                <tr>
                    <td>바이크 #3</td>
                    <td>유산소</td>
                    <td>8 대</td>
                    <td>2025.10.15</td>
                    <td>2025.11.01</td>
                    <td><button class="action-btn" onclick="editEquipment(this)">수정</button></td>
                </tr>
                <tr>
                    <td>덤벨세트 #3</td>
                    <td>웨이트룸장</td>
                    <td>5 세트</td>
                    <td>2025.10.22</td>
                    <td>2025.11.22</td>
                    <td><button class="action-btn" onclick="editEquipment(this)">수정</button></td>
                </tr>
                </tbody>
            </table>
        </div>

        <!-- Bottom Grid -->
        <div class="bottom-grid">
            <!-- 락커 관리 -->
            <div class="section">
                <div class="section-header">
                    <div class="section-title-group">
                        <h2>락커 관리</h2>
                        <p>전체 30개 락커</p>
                    </div>
                    <button class="add-button" onclick="addLocker()">+ 락커 추가</button>
                </div>

                <div class="locker-grid">
                    <div class="locker-item occupied">
                        <div class="locker-number">A-127</div>
                        <div class="locker-name">김회원</div>
                        <div class="locker-date">2024.04.01</div>
                        <div class="locker-date">2025.04.01</div>
                    </div>
                    <div class="locker-item occupied">
                        <div class="locker-number">A-45</div>
                        <div class="locker-name">이회원</div>
                        <div class="locker-date">2024.09.15</div>
                        <div class="locker-date">2024.12.15</div>
                    </div>
                    <div class="locker-item occupied">
                        <div class="locker-number">A-34</div>
                        <div class="locker-name">강민지</div>
                        <div class="locker-date">2024.03.13</div>
                        <div class="locker-date">2025.05.15</div>
                    </div>
                    <div class="locker-item occupied">
                        <div class="locker-number">B-78</div>
                        <div class="locker-name">박소희</div>
                        <div class="locker-date">2024.06.01</div>
                        <div class="locker-date">2024.09.01</div>
                    </div>
                    <div class="locker-item occupied">
                        <div class="locker-number">C-12</div>
                        <div class="locker-name">한소희</div>
                        <div class="locker-date">2024.10.01</div>
                        <div class="locker-date">2025.01.01</div>
                    </div>
                    <div class="locker-item available">
                        <div class="locker-number">A-15</div>
                        <div class="locker-name">-</div>
                        <div class="locker-date">-</div>
                        <div class="locker-date">-</div>
                    </div>
                    <div class="locker-item available">
                        <div class="locker-number">B-23</div>
                        <div class="locker-name">-</div>
                        <div class="locker-date">-</div>
                        <div class="locker-date">-</div>
                    </div>
                </div>
            </div>

            <!-- 락커 현황 -->
            <div class="section">
                <div class="section-header">
                    <div class="section-title-group">
                        <h2>락커 현황</h2>
                    </div>
                </div>

                <div class="locker-status">
                    <div class="status-item">
                        <div class="status-label">전체 락커</div>
                        <div class="status-value">30개</div>
                    </div>
                    <div class="status-sub-grid">
                        <div class="status-item">
                            <div class="status-label">사용중</div>
                            <div class="status-value used">17개</div>
                        </div>
                        <div class="status-item">
                            <div class="status-label">만료예정</div>
                            <div class="status-value expiring">6개</div>
                        </div>
                    </div>
                    <div class="status-item">
                        <div class="status-label">사용 가능한 락커 수</div>
                        <div class="status-value available">13개</div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- 락커 추가 모달 -->
<div class="modal-overlay" id="addLockerModal" onclick="closeModalOnOverlay(event, 'addLockerModal')">
    <div class="modal-container" onclick="event.stopPropagation()">
        <div class="modal-header">
            <button class="modal-close" onclick="closeModal('addLockerModal')">×</button>
            <h2 class="modal-title">락커 추가</h2>
            <p class="modal-subtitle">새로운 락커를 등록합니다</p>
        </div>
        <div class="modal-body">
            <div class="modal-form-group">
                <label class="modal-label" for="lockerNumber">
                    락커 번호<span class="required">*</span>
                </label>
                <input type="text" id="lockerNumber" class="modal-input" placeholder="예: A-150">
            </div>
            <div class="modal-form-group">
                <label class="modal-label" for="memberName">회원명</label>
                <select id="memberName" class="modal-select">
                    <option value="">회원을 선택하세요</option>
                    <option value="김회원">김회원</option>
                    <option value="이회원">이회원</option>
                    <option value="박서준">박서준</option>
                    <option value="최유진">최유진</option>
                    <option value="정수연">정수연</option>
                    <option value="강민지">강민지</option>
                    <option value="윤태민">윤태민</option>
                    <option value="한소희">한소희</option>
                </select>
            </div>
            <div class="modal-form-group">
                <label class="modal-label" for="expirationDate">시작일</label>
                <input type="date" id="expirationDate" class="modal-date-input">
            </div>
        </div>
        <div class="modal-footer">
            <button class="modal-button modal-button-cancel" onclick="closeModal('addLockerModal')">취소</button>
            <button class="modal-button modal-button-submit" onclick="submitLockerRegistration()">등록</button>
        </div>
    </div>
</div>

<script>
    // 기구 추가
    function addEquipment() {
        location.href = '${pageContext.request.contextPath}/facility/machine/enroll.gym';
    }

    // 기구 수정
    function editEquipment(button) {
        const row = button.closest('tr');
        const name = row.querySelector('td:first-child').textContent;
        alert(name + ' 기구 정보를 수정합니다.');
    }

    // 모달 열기
    function openModal(modalId) {
        const modal = document.getElementById(modalId);
        if (modal) {
            modal.classList.add('active');
            document.body.style.overflow = 'hidden';
        }
    }

    // 모달 닫기
    function closeModal(modalId) {
        const modal = document.getElementById(modalId);
        if (modal) {
            modal.classList.remove('active');
            document.body.style.overflow = '';
        }
    }

    // 오버레이 클릭 시 모달 닫기
    function closeModalOnOverlay(event, modalId) {
        if (event.target.classList.contains('modal-overlay')) {
            closeModal(modalId);
        }
    }

    // 락커 추가 모달 열기
    function addLocker() {
        // 입력 필드 초기화
        document.getElementById('lockerNumber').value = '';
        document.getElementById('memberName').value = '';
        document.getElementById('expirationDate').value = '';
        openModal('addLockerModal');
    }

    // 락커 등록 제출
    function submitLockerRegistration() {
        const lockerNumber = document.getElementById('lockerNumber').value.trim();
        const memberName = document.getElementById('memberName').value;
        const expirationDate = document.getElementById('expirationDate').value;

        if (!lockerNumber) {
            alert('락커 번호를 입력해주세요.');
            return;
        }

        // 실제로는 서버에 데이터 전송
        console.log('락커 등록:', {
            lockerNumber,
            memberName,
            expirationDate
        });

        alert(`락커가 등록되었습니다!\n락커 번호: ${lockerNumber}\n회원명: ${memberName || '미정'}\n만료일: ${expirationDate || '미정'}`);
        closeModal('addLockerModal');
    }

    // ESC 키로 모달 닫기
    document.addEventListener('keydown', function(event) {
        if (event.key === 'Escape') {
            const activeModal = document.querySelector('.modal-overlay.active');
            if (activeModal) {
                closeModal(activeModal.id);
            }
        }
    });

    // 락커 클릭
    document.querySelectorAll('.locker-item').forEach(locker => {
        locker.addEventListener('click', function() {
            const number = this.querySelector('.locker-number').textContent;
            const name = this.querySelector('.locker-name').textContent;
            if (name === '-') {
                alert(number + ' 락커는 사용 가능합니다.');
            } else {
                alert(number + ' 락커 정보\n사용자: ' + name);
            }
        });
    });

    // 카드 호버 효과
    document.querySelectorAll('.stat-card').forEach(card => {
        card.addEventListener('mouseenter', function() {
            this.style.transform = 'translateY(-5px)';
            this.style.transition = 'transform 0.3s';
        });
        card.addEventListener('mouseleave', function() {
            this.style.transform = 'translateY(0)';
        });
    });


</script>
</body>
</html>
