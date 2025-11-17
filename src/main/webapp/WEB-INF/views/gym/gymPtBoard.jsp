<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
        /* gymPtBoard 전용 스타일 */
        /* main-content는 common.css에 있음 */

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
        }

        .user-icon img {
            width: 24px;
            height: 24px;
        }

        .detail-icon {
            width: 16px;
            height: 16px;
            vertical-align: middle;
            margin-right: 4px;
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
                대기중 <span class="tab-count" id="pendingCount">
                    (<c:choose>
                        <c:when test="${not empty pendingPtReserves}">${pendingPtReserves.size()}</c:when>
                        <c:otherwise>0</c:otherwise>
                    </c:choose>)
                </span>
            </button>
            <button class="tab-btn" data-tab="completed">
                승인/거절 <span class="tab-count" id="completedCount">
                    (<c:choose>
                        <c:when test="${not empty approvedOrRejectedPtReserves}">${approvedOrRejectedPtReserves.size()}</c:when>
                        <c:otherwise>0</c:otherwise>
                    </c:choose>)
                </span>
            </button>
        </div>

        <!-- 대기중 탭 -->
        <div class="tab-panel active" id="pending-panel">
            <c:choose>
                <c:when test="${not empty pendingPtReserves}">
                    <c:forEach var="ptReserve" items="${pendingPtReserves}">
                        <div class="pt-request-card" data-pt-reserve-no="${ptReserve.ptReserveNo}">
                            <div class="card-header-section">
                                <div class="user-icon">
                                    <img src="${pageContext.request.contextPath}/resources/images/icon/person.png" alt="사용자">
                                </div>
                                <div class="card-user-info">
                                    <div class="card-user-name">${ptReserve.memberName}</div>
                                    <div class="card-user-id">회원 번호: ${ptReserve.memberNo}</div>
                                </div>
                                <span class="card-status status-pending">대기중</span>
                            </div>

                            <div class="card-details">
                                <div class="detail-item">
                                    <span class="detail-label">
                                        <img src="${pageContext.request.contextPath}/resources/images/icon/calendar.png" alt="예약일" class="detail-icon"> 예약일:
                                    </span>
                                    <span class="detail-value">
                                        <c:choose>
                                            <c:when test="${not empty ptReserve.ptReserveTime}">
                                                <fmt:formatDate value="${ptReserve.ptReserveTime}" pattern="yyyy-MM-dd HH:mm" />
                                            </c:when>
                                            <c:otherwise>-</c:otherwise>
                                        </c:choose>
                                    </span>
                                </div>
                                <c:if test="${not empty ptReserve.ptTrainer}">
                                    <div class="detail-item">
                                        <span class="detail-label">
                                            <img src="${pageContext.request.contextPath}/resources/images/icon/person.png" alt="트레이너" class="detail-icon"> 희망 트레이너:
                                        </span>
                                        <span class="detail-value">${not empty ptReserve.desiredTrainerName ? ptReserve.desiredTrainerName : ptReserve.ptTrainer + '번'}</span>
                                    </div>
                                </c:if>
                                <div class="detail-item">
                                    <span class="detail-label">
                                        <img src="${pageContext.request.contextPath}/resources/images/icon/call.png" alt="연락처" class="detail-icon"> 연락처:
                                    </span>
                                    <span class="detail-value">${empty ptReserve.memberPhone ? '-' : ptReserve.memberPhone}</span>
                                </div>
                            </div>

                            <div class="card-actions">
                                <button class="action-btn approve-btn" onclick="handleApprove(this)">✓ 승인</button>
                                <button class="action-btn reject-btn" onclick="handleReject(this)">✕ 거절</button>
                            </div>
                        </div>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <div style="text-align: center; padding: 40px; color: #b0b0b0;">
                        대기중인 PT 신청이 없습니다.
                    </div>
                </c:otherwise>
            </c:choose>
        </div>

        <!-- 완성 내역 탭 -->
        <div class="tab-panel" id="completed-panel">
            <c:choose>
                <c:when test="${not empty approvedOrRejectedPtReserves}">
                    <c:forEach var="ptReserve" items="${approvedOrRejectedPtReserves}">
                        <c:set var="statusClass" value="${ptReserve.ptReserveStatus == '승인됨' ? 'status-completed' : 'status-cancelled'}" />
                        <div class="pt-request-card" data-pt-reserve-no="${ptReserve.ptReserveNo}">
                            <div class="card-header-section">
                                <div class="user-icon">
                                    <img src="${pageContext.request.contextPath}/resources/images/icon/person.png" alt="사용자">
                                </div>
                                <div class="card-user-info">
                                    <div class="card-user-name">${ptReserve.memberName}</div>
                                    <div class="card-user-id">회원 번호: ${ptReserve.memberNo}</div>
                                </div>
                                <span class="card-status ${statusClass}">${ptReserve.ptReserveStatus}</span>
                            </div>

                            <div class="card-details">
                                <div class="detail-item">
                                    <span class="detail-label">
                                        <img src="${pageContext.request.contextPath}/resources/images/icon/calendar.png" alt="예약일" class="detail-icon"> 예약일:
                                    </span>
                                    <span class="detail-value">
                                        <c:choose>
                                            <c:when test="${not empty ptReserve.ptReserveTime}">
                                                <fmt:formatDate value="${ptReserve.ptReserveTime}" pattern="yyyy-MM-dd HH:mm" />
                                            </c:when>
                                            <c:otherwise>-</c:otherwise>
                                        </c:choose>
                                    </span>
                                </div>
                                <c:if test="${ptReserve.ptReserveStatus == '승인됨' and not empty ptReserve.trainerName}">
                                    <div class="detail-item">
                                        <span class="detail-label">
                                            <img src="${pageContext.request.contextPath}/resources/images/icon/person.png" alt="트레이너" class="detail-icon"> 배정 트레이너:
                                        </span>
                                        <span class="detail-value">${ptReserve.trainerName}</span>
                                    </div>
                                </c:if>
                                <c:if test="${ptReserve.ptReserveStatus == '거절됨' and not empty ptReserve.ptTrainer}">
                                    <div class="detail-item">
                                        <span class="detail-label">
                                            <img src="${pageContext.request.contextPath}/resources/images/icon/person.png" alt="트레이너" class="detail-icon"> 희망 트레이너:
                                        </span>
                                        <span class="detail-value">${not empty ptReserve.desiredTrainerName ? ptReserve.desiredTrainerName : ptReserve.ptTrainer + '번'}</span>
                                    </div>
                                </c:if>
                                <div class="detail-item">
                                    <span class="detail-label">
                                        <img src="${pageContext.request.contextPath}/resources/images/icon/call.png" alt="연락처" class="detail-icon"> 연락처:
                                    </span>
                                    <span class="detail-value">${empty ptReserve.memberPhone ? '-' : ptReserve.memberPhone}</span>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <div style="text-align: center; padding: 40px; color: #b0b0b0;">
                        승인/거절 내역이 없습니다.
                    </div>
                </c:otherwise>
            </c:choose>
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
                    <!-- 동적으로 트레이너 목록이 추가됩니다 -->
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
    var contextPath = '${pageContext.request.contextPath}';
    var currentCard = null;
    var currentPtReserveNo = null;

    // 탭 전환 기능
    function initializeTabs() {
        var tabButtons = document.querySelectorAll('.tab-btn');

        for (var i = 0; i < tabButtons.length; i++) {
            tabButtons[i].addEventListener('click', function() {
                var targetTab = this.getAttribute('data-tab');

                // 모든 탭 버튼에서 active 제거
                var allTabButtons = document.querySelectorAll('.tab-btn');
                for (var j = 0; j < allTabButtons.length; j++) {
                    allTabButtons[j].classList.remove('active');
                }

                // 모든 패널에서 active 제거
                var allPanels = document.querySelectorAll('.tab-panel');
                for (var k = 0; k < allPanels.length; k++) {
                    allPanels[k].classList.remove('active');
                }

                // 클릭된 탭 버튼에 active 추가
                this.classList.add('active');

                // 해당 패널에 active 추가
                var targetPanel = document.getElementById(targetTab + '-panel');
                if (targetPanel) {
                    targetPanel.classList.add('active');
                }
            });
        }
    }

    // 승인 버튼 클릭
    function handleApprove(btn) {
        currentCard = btn.closest('.pt-request-card');
        currentPtReserveNo = parseInt(currentCard.getAttribute('data-pt-reserve-no'));
        
        // 트레이너 목록 조회
        fetch(contextPath + '/trainer/list.ajax')
            .then(function(response) {
                return response.json();
            })
            .then(function(data) {
                if (data.success) {
                    var trainerSelect = document.getElementById('trainerSelect');
                    trainerSelect.innerHTML = '<option value="">선택하세요</option>';
                    
                    if (data.trainers && data.trainers.length > 0) {
                        for (var i = 0; i < data.trainers.length; i++) {
                            var trainer = data.trainers[i];
                            var option = document.createElement('option');
                            option.value = trainer.memberNo;
                            option.textContent = trainer.memberName || '트레이너 ' + trainer.memberNo;
                            trainerSelect.appendChild(option);
                        }
                    }
                    
                    // 모달 표시
                    document.getElementById('trainerModal').classList.add('active');
                } else {
                    alert(data.message || '트레이너 목록을 불러오는데 실패했습니다.');
                }
            })
            .catch(function(error) {
                console.error('트레이너 목록 조회 오류:', error);
                alert('트레이너 목록을 불러오는 중 오류가 발생했습니다.');
            });
    }

    // 거절 버튼 클릭
    function handleReject(btn) {
        var card = btn.closest('.pt-request-card');
        var ptReserveNo = parseInt(card.getAttribute('data-pt-reserve-no'));
        var userName = card.querySelector('.card-user-name').textContent;

        if (confirm(userName + '님의 PT 신청을 거절하시겠습니까?')) {
            var requestData = {
                ptReserveNo: ptReserveNo
            };
            
            fetch(contextPath + '/pt/reject.ajax', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify(requestData)
            })
            .then(function(response) {
                return response.json();
            })
            .then(function(data) {
                if (data.success) {
                    alert('PT 예약이 거절되었습니다.');
                    location.reload();
                } else {
                    alert(data.message || 'PT 예약 거절에 실패했습니다.');
                }
            })
            .catch(function(error) {
                console.error('PT 예약 거절 오류:', error);
                alert('PT 예약 거절 중 오류가 발생했습니다.');
            });
        }
    }

    // 모달 닫기
    function closeModal() {
        document.getElementById('trainerModal').classList.remove('active');
        document.getElementById('trainerSelect').value = '';
        currentCard = null;
        currentPtReserveNo = null;
    }

    // 트레이너 배정 확인
    function confirmAssign() {
        var trainerSelect = document.getElementById('trainerSelect');
        var selectedTrainerNo = trainerSelect.value;

        if (!selectedTrainerNo) {
            alert('트레이너를 선택해주세요.');
            return;
        }

        if (!currentPtReserveNo) {
            alert('예약 정보를 찾을 수 없습니다.');
            return;
        }

        var requestData = {
            ptReserveNo: currentPtReserveNo,
            ptTrainerNo: parseInt(selectedTrainerNo)
        };
        
        fetch(contextPath + '/pt/approve.ajax', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(requestData)
        })
        .then(function(response) {
            return response.json();
        })
        .then(function(data) {
            if (data.success) {
                var selectedTrainerName = trainerSelect.options[trainerSelect.selectedIndex].textContent;
                alert('PT 예약이 승인되었습니다.\n배정 트레이너: ' + selectedTrainerName);
                closeModal();
                location.reload();
            } else {
                alert(data.message || 'PT 예약 승인에 실패했습니다.');
            }
        })
        .catch(function(error) {
            console.error('PT 예약 승인 오류:', error);
            alert('PT 예약 승인 중 오류가 발생했습니다.');
        });
    }

    // 모달 오버레이 클릭시 닫기
    document.addEventListener('DOMContentLoaded', function() {
        var modal = document.getElementById('trainerModal');
        if (modal) {
            modal.addEventListener('click', function(e) {
                if (e.target === this) {
                    closeModal();
                }
            });
        }
        
        // 탭 초기화
        initializeTabs();
    });
</script>
</body>
</html>