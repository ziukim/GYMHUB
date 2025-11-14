<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>GymHub - 트레이너 관리</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=ADLaM+Display&family=ABeeZee&family=Noto+Sans+KR:wght@400;700&display=swap" rel="stylesheet">
    <style>
        /* gymTrainerManagement 전용 스타일 */
        /* main-content는 common.css에 있음 */
        
        body {
            font-family: 'ABeeZee', 'Noto Sans KR', sans-serif;
            background: #0a0a0a;
            color: #ffa366;
            overflow: hidden;
        }

        .content-wrapper {
            padding: 0;
        }

        /* Header */
        .page-header {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-bottom: 24px;
        }

        .header-left {
            display: flex;
            align-items: center;
            gap: 16px;
        }

        .back-button {
            height: 36px;
            width: 40px;
            border-radius: 8px;
            display: flex;
            align-items: center;
            justify-content: center;
            background: transparent;
            border: none;
            cursor: pointer;
            transition: background 0.2s;
        }

        .back-button:hover {
            background: rgba(255, 107, 0, 0.1);
        }

        .page-title {
            color: #ff6b00;
            font-size: 24px;
        }

        .add-trainer-button {
            background: #ff6b00;
            border: none;
            border-radius: 8px;
            padding: 8px 20px;
            color: #0a0a0a;
            font-size: 14px;
            cursor: pointer;
            display: flex;
            align-items: center;
            gap: 6px;
            transition: opacity 0.2s;
            font-family: 'ABeeZee', 'Noto Sans KR', sans-serif;
        }

        .add-trainer-button:hover {
            opacity: 0.9;
        }

        /* Trainer Grid */
        .trainer-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
            gap: 20px;
        }

        /* Trainer Card */
        .trainer-card {
            background: #1a0f0a;
            border: 1px solid #ff6b00;
            border-radius: 14px;
            padding: 24px;
            display: flex;
            flex-direction: column;
            transition: all 0.2s;
        }

        .trainer-card:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(255, 107, 0, 0.2);
        }

        .trainer-name {
            color: #ff6b00;
            font-size: 18px;
            font-weight: 500;
            margin-bottom: 16px;
        }

        .trainer-info {
            display: flex;
            flex-direction: column;
            gap: 8px;
            margin-bottom: 20px;
        }

        .trainer-info-item {
            color: #8a6a50;
            font-size: 13px;
            line-height: 1.5;
        }

        .trainer-info-label {
            color: #ffa366;
            margin-right: 4px;
        }

        .trainer-actions {
            margin-top: auto;
        }

        .delete-button {
            width: 36px;
            height: 36px;
            background: transparent;
            border: 1px solid #ff6b00;
            border-radius: 8px;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            transition: all 0.2s;
        }

        .delete-button:hover {
            background: rgba(255, 82, 82, 0.1);
            border-color: #ff5252;
        }

        .delete-icon {
            width: 20px;
            height: 20px;
        }

        /* Modal */
        .modal-overlay {
            position: fixed;
            inset: 0;
            z-index: 50;
            display: none;
            align-items: center;
            justify-content: center;
            background: rgba(0, 0, 0, 0.7);
        }

        .modal-overlay.active {
            display: flex;
        }

        .modal-content {
            background: #1a0f0a;
            border-radius: 10px;
            width: 90%;
            max-width: 500px;
            border: 1px solid #ff6b00;
            box-shadow: 0px 10px 15px -3px rgba(0, 0, 0, 0.3);
            position: relative;
        }

        .modal-close {
            position: absolute;
            right: 17px;
            top: 17px;
            width: 24px;
            height: 24px;
            opacity: 0.7;
            background: transparent;
            border: none;
            cursor: pointer;
            transition: opacity 0.2s;
            color: #ffa366;
            font-size: 24px;
            line-height: 1;
        }

        .modal-close:hover {
            opacity: 1;
        }

        .modal-header {
            padding: 25px 25px 16px;
        }

        .modal-title {
            font-family: 'Arial', 'Noto Sans KR', sans-serif;
            font-weight: 700;
            color: #ff6b00;
            font-size: 18px;
            margin-bottom: 8px;
        }

        .modal-description {
            color: #8a6a50;
            font-size: 14px;
        }

        .modal-body {
            padding: 0 25px 25px;
        }

        /* 아이디 조회 섹션 */
        .id-lookup-group {
            display: flex;
            gap: 8px;
            align-items: flex-start;
        }

        .lookup-btn {
            background: #ff6b00;
            border: none;
            border-radius: 8px;
            padding: 0 16px;
            height: 40px;
            color: #0a0a0a;
            font-size: 14px;
            cursor: pointer;
            white-space: nowrap;
            transition: opacity 0.2s;
            font-family: 'ABeeZee', 'Noto Sans KR', sans-serif;
        }

        .lookup-btn:hover {
            opacity: 0.9;
        }

        /* 트레이너 프로필 카드 */
        .trainer-profile-card {
            background: #2d1810;
            border: 1px solid #ff6b00;
            border-radius: 8px;
            padding: 20px;
            margin-top: 16px;
            margin-bottom: 16px;
        }

        .profile-header {
            display: flex;
            align-items: center;
            gap: 16px;
            margin-bottom: 16px;
            padding-bottom: 16px;
            border-bottom: 1px solid rgba(255, 107, 0, 0.3);
        }

        .profile-avatar {
            width: 60px;
            height: 60px;
            border-radius: 50%;
            border: 2px solid #ff6b00;
            overflow: hidden;
            flex-shrink: 0;
            background: #1a0f0a;
            display: flex;
            align-items: center;
            justify-content: center;
            position: relative;
            color: white;
            font-size: 24px;
            font-weight: bold;
        }

        .profile-avatar img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            position: absolute;
            top: 0;
            left: 0;
        }

        .profile-avatar span {
            position: relative;
            z-index: 1;
            color: white;
            font-size: 24px;
            font-weight: bold;
        }

        .profile-info {
            flex: 1;
        }

        .profile-name {
            font-size: 18px;
            font-weight: bold;
            color: #ff6b00;
            margin-bottom: 4px;
        }

        .profile-id {
            font-size: 14px;
            color: #ffa366;
        }

        .profile-details {
            display: flex;
            flex-direction: column;
            gap: 12px;
        }

        .detail-row {
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .detail-icon {
            width: 16px;
            height: 16px;
            flex-shrink: 0;
            color: #ff6b00;
        }

        .detail-label {
            font-size: 14px;
            color: #ffa366;
            min-width: 80px;
        }

        .detail-value {
            font-size: 14px;
            color: white;
            flex: 1;
        }

        /* 트레이너 조회 섹션 */
        .trainer-lookup-section {
            margin-top: 20px;
        }

        .lookup-section-title {
            font-size: 18px;
            color: #ff6b00;
            font-weight: 700;
            margin-bottom: 16px;
        }

        .form-group {
            margin-bottom: 16px;
        }

        .form-label {
            display: block;
            color: #ffa366;
            font-size: 14px;
            margin-bottom: 8px;
        }

        .form-input {
            background: #2d1810;
            border: 1px solid #ff6b00;
            border-radius: 8px;
            width: 100%;
            height: 40px;
            padding: 0 12px;
            color: #ffa366;
            font-size: 14px;
            font-family: 'ABeeZee', 'Noto Sans KR', sans-serif;
        }

        .form-input:focus {
            outline: none;
            border-color: #ffa366;
        }

        .form-input::placeholder {
            color: #8a6a50;
        }

        .modal-buttons {
            display: flex;
            gap: 12px;
            padding-top: 16px;
        }

        .modal-button {
            flex: 1;
            height: 40px;
            border-radius: 8px;
            font-size: 14px;
            cursor: pointer;
            border: none;
            transition: opacity 0.2s;
            font-family: 'ABeeZee', 'Noto Sans KR', sans-serif;
        }

        .modal-button:hover {
            opacity: 0.9;
        }

        .btn-cancel {
            background: #0a0a0a;
            border: 1px solid #8a6a50;
            color: #8a6a50;
        }

        .btn-confirm {
            background: #ff6b00;
            color: #0a0a0a;
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
            <div class="content-wrapper">
                <!-- Header -->
                <div class="page-intro">
                    <h1>트레이너 관리</h1>
                    <p>헬스장의 트레이너를 등록하고 관리하세요</p>
                </div>
                <div class="page-header">
                    <div class="header-left">
                    </div>
                    <button class="add-trainer-button" onclick="openAddModal()">
                        <img src="${pageContext.request.contextPath}/resources/images/icon/add.png" alt="추가" style="width: 16px; height: 16px;">
                        <span>트레이너 등록</span>
                    </button>
                </div>

                <!-- Trainer Grid -->
                <div class="trainer-grid" id="trainerGrid">
                    <c:choose>
                        <c:when test="${empty trainers}">
                            <div style="grid-column: 1 / -1; text-align: center; padding: 40px; color: #8a6a50;">
                                등록된 트레이너가 없습니다.
                            </div>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="trainer" items="${trainers}">
                                <div class="trainer-card">
                                    <div class="trainer-name">${trainer.memberName}</div>
                                    <div class="trainer-info">
                                        <div class="trainer-info-item">
                                            <span class="trainer-info-label">연락처:</span><br>
                                            ${trainer.memberPhone}
                                        </div>
                                        <c:if test="${not empty trainer.memberEmail}">
                                            <div class="trainer-info-item">
                                                <span class="trainer-info-label">이메일:</span><br>
                                                ${trainer.memberEmail}
                                            </div>
                                        </c:if>
                                    </div>
                                    <div class="trainer-actions">
                                        <form method="post" action="${pageContext.request.contextPath}/trainer/delete.gym" style="display: inline;">
                                            <input type="hidden" name="memberNo" value="${trainer.memberNo}">
                                            <button type="submit" class="delete-button" onclick="return confirm('정말 삭제하시겠습니까?')">
                                                <img src="${pageContext.request.contextPath}/resources/images/icon/delete.png" alt="삭제" class="delete-icon">
                                            </button>
                                        </form>
                                    </div>
                                </div>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
    </div>

    <!-- Add/Edit Trainer Modal -->
    <div class="modal-overlay" id="trainerModal">
        <div class="modal-content">
            <button class="modal-close" onclick="closeModal()">
                <img src="${pageContext.request.contextPath}/resources/images/icon/close.png" alt="닫기" style="width: 16px; height: 16px;">
            </button>

            <div class="modal-header">
                <h2 class="modal-title" id="modalTitle">트레이너 등록</h2>
                <p class="modal-description">새로운 트레이너를 등록하세요</p>
            </div>

            <form method="post" action="${pageContext.request.contextPath}/trainer/register.gym" id="trainerRegisterForm">
            <div class="modal-body">
                <!-- 아이디 조회 -->
                <div class="form-group">
                    <label class="form-label">아이디 조회</label>
                    <div class="id-lookup-group">
                        <input type="text" class="form-input" id="trainerIdInput" name="memberId" placeholder="예: 김트레이너" required>
                        <button type="button" class="lookup-btn" onclick="lookupTrainerId()">조회하기</button>
                    </div>
                </div>

                <!-- 트레이너 조회 섹션 -->
                <div class="trainer-lookup-section" id="trainerLookupSection" style="display: none;">
                    <h3 class="lookup-section-title">트레이너 조회</h3>
                    
                    <!-- 트레이너 프로필 카드 -->
                    <div class="trainer-profile-card">
                        <div class="profile-header">
                            <div class="profile-avatar" id="trainerAvatar">
                                <img id="trainerAvatarImg" src="" alt="프로필" style="display: none; width: 100%; height: 100%; object-fit: cover; border-radius: 50%;">
                                <span id="trainerAvatarText">홍</span>
                            </div>
                            <div class="profile-info">
                                <div class="profile-name" id="trainerProfileName">홍길동</div>
                                <div class="profile-id" id="trainerProfileId">010915</div>
                            </div>
                        </div>
                        <div class="profile-details">
                            <div class="detail-row">
                                <span class="detail-label">이름</span>
                                <span class="detail-value" id="trainerDetailName">홍길동</span>
                            </div>
                            <div class="detail-row">
                                <span class="detail-label">생년월일</span>
                                <span class="detail-value" id="trainerDetailBirth">010915</span>
                            </div>
                            <div class="detail-row">
                                <img src="${pageContext.request.contextPath}/resources/images/icon/call.png" alt="연락처" class="detail-icon">
                                <span class="detail-label">연락처</span>
                                <span class="detail-value" id="trainerDetailPhone">010-1234-5678</span>
                            </div>
                            <div class="detail-row">
                                <img src="${pageContext.request.contextPath}/resources/images/icon/output.png" alt="이메일" class="detail-icon">
                                <span class="detail-label">이메일</span>
                                <span class="detail-value" id="trainerDetailEmail">hong@example.com</span>
                            </div>
                            <div class="detail-row">
                                <img src="${pageContext.request.contextPath}/resources/images/icon/location.png" alt="주소" class="detail-icon">
                                <span class="detail-label">주소</span>
                                <span class="detail-value" id="trainerDetailAddress">서울시 강남구 테헤란로 123</span>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="modal-buttons">
                    <button type="button" class="modal-button btn-cancel" onclick="closeModal()">취소</button>
                    <button type="submit" class="modal-button btn-confirm" id="registerSubmitBtn" disabled>등록</button>
                </div>
            </div>
            </form>
        </div>
    </div>

    <script>
        let trainerData = null;

        // Open add modal
        function openAddModal() {
            document.getElementById('modalTitle').textContent = '트레이너 등록';
            document.getElementById('trainerIdInput').value = '';
            document.getElementById('trainerLookupSection').style.display = 'none';
            document.getElementById('registerSubmitBtn').disabled = true;
            trainerData = null;
            document.getElementById('trainerModal').classList.add('active');
        }

        // Close modal
        function closeModal() {
            document.getElementById('trainerModal').classList.remove('active');
            // 초기화
            document.getElementById('trainerIdInput').value = '';
            document.getElementById('trainerLookupSection').style.display = 'none';
            document.getElementById('registerSubmitBtn').disabled = true;
            trainerData = null;
        }

        // 아이디 조회 함수
        function lookupTrainerId() {
            const trainerId = document.getElementById('trainerIdInput').value.trim();
            
            if (!trainerId) {
                alert('아이디를 입력해주세요.');
                return;
            }
            
            // 서버에서 트레이너 조회 (memberType=2, gymNo=null)
            fetch('${pageContext.request.contextPath}/trainer/lookup.ajax?memberId=' + encodeURIComponent(trainerId))
                .then(response => response.json())
                .then(data => {
                    if (data.success) {
                        trainerData = data.trainer;
                        
                        // 프로필 카드에 데이터 설정
                        document.getElementById('trainerProfileName').textContent = trainerData.memberName || '';
                        document.getElementById('trainerProfileId').textContent = trainerData.memberId || '';
                        document.getElementById('trainerDetailName').textContent = trainerData.memberName || '';
                        document.getElementById('trainerDetailBirth').textContent = trainerData.memberBirth ? new Date(trainerData.memberBirth).toLocaleDateString('ko-KR') : '';
                        document.getElementById('trainerDetailPhone').textContent = trainerData.memberPhone || '';
                        document.getElementById('trainerDetailEmail').textContent = trainerData.memberEmail || '없음';
                        document.getElementById('trainerDetailAddress').textContent = trainerData.memberAddress || '없음';
                        
                        // 프로필 아바타 업데이트 (프로필 사진이 있으면 표시, 없으면 기본 아바타)
                        const trainerAvatarImg = document.getElementById('trainerAvatarImg');
                        const trainerAvatarText = document.getElementById('trainerAvatarText');
                        
                        if (trainerData.memberPhotoPath && trainerData.memberPhotoPath.trim() !== '') {
                            // 프로필 사진이 있는 경우
                            trainerAvatarImg.src = '${pageContext.request.contextPath}' + trainerData.memberPhotoPath;
                            trainerAvatarImg.style.display = 'block';
                            trainerAvatarText.style.display = 'none';
                        } else {
                            // 프로필 사진이 없는 경우 기본 아바타 (이름의 첫 글자)
                            const firstChar = trainerData.memberName ? trainerData.memberName.charAt(0) : '?';
                            trainerAvatarText.textContent = firstChar;
                            trainerAvatarImg.style.display = 'none';
                            trainerAvatarText.style.display = 'block';
                        }
                        
                        // 트레이너 조회 섹션 표시
                        document.getElementById('trainerLookupSection').style.display = 'block';
                        
                        // 등록 버튼 활성화
                        document.getElementById('registerSubmitBtn').disabled = false;
                    } else {
                        alert(data.message || '등록 가능한 트레이너를 찾을 수 없습니다. (이미 다른 헬스장에 등록되었거나 트레이너가 아닌 회원입니다.)');
                        document.getElementById('trainerLookupSection').style.display = 'none';
                        document.getElementById('registerSubmitBtn').disabled = true;
                    }
                })
                .catch(error => {
                    console.error('트레이너 조회 오류:', error);
                    alert('트레이너 조회 중 오류가 발생했습니다.');
                    document.getElementById('trainerLookupSection').style.display = 'none';
                    document.getElementById('registerSubmitBtn').disabled = true;
                });
        }

        // Close modal when clicking outside
        document.getElementById('trainerModal').addEventListener('click', (e) => {
            if (e.target.id === 'trainerModal') {
                closeModal();
            }
        });

        // Enter 키 입력 시 조회
        document.getElementById('trainerIdInput').addEventListener('keypress', (e) => {
            if (e.key === 'Enter') {
                lookupTrainerId();
            }
        });

        // 폼 제출 전 검증
        document.getElementById('trainerRegisterForm').addEventListener('submit', function(e) {
            const trainerId = document.getElementById('trainerIdInput').value.trim();
            
            if (!trainerId) {
                e.preventDefault();
                alert('아이디를 입력해주세요.');
                return false;
            }
            
            if (document.getElementById('trainerLookupSection').style.display === 'none') {
                e.preventDefault();
                alert('아이디 조회를 먼저 진행해주세요.');
                return false;
            }
            
            if (!trainerData) {
                e.preventDefault();
                alert('트레이너 정보를 조회해주세요.');
                return false;
            }
        });
    </script>
</body>
</html>

