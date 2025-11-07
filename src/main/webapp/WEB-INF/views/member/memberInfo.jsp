<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>내 정보 - Gym Hub</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common.css">

    <style>
        .main-content {
            flex: 1;
            width: 100%;
            max-width: 100%;
            padding: 40px 40px 40px 20px;
            margin-left: 0;
        }
        /* 추가 스타일 - common.css에 없는 부분만 */
        .profile-section {
            display: flex;
            gap: 24px;
            align-items: flex-start;
            margin-bottom: 24px;
        }

        .profile-image-container {
            position: relative;
            width: 96px;
            height: 96px;
            flex-shrink: 0;
        }

        .profile-image {
            width: 96px;
            height: 96px;
            background-color: #2d1810;
            border: 1px solid #ff6b00;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            overflow: hidden;
        }

        .profile-image img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .profile-image svg {
            width: 48px;
            height: 48px;
        }

        .camera-button {
            position: absolute;
            right: 0;
            bottom: 0;
            background: transparent;  /* 배경 투명하게 */
            border: none;  /* 테두리 제거 */
            cursor: pointer;
            font-size: 20px;  /* 아이콘 크기 조정 */
            padding: 0;
            width: auto;  /* 자동 너비 */
            height: auto;  /* 자동 높이 */
            transform: none;
            line-height: 1;
        }

        .camera-button:hover {
            transform: scale(1.2);  /* 호버 시 살짝 커지는 효과 */
            filter: brightness(1.2);  /* 호버 시 밝아지는 효과 */
        }

        .profile-info {
            flex: 1;
        }

        .info-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 16px;
            margin-bottom: 16px;
        }

        .info-item {
            display: flex;
            flex-direction: column;
            gap: 4px;
        }

        .info-item.full-width {
            grid-column: 1 / -1;
        }

        .info-label {
            font-size: 14px;
            color: #8a6a50;
        }

        .info-value {
            font-size: 16px;
            color: #ffa366;
        }

        .edit-buttons {
            display: flex;
            gap: 8px;
            margin-top: 16px;
        }

        .membership-dates p {
            font-size: 14px;
            color: #8a6a50;
            margin: 4px 0;
        }

        .date-label {
            display: inline-block;
            width: 42px;
        }

        .remaining-days {
            font-size: 14px;
            color: #4caf50;
            margin-top: 8px;
        }

        .pt-count {
            font-size: 24px;
            color: #ffa366;
            font-weight: 400;
        }

        .pt-remaining {
            font-size: 14px;
            color: #8a6a50;
        }

        .locker-number {
            font-size: 35px;
            color: #ffa366;
        }

        .locker-expire {
            font-size: 20px;
            color: #8a6a50;
        }

        @media (max-width: 768px) {
            .info-grid {
                grid-template-columns: 1fr;
            }
        }

    </style>
</head>
<body>
<div class="app-container">
    <!-- Sidebar Include -->
    <jsp:include page="../common/sidebar/sidebarMember.jsp" />

    <!-- Main Content -->
    <div class="main-content">
        <header class="header">
            <div>
                <h1 class="page-title">내 정보</h1>
                <p class="page-subtitle" style="color: #8a6a50;">회원 정보를 확인하고 관리하세요</p>
            </div>
        </header>

        <!-- 프로필 카드 -->
        <section class="card">
            <div class="profile-section">
                <div class="profile-image-container">
                    <div class="profile-image" id="mainProfileImage">
                        <svg viewBox="0 0 48 48" fill="none">
                            <path d="M24 24C28.4183 24 32 20.4183 32 16C32 11.5817 28.4183 8 24 8C19.5817 8 16 11.5817 16 16C16 20.4183 19.5817 24 24 24Z" stroke="#FF6B00" stroke-width="4" stroke-linecap="round" stroke-linejoin="round"/>
                            <path d="M40 40C40 35.757 38.3143 31.6869 35.3137 28.6863C32.3131 25.6857 28.243 24 24 24C19.757 24 15.6869 25.6857 12.6863 28.6863C9.68571 31.6869 8 35.757 8 40" stroke="#FF6B00" stroke-width="4" stroke-linecap="round" stroke-linejoin="round"/>
                        </svg>
                    </div>
                    <input type="file" id="profileImageInput" accept="image/*" style="display: none;">
                    <button class="camera-button" onclick="document.getElementById('profileImageInput').click()">📷</button>
                </div>

                <div class="profile-info">
                    <div class="info-grid">
                        <div class="info-item">
                            <label class="info-label">이름</label>
                            <p class="info-value">${loginMember.memberName}</p>
                        </div>
                        <div class="info-item">
                            <label class="info-label">생년월일</label>
                            <p class="info-value">1990. 1. 15.</p>
                        </div>
                    </div>

                    <div class="info-grid">
                        <div class="info-item">
                            <label class="info-label">연락처</label>
                            <p class="info-value">${loginMember.phone}</p>
                        </div>
                        <div class="info-item">
                            <label class="info-label">이메일</label>
                            <p class="info-value">${loginMember.email}</p>
                        </div>
                    </div>

                    <div class="info-item full-width">
                        <label class="info-label">주소</label>
                        <p class="info-value">${loginMember.address}</p>
                    </div>

                    <div class="info-item">
                        <label class="info-label">소속 헬스장</label>
                        <p class="info-value">강남 헬스보이짐</p>
                    </div>

                    <div class="edit-buttons">
                        <button class="btn btn-primary" onclick="openModal('editModal')">정보 수정</button>
                        <button class="btn btn-secondary" onclick="openModal('passwordModal')">비밀번호 변경</button>
                    </div>
                </div>
            </div>
        </section>

        <!-- 정보 카드들 -->
        <section class="info-cards">
            <div class="info-card">
                <div class="card-header">
                    <span class="card-icon">
                        <img src="${pageContext.request.contextPath}/resources/images/icon/ticket.png" alt="회원권 아이콘">
                    </span>
                    <h3>회원권</h3>
                </div>
                <div class="card-content">
                    <span class="badge">프리미엄 회원권</span>
                    <div class="membership-dates">
                        <p><span class="date-label">시작:</span> 2025. 4. 1.</p>
                        <p><span class="date-label">만료:</span> 2026. 3. 31.</p>
                    </div>
                    <p class="remaining-days">154일 남음</p>
                    <div class="progress-bar">
                        <div class="progress-fill" style="width: 42%"></div>
                    </div>
                </div>
            </div>

            <div class="info-card">
                <div class="card-header">
                    <span class="card-icon">
                        <img src="${pageContext.request.contextPath}/resources/images/icon/calendar.png" alt="PT정보 아이콘">
                    </span>
                    <h3>PT 정보</h3>
                </div>
                <div class="card-content">
                    <p class="pt-count">8 / 20회</p>
                    <div class="progress-bar">
                        <div class="progress-fill" style="width: 40%"></div>
                    </div>
                    <p class="pt-remaining">남은 PT: 8회</p>
                </div>
            </div>

            <div class="info-card">
                <div class="card-header">
                    <span class="card-icon">
                        <img src="${pageContext.request.contextPath}/resources/images/icon/locker.png" alt="락커 아이콘">
                    </span>
                    <h3>락커</h3>
                </div>
                <div class="card-content">
                    <p class="locker-number">A-42</p>
                    <p class="locker-expire">만료일: 2026. 3. 31.</p>
                </div>
            </div>
        </section>

        <!-- 탭 -->
        <div class="tabs">
            <button class="tab-button active" onclick="switchTab(event, 'inbody')">인바디 기록</button>
            <button class="tab-button" onclick="switchTab(event, 'attendance')">출석 통계</button>
        </div>

        <!-- 인바디 기록 탭 -->
        <section id="inbodyTab" class="tab-content active">
            <div class="section">
                <div class="section-header">
                    <h3 class="section-title">인바디 측정 내역</h3>
                    <button class="btn btn-primary" onclick="openModal('inbodyModal')">인바디 기록</button>
                </div>
                <table>
                    <thead>
                    <tr>
                        <th>측정일</th>
                        <th>체중 (kg)</th>
                        <th>골격근량 (kg)</th>
                        <th>체지방률 (%)</th>
                        <th>BMI</th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr>
                        <td>2025. 10. 20.</td>
                        <td style="color: #ffa366;">72.5</td>
                        <td style="color: #4caf50;">32.1</td>
                        <td style="color: #ff4444;">18.2</td>
                        <td>23.1</td>
                    </tr>
                    <tr>
                        <td>2025. 9. 20.</td>
                        <td style="color: #ffa366;">74.2</td>
                        <td style="color: #4caf50;">31.5</td>
                        <td style="color: #ff4444;">19.8</td>
                        <td>23.7</td>
                    </tr>
                    <tr>
                        <td>2025. 8. 20.</td>
                        <td style="color: #ffa366;">75.8</td>
                        <td style="color: #4caf50;">31</td>
                        <td style="color: #ff4444;">21.2</td>
                        <td>24.2</td>
                    </tr>
                    </tbody>
                </table>
            </div>
        </section>

        <!-- 출석 통계 탭 -->
        <section id="attendanceTab" class="tab-content">
            <div class="stats-grid">
                <div class="stat-card">
                    <div class="stat-card-label">총 출석 일수</div>
                    <div class="stat-card-value">124일</div>
                </div>
                <div class="stat-card">
                    <div class="stat-card-label">이번 달 출석</div>
                    <div class="stat-card-value">18일</div>
                </div>
                <div class="stat-card">
                    <div class="stat-card-label">주 평균 출석</div>
                    <div class="stat-card-value">4.5회</div>
                </div>
                <div class="stat-card">
                    <div class="stat-card-label">총 운동 시간</div>
                    <div class="stat-card-value">186시간</div>
                </div>
            </div>
            <div class="section">
                <table>
                    <thead>
                    <tr>
                        <th>출석일</th>
                        <th>입장 시간</th>
                        <th>퇴장 시간</th>
                        <th>운동 시간</th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr>
                        <td>2025. 11. 5.</td>
                        <td style="color: #4caf50;">18:23</td>
                        <td style="color: #ff4444;">20:45</td>
                        <td style="color: #ffa366;">2시간 22분</td>
                    </tr>
                    <tr>
                        <td>2025. 11. 4.</td>
                        <td style="color: #4caf50;">07:15</td>
                        <td style="color: #ff4444;">09:30</td>
                        <td style="color: #ffa366;">2시간 15분</td>
                    </tr>
                    <tr>
                        <td>2025. 11. 3.</td>
                        <td style="color: #4caf50;">19:00</td>
                        <td style="color: #ff4444;">21:10</td>
                        <td style="color: #ffa366;">2시간 10분</td>
                    </tr>
                    </tbody>
                </table>
            </div>
        </section>
    </div>
</div>

<!-- 정보 수정 모달 -->
<div id="editModal" class="modal-overlay">
    <div class="modal-container">
        <div class="modal-header">
            <h3 class="modal-title">정보 수정</h3>
            <button class="modal-close" onclick="closeModal('editModal')">
                <img src="${pageContext.request.contextPath}/resources/images/icon/close.png" alt="닫기" style="width: 16px; height: 16px;">
            </button>
        </div>
        <div class="modal-body">
            <form action="${pageContext.request.contextPath}/updateMemberInfo.me" method="post">
                <div class="form-grid">
                    <div class="form-group">
                        <label class="form-label">이름</label>
                        <input type="text" name="memberName" class="modal-input" value="${loginMember.memberName}">
                    </div>
                    <div class="form-group">
                        <label class="form-label">생년월일</label>
                        <input type="text" name="birthDate" class="modal-input" placeholder="1990. 1. 15.">
                    </div>
                </div>
                <div class="form-grid">
                    <div class="form-group">
                        <label class="form-label">연락처</label>
                        <input type="text" name="phone" class="modal-input" value="${loginMember.phone}">
                    </div>
                    <div class="form-group">
                        <label class="form-label">이메일</label>
                        <input type="email" name="email" class="modal-input" value="${loginMember.email}">
                    </div>
                </div>
                <div class="modal-form-group">
                    <label class="modal-label">주소</label>
                    <input type="text" name="address" class="modal-input" value="${loginMember.address}">
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" onclick="closeModal('editModal')">취소</button>
                    <button type="submit" class="btn btn-primary">저장</button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- 비밀번호 변경 모달 -->
<div id="passwordModal" class="modal-overlay">
    <div class="modal-container">
        <div class="modal-header">
            <h3 class="modal-title">비밀번호 변경</h3>
            <button class="modal-close" onclick="closeModal('passwordModal')">
                <img src="${pageContext.request.contextPath}/resources/images/icon/close.png" alt="닫기" style="width: 16px; height: 16px;">
            </button>
        </div>
        <div class="modal-body">
            <form id="passwordForm" action="${pageContext.request.contextPath}/updatePassword.me" method="post">
                <div class="modal-form-group">
                    <label class="modal-label">현재 비밀번호</label>
                    <input type="password" name="currentPassword" id="currentPassword" class="modal-input" required>
                </div>
                <div class="modal-form-group">
                    <label class="modal-label">새 비밀번호</label>
                    <input type="password" name="newPassword" id="newPassword" class="modal-input" required>
                </div>
                <div class="modal-form-group">
                    <label class="modal-label">새 비밀번호 확인</label>
                    <input type="password" id="confirmPassword" class="modal-input" required>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" onclick="closeModal('passwordModal')">취소</button>
                    <button type="submit" class="btn btn-primary">변경</button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- 인바디 기록 모달 -->
<div id="inbodyModal" class="modal-overlay">
    <div class="modal-container">
        <div class="modal-header">
            <h3 class="modal-title">인바디 기록</h3>
            <button class="modal-close" onclick="closeModal('inbodyModal')">
                <img src="${pageContext.request.contextPath}/resources/images/icon/close.png" alt="닫기" style="width: 16px; height: 16px;">
            </button>
        </div>
        <div class="modal-body">
            <form action="${pageContext.request.contextPath}/insertInbody.me" method="post">
                <div class="modal-form-group">
                    <label class="modal-label">체중 (kg)</label>
                    <input type="number" step="0.1" name="weight" class="modal-input" required>
                </div>
                <div class="modal-form-group">
                    <label class="modal-label">근육량 (kg)</label>
                    <input type="number" step="0.1" name="muscle" class="modal-input" required>
                </div>
                <div class="form-grid">
                    <div class="form-group">
                        <label class="form-label">체지방률 (%)</label>
                        <input type="number" step="0.1" name="bodyFat" class="modal-input" required>
                    </div>
                    <div class="form-group">
                        <label class="form-label">BMI</label>
                        <input type="number" step="0.1" name="bmi" class="modal-input" required>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" onclick="closeModal('inbodyModal')">취소</button>
                    <button type="submit" class="btn btn-primary">기록하기</button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- 운동 기록 모달 -->
<div id="exerciseModal" class="modal-overlay">
    <div class="modal-container">
        <div class="modal-header">
            <h3 class="modal-title">운동 기록</h3>
            <button class="modal-close" onclick="closeModal('exerciseModal')">
                <img src="${pageContext.request.contextPath}/resources/images/icon/close.png" alt="닫기" style="width: 16px; height: 16px;">
            </button>
        </div>
        <div class="modal-body">
            <form action="${pageContext.request.contextPath}/insertExercise.me" method="post">
                <div class="modal-form-group">
                    <label class="modal-label">운동 시간</label>
                    <input type="text" name="duration" class="modal-input" placeholder="예: 1:30:00" required>
                </div>
                <div class="modal-form-group">
                    <label class="modal-label">활동 킬로칼로리</label>
                    <input type="number" name="calories" class="modal-input" placeholder="KCAL" required>
                </div>
                <div class="modal-form-group">
                    <label class="modal-label">평균 심박수</label>
                    <input type="number" name="heartRate" class="modal-input" placeholder="BPM" required>
                </div>
                <div class="modal-form-group">
                    <label class="modal-label">운동 메모</label>
                    <input type="text" name="memo" class="modal-input">
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" onclick="closeModal('exerciseModal')">취소</button>
                    <button type="submit" class="btn btn-primary">기록하기</button>
                </div>
            </form>
        </div>
    </div>
</div>

<script>
    // 탭 전환
    function switchTab(event, tabName) {
        var i, tabContent, tabButtons;

        tabContent = document.getElementsByClassName("tab-content");
        for (i = 0; i < tabContent.length; i++) {
            tabContent[i].classList.remove("active");
        }

        tabButtons = document.getElementsByClassName("tab-button");
        for (i = 0; i < tabButtons.length; i++) {
            tabButtons[i].classList.remove("active");
        }

        document.getElementById(tabName + "Tab").classList.add("active");
        event.currentTarget.classList.add("active");
    }

    // 모달 열기
    function openModal(modalId) {
        document.getElementById(modalId).classList.add('active');
    }

    // 모달 닫기
    function closeModal(modalId) {
        document.getElementById(modalId).classList.remove('active');
    }

    // 모달 외부 클릭 시 닫기
    window.onclick = function(event) {
        if (event.target.classList.contains('modal-overlay')) {
            event.target.classList.remove('active');
        }
    }

    // 비밀번호 확인 검증
    document.getElementById('passwordForm').addEventListener('submit', function(e) {
        var newPassword = document.getElementById('newPassword').value;
        var confirmPassword = document.getElementById('confirmPassword').value;

        if (newPassword !== confirmPassword) {
            e.preventDefault();
            alert('새 비밀번호가 일치하지 않습니다.');
            return false;
        }
    });

    // 프로필 이미지 변경
    document.getElementById('profileImageInput').addEventListener('change', function(e) {
        if (e.target.files && e.target.files[0]) {
            var reader = new FileReader();
            reader.onload = function(event) {
                var img = document.createElement('img');
                img.src = event.target.result;
                img.style.width = '100%';
                img.style.height = '100%';
                img.style.objectFit = 'cover';
                img.style.borderRadius = '50%';

                document.getElementById('mainProfileImage').innerHTML = '';
                document.getElementById('mainProfileImage').appendChild(img);
            }
            reader.readAsDataURL(e.target.files[0]);
        }
    });
</script>
</body>
</html>