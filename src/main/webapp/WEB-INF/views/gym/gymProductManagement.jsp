<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>GymHub - 재고 관리</title>
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
            justify-content: flex-end;
            align-items: center;
            margin-bottom: 24px;
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
                <!-- Card 1: 수건 -->
                <div class="stat-card" onclick="viewDetail('수건')">
                    <div class="stat-card-header">
                        <div class="stat-card-title">수건</div>
                        <div class="stat-card-icons">
                            <button class="icon-button" onclick="openManageInventoryModal(event, '수건')">
                                <img src="${pageContext.request.contextPath}/resources/images/icon/change.png" alt="재고 관리" style="width: 16px; height: 16px;">
                            </button>
                            <button class="icon-button" onclick="openQuantityChangeModal(event, '수건')">
                                <img src="${pageContext.request.contextPath}/resources/images/icon/edit.png" alt="수정" style="width: 16px; height: 16px;">
                            </button>
                            <button class="icon-button" onclick="deleteItem(event, '수건')">
                                <img src="${pageContext.request.contextPath}/resources/images/icon/delete.png" alt="삭제" style="width: 16px; height: 16px;">
                            </button>
                        </div>
                    </div>
                    <div class="stat-card-info">현재 재고 150개</div>
                    <div class="progress-container">
                        <div class="progress-bar" style="width: 75%;"></div>
                    </div>
                    <div class="progress-text">150개</div>
                </div>

                <!-- Card 2: 운동복(상의) -->
                <div class="stat-card" onclick="viewDetail('운동복(상의)')">
                    <div class="stat-card-header">
                        <div class="stat-card-title">운동복(상의)</div>
                        <div class="stat-card-icons">
                            <button class="icon-button" onclick="openManageInventoryModal(event, '운동복(상의)')">
                                <img src="${pageContext.request.contextPath}/resources/images/icon/change.png" alt="재고 관리" style="width: 16px; height: 16px;">
                            </button>
                            <button class="icon-button" onclick="openQuantityChangeModal(event, '운동복(상의)')">
                                <img src="${pageContext.request.contextPath}/resources/images/icon/edit.png" alt="수정" style="width: 16px; height: 16px;">
                            </button>
                            <button class="icon-button" onclick="deleteItem(event, '운동복(상의)')">
                                <img src="${pageContext.request.contextPath}/resources/images/icon/delete.png" alt="삭제" style="width: 16px; height: 16px;">
                            </button>
                        </div>
                    </div>
                    <div class="stat-card-info">현재 재고 100개</div>
                    <div class="progress-container">
                        <div class="progress-bar" style="width: 100%;"></div>
                    </div>
                    <div class="progress-text">100%</div>
                </div>

                <!-- Card 3: 당일권 패키지 -->
                <div class="stat-card" onclick="viewDetail('당일권 패키지')">
                    <div class="stat-card-header">
                        <div class="stat-card-title">당일권 패키지</div>
                        <div class="stat-card-icons">
                            <button class="icon-button" onclick="openManageInventoryModal(event, '당일권 패키지')">
                                <img src="${pageContext.request.contextPath}/resources/images/icon/change.png" alt="재고 관리" style="width: 16px; height: 16px;">
                            </button>
                            <button class="icon-button" onclick="openQuantityChangeModal(event, '당일권 패키지')">
                                <img src="${pageContext.request.contextPath}/resources/images/icon/edit.png" alt="수정" style="width: 16px; height: 16px;">
                            </button>
                            <button class="icon-button" onclick="deleteItem(event, '당일권 패키지')">
                                <img src="${pageContext.request.contextPath}/resources/images/icon/delete.png" alt="삭제" style="width: 16px; height: 16px;">
                            </button>
                        </div>
                    </div>
                    <div class="stat-card-info">현재 재고 50개</div>
                    <div class="progress-container">
                        <div class="progress-bar" style="width: 50%;"></div>
                    </div>
                    <div class="progress-text">83개</div>
                </div>
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
                            <th>최근 입고일</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>수건</td>
                            <td><span class="status-badge status-sufficient">입고</span></td>
                            <td>120 개</td>
                            <td>2025.06.01 14 : 00</td>
                        </tr>
                        <tr>
                            <td>운동복(상의)</td>
                            <td><span class="status-badge status-sufficient">입고</span></td>
                            <td>165 개</td>
                            <td>2025.12.15 12 : 00</td>
                        </tr>
                        <tr>
                            <td>운동복(하의)</td>
                            <td><span class="status-badge status-low">출고</span></td>
                            <td>80 개</td>
                            <td>2025.10.15 15 : 00</td>
                        </tr>
                        <tr>
                            <td>상수</td>
                            <td><span class="status-badge status-sufficient">입고</span></td>
                            <td>90 개</td>
                            <td>2025.12.03 16 : 00</td>
                        </tr>
                        <tr>
                            <td>바이탈 프로</td>
                            <td><span class="status-badge status-sufficient">입고</span></td>
                            <td>20 개</td>
                            <td>2025.01.05 18 : 00</td>
                        </tr>
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
                        <input type="text" class="modal-input" placeholder="재고명을 입력하세요" required>
                    </div>
                    <div class="modal-form-group">
                        <label class="modal-label">수량 <span style="color: #ff6b00;">*</span></label>
                        <input type="number" class="modal-input" placeholder="수량을 입력하세요" required>
                    </div>
                    <div class="modal-form-group">
                        <label class="modal-label">가격 <span style="color: #ff6b00;">*</span></label>
                        <input type="number" class="modal-input" placeholder="가격을 입력하세요" required>
                    </div>
                    <div class="modal-form-group">
                        <label class="modal-label">카테고리 <span style="color: #ff6b00;">*</span></label>
                        <select class="modal-select" required>
                            <option value="">카테고리 선택</option>
                            <option value="용품">용품</option>
                            <option value="의류">의류</option>
                            <option value="보충제">보충제</option>
                            <option value="회원권">회원권</option>
                        </select>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button class="modal-button modal-button-cancel" onclick="closeAddModal()">취소</button>
                <button class="modal-button modal-button-submit" onclick="submitAddForm()">등록</button>
            </div>
        </div>
    </div>

    <!-- 재고 수정 모달 -->
    <div class="modal-overlay" id="editModal">
        <div class="modal-container">
            <div class="modal-header">
                <button class="modal-close" onclick="closeEditModal()">
                    <img src="${pageContext.request.contextPath}/resources/images/icon/close.png" alt="닫기" style="width: 16px; height: 16px;">
                </button>
                <div class="modal-title">재고 수정</div>
                <div class="modal-subtitle">재고 정보를 수정합니다</div>
            </div>
            <div class="modal-body">
                <form id="editProductForm">
                    <div class="modal-form-group">
                        <label class="modal-label">재고명 <span style="color: #ff6b00;">*</span></label>
                        <input type="text" class="modal-input" id="editProductName" required>
                    </div>
                    <div class="modal-form-group">
                        <label class="modal-label">수량 <span style="color: #ff6b00;">*</span></label>
                        <input type="number" class="modal-input" id="editProductQuantity" required>
                    </div>
                    <div class="modal-form-group">
                        <label class="modal-label">가격 <span style="color: #ff6b00;">*</span></label>
                        <input type="number" class="modal-input" id="editProductPrice" required>
                    </div>
                    <div class="modal-form-group">
                        <label class="modal-label">카테고리 <span style="color: #ff6b00;">*</span></label>
                        <select class="modal-select" id="editProductCategory" required>
                            <option value="">카테고리 선택</option>
                            <option value="용품">용품</option>
                            <option value="의류">의류</option>
                            <option value="보충제">보충제</option>
                            <option value="회원권">회원권</option>
                        </select>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button class="modal-button modal-button-delete" onclick="confirmDelete()">삭제</button>
                <button class="modal-button modal-button-cancel" onclick="closeEditModal()">취소</button>
                <button class="modal-button modal-button-submit" onclick="submitEditForm()">수정</button>
            </div>
        </div>
    </div>

    <!-- 수량 변경 모달 -->
    <div class="modal-overlay" id="quantityChangeModal">
        <div class="modal-container">
            <div class="modal-header">
                <button class="modal-close" onclick="closeQuantityChangeModal()">
                    <img src="${pageContext.request.contextPath}/resources/images/icon/close.png" alt="닫기" style="width: 16px; height: 16px;">
                </button>
                <div class="modal-title">수량 변경</div>
                <div class="modal-subtitle">재고 수량을 변경합니다.</div>
            </div>
            <div class="modal-body">
                <form id="quantityChangeForm">
                    <div class="modal-form-group">
                        <div class="radio-group">
                            <div class="radio-option">
                                <input type="radio" id="outgoing" name="type" value="outgoing" checked>
                                <label for="outgoing">출고</label>
                            </div>
                            <div class="radio-option">
                                <input type="radio" id="incoming" name="type" value="incoming">
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
                <button class="modal-button modal-button-submit" onclick="submitQuantityChange()">수정</button>
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
                <div class="modal-title">관리 재고 수정</div>
                <div class="modal-subtitle">재고의 변경된 사항을 입력해주세요.</div>
            </div>
            <div class="modal-body">
                <form id="manageInventoryForm">
                    <div class="modal-form-group">
                        <label class="modal-label">재고 이름 <span style="color: #ff6b00;">*</span></label>
                        <input type="text" class="modal-input" id="inventoryNameInput" placeholder="재고 이름을 입력하세요" required>
                    </div>
                    <div class="modal-form-group">
                        <label class="modal-label">관리 재고 수량 <span style="color: #ff6b00;">*</span></label>
                        <input type="number" class="modal-input" id="inventoryQuantitySelect" placeholder="수량을 입력하세요" required min="1">
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button class="modal-button modal-button-cancel" onclick="closeManageInventoryModal()">취소</button>
                <button class="modal-button modal-button-submit" onclick="submitManageInventory()">등록</button>
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

        // 재고 수정 모달 열기
        function openEditModal(productName) {
            document.getElementById('editModal').classList.add('active');
            document.getElementById('editProductName').value = productName;
            // 실제로는 서버에서 데이터를 가져와서 채워야 함
        }

        // 재고 수정 모달 닫기
        function closeEditModal() {
            document.getElementById('editModal').classList.remove('active');
            document.getElementById('editProductForm').reset();
        }

        // 재고 추가 폼 제출
        function submitAddForm() {
            const form = document.getElementById('addProductForm');
            if (form.checkValidity()) {
                alert('재고가 추가되었습니다.');
                closeAddModal();
                // 실제로는 서버로 데이터 전송
            } else {
                alert('모든 필수 항목을 입력해주세요.');
            }
        }

        // 재고 수정 폼 제출
        function submitEditForm() {
            const form = document.getElementById('editProductForm');
            if (form.checkValidity()) {
                alert('재고가 수정되었습니다.');
                closeEditModal();
                // 실제로는 서버로 데이터 전송
            } else {
                alert('모든 필수 항목을 입력해주세요.');
            }
        }

        // 수량 변경 모달 열기
        function openQuantityChangeModal(event, itemName) {
            if (event) {
                event.stopPropagation();
            }
            document.getElementById('quantityChangeModal').classList.add('active');
            // 현재 재고 정보를 가져와서 설정할 수 있음
            document.getElementById('quantityInput').value = '';
        }

        // 수량 변경 모달 닫기
        function closeQuantityChangeModal() {
            document.getElementById('quantityChangeModal').classList.remove('active');
            document.getElementById('quantityChangeForm').reset();
            document.getElementById('outgoing').checked = true;
        }

        // 수량 변경 제출
        function submitQuantityChange() {
            const form = document.getElementById('quantityChangeForm');
            if (form.checkValidity()) {
                const type = document.querySelector('input[name="type"]:checked').value;
                const quantity = document.getElementById('quantityInput').value;
                const typeText = type === 'outgoing' ? '출고' : '입고';
                alert(`${typeText} ${quantity}개가 처리되었습니다.`);
                closeQuantityChangeModal();
                // 실제로는 서버로 데이터 전송
            } else {
                alert('수량을 입력해주세요.');
            }
        }

        // 관리 재고 수정 모달 열기
        function openManageInventoryModal(event, itemName) {
            if (event) {
                event.stopPropagation();
            }
            document.getElementById('manageInventoryModal').classList.add('active');
            document.getElementById('inventoryNameInput').value = itemName || '';
            // 실제로는 서버에서 현재 재고 정보를 가져와서 설정
            document.getElementById('inventoryQuantitySelect').value = '10'; // 예시: 기본값 10개
        }

        // 관리 재고 수정 모달 닫기
        function closeManageInventoryModal() {
            document.getElementById('manageInventoryModal').classList.remove('active');
            document.getElementById('manageInventoryForm').reset();
        }

        // 관리 재고 수정 제출
        function submitManageInventory() {
            const form = document.getElementById('manageInventoryForm');
            if (form.checkValidity()) {
                const inventoryName = document.getElementById('inventoryNameInput').value;
                const quantity = document.getElementById('inventoryQuantitySelect').value;
                alert(`재고 "${inventoryName}"의 수량이 ${quantity}개로 수정되었습니다.`);
                closeManageInventoryModal();
                // 실제로는 서버로 데이터 전송
            } else {
                alert('모든 필수 항목을 입력해주세요.');
            }
        }

        // 상세 보기
        function viewDetail(event, itemName) {
            if (event && event.stopPropagation) {
                event.stopPropagation();
            }
            if (itemName) {
                alert(itemName + ' 상세 정보를 확인합니다.');
            }
        }

        // 편집
        function editItem(event, itemName) {
            event.stopPropagation();
            openEditModal(itemName);
        }

        // 삭제
        function deleteItem(event, itemName) {
            event.stopPropagation();
            confirmDelete(itemName);
        }

        // 삭제 확인
        function confirmDelete(itemName) {
            if (confirm((itemName || '이 재고') + '을(를) 삭제하시겠습니까?')) {
                alert((itemName || '재고') + '이(가) 삭제되었습니다.');
                closeEditModal();
                // 실제로는 서버로 삭제 요청
            }
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
