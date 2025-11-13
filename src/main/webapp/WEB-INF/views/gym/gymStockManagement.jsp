<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>GymHub - 재고 관리</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common.css">
    <style>
        /* gymStockManagement 전용 스타일 */
        /* main-content, page-header는 common.css에 있음 */
        
        /* page-header는 justify-content만 오버라이드 */
        .page-header {
            justify-content: flex-end;
        }

        /* Stats Grid */
        .stats-grid {
            grid-template-columns: repeat(3, 1fr);
        }

        /* Stat Card 추가 스타일 */
        .stat-card {
            cursor: pointer;
            transition: all 0.3s;
        }

        .stat-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 0 25px rgba(255, 107, 0, 0.5);
        }

        .stat-card-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 16px;
        }

        .stat-card-title {
            font-size: 16px;
            color: white;
            font-weight: 600;
        }

        .stat-card-icons {
            display: flex;
            gap: 8px;
        }

        .icon-button {
            width: 24px;
            height: 24px;
            background: transparent;
            border: none;
            color: #ff6b00;
            font-size: 16px;
            cursor: pointer;
            transition: all 0.2s;
        }

        .icon-button:hover {
            transform: scale(1.2);
        }

        .stat-card-info {
            font-size: 12px;
            color: #b0b0b0;
            margin-bottom: 12px;
        }

        .progress-container {
            position: relative;
            height: 8px;
            background-color: #1a0f0a;
            border: 2px solid #ff6b00;
            border-radius: 8px;
            overflow: hidden;
        }

        .progress-bar {
            height: 4px;
            background-color: #ff6b00;
            margin: 2px;
            box-shadow: 0 0 10px rgba(255, 107, 0, 0.5);
            transition: width 0.5s ease;
        }

        .progress-text {
            font-size: 12px;
            color: #b0b0b0;
            text-align: right;
            margin-top: 8px;
        }

        /* Inventory Table */
        .inventory-section {
            background-color: #2d1810;
            border: 2px solid #ff6b00;
            border-radius: 8px;
            padding: 26px;
            box-shadow: 0 0 15px rgba(255, 107, 0, 0.3);
        }

        /* Status Badge 추가 스타일 */
        .status-low {
            background-color: rgba(251, 44, 54, 0.2);
            border: 1px solid #fb2c36;
            color: #ff6467;
        }

        /* Modal 애니메이션 */
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

        .modal-container {
            animation: modalSlideIn 0.3s ease-out;
        }

        .modal-header {
            padding: 20px 24px 16px 24px;
            border-bottom: 2px solid #ff6b00;
            position: relative;
        }

        .modal-close {
            position: absolute;
            top: 4px;
            right: 8px;
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
            margin-bottom: 6px;
        }

        .modal-subtitle {
            font-size: 14px;
            color: white;
            margin-top: 4px;
        }

        .modal-body {
            padding: 20px 24px;
        }

        .modal-form-group {
            margin-bottom: 18px;
        }

        .modal-label {
            display: block;
            font-size: 14px;
            color: white;
            margin-bottom: 10px;
            font-weight: 500;
        }

        .modal-input {
            width: 100%;
            background-color: #2d1810;
            border: 2px solid #ff6b00;
            border-radius: 8px;
            padding: 12px 16px;
            color: white;
            font-size: 14px;
            font-family: 'Noto Sans KR', sans-serif;
            transition: all 0.3s;
        }

        .modal-input:focus {
            outline: none;
            box-shadow: 0 0 15px rgba(255, 107, 0, 0.4);
            border-color: #ff8800;
        }

        .modal-select {
            width: 100%;
            padding: 12px 16px;
            background-color: #2d1810;
            border: 2px solid #ff6b00;
            border-radius: 8px;
            color: white;
            font-size: 14px;
            font-family: 'Noto Sans KR', sans-serif;
            cursor: pointer;
            transition: all 0.3s;
        }

        .modal-select:focus {
            outline: none;
            box-shadow: 0 0 15px rgba(255, 107, 0, 0.4);
            border-color: #ff8800;
        }

        .modal-footer {
            padding: 16px 24px 20px 24px;
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

        .modal-button-delete {
            background-color: #ff5252;
            border-color: #ff5252;
            color: white;
        }

        .modal-button-delete:hover {
            background-color: #ff3333;
            box-shadow: 0 0 20px rgba(255, 82, 82, 0.6);
            transform: translateY(-2px);
        }

        /* 라디오 버튼 스타일 */
        .radio-group {
            display: flex;
            gap: 24px;
            margin-bottom: 0;
        }

        .radio-option {
            display: flex;
            align-items: center;
            gap: 8px;
            cursor: pointer;
        }

        .radio-option input[type="radio"] {
            width: 20px;
            height: 20px;
            accent-color: #ff6b00;
            cursor: pointer;
        }

        .radio-option label {
            color: white;
            font-size: 14px;
            cursor: pointer;
            user-select: none;
        }

        /* 반응형 */
        @media (max-width: 768px) {
            .main-content {
                width: 100% !important;
                margin-left: 0 !important;
            }
            
            .stats-grid {
                grid-template-columns: 1fr;
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
            <div class="page-intro">
                <h1>재고 관리</h1>
                <p>헬스장의 회원권과 재고를 등록하고 관리하세요</p>
            </div>
            <div class="page-header">
                <button class="add-button" onclick="openAddModal()">
                    <img src="${pageContext.request.contextPath}/resources/images/icon/add.png" alt="추가" style="width: 16px; height: 16px; vertical-align: middle; margin-right: 4px;"> 재고 추가
                </button>
            </div>

            <!-- Stats Cards -->
            <div class="stats-grid">
            <c:forEach var="stock" items="${stockList}">
                <div class="stat-card" onclick="viewDetail(event, '${stock.stockName}')">
                    <div class="stat-card-header">
                        <div class="stat-card-title">${stock.stockName}</div>
                        <div class="stat-card-icons">
                            <button class="icon-button" onclick="openManageInventoryModal(event, ${stock.stockId}, '${stock.stockName}', ${stock.targetStockCount})">
                                <img src="${pageContext.request.contextPath}/resources/images/icon/change.png" alt="재고 관리" style="width: 16px; height: 16px;">
                            </button>
                            <button class="icon-button" onclick="openQuantityChangeModal(event, ${stock.stockId}, '${stock.stockName}')">
                                <img src="${pageContext.request.contextPath}/resources/images/icon/edit.png" alt="수정" style="width: 16px; height: 16px;">
                            </button>
                            <button class="icon-button" onclick="deleteItem(event, ${stock.stockId}, '${stock.stockName}')">
                                <img src="${pageContext.request.contextPath}/resources/images/icon/delete.png" alt="삭제" style="width: 16px; height: 16px;">
                            </button>
                        </div>
                    </div>
                    <div class="stat-card-info">현재 재고 ${stock.stockCount}개 / 목표 ${stock.targetStockCount}개</div>
                    <div class="progress-container">
                        <c:set var="percentage" value="${stock.targetStockCount > 0 ? (stock.stockCount * 100 / stock.targetStockCount) : 0}" />
                        <div class="progress-bar" style="width: ${percentage > 100 ? 100 : percentage}%;"></div>
                    </div>
                    <div class="progress-text">${stock.stockCount}개</div>
                </div>
            </c:forEach>
            </div>

            <!-- Inventory Table -->
            <div class="inventory-section">
                <div class="section-header">
                    <h2 class="section-title">입출고 내역</h2>
                </div>

                <table>
                    <thead>
                        <tr>
                            <th>항목명</th>
                            <th>상태</th>
                            <th>수량</th>
                    <th>최근 입출고일</th>
                        </tr>
                    </thead>
                    <tbody>
                <c:choose>
                    <c:when test="${empty stockManageList}">
                        <tr>
                            <td colspan="4" style="text-align: center; padding: 40px;">
                                입출고 내역이 없습니다.
                            </td>
                        </tr>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="manage" items="${stockManageList}">
                            <tr>
                                <td>${empty manage.stockName ? '(삭제된 재고)' : manage.stockName}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${manage.stockManageType eq '입고'}">
                                            <span class="status-badge status-sufficient">입고</span>
                                        </c:when>
                                        <c:when test="${manage.stockManageType eq '출고'}">
                                            <span class="status-badge status-low">출고</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="status-badge">${manage.stockManageType}</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>${manage.stockManageCount} 개</td>
                                <td>
                                    <fmt:formatDate value="${manage.stockManageDate}" pattern="yyyy.MM.dd HH:mm" />
                                </td>
                        </tr>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <!-- 재고 추가 모달 -->
    <div class="modal-overlay" id="addModal">
        <div class="modal-container">
            <div class="modal-header">
                <button class="modal-close" onclick="closeAddModal()">
                    <img src="${pageContext.request.contextPath}/resources/images/icon/close.png" alt="닫기" style="width: 16px; height: 16px;">
                </button>
                <div class="modal-title">재고 추가</div>
                <div class="modal-subtitle">새로운 재고를 등록합니다</div>
            </div>
            <div class="modal-body">
                <form id="addProductForm">
                    <div class="modal-form-group">
                        <label class="modal-label">재고명 <span style="color: #ff6b00;">*</span></label>
                    <input type="text" class="modal-input" id="addStockName" placeholder="재고명을 입력하세요" required>
                    </div>
                    <div class="modal-form-group">
                    <label class="modal-label">목표재고수량 <span style="color: #ff6b00;">*</span></label>
                    <input type="number" class="modal-input" id="addTargetStockCount" placeholder="목표재고수량을 입력하세요" required min="0">
                    </div>
                    <div class="modal-form-group">
                    <label class="modal-label">물품가격 <span style="color: #ff6b00;">*</span></label>
                    <input type="number" class="modal-input" id="addStockPrice" placeholder="물품가격을 입력하세요" required min="0">
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button class="modal-button modal-button-cancel" onclick="closeAddModal()">취소</button>
                <button class="modal-button modal-button-submit" onclick="submitAddForm()">등록</button>
            </div>
        </div>
    </div>

<!-- 수량 변경 모달 (입출고) -->
    <div class="modal-overlay" id="quantityChangeModal">
        <div class="modal-container">
            <div class="modal-header">
                <button class="modal-close" onclick="closeQuantityChangeModal()">
                    <img src="${pageContext.request.contextPath}/resources/images/icon/close.png" alt="닫기" style="width: 16px; height: 16px;">
                </button>
            <div class="modal-title">입출고 처리</div>
            <div class="modal-subtitle">재고의 입출고를 처리합니다.</div>
            </div>
            <div class="modal-body">
                <form id="quantityChangeForm">
                <input type="hidden" id="inOutStockId">
                <div class="modal-form-group">
                    <label class="modal-label">재고명</label>
                    <input type="text" class="modal-input" id="inOutStockName" readonly>
                </div>
                    <div class="modal-form-group">
                    <label class="modal-label">입출고 구분 <span style="color: #ff6b00;">*</span></label>
                        <div class="radio-group">
                            <div class="radio-option">
                            <input type="radio" id="outgoing" name="type" value="출고" checked>
                                <label for="outgoing">출고</label>
                            </div>
                            <div class="radio-option">
                            <input type="radio" id="incoming" name="type" value="입고">
                                <label for="incoming">입고</label>
                            </div>
                        </div>
                    </div>
                    <div class="modal-form-group">
                        <label class="modal-label">수량 <span style="color: #ff6b00;">*</span></label>
                        <input type="number" class="modal-input" id="quantityInput" placeholder="수량을 입력하세요" required min="1">
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button class="modal-button modal-button-cancel" onclick="closeQuantityChangeModal()">취소</button>
            <button class="modal-button modal-button-submit" onclick="submitQuantityChange()">처리</button>
            </div>
        </div>
    </div>

    <!-- 관리 재고 수정 모달 -->
    <div class="modal-overlay" id="manageInventoryModal">
        <div class="modal-container">
            <div class="modal-header">
                <button class="modal-close" onclick="closeManageInventoryModal()">
                    <img src="${pageContext.request.contextPath}/resources/images/icon/close.png" alt="닫기" style="width: 16px; height: 16px;">
                </button>
            <div class="modal-title">재고 정보 수정</div>
            <div class="modal-subtitle">재고명과 목표재고수량을 수정합니다.</div>
            </div>
            <div class="modal-body">
                <form id="manageInventoryForm">
                <input type="hidden" id="manageStockId">
                <div class="modal-form-group">
                    <label class="modal-label">재고명 <span style="color: #ff6b00;">*</span></label>
                    <input type="text" class="modal-input" id="manageStockName" placeholder="재고명을 입력하세요" required>
                </div>
                    <div class="modal-form-group">
                    <label class="modal-label">목표재고수량 <span style="color: #ff6b00;">*</span></label>
                    <input type="number" class="modal-input" id="manageTargetStockCount" placeholder="목표재고수량을 입력하세요" required min="0">
                    </div>
                    <div class="modal-form-group">
                    <label class="modal-label">물품가격 <span style="color: #ff6b00;">*</span></label>
                    <input type="number" class="modal-input" id="manageStockPrice" placeholder="물품가격을 입력하세요" required min="0">
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button class="modal-button modal-button-cancel" onclick="closeManageInventoryModal()">취소</button>
            <button class="modal-button modal-button-submit" onclick="submitManageInventory()">수정</button>
            </div>
        </div>
    </div>

    <script>
        // 재고 추가 모달 열기
        function openAddModal() {
            document.getElementById('addModal').classList.add('active');
        }

        // 재고 추가 모달 닫기
        function closeAddModal() {
            document.getElementById('addModal').classList.remove('active');
            document.getElementById('addProductForm').reset();
        }

    // 재고 추가 폼 제출
    function submitAddForm() {
        console.log('=== submitAddForm 시작 ===');

        const stockName = document.getElementById('addStockName').value.trim();
        const targetStockCount = document.getElementById('addTargetStockCount').value;
        const stockPrice = document.getElementById('addStockPrice').value;

        console.log('stockName:', stockName);
        console.log('targetStockCount:', targetStockCount);
        console.log('stockPrice:', stockPrice);

        if (!stockName || !targetStockCount || !stockPrice) {
                alert('모든 필수 항목을 입력해주세요.');
            return;
        }

        const formData = new FormData();
        formData.append('stockName', stockName);
        formData.append('targetStockCount', targetStockCount);
        formData.append('stockPrice', stockPrice);

        console.log('fetch 요청 시작');

        fetch('${pageContext.request.contextPath}/stockInsert.gym', {
            method: 'POST',
            body: formData
        })
            .then(response => {
                console.log('response:', response);
                return response.text();
            })
            .then(result => {
                console.log('result:', result);
                if (result === 'success') {
                    alert('재고가 추가되었습니다.');
                    // 페이지 전체 새로고침이 아닌 목록 페이지로 이동
                    window.location.href = '${pageContext.request.contextPath}/stock.gym';
                } else if (result === 'fail_auth') {
                    alert('권한이 없습니다.');
            } else {
                    alert('재고 추가에 실패했습니다: ' + result);
            }
            })
            .catch(error => {
                console.error('Error:', error);
                alert('오류가 발생했습니다.');
            });
        }

    // 입출고 모달 열기
    function openQuantityChangeModal(event, stockId, stockName) {
            if (event) {
                event.stopPropagation();
            }
        document.getElementById('inOutStockId').value = stockId;
        document.getElementById('inOutStockName').value = stockName;
        document.getElementById('quantityInput').value = '';
        document.getElementById('outgoing').checked = true;
            document.getElementById('quantityChangeModal').classList.add('active');
        }

    // 입출고 모달 닫기
        function closeQuantityChangeModal() {
            document.getElementById('quantityChangeModal').classList.remove('active');
            document.getElementById('quantityChangeForm').reset();
        }

    // 입출고 처리 제출
        function submitQuantityChange() {
        const stockId = document.getElementById('inOutStockId').value;
                const type = document.querySelector('input[name="type"]:checked').value;
        const count = document.getElementById('quantityInput').value;

        if (!count || count <= 0) {
                alert('수량을 입력해주세요.');
            return;
        }

        const formData = new FormData();
        formData.append('stockId', stockId);
        formData.append('type', type);
        formData.append('count', count);

        fetch('${pageContext.request.contextPath}/stockInOut.gym', {
            method: 'POST',
            body: formData
        })
            .then(response => response.text())
            .then(result => {
                if (result === 'success') {
                    alert(type + ' 처리가 완료되었습니다.');
                    location.reload();
                } else if (result === 'fail_auth') {
                    alert('권한이 없습니다.');
                } else {
                    alert('처리에 실패했습니다.');
                }
            })
            .catch(error => {
                console.error('Error:', error);
                alert('오류가 발생했습니다.');
            });
    }

    // 재고 정보 수정 모달 열기
    function openManageInventoryModal(event, stockId, stockName, targetStockCount) {
            if (event) {
                event.stopPropagation();
            }

        // 서버에서 재고 상세 정보 조회
        fetch('${pageContext.request.contextPath}/stockDetail.gym?stockId=' + stockId)
            .then(response => response.json())
            .then(stock => {
                document.getElementById('manageStockId').value = stock.stockId;
                document.getElementById('manageStockName').value = stock.stockName;
                document.getElementById('manageTargetStockCount').value = targetStockCount;
                document.getElementById('manageStockPrice').value = stock.stockPrice;
            document.getElementById('manageInventoryModal').classList.add('active');
            })
            .catch(error => {
                console.error('Error:', error);
                alert('재고 정보를 불러오는데 실패했습니다.');
            });
        }

    // 재고 정보 수정 모달 닫기
        function closeManageInventoryModal() {
            document.getElementById('manageInventoryModal').classList.remove('active');
            document.getElementById('manageInventoryForm').reset();
        }

    // 재고 정보 수정 제출
        function submitManageInventory() {
        const stockId = document.getElementById('manageStockId').value;
        const stockName = document.getElementById('manageStockName').value.trim();
        const targetStockCount = document.getElementById('manageTargetStockCount').value;
        const stockPrice = document.getElementById('manageStockPrice').value;

        if (!stockName || !targetStockCount || !stockPrice) {
                alert('모든 필수 항목을 입력해주세요.');
            return;
        }

        const formData = new FormData();
        formData.append('stockId', stockId);
        formData.append('stockName', stockName);
        formData.append('targetStockCount', targetStockCount);
        formData.append('stockPrice', stockPrice);

        fetch('${pageContext.request.contextPath}/stockUpdate.gym', {
            method: 'POST',
            body: formData
        })
            .then(response => response.text())
            .then(result => {
                if (result === 'success') {
                    alert('재고 정보가 수정되었습니다.');
                    location.reload();
                } else if (result === 'fail_auth') {
                    alert('권한이 없습니다.');
                } else {
                    alert('수정에 실패했습니다.');
                }
            })
            .catch(error => {
                console.error('Error:', error);
                alert('오류가 발생했습니다.');
            });
        }

        // 상세 보기
        function viewDetail(event, itemName) {
            if (event && event.stopPropagation) {
                event.stopPropagation();
            }
        }

        // 삭제
    function deleteItem(event, stockId, stockName) {
            event.stopPropagation();

        if (!confirm(stockName + '을(를) 삭제하시겠습니까?')) {
            return;
        }

        const formData = new FormData();
        formData.append('stockId', stockId);

        fetch('${pageContext.request.contextPath}/stockDelete.gym', {
            method: 'POST',
            body: formData
        })
            .then(response => response.text())
            .then(result => {
                if (result === 'success') {
                    alert('재고가 삭제되었습니다.');
                    location.reload();
                } else {
                    alert('삭제에 실패했습니다.');
                }
            })
            .catch(error => {
                console.error('Error:', error);
                alert('오류가 발생했습니다.');
            });
        }

        // 프로그레스 바 애니메이션
        window.addEventListener('load', function() {
            const progressBars = document.querySelectorAll('.progress-bar');
            progressBars.forEach(bar => {
                const width = bar.style.width;
                bar.style.width = '0%';
                setTimeout(() => {
                    bar.style.width = width;
                }, 100);
            });

            // 카드 진입 애니메이션
            const cards = document.querySelectorAll('.stat-card');
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

        // 모달 외부 클릭시 닫기
        document.querySelectorAll('.modal-overlay').forEach(overlay => {
            overlay.addEventListener('click', function(e) {
                if (e.target === this) {
                    this.classList.remove('active');
                }
            });
        });
    </script>

</body>
</html>
