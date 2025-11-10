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
                <div class="goal-text">
                    <div class="goal-title completed">벤치 프레스 100KG 달성</div>
                    <div class="goal-subtitle">벤치프레스</div>
                </div>
            </div>

            <div class="goal-item">
                <div class="goal-text">
                    <div class="goal-title completed">스쿼트 160KG 달성</div>
                    <div class="goal-subtitle">1RM</div>
                </div>
            </div>

            <div class="goal-item">
                <div class="goal-text">
                    <div class="goal-title">데드리프트 200KG 달성</div>
                    <div class="goal-subtitle">1RM</div>
                </div>
            </div>

            <div class="goal-item">
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
                </div>
                <!-- form 대신 button으로 변경 -->
                <button type="button" class="search-btn" id="videoListBtn">+ 더보기</button>
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

        <!-- 운동 영상 리스트 모달 추가 (기존 모달들 다음에 추가) -->
        <div class="modal-overlay" id="videoListModal">
            <div class="modal-content" style="width: 1200px; max-height: 90vh; overflow-y: auto;">
                <!-- Close Button -->
                <button class="close-button" id="closeVideoListBtn">
                    <svg fill="none" viewBox="0 0 16 16">
                        <path d="M12 4L4 12" stroke="#FFA366" stroke-linecap="round" stroke-linejoin="round" stroke-width="1.33333" />
                        <path d="M4 4L12 12" stroke="#FFA366" stroke-linecap="round" stroke-linejoin="round" stroke-width="1.33333" />
                    </svg>
                </button>

                <!-- Header -->
                <div class="modal-header">
                    <h2 class="modal-title">운동 영상 라이브러리</h2>
                    <p style="color: #8a6a50; font-size: 14px; margin-top: 8px;">트레이너 추천 운동 영상을 확인하세요</p>
                </div>

                <!-- Body -->
                <div class="modal-body">
                    <div class="video-grid" style="grid-template-columns: repeat(4, 1fr); gap: 20px;">
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

                        <div class="video-card">
                            <div class="video-thumbnail">
                                <div class="play-button">▶</div>
                            </div>
                            <div class="video-info">
                                <div class="video-title">가슴 운동 완벽 가이드</div>
                                <div class="video-author">최트레이너</div>
                            </div>
                        </div>

                        <div class="video-card">
                            <div class="video-thumbnail">
                                <div class="play-button">▶</div>
                            </div>
                            <div class="video-info">
                                <div class="video-title">등 운동 집중 프로그램</div>
                                <div class="video-author">정코치</div>
                            </div>
                        </div>

                        <div class="video-card">
                            <div class="video-thumbnail">
                                <div class="play-button">▶</div>
                            </div>
                            <div class="video-info">
                                <div class="video-title">팔 운동 루틴</div>
                                <div class="video-author">강트레이너</div>
                            </div>
                        </div>

                        <div class="video-card">
                            <div class="video-thumbnail">
                                <div class="play-button">▶</div>
                            </div>
                            <div class="video-info">
                                <div class="video-title">복근 만들기</div>
                                <div class="video-author">김코치</div>
                            </div>
                        </div>

                        <div class="video-card">
                            <div class="video-thumbnail">
                                <div class="play-button">▶</div>
                            </div>
                            <div class="video-info">
                                <div class="video-title">하체 강화 운동</div>
                                <div class="video-author">이트레이너</div>
                            </div>
                        </div>

                        <div class="video-card">
                            <div class="video-thumbnail">
                                <div class="play-button">▶</div>
                            </div>
                            <div class="video-info">
                                <div class="video-title">전신 운동 프로그램</div>
                                <div class="video-author">박코치</div>
                            </div>
                        </div>
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
                        <div class="modal-goal-text">
                            <div class="modal-goal-title">데드리프트 200KG 달성</div>
                            <div class="modal-goal-date">2025.09.09</div>
                        </div>
                        <svg class="modal-goal-icon goal-checkbox" fill="none" viewBox="0 0 20 20" style="cursor: pointer;">
                            <path class="circle-path" d="M10 18.3334C14.6024 18.3334 18.3333 14.6025 18.3333 10.0001C18.3333 5.39771 14.6024 1.66675 10 1.66675C5.39763 1.66675 1.66667 5.39771 1.66667 10.0001C1.66667 14.6025 5.39763 18.3334 10 18.3334Z" stroke="#8A6A50" stroke-linecap="round" stroke-linejoin="round" stroke-width="1.66667"/>
                            <path class="check-path" d="M6.66667 10L9.16667 12.5L13.3333 8.33333" stroke="#FF6B00" stroke-linecap="round" stroke-linejoin="round" stroke-width="1.66667" style="display: none;"/>
                        </svg>
                    </div>

                    <div class="modal-goal-item">
                        <div class="modal-goal-text">
                            <div class="modal-goal-title">체지방 12% 미만 달성</div>
                            <div class="modal-goal-date">2025.09.09</div>
                        </div>
                        <svg class="modal-goal-icon goal-checkbox" fill="none" viewBox="0 0 20 20" style="cursor: pointer;">
                            <path class="circle-path" d="M10 18.3334C14.6024 18.3334 18.3333 14.6025 18.3333 10.0001C18.3333 5.39771 14.6024 1.66675 10 1.66675C5.39763 1.66675 1.66667 5.39771 1.66667 10.0001C1.66667 14.6025 5.39763 18.3334 10 18.3334Z" stroke="#8A6A50" stroke-linecap="round" stroke-linejoin="round" stroke-width="1.66667"/>
                            <path class="check-path" d="M6.66667 10L9.16667 12.5L13.3333 8.33333" stroke="#FF6B00" stroke-linecap="round" stroke-linejoin="round" stroke-width="1.66667" style="display: none;"/>
                        </svg>
                    </div>

                    <div class="modal-goal-item">
                        <div class="modal-goal-text">
                            <div class="modal-goal-title">주 3회 꾸준히 운동 3개월 유지</div>
                            <div class="modal-goal-date">2025.09.09</div>
                        </div>
                        <svg class="modal-goal-icon goal-checkbox" fill="none" viewBox="0 0 20 20" style="cursor: pointer;">
                            <path class="circle-path" d="M10 18.3334C14.6024 18.3334 18.3333 14.6025 18.3333 10.0001C18.3333 5.39771 14.6024 1.66675 10 1.66675C5.39763 1.66675 1.66667 5.39771 1.66667 10.0001C1.66667 14.6025 5.39763 18.3334 10 18.3334Z" stroke="#8A6A50" stroke-linecap="round" stroke-linejoin="round" stroke-width="1.66667"/>
                            <path class="check-path" d="M6.66667 10L9.16667 12.5L13.3333 8.33333" stroke="#FF6B00" stroke-linecap="round" stroke-linejoin="round" stroke-width="1.66667" style="display: none;"/>
                        </svg>
                    </div>
                    <div class="modal-goal-item">
                        <div class="modal-goal-text">
                            <div class="modal-goal-title">체중 65kg → 58kg</div>
                            <div class="modal-goal-date">2025.09.09</div>
                        </div>
                        <svg class="modal-goal-icon goal-checkbox" fill="none" viewBox="0 0 20 20" style="cursor: pointer;">
                            <path class="circle-path" d="M10 18.3334C14.6024 18.3334 18.3333 14.6025 18.3333 10.0001C18.3333 5.39771 14.6024 1.66675 10 1.66675C5.39763 1.66675 1.66667 5.39771 1.66667 10.0001C1.66667 14.6025 5.39763 18.3334 10 18.3334Z" stroke="#8A6A50" stroke-linecap="round" stroke-linejoin="round" stroke-width="1.66667"/>
                            <path class="check-path" d="M6.66667 10L9.16667 12.5L13.3333 8.33333" stroke="#FF6B00" stroke-linecap="round" stroke-linejoin="round" stroke-width="1.66667" style="display: none;"/>
                        </svg>
                    </div>
                    <div class="modal-goal-item">
                        <div class="modal-goal-text">
                            <div class="modal-goal-title">5km 러닝 25분 이내 완주</div>
                            <div class="modal-goal-date">2025.09.09</div>
                        </div>
                        <svg class="modal-goal-icon goal-checkbox" fill="none" viewBox="0 0 20 20" style="cursor: pointer;">
                            <path class="circle-path" d="M10 18.3334C14.6024 18.3334 18.3333 14.6025 18.3333 10.0001C18.3333 5.39771 14.6024 1.66675 10 1.66675C5.39763 1.66675 1.66667 5.39771 1.66667 10.0001C1.66667 14.6025 5.39763 18.3334 10 18.3334Z" stroke="#8A6A50" stroke-linecap="round" stroke-linejoin="round" stroke-width="1.66667"/>
                            <path class="check-path" d="M6.66667 10L9.16667 12.5L13.3333 8.33333" stroke="#FF6B00" stroke-linecap="round" stroke-linejoin="round" stroke-width="1.66667" style="display: none;"/>
                        </svg>
                    </div>
                </div>

                <!-- Completed Tab -->
                <div id="completedTab" class="tab-content" style="display: none;">

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
        </div>
    </div>
</div>

<script>
    // 기존 스크립트에 추가할 내용
    document.addEventListener('DOMContentLoaded', function() {
        // ========== 기존 코드 시작 ==========
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

        // Video Detail Modal 관련 요소
        const videoDetailModal = document.getElementById('videoDetailModal');
        const closeVideoDetailBtn = document.getElementById('closeVideoDetailBtn');
        const videoCards = document.querySelectorAll('.video-card');

        // 목표 관리 모달 열기
        if (openBtn) {
            openBtn.addEventListener('click', function() {
                modal.classList.add('active');
            });
        }

        // 목표 관리 모달 닫기
        if (closeBtn) {
            closeBtn.addEventListener('click', function() {
                modal.classList.remove('active');
            });
        }

        // 목표 관리 모달 오버레이 클릭시 닫기
        if (modal) {
            modal.addEventListener('click', function(e) {
                if (e.target === modal) {
                    modal.classList.remove('active');
                }
            });
        }

        // 탭 전환
        tabButtons.forEach(function(button) {
            button.addEventListener('click', function() {
                tabButtons.forEach(function(btn) {
                    btn.classList.remove('active');
                });
                button.classList.add('active');

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
            addGoalBtn.addEventListener('click', function() {
                addGoalModal.classList.add('active');
                if (goalInput) {
                    goalInput.focus();
                }
            });
        }

        // 목표 추가 모달 닫기
        if (closeAddGoalBtn) {
            closeAddGoalBtn.addEventListener('click', function() {
                addGoalModal.classList.remove('active');
                if (goalInput) {
                    goalInput.value = '';
                }
            });
        }

        if (cancelAddGoalBtn) {
            cancelAddGoalBtn.addEventListener('click', function() {
                addGoalModal.classList.remove('active');
                if (goalInput) {
                    goalInput.value = '';
                }
            });
        }

        // 목표 추가 모달 오버레이 클릭시 닫기
        if (addGoalModal) {
            addGoalModal.addEventListener('click', function(e) {
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
            submitAddGoalBtn.addEventListener('click', function() {
                if (goalInput) {
                    const goal = goalInput.value.trim();
                    if (goal) {
                        console.log('새 목표:', goal);
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
            goalInput.addEventListener('keypress', function(e) {
                if (e.key === 'Enter') {
                    submitAddGoalBtn.click();
                }
            });
        }

        // 비디오 카드 클릭시 모달 열기
        videoCards.forEach(function(card) {
            card.addEventListener('click', function() {
                const title = card.querySelector('.video-title').textContent;
                const author = card.querySelector('.video-author').textContent;

                document.getElementById('videoModalTitle').textContent = title;
                document.getElementById('videoModalAuthor').textContent = author;

                videoDetailModal.classList.add('active');
            });
        });

        // 비디오 상세 모달 닫기
        if (closeVideoDetailBtn) {
            closeVideoDetailBtn.addEventListener('click', function() {
                videoDetailModal.classList.remove('active');
            });
        }

        // 비디오 상세 모달 오버레이 클릭시 닫기
        if (videoDetailModal) {
            videoDetailModal.addEventListener('click', function(e) {
                if (e.target === videoDetailModal) {
                    videoDetailModal.classList.remove('active');
                }
            });
        }

        // 목표 체크박스 기능
        const goalCheckboxes = document.querySelectorAll('.goal-checkbox');
        goalCheckboxes.forEach(function(checkbox) {
            checkbox.addEventListener('click', function(e) {
                e.stopPropagation();

                const circlePath = this.querySelector('.circle-path');
                const checkPath = this.querySelector('.check-path');
                const goalItem = this.closest('.modal-goal-item');
                const goalTitle = goalItem.querySelector('.modal-goal-title');
                const goalsTab = document.getElementById('goalsTab');
                const completedTab = document.getElementById('completedTab');

                const isChecked = checkPath.style.display === 'block';

                if (isChecked) {
                    // 체크 해제
                    checkPath.style.display = 'none';
                    circlePath.setAttribute('stroke', '#8A6A50');
                    goalTitle.classList.remove('completed');

                    // 달성한 목표 탭에서 해당 목표 찾아서 삭제
                    const completedItems = completedTab.querySelectorAll('.modal-goal-item');
                    completedItems.forEach(function(item) {
                        if (item.querySelector('.modal-goal-title').textContent === goalTitle.textContent) {
                            item.remove();
                        }
                    });
                } else {
                    // 체크 (목표 달성)
                    checkPath.style.display = 'block';
                    circlePath.setAttribute('stroke', '#FF6B00');
                    goalTitle.classList.add('completed');
                    goalsTab.appendChild(goalItem);

                    // 달성한 목표 탭으로 복사
                    const clonedItem = goalItem.cloneNode(true);
                    completedTab.appendChild(clonedItem);

                    // 복사된 항목의 체크박스에 이벤트 리스너 추가
                    const newCheckbox = clonedItem.querySelector('.goal-checkbox');
                    addCheckboxEvent(newCheckbox);
                }
            });
        });

        // 체크박스 이벤트를 추가하는 함수 (달성한 목표 탭용)
        function addCheckboxEvent(checkbox) {
            checkbox.addEventListener('click', function(e) {
                e.stopPropagation();

                const goalItem = this.closest('.modal-goal-item');
                const goalTitle = goalItem.querySelector('.modal-goal-title');

                // 달성한 목표에서 삭제
                if (confirm('이 목표를 삭제하시겠습니까?')) {
                    goalItem.remove();

                    // 목표 탭에서도 완전히 삭제
                    const goalsTab = document.getElementById('goalsTab');
                    const goalItems = goalsTab.querySelectorAll('.modal-goal-item');
                    goalItems.forEach(function(item) {
                        const title = item.querySelector('.modal-goal-title');
                        if (title.textContent === goalTitle.textContent) {
                            item.remove();
                        }
                    });
                }
            });
        }
        // ========== 기존 코드 끝 ==========

        // ========== 추가된 코드: 운동 영상 리스트 모달 ==========
        const videoListModal = document.getElementById('videoListModal');
        const videoListBtn = document.getElementById('videoListBtn');
        const closeVideoListBtn = document.getElementById('closeVideoListBtn');

        // 운동 영상 리스트 모달 열기
        if (videoListBtn) {
            videoListBtn.addEventListener('click', function() {
                videoListModal.classList.add('active');
            });
        }

        // 운동 영상 리스트 모달 닫기
        if (closeVideoListBtn) {
            closeVideoListBtn.addEventListener('click', function() {
                videoListModal.classList.remove('active');
            });
        }

        // 운동 영상 리스트 모달 오버레이 클릭시 닫기
        if (videoListModal) {
            videoListModal.addEventListener('click', function(e) {
                if (e.target === videoListModal) {
                    videoListModal.classList.remove('active');
                }
            });
        }

        // 리스트 모달 안의 비디오 카드 클릭시 상세 모달 열기
        const videoListModalCards = videoListModal.querySelectorAll('.video-card');
        videoListModalCards.forEach(function(card) {
            card.addEventListener('click', function() {
                const title = card.querySelector('.video-title').textContent;
                const author = card.querySelector('.video-author').textContent;

                document.getElementById('videoModalTitle').textContent = title;
                document.getElementById('videoModalAuthor').textContent = author;

                videoListModal.classList.remove('active');
                videoDetailModal.classList.add('active');
            });
        });

        // ESC 키로 모달 닫기 (모든 모달 포함)
        document.addEventListener('keydown', function(e) {
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
                if (videoDetailModal && videoDetailModal.classList.contains('active')) {
                    videoDetailModal.classList.remove('active');
                }
                if (videoListModal && videoListModal.classList.contains('active')) {
                    videoListModal.classList.remove('active');
                }
            }
        });
    });
</script>
</body>
</html>
