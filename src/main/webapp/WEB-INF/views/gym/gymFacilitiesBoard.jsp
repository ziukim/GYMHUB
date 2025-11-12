<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
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
            color: #00c950; /* Green, matching occupied locker-item border */
        }

        .status-value.expiring {
            color: #fdc700;
        }

        .status-value.available {
            color: #b0b0b0; /* Grey, matching other labels */
        }

        .machine-image {
            width: 60px;
            height: 60px;
            object-fit: cover;
            border-radius: 8px;
            border: 2px solid #ff6b00;
        }

        .delete-btn {
            border-color: #f44336;
            color: #ff6666;
        }

        .delete-btn:hover {
            background-color: #f44336;
            color: white;
        }

        .empty-message {
            text-align: center;
            padding: 40px 20px;
            color: #b0b0b0;
            font-size: 16px;
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

        <!-- 알림 메시지 -->
        <c:if test="${not empty alertMsg}">
            <script>
                alert("${alertMsg}");
            </script>
        </c:if>
        <c:if test="${not empty errorMsg}">
            <script>
                alert("${errorMsg}");
            </script>
        </c:if>

        <!-- Stats Cards -->
        <div class="stats-grid">
            <div class="stat-card">
                <div class="stat-card-icon">
                    <img src="${pageContext.request.contextPath}/resources/images/icon/machine.png" alt="운동 기구" style="width: 24px; height: 24px;">
                </div>
                <div class="stat-card-label">운동 기구</div>
                <div class="stat-card-value">${not empty machineList ? machineList.size() : 0}개</div>
                <div class="stat-card-sub">전체 기구수</div>
            </div>
            <div class="stat-card">
                <div class="stat-card-icon">
                    <img src="${pageContext.request.contextPath}/resources/images/icon/done.png" alt="정상" style="width: 24px; height: 24px;">
                </div>
                <div class="stat-card-value">
                    <c:set var="activeCount" value="0"/>
                    <c:forEach items="${machineList}" var="m">
                        <c:if test="${m.machineStatus == 'Y'}">
                            <c:set var="activeCount" value="${activeCount + 1}"/>
                        </c:if>
                    </c:forEach>
                    ${activeCount}개
                </div>
                <div class="stat-card-sub">정상</div>
            </div>
            <div class="stat-card">
                <div class="stat-card-icon">
                    <img src="${pageContext.request.contextPath}/resources/images/icon/inspection.png" alt="수리" style="width: 24px; height: 24px;">
                </div>
                <div class="stat-card-value">
                    <c:set var="inspectionCount" value="0"/>
                    <c:forEach items="${machineList}" var="m">
                        <c:if test="${m.machineStatus == 'I'}">
                            <c:set var="inspectionCount" value="${inspectionCount + 1}"/>
                        </c:if>
                    </c:forEach>
                    ${inspectionCount}개
                </div>
                <div class="stat-card-sub">점검</div>
            </div>
            <div class="stat-card">
                <div class="stat-card-icon">
                    <img src="${pageContext.request.contextPath}/resources/images/icon/breakdown.png" alt="경고" style="width: 24px; height: 24px;">
                </div>
                <div class="stat-card-value">
                    <c:set var="brokenCount" value="0"/>
                    <c:forEach items="${machineList}" var="m">
                        <c:if test="${m.machineStatus == 'N'}">
                            <c:set var="brokenCount" value="${brokenCount + 1}"/>
                        </c:if>
                    </c:forEach>
                    ${brokenCount}개
                </div>
                <div class="stat-card-sub">고장</div>
            </div>
        </div>

        <!-- 기구 관리 -->
        <div class="section">
            <div class="section-header">
                <div class="section-title-group">
                    <h2>기구 관리</h2>
                    <p>전체 ${not empty machineList ? machineList.size() : 0}개 기구</p>
                </div>
                <button class="add-button" onclick="addEquipment()">+ 기구 추가</button>
            </div>

            <c:choose>
                <c:when test="${empty machineList}">
                    <div class="empty-message">
                        등록된 기구가 없습니다. 기구를 추가해주세요.
                    </div>
                </c:when>
                <c:otherwise>
                    <table>
                        <thead>
                        <tr>
                            <th>이미지</th>
                            <th>기구명</th>
                            <th>브랜드명</th>
                            <th>상태</th>
                            <th>최근 점검일</th>
                            <th>다음 점검일</th>
                            <th>관리</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${machineList}" var="machine">
                            <tr>
                                <td>
                                    <c:choose>
                                        <c:when test="${not empty machine.machinePhotoPath}">
                                            <img src="${pageContext.request.contextPath}${machine.machinePhotoPath}"
                                                 alt="${machine.machineName}"
                                                 class="machine-image"
                                                 onerror="this.src='${pageContext.request.contextPath}/resources/images/icon/machine.png'">
                                        </c:when>
                                        <c:otherwise>
                                            <img src="${pageContext.request.contextPath}/resources/images/icon/machine.png"
                                                 alt="기본 이미지"
                                                 class="machine-image">
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>${machine.machineName}</td>
                                <td>${machine.brand}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${machine.machineStatus == 'Y'}">정상</c:when>
                                        <c:when test="${machine.machineStatus == 'I'}">점검중</c:when>
                                        <c:when test="${machine.machineStatus == 'N'}">고장</c:when>
                                        <c:otherwise>-</c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${not empty machine.machineCheckedDate}">
                                            <fmt:formatDate value="${machine.machineCheckedDate}" pattern="yyyy.MM.dd" />
                                        </c:when>
                                        <c:otherwise>-</c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${not empty machine.machineNextCheck}">
                                            <fmt:formatDate value="${machine.machineNextCheck}" pattern="yyyy.MM.dd" />
                                        </c:when>
                                        <c:otherwise>-</c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <button class="action-btn" onclick="editEquipment(${machine.machineManageNo})">수정</button>
                                    <button class="action-btn delete-btn" onclick="deleteMachine(${machine.machineManageNo}, '${machine.machineName}')">삭제</button>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </c:otherwise>
            </c:choose>
        </div>

        <!-- Bottom Grid -->
        <div class="bottom-grid">
            <!-- 락커 관리 -->
            <div class="section">
                <div class="section-header">
                    <div class="section-title-group">
                        <h2>락커 관리</h2>
                        <p>전체 ${not empty lockerPassList ? lockerPassList.size() : 0}개 락커</p>
                    </div>
                    <button class="add-button" onclick="addLocker()">+ 락커 추가</button>
                </div>

                <c:choose>
                    <c:when test="${empty lockerPassList}">
                        <div class="empty-message">
                            등록된 락커가 없습니다.
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="locker-grid">
                            <c:forEach items="${lockerPassList}" var="locker">
                                <c:choose>
                                    <c:when test="${not empty locker.memberName}">
                                        <div class="locker-item occupied">
                                            <div class="locker-number">${locker.lockerRealNum}</div>
                                            <div class="locker-name">${locker.memberName}</div>
                                            <div class="locker-date">
                                                <fmt:formatDate value="${locker.lockerPassStart}" pattern="yy.MM.dd" />
                                            </div>
                                            <div class="locker-date">
                                                <fmt:formatDate value="${locker.lockerEnd}" pattern="yy.MM.dd" />
                                            </div>
                                        </div>
                                    </c:when>
                                    <c:otherwise>
                                        <div class="locker-item available">
                                            <div class="locker-number">${locker.lockerRealNum}</div>
                                            <div class="locker-name">-</div>
                                            <div class="locker-date">-</div>
                                            <div class="locker-date">-</div>
                                        </div>
                                    </c:otherwise>
                                </c:choose>
                            </c:forEach>
                        </div>
                    </c:otherwise>
                </c:choose>
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
                        <div class="status-value">${not empty lockerPassList ? lockerPassList.size() : 0}개</div>
                    </div>
                    <div class="status-sub-grid">
                        <div class="status-item">
                            <div class="status-label">사용중</div>
                            <div class="status-value used">
                                <c:set var="usedCount" value="0" />
                                <c:forEach items="${lockerPassList}" var="l">
                                    <c:if test="${not empty l.memberName}">
                                        <c:set var="usedCount" value="${usedCount + 1}" />
                                    </c:if>
                                </c:forEach>
                                ${usedCount}개
                            </div>
                        </div>
                        <div class="status-item">
                            <div class="status-label">만료예정</div>
                            <div class="status-value expiring">
                                 <c:set var="expiringCount" value="0" />
                                <c:forEach items="${lockerPassList}" var="l">
                                    <c:set var="now" value="<%=new java.util.Date()%>" />
                                    <c:if test="${l.lockerEnd.time > now.time && (l.lockerEnd.time - now.time) < (7 * 24 * 60 * 60 * 1000)}">
                                        <c:set var="expiringCount" value="${expiringCount + 1}" />
                                    </c:if>
                                </c:forEach>
                                ${expiringCount}개
                            </div>
                        </div>
                    </div>
                    <div class="status-item">
                        <div class="status-label">사용 가능한 락커 수</div>
                        <div class="status-value available">
                            ${(not empty lockerPassList ? lockerPassList.size() : 0) - usedCount}개
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- 기구 수정 모달 -->
<div class="modal-overlay" id="editMachineModal" onclick="closeModalOnOverlay(event, 'editMachineModal')">
    <div class="modal-container" onclick="event.stopPropagation()">
        <div class="modal-header">
            <button class="modal-close" onclick="closeModal('editMachineModal')">×</button>
            <h2 class="modal-title">기구 정보 수정</h2>
            <p class="modal-subtitle" id="modalMachineName"></p>
        </div>
        <div class="modal-body">
            <input type="hidden" id="editMachineManageNo">

            <div class="modal-form-group">
                <label class="modal-label" for="editMachineStatus">
                    상태<span class="required">*</span>
                </label>
                <select id="editMachineStatus" class="modal-select">
                    <option value="Y">정상</option>
                    <option value="I">점검중</option>
                    <option value="N">고장</option>
                </select>
            </div>

            <div class="modal-form-group">
                <label class="modal-label" for="editMachineCheckedDate">
                    최근 점검일<span class="required">*</span>
                </label>
                <input type="date" id="editMachineCheckedDate" class="modal-date-input" required>
            </div>

            <div class="modal-form-group">
                <label class="modal-label" for="editMachineNextCheck">
                    다음 점검일<span class="required">*</span>
                </label>
                <input type="date" id="editMachineNextCheck" class="modal-date-input" required>
            </div>
        </div>
        <div class="modal-footer">
            <button class="modal-button modal-button-cancel" onclick="closeModal('editMachineModal')">취소</button>
            <button class="modal-button modal-button-submit" onclick="submitMachineUpdate()">수정</button>
        </div>
    </div>
</div>

<!-- 락커 추가 모달 -->
<div class="modal-overlay" id="addLockerModal" onclick="closeModalOnOverlay(event, 'addLockerModal')">
    <div class="modal-container" onclick="event.stopPropagation()">
        <div class="modal-header">
            <button class="modal-close" onclick="closeModal('addLockerModal')">×</button>
            <h2 class="modal-title">신규 락커 추가</h2>
            <p class="modal-subtitle">새로운 빈 락커를 시스템에 등록합니다.</p>
        </div>
        <div class="modal-body">
            <div class="modal-form-group">
                <label class="modal-label" for="lockerRealNum">
                    락커 번호<span class="required">*</span>
                </label>
                <input type="text" id="lockerRealNum" class="modal-input" placeholder="예: A-151">
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
        location.href = '${pageContext.request.contextPath}/machineEnrollForm.gym';
    }

    // 기구 수정 모달 열기
    function editEquipment(machineManageNo) {
        fetch('${pageContext.request.contextPath}/machineDetail.gym?machineManageNo=' + machineManageNo)
            .then(function(response) {
                return response.json();
            })
            .then(function(data) {
                document.getElementById('editMachineManageNo').value = data.machineManageNo;
                document.getElementById('modalMachineName').textContent = data.machineName + ' - ' + data.brand;
                document.getElementById('editMachineStatus').value = data.machineStatus || 'Y';

                if (data.machineCheckedDate) {
                    var checkedDate = new Date(data.machineCheckedDate);
                    document.getElementById('editMachineCheckedDate').value = formatDateForInput(checkedDate);
                }

                if (data.machineNextCheck) {
                    var nextCheck = new Date(data.machineNextCheck);
                    document.getElementById('editMachineNextCheck').value = formatDateForInput(nextCheck);
                }

                openModal('editMachineModal');
            })
            .catch(function(error) {
                console.error('Error:', error);
                alert('기구 정보를 불러오는데 실패했습니다.');
            });
    }

    // 날짜 형식 변환
    function formatDateForInput(date) {
        var year = date.getFullYear();
        var month = String(date.getMonth() + 1).padStart(2, '0');
        var day = String(date.getDate()).padStart(2, '0');
        return year + '-' + month + '-' + day;
    }

    // 기구 정보 수정
    function submitMachineUpdate() {
        var machineManageNo = document.getElementById('editMachineManageNo').value;
        var machineStatus = document.getElementById('editMachineStatus').value;
        var machineCheckedDate = document.getElementById('editMachineCheckedDate').value;
        var machineNextCheck = document.getElementById('editMachineNextCheck').value;

        if (!machineCheckedDate || !machineNextCheck) {
            alert('모든 필드를 입력해주세요.');
            return;
        }

        var data = {
            machineManageNo: machineManageNo,
            machineStatus: machineStatus,
            machineCheckedDate: machineCheckedDate,
            machineNextCheck: machineNextCheck
        };

        fetch('${pageContext.request.contextPath}/machineUpdate.gym', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify(data)
        })
            .then(function(response) {
                return response.text();
            })
            .then(function(result) {
                if (result === 'success') {
                    alert('기구 정보가 수정되었습니다.');
                    location.reload();
                } else {
                    alert('기구 정보 수정에 실패했습니다.');
                }
            })
            .catch(function(error) {
                console.error('Error:', error);
                alert('기구 정보 수정 중 오류가 발생했습니다.');
            });
    }

    // 기구 삭제
    function deleteMachine(machineManageNo, machineName) {
        if (!confirm(machineName + ' 기구를 삭제하시겠습니까?')) {
            return;
        }

        fetch('${pageContext.request.contextPath}/machineDelete.gym?machineManageNo=' + machineManageNo, {
            method: 'POST'
        })
            .then(function(response) {
                return response.text();
            })
            .then(function(result) {
                if (result === 'success') {
                    alert('기구가 삭제되었습니다.');
                    location.reload();
                } else {
                    alert('기구 삭제에 실패했습니다.');
                }
            })
            .catch(function(error) {
                console.error('Error:', error);
                alert('기구 삭제 중 오류가 발생했습니다.');
            });
    }

    // 모달 열기
    function openModal(modalId) {
        var modal = document.getElementById(modalId);
        if (modal) {
            modal.classList.add('active');
            document.body.style.overflow = 'hidden';
        }
    }

    // 모달 닫기
    function closeModal(modalId) {
        var modal = document.getElementById(modalId);
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
        document.getElementById('lockerRealNum').value = '';
        openModal('addLockerModal');
    }

    // 락커 등록
    function submitLockerRegistration() {
        var lockerRealNum = document.getElementById('lockerRealNum').value.trim();

        if (!lockerRealNum) {
            alert('락커 번호를 입력해주세요.');
            return;
        }

        var formData = new FormData();
        formData.append('lockerRealNum', lockerRealNum);

        fetch('${pageContext.request.contextPath}/locker/add.gym', {
            method: 'POST',
            body: new URLSearchParams(formData)
        })
        .then(function(response) {
            return response.text();
        })
        .then(function(result) {
            if (result === 'success') {
                alert('새로운 락커가 등록되었습니다.');
                location.reload();
            } else if (result === 'fail_duplicate') {
                alert('이미 등록된 락커 번호입니다.');
            } else if (result === 'fail_auth') {
                alert('인증에 실패했습니다. 다시 로그인해주세요.');
            } else {
                alert('락커 등록에 실패했습니다.');
            }
        })
        .catch(function(error) {
            console.error('Error:', error);
            alert('락커 등록 중 오류가 발생했습니다.');
        });
    }

    // ESC 키로 모달 닫기
    document.addEventListener('keydown', function(event) {
        if (event.key === 'Escape') {
            var activeModal = document.querySelector('.modal-overlay.active');
            if (activeModal) {
                closeModal(activeModal.id);
            }
        }
    });

    // 락커 클릭
    var lockerItems = document.querySelectorAll('.locker-item');
    for (var i = 0; i < lockerItems.length; i++) {
        lockerItems[i].addEventListener('click', function() {
            var number = this.querySelector('.locker-number').textContent;
            var name = this.querySelector('.locker-name').textContent;
            if (name === '-') {
                alert(number + ' 락커는 사용 가능합니다.');
            } else {
                alert(number + ' 락커 정보\n사용자: ' + name);
            }
        });
    }


</script>
</body>
</html>
