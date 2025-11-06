<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>회원 대시보드 - GymHub</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/dashboard.css">
</head>
<body>
<div class="app-container">
    <!-- Sidebar Include -->
    <jsp:include page="/WEB-INF/views/common/sidebar/sidebarMember.jsp" />

    <!-- Main Content -->
    <div class="main-content">
        <h1 class="welcome-message">
            ${loginMember.name}님 환영합니다! 오늘도 힘차게 운동하세요
            <img src="${pageContext.request.contextPath}/resources/images/icon/logo.png" alt="GymHub 로고 아이콘">
        </h1>

        <!-- Top Cards -->
        <div class="card-grid">
            <!-- Membership Card -->
            <div class="card">
                <div class="card-title">
                    <span class="card-icon">
                        <img src="${pageContext.request.contextPath}/resources/images/icon/ticket.png" alt="회원권 아이콘">
                    </span>
                    회원권 정보
                    <span style="margin-left: auto; color: #8a6a50; font-size: 14px;">남은 기간</span>
                    <span style="color: #ff6b00; font-size: 14px;">89일</span>
                </div>
                <div class="info-row">
                    <span class="info-label">이용권</span>
                    <span class="info-value">6개월 회원권</span>
                </div>
                <div class="info-row">
                    <span class="info-label">시작일</span>
                    <span class="info-value">2025.08.01</span>
                </div>
                <div class="info-row">
                    <span class="info-label">종료일</span>
                    <span class="info-value">2026.01.31</span>
                </div>
                <div class="info-row">
                    <span class="info-label">락커 번호</span>
                    <span class="info-value highlight">12번</span>
                </div>
            </div>

            <!-- Attendance Card -->
            <div class="card">
                <div class="card-title">
                    <span class="card-icon">
                        <img src="${pageContext.request.contextPath}/resources/images/icon/calendar.png" alt="출석 아이콘">
                    </span>
                    이번 달 출석
                </div>
                <div class="attendance-display">
                    <div class="attendance-number">18일</div>
                    <div class="attendance-label">이번 달 총 출석일</div>
                </div>
                <div class="progress-bar">
                    <div class="progress-fill"></div>
                </div>
                <div class="info-row">
                    <span class="info-label">목표 달성률</span>
                    <span class="info-value highlight">72%</span>
                </div>
            </div>

            <!-- PT Info Card -->
            <div class="card">
                <div class="card-title">
                    <span class="card-icon">
                        <img src="${pageContext.request.contextPath}/resources/images/icon/calendar.png" alt="PT 아이콘">
                    </span>
                    PT 정보
                </div>
                <div class="info-row">
                    <span class="info-label">담당 트레이너</span>
                    <span class="info-value">김철수 코치</span>
                </div>
                <div class="info-row">
                    <span class="info-label">다음 예약 일정</span>
                    <span class="info-value">10월 28일 14:00</span>
                </div>
                <div class="info-row">
                    <span class="info-label">남은 횟수</span>
                    <span class="info-value highlight">12회 / 20회</span>
                </div>
            </div>
        </div>

        <!-- Two Column Section -->
        <div class="two-column">
            <!-- Congestion Card -->
            <div class="large-card">
                <div class="card-title">
                    <span class="card-icon">
                        <img src="${pageContext.request.contextPath}/resources/images/icon/people.png" alt="혼잡도 아이콘">
                    </span>
                    현재 혼잡도
                </div>
                <div class="center-content">
                    <div class="large-text">2025년 10월 30일</div>
                    <div class="large-text">14:00</div>
                    <div class="medium-text">현재 이용인원</div>
                    <div class="large-text">12 명</div>
                </div>
            </div>

            <!-- My Gym Card -->
            <div class="large-card">
                <div class="card-title">
                    <span class="card-icon">
                        <img src="${pageContext.request.contextPath}/resources/images/icon/company.png" alt="헬스장 아이콘">
                    </span>
                    나의 헬스장
                </div>
                <div class="center-content">
                    <div class="large-text">헬스보이짐 판교역점</div>
                </div>
                <div class="notice-list">
                    <div class="notice-item">
                        <span class="notice-badge">중요</span>
                        <div class="notice-title">추석 연휴 운영시간 안내</div>
                        <div class="notice-date">2025.10.25</div>
                    </div>
                    <div class="notice-item">
                        <div class="notice-title">신규 GX 프로그램 오픈</div>
                        <div class="notice-date">2025.10.23</div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Goals Section -->
        <div class="large-card">
            <div class="goals-header">
                <div class="card-title">
                    <span class="card-icon">
                        <img src="${pageContext.request.contextPath}/resources/images/icon/target.png" alt="목표 아이콘">
                    </span>
                    운동 목표
                </div>
                <div class="btn-group">
                    <button class="search-btn" id="goalManagementBtn">목표 관리</button>
                    <button class="search-btn" id="addGoalBtn">운동 목표 추가</button>
                </div>
            </div>

            <div class="goal-item">
                <input type="checkbox" class="checkbox" checked>
                <div class="goal-text">
                    <div class="goal-title completed">벤치 프레스 100KG 달성</div>
                    <div class="goal-subtitle">벤치프레스</div>
                </div>
            </div>

            <div class="goal-item">
                <input type="checkbox" class="checkbox" checked>
                <div class="goal-text">
                    <div class="goal-title completed">스쿼트 160KG 달성</div>
                    <div class="goal-subtitle">1RM</div>
                </div>
            </div>

            <div class="goal-item">
                <input type="checkbox" class="checkbox">
                <div class="goal-text">
                    <div class="goal-title">데드리프트 200KG 달성</div>
                    <div class="goal-subtitle">1RM</div>
                </div>
            </div>

            <div class="goal-item">
                <input type="checkbox" class="checkbox">
                <div class="goal-text">
                    <div class="goal-title">체지방 12% 미만 달성</div>
                    <div class="goal-subtitle">3세트 x 최대</div>
                </div>
            </div>
        </div>

        <!-- Video Library -->
        <div class="large-card" style="margin-top: 40px;">
            <div class="goals-header">
                <div>
                    <div class="card-title">
                        <span class="card-icon">
                            <img src="${pageContext.request.contextPath}/resources/images/icon/book.png" alt="라이브러리 아이콘">
                        </span>
                        운동 영상 라이브러리
                    </div>
                    <div class="medium-text" style="margin-left: 28px;">트레이너 추천 운동 영상</div>
                </div>
                <form action="${pageContext.request.contextPath}/member/videolist" method="get">
                    <button type="submit" class="search-btn">+ 더보기</button>
                </form>
            </div>

            <div class="video-grid">
                <div class="video-card">
                    <div class="video-thumbnail">
                        <div class="play-button">▶</div>
                    </div>
                    <div class="video-info">
                        <div class="video-title">올바른 스쿼트 자세</div>
                        <div class="video-author">김트레이너</div>
                    </div>
                </div>

                <div class="video-card">
                    <div class="video-thumbnail">
                        <div class="play-button">▶</div>
                    </div>
                    <div class="video-info">
                        <div class="video-title">데드리프트 마스터</div>
                        <div class="video-author">이코치</div>
                    </div>
                </div>

                <div class="video-card">
                    <div class="video-thumbnail">
                        <div class="play-button">▶</div>
                    </div>
                    <div class="video-info">
                        <div class="video-title">어깨 운동 루틴</div>
                        <div class="video-author">박강사</div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Goal Management Modal -->
    <div class="modal-overlay" id="goalModal">
        <div class="modal-content">
            <!-- Close Button -->
            <button class="close-button" id="closeModalBtn">
                <svg fill="none" viewBox="0 0 16 16">
                    <path d="M12 4L4 12" stroke="#FFA366" stroke-linecap="round" stroke-linejoin="round" stroke-width="1.33333" />
                    <path d="M4 4L12 12" stroke="#FFA366" stroke-linecap="round" stroke-linejoin="round" stroke-width="1.33333" />
                </svg>
            </button>

            <!-- Header -->
            <div class="modal-header">
                <h2 class="modal-title">목표 관리</h2>
                <div class="tab-list">
                    <button class="tab-button active" data-tab="goals">목표</button>
                    <button class="tab-button" data-tab="completed">달성한 목표</button>
                </div>
            </div>

            <!-- Body -->
            <div class="modal-body">
                <!-- Goals Tab -->
                <div id="goalsTab" class="tab-content">
                    <div class="modal-goal-item">
                        <input type="checkbox" class="checkbox">
                        <div class="modal-goal-text">
                            <div class="modal-goal-title">데드리프트 200KG 달성</div>
                            <div class="modal-goal-date">2025.09.09</div>
                        </div>
                        <svg class="modal-goal-icon" fill="none" viewBox="0 0 20 20">
                            <path d="M10 18.3334C14.6024 18.3334 18.3333 14.6025 18.3333 10.0001C18.3333 5.39771 14.6024 1.66675 10 1.66675C5.39763 1.66675 1.66667 5.39771 1.66667 10.0001C1.66667 14.6025 5.39763 18.3334 10 18.3334Z" stroke="#8A6A50" stroke-linecap="round" stroke-linejoin="round" stroke-width="1.66667"/>
                        </svg>
                    </div>

                    <div class="modal-goal-item">
                        <input type="checkbox" class="checkbox">
                        <div class="modal-goal-text">
                            <div class="modal-goal-title">데드리프트 200KG 달성</div>
                            <div class="modal-goal-date">2025.09.09</div>
                        </div>
                        <svg class="modal-goal-icon" fill="none" viewBox="0 0 20 20">
                            <path d="M10 18.3334C14.6024 18.3334 18.3333 14.6025 18.3333 10.0001C18.3333 5.39771 14.6024 1.66675 10 1.66675C5.39763 1.66675 1.66667 5.39771 1.66667 10.0001C1.66667 14.6025 5.39763 18.3334 10 18.3334Z" stroke="#8A6A50" stroke-linecap="round" stroke-linejoin="round" stroke-width="1.66667"/>
                        </svg>
                    </div>

                    <div class="modal-goal-item">
                        <input type="checkbox" class="checkbox">
                        <div class="modal-goal-text">
                            <div class="modal-goal-title">체지방 12% 미만 달성</div>
                            <div class="modal-goal-date">2025.09.09</div>
                        </div>
                        <svg class="modal-goal-icon" fill="none" viewBox="0 0 20 20">
                            <path d="M10 18.3334C14.6024 18.3334 18.3333 14.6025 18.3333 10.0001C18.3333 5.39771 14.6024 1.66675 10 1.66675C5.39763 1.66675 1.66667 5.39771 1.66667 10.0001C1.66667 14.6025 5.39763 18.3334 10 18.3334Z" stroke="#8A6A50" stroke-linecap="round" stroke-linejoin="round" stroke-width="1.66667"/>
                        </svg>
                    </div>

                    <div class="modal-goal-item">
                        <input type="checkbox" class="checkbox">
                        <div class="modal-goal-text">
                            <div class="modal-goal-title">체지방 12% 미만 달성</div>
                            <div class="modal-goal-date">2025.09.09</div>
                        </div>
                        <svg class="modal-goal-icon" fill="none" viewBox="0 0 20 20">
                            <path d="M10 18.3334C14.6024 18.3334 18.3333 14.6025 18.3333 10.0001C18.3333 5.39771 14.6024 1.66675 10 1.66675C5.39763 1.66675 1.66667 5.39771 1.66667 10.0001C1.66667 14.6025 5.39763 18.3334 10 18.3334Z" stroke="#8A6A50" stroke-linecap="round" stroke-linejoin="round" stroke-width="1.66667"/>
                        </svg>
                    </div>
                </div>

                <!-- Completed Tab -->
                <div id="completedTab" class="tab-content" style="display: none;">
                    <div class="modal-goal-item">
                        <input type="checkbox" class="checkbox" checked>
                        <div class="modal-goal-text">
                            <div class="modal-goal-title completed">벤치 프레스 100KG 달성</div>
                            <div class="modal-goal-date">2025.09.09</div>
                        </div>
                        <svg class="modal-goal-icon" fill="none" viewBox="0 0 20 20">
                            <path d="M10 18.3334C14.6024 18.3334 18.3333 14.6025 18.3333 10.0001C18.3333 5.39771 14.6024 1.66675 10 1.66675C5.39763 1.66675 1.66667 5.39771 1.66667 10.0001C1.66667 14.6025 5.39763 18.3334 10 18.3334Z" stroke="#FF6B00" stroke-linecap="round" stroke-linejoin="round" stroke-width="1.66667"/>
                            <path d="M6.66667 10L9.16667 12.5L13.3333 8.33333" stroke="#FF6B00" stroke-linecap="round" stroke-linejoin="round" stroke-width="1.66667"/>
                        </svg>
                    </div>

                    <div class="modal-goal-item">
                        <input type="checkbox" class="checkbox" checked>
                        <div class="modal-goal-text">
                            <div class="modal-goal-title completed">벤치 프레스 100KG 달성</div>
                            <div class="modal-goal-date">2025.09.09</div>
                        </div>
                        <svg class="modal-goal-icon" fill="none" viewBox="0 0 20 20">
                            <path d="M10 18.3334C14.6024 18.3334 18.3333 14.6025 18.3333 10.0001C18.3333 5.39771 14.6024 1.66675 10 1.66675C5.39763 1.66675 1.66667 5.39771 1.66667 10.0001C1.66667 14.6025 5.39763 18.3334 10 18.3334Z" stroke="#FF6B00" stroke-linecap="round" stroke-linejoin="round" stroke-width="1.66667"/>
                            <path d="M6.66667 10L9.16667 12.5L13.3333 8.33333" stroke="#FF6B00" stroke-linecap="round" stroke-linejoin="round" stroke-width="1.66667"/>
                        </svg>
                    </div>

                    <div class="modal-goal-item">
                        <input type="checkbox" class="checkbox" checked>
                        <div class="modal-goal-text">
                            <div class="modal-goal-title completed">스쿼트 160KG 달성</div>
                            <div class="modal-goal-date">2025.09.09</div>
                        </div>
                        <svg class="modal-goal-icon" fill="none" viewBox="0 0 20 20">
                            <path d="M10 18.3334C14.6024 18.3334 18.3333 14.6025 18.3333 10.0001C18.3333 5.39771 14.6024 1.66675 10 1.66675C5.39763 1.66675 1.66667 5.39771 1.66667 10.0001C1.66667 14.6025 5.39763 18.3334 10 18.3334Z" stroke="#FF6B00" stroke-linecap="round" stroke-linejoin="round" stroke-width="1.66667"/>
                            <path d="M6.66667 10L9.16667 12.5L13.3333 8.33333" stroke="#FF6B00" stroke-linecap="round" stroke-linejoin="round" stroke-width="1.66667"/>
                        </svg>
                    </div>

                    <div class="modal-goal-item">
                        <input type="checkbox" class="checkbox" checked>
                        <div class="modal-goal-text">
                            <div class="modal-goal-title completed">스쿼트 160KG 달성</div>
                            <div class="modal-goal-date">2025.09.09</div>
                        </div>
                        <svg class="modal-goal-icon" fill="none" viewBox="0 0 20 20">
                            <path d="M10 18.3334C14.6024 18.3334 18.3333 14.6025 18.3333 10.0001C18.3333 5.39771 14.6024 1.66675 10 1.66675C5.39763 1.66675 1.66667 5.39771 1.66667 10.0001C1.66667 14.6025 5.39763 18.3334 10 18.3334Z" stroke="#FF6B00" stroke-linecap="round" stroke-linejoin="round" stroke-width="1.66667"/>
                            <path d="M6.66667 10L9.16667 12.5L13.3333 8.33333" stroke="#FF6B00" stroke-linecap="round" stroke-linejoin="round" stroke-width="1.66667"/>
                        </svg>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Add Goal Modal -->
    <div class="modal-overlay" id="addGoalModal">
        <div class="modal-content" style="width: 512px; height: 252px;">
            <!-- Close Button -->
            <button class="close-button" id="closeAddGoalBtn">
                <svg fill="none" viewBox="0 0 16 16">
                    <path d="M12 4L4 12" stroke="#FFA366" stroke-linecap="round" stroke-linejoin="round" stroke-width="1.33333" />
                    <path d="M4 4L12 12" stroke="#FFA366" stroke-linecap="round" stroke-linejoin="round" stroke-width="1.33333" />
                </svg>
            </button>

            <!-- Header -->
            <div style="padding: 25px 25px 0;">
                <h2 class="modal-title">운동 목표 추가</h2>
                <p style="color: #8a6a50; font-size: 14px; margin-top: 8px;">달성하고싶은 목표를 작성하세요</p>
            </div>

            <!-- Body -->
            <div style="padding: 16px 25px 25px;">
                <!-- Input Container -->
                <div style="margin-bottom: 16px;">
                    <label style="display: block; color: #ffa366; font-size: 14px; margin-bottom: 8px;">목표 입력</label>
                    <div class="goal-input-wrapper">
                        <input
                                type="text"
                                id="goalInput"
                                class="goal-input"
                                placeholder="데드리프트 220KG 달성"
                        />
                    </div>
                </div>

                <!-- Buttons -->
                <div style="display: flex; gap: 12px; padding-top: 16px;">
                    <button class="modal-btn modal-btn-cancel" id="cancelAddGoalBtn">취소</button>
                    <button class="modal-btn modal-btn-submit" id="submitAddGoalBtn">목표 설정!</button>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- Video Detail Modal -->
<div class="modal-overlay" id="videoDetailModal">
    <div class="modal-content" style="width: 800px; height: auto; max-height: 90vh;">
        <!-- Close Button -->
        <button class="close-button" id="closeVideoDetailBtn">
            <svg fill="none" viewBox="0 0 16 16">
                <path d="M12 4L4 12" stroke="#FFA366" stroke-linecap="round" stroke-linejoin="round" stroke-width="1.33333" />
                <path d="M4 4L12 12" stroke="#FFA366" stroke-linecap="round" stroke-linejoin="round" stroke-width="1.33333" />
            </svg>
        </button>

        <!-- Header -->
        <div style="padding: 25px 25px 0;">
            <h2 class="modal-title" id="videoModalTitle">올바른 스쿼트 자세</h2>
            <p style="color: #8a6a50; font-size: 14px; margin-top: 8px;" id="videoModalAuthor">김트레이너</p>
        </div>

        <!-- Body -->
        <div style="padding: 16px 25px 25px;">
            <!-- Video Player -->
            <div style="width: 100%; height: 400px; background: linear-gradient(135deg, #ff6b00 0%, #ff8c00 100%); border-radius: 10px; display: flex; align-items: center; justify-content: center; margin-bottom: 16px;">
                <div class="play-button" style="width: 64px; height: 64px; font-size: 24px;">▶</div>
            </div>

            <!-- Video Description -->
            <div style="background: #2d1810; border-radius: 10px; padding: 16px;">
                <h3 style="color: #ff6b00; font-size: 16px; margin-bottom: 12px;">영상 설명</h3>
                <p style="color: #b0b0b0; font-size: 14px; line-height: 1.6;" id="videoModalDescription">
                    이 영상에서는 올바른 스쿼트 자세에 대해 자세히 설명합니다.
                    무릎과 허리 부상을 방지하고 효과적인 운동을 위한 팁을 알려드립니다.
                </p>
            </div>
        </div>
    </div>
</div>

<script>
    // DOM이 로드된 후 실행
    document.addEventListener('DOMContentLoaded', function() {
        // Modal 관련 요소
        const modal = document.getElementById('goalModal');
        const openBtn = document.getElementById('goalManagementBtn');
        const closeBtn = document.getElementById('closeModalBtn');
        const tabButtons = document.querySelectorAll('.tab-button');
        const goalsTab = document.getElementById('goalsTab');
        const completedTab = document.getElementById('completedTab');

        // Add Goal Modal 관련 요소
        const addGoalModal = document.getElementById('addGoalModal');
        const addGoalBtn = document.getElementById('addGoalBtn');
        const closeAddGoalBtn = document.getElementById('closeAddGoalBtn');
        const cancelAddGoalBtn = document.getElementById('cancelAddGoalBtn');
        const submitAddGoalBtn = document.getElementById('submitAddGoalBtn');
        const goalInput = document.getElementById('goalInput');

        // 목표 관리 모달 열기
        if (openBtn) {
            openBtn.addEventListener('click', () => {
                modal.classList.add('active');
            });
        }

        // 목표 관리 모달 닫기
        if (closeBtn) {
            closeBtn.addEventListener('click', () => {
                modal.classList.remove('active');
            });
        }

        // 목표 관리 모달 오버레이 클릭시 닫기
        if (modal) {
            modal.addEventListener('click', (e) => {
                if (e.target === modal) {
                    modal.classList.remove('active');
                }
            });
        }

        // 탭 전환
        tabButtons.forEach(button => {
            button.addEventListener('click', () => {
                // 모든 탭 버튼에서 active 제거
                tabButtons.forEach(btn => btn.classList.remove('active'));
                // 클릭한 버튼에 active 추가
                button.classList.add('active');

                // 탭 컨텐츠 표시
                const tab = button.getAttribute('data-tab');
                if (tab === 'goals') {
                    goalsTab.style.display = 'block';
                    completedTab.style.display = 'none';
                } else {
                    goalsTab.style.display = 'none';
                    completedTab.style.display = 'block';
                }
            });
        });

        // 목표 추가 모달 열기
        if (addGoalBtn) {
            addGoalBtn.addEventListener('click', () => {
                addGoalModal.classList.add('active');
                if (goalInput) {
                    goalInput.focus();
                }
            });
        }

        // 목표 추가 모달 닫기
        if (closeAddGoalBtn) {
            closeAddGoalBtn.addEventListener('click', () => {
                addGoalModal.classList.remove('active');
                if (goalInput) {
                    goalInput.value = '';
                }
            });
        }

        if (cancelAddGoalBtn) {
            cancelAddGoalBtn.addEventListener('click', () => {
                addGoalModal.classList.remove('active');
                if (goalInput) {
                    goalInput.value = '';
                }
            });
        }

        // 목표 추가 모달 오버레이 클릭시 닫기
        if (addGoalModal) {
            addGoalModal.addEventListener('click', (e) => {
                if (e.target === addGoalModal) {
                    addGoalModal.classList.remove('active');
                    if (goalInput) {
                        goalInput.value = '';
                    }
                }
            });
        }

        // 목표 제출
        if (submitAddGoalBtn) {
            submitAddGoalBtn.addEventListener('click', () => {
                if (goalInput) {
                    const goal = goalInput.value.trim();
                    if (goal) {
                        console.log('새 목표:', goal);
                        // TODO: 서버로 목표 추가 요청
                        alert('목표가 추가되었습니다: ' + goal);
                        addGoalModal.classList.remove('active');
                        goalInput.value = '';
                    } else {
                        alert('목표를 입력해주세요.');
                    }
                }
            });
        }

        // Enter 키로 제출
        if (goalInput) {
            goalInput.addEventListener('keypress', (e) => {
                if (e.key === 'Enter') {
                    submitAddGoalBtn.click();
                }
            });
        }

        // ESC 키로 모달 닫기
        document.addEventListener('keydown', (e) => {
            if (e.key === 'Escape') {
                if (modal && modal.classList.contains('active')) {
                    modal.classList.remove('active');
                }
                if (addGoalModal && addGoalModal.classList.contains('active')) {
                    addGoalModal.classList.remove('active');
                    if (goalInput) {
                        goalInput.value = '';
                    }
                }
            }
        });
    });
    // 기존 DOMContentLoaded 이벤트 리스너 안에 추가
    // Video Detail Modal 관련 요소
    const videoDetailModal = document.getElementById('videoDetailModal');
    const closeVideoDetailBtn = document.getElementById('closeVideoDetailBtn');
    const videoCards = document.querySelectorAll('.video-card');

    // 비디오 카드 클릭시 모달 열기
    videoCards.forEach(card => {
        card.addEventListener('click', () => {
            // 카드에서 정보 가져오기
            const title = card.querySelector('.video-title').textContent;
            const author = card.querySelector('.video-author').textContent;

            // 모달에 정보 설정
            document.getElementById('videoModalTitle').textContent = title;
            document.getElementById('videoModalAuthor').textContent = author;

            // 모달 열기
            videoDetailModal.classList.add('active');
        });
    });

    // 비디오 상세 모달 닫기
    if (closeVideoDetailBtn) {
        closeVideoDetailBtn.addEventListener('click', () => {
            videoDetailModal.classList.remove('active');
        });
    }

    // 비디오 상세 모달 오버레이 클릭시 닫기
    if (videoDetailModal) {
        videoDetailModal.addEventListener('click', (e) => {
            if (e.target === videoDetailModal) {
                videoDetailModal.classList.remove('active');
            }
        });
    }

    // 기존 ESC 키 이벤트 리스너에 추가
    // 기존 코드에서 이 부분을 찾아서:
    document.addEventListener('keydown', (e) => {
        if (e.key === 'Escape') {
            if (modal && modal.classList.contains('active')) {
                modal.classList.remove('active');
            }
            if (addGoalModal && addGoalModal.classList.contains('active')) {
                addGoalModal.classList.remove('active');
                if (goalInput) {
                    goalInput.value = '';
                }
            }
            // 여기에 추가:
            if (videoDetailModal && videoDetailModal.classList.contains('active')) {
                videoDetailModal.classList.remove('active');
            }
        }
    });
</script>
</body>
</html>
