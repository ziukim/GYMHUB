<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>GymHub - 헬스장 정보 관리</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=ADLaM+Display&family=ABeeZee&family=Noto+Sans+KR:wght@400;700&display=swap" rel="stylesheet">
    <style>
        /* main-content 가로로 가득 차게 - !important로 common.css 오버라이드 */
        .main-content {
            width: calc(100% - 255px) !important;
            margin-left: 255px !important;
            padding: 24px 24px 24px 24px !important;
            margin-right: 0 !important;
        }

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

        .save-button {
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
        }

        .save-button:hover {
            opacity: 0.9;
        }

        /* Section */
        .section {
            background: #1a0f0a;
            border: 1px solid #ff6b00;
            border-radius: 14px;
            padding: 25px;
            margin-bottom: 20px;
        }

        .section-title {
            color: #ff6b00;
            font-size: 16px;
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .section-icon {
            width: 18px;
            height: 18px;
        }

        /* Image Upload */
        .image-upload-area {
            border: 2px solid #ff6b00;
            border-radius: 8px;
            padding: 20px;
            min-height: 350px;
            display: flex;
            flex-direction: column;
            position: relative;
        }

        .upload-button {
            background: #ff6b00;
            border: none;
            border-radius: 20px;
            padding: 8px 20px;
            color: #0a0a0a;
            font-size: 13px;
            cursor: pointer;
            display: inline-flex;
            align-items: center;
            gap: 6px;
            transition: opacity 0.2s;
            width: fit-content;
        }

        .upload-button:hover {
            opacity: 0.9;
        }

        /* Form Grid */
        .form-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
        }

        .form-group {
            display: flex;
            flex-direction: column;
            gap: 8px;
        }

        .form-group.full-width {
            grid-column: 1 / -1;
        }

        .form-label {
            color: #ffa366;
            font-size: 14px;
            display: flex;
            align-items: center;
            gap: 6px;
        }

        .label-icon {
            width: 14px;
            height: 14px;
        }

        .form-input {
            background: #2d1810;
            border: 1px solid #ff6b00;
            border-radius: 8px;
            padding: 10px 12px;
            color: #8a6a50;
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

        .form-textarea {
            background: #2d1810;
            border: 1px solid #ff6b00;
            border-radius: 8px;
            padding: 10px 12px;
            color: #8a6a50;
            font-size: 14px;
            font-family: 'ABeeZee', 'Noto Sans KR', sans-serif;
            resize: vertical;
            min-height: 80px;
        }

        .form-textarea:focus {
            outline: none;
            border-color: #ffa366;
        }

        .form-textarea::placeholder {
            color: #8a6a50;
        }

        /* Membership Prices */
        .price-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
        }

        .price-item {
            display: flex;
            flex-direction: column;
            gap: 8px;
        }

        .price-label {
            color: #ffa366;
            font-size: 14px;
        }

        /* Operating Hours */
        .hours-section {
            margin-bottom: 20px;
        }

        .day-title {
            color: #ffa366;
            font-size: 14px;
            margin-bottom: 12px;
        }

        .time-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 16px;
        }

        .time-group {
            display: flex;
            flex-direction: column;
            gap: 8px;
        }

        .time-label {
            color: #8a6a50;
            font-size: 13px;
        }

        .time-note {
            color: #8a6a50;
            font-size: 12px;
            margin-top: 8px;
        }

        /* Facilities */
        .facilities-label {
            color: #ffa366;
            font-size: 14px;
            margin-bottom: 12px;
        }

        .facilities-subtitle {
            color: #8a6a50;
            font-size: 13px;
            margin-bottom: 16px;
        }

        .facilities-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 12px;
            margin-bottom: 20px;
        }

        .facility-button {
            background: transparent;
            border: 1px solid #ff6b00;
            border-radius: 8px;
            padding: 12px;
            color: #ffa366;
            font-size: 14px;
            cursor: pointer;
            display: flex;
            flex-direction: column;
            align-items: center;
            gap: 8px;
            transition: all 0.2s;
        }

        .facility-button:hover {
            background: rgba(255, 107, 0, 0.1);
        }

        .facility-button.selected {
            background: rgba(255, 107, 0, 0.2);
            border-color: #ffa366;
        }

        .facility-icon {
            width: 24px;
            height: 24px;
        }

        /* Time Tags */
        .time-tags-label {
            color: #ffa366;
            font-size: 14px;
            margin-bottom: 12px;
        }

        .time-tags {
            display: flex;
            flex-wrap: wrap;
            gap: 8px;
        }

        .time-tag {
            background: transparent;
            border: 1px solid #ff6b00;
            border-radius: 16px;
            padding: 6px 16px;
            color: #ffa366;
            font-size: 13px;
            cursor: pointer;
            transition: all 0.2s;
        }

        .time-tag:hover {
            background: rgba(255, 107, 0, 0.1);
        }

        .time-tag.selected {
            background: rgba(255, 107, 0, 0.2);
            border-color: #ffa366;
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
                <div class="page-header">
                    <div class="header-left">
                        <button class="back-button" onclick="history.back()">
                            <svg width="16" height="16" fill="none" viewBox="0 0 16 16">
                                <path d="M8 12.6667L3.33333 8L8 3.33333" stroke="#FFA366" stroke-linecap="round" stroke-linejoin="round" stroke-width="1.33333" />
                                <path d="M12.6667 8H3.33333" stroke="#FFA366" stroke-linecap="round" stroke-linejoin="round" stroke-width="1.33333" />
                            </svg>
                        </button>
                        <h1 class="page-title">헬스장 정보 관리</h1>
                    </div>
                    <button class="save-button" onclick="saveGymInfo()">
                        <svg width="16" height="16" fill="none" viewBox="0 0 16 16">
                            <path d="M13.8333 7.16667H12.18C11.8886 7.16604 11.6051 7.26087 11.3727 7.43664C11.1404 7.61242 10.972 7.85947 10.8933 8.14L9.32667 13.7133C9.31657 13.748 9.29552 13.7784 9.26667 13.8C9.23782 13.8216 9.20273 13.8333 9.16667 13.8333C9.1306 13.8333 9.09552 13.8216 9.06667 13.8C9.03782 13.7784 9.01676 13.748 9.00667 13.7133L5.32667 0.62C5.31657 0.585381 5.29552 0.55497 5.26667 0.533333C5.23782 0.511696 5.20273 0.5 5.16667 0.5C5.1306 0.5 5.09552 0.511696 5.06667 0.533333C5.03782 0.55497 5.01676 0.585381 5.00667 0.62L3.44 6.19333C3.36164 6.47277 3.19425 6.71901 2.96324 6.89468C2.73223 7.07034 2.45021 7.16584 2.16 7.16667H0.5" stroke="#0a0a0a" stroke-linecap="round" stroke-linejoin="round" />
                        </svg>
                        <span>저장</span>
                    </button>
                </div>

                <!-- Image Upload Section -->
                <div class="section">
                    <div class="section-title">
                        <svg class="section-icon" fill="none" viewBox="0 0 18 18">
                            <path d="M15.75 2.25H2.25C1.42157 2.25 0.75 2.92157 0.75 3.75V14.25C0.75 15.0784 1.42157 15.75 2.25 15.75H15.75C16.5784 15.75 17.25 15.0784 17.25 14.25V3.75C17.25 2.92157 16.5784 2.25 15.75 2.25Z" stroke="#FF6B00" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/>
                            <path d="M6.375 7.5C7.20343 7.5 7.875 6.82843 7.875 6C7.875 5.17157 7.20343 4.5 6.375 4.5C5.54657 4.5 4.875 5.17157 4.875 6C4.875 6.82843 5.54657 7.5 6.375 7.5Z" stroke="#FF6B00" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/>
                            <path d="M17.25 11.25L13.5 7.5L2.25 15.75" stroke="#FF6B00" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/>
                        </svg>
                        대표 이미지
                    </div>
                    <div class="image-upload-area">
                        <button class="upload-button" onclick="uploadImage()">
                            <svg width="16" height="16" fill="none" viewBox="0 0 16 16">
                                <path d="M14 10v2.667A1.334 1.334 0 0112.667 14H3.333A1.333 1.333 0 012 12.667V10" stroke="#0a0a0a" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/>
                                <path d="M11.333 5.333L8 2 4.667 5.333" stroke="#0a0a0a" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/>
                                <path d="M8 2v8" stroke="#0a0a0a" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/>
                            </svg>
                            <span>이미지 업로드</span>
                        </button>
                    </div>
                </div>

                <!-- Basic Information Section -->
                <div class="section">
                    <div class="section-title">
                        <svg class="section-icon" fill="none" viewBox="0 0 18 18">
                            <path d="M2.25 2.25H15.75V15.75H2.25V2.25Z" stroke="#FF6B00" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/>
                            <path d="M6 6H12" stroke="#FF6B00" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/>
                            <path d="M6 9.75H12" stroke="#FF6B00" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/>
                        </svg>
                        기본 정보
                    </div>
                    <div class="form-grid">
                        <div class="form-group">
                            <label class="form-label">
                                <svg class="label-icon" fill="none" viewBox="0 0 14 14">
                                    <path d="M7 1v12M1 7h12" stroke="#FFA366" stroke-width="1.5" stroke-linecap="round"/>
                                </svg>
                                헬스장 이름
                            </label>
                            <input type="text" class="form-input" placeholder="피트니스 센터 강남점" id="gymName">
                        </div>
                        <div class="form-group full-width">
                            <label class="form-label">헬스장 소개</label>
                            <textarea class="form-textarea" placeholder="헬스장에 대한 간단한 소개를 입력해주세요" id="gymDescription"></textarea>
                        </div>
                        <div class="form-group">
                            <label class="form-label">
                                <svg class="label-icon" fill="none" viewBox="0 0 14 14">
                                    <path d="M12.25 5.833c0 4.084-5.25 7.584-5.25 7.584S1.75 9.917 1.75 5.833a5.25 5.25 0 1110.5 0z" stroke="#FFA366" stroke-width="1.5"/>
                                    <circle cx="7" cy="5.833" r="1.75" stroke="#FFA366" stroke-width="1.5"/>
                                </svg>
                                전화번호
                            </label>
                            <input type="text" class="form-input" placeholder="02-1234-5678" id="gymPhone">
                        </div>
                        <div class="form-group">
                            <label class="form-label">
                                <svg class="label-icon" fill="none" viewBox="0 0 14 14">
                                    <path d="M7 12.833A5.833 5.833 0 107 1.167a5.833 5.833 0 000 11.666z" stroke="#FFA366" stroke-width="1.5"/>
                                </svg>
                                주소
                            </label>
                            <input type="text" class="form-input" placeholder="서울 강남구 테헤란로 123" id="gymAddress">
                        </div>
                        <div class="form-group full-width">
                            <label class="form-label">상세 주소 / 위치 안내</label>
                            <input type="text" class="form-input" placeholder="3층 (해성빌딩 2번 출구 기준 5분)" id="gymDetailAddress">
                        </div>
                    </div>
                </div>

                <!-- Membership Prices Section -->
                <div class="section">
                    <div class="section-title">
                        <svg class="section-icon" fill="none" viewBox="0 0 18 18">
                            <path d="M9 16.5a7.5 7.5 0 100-15 7.5 7.5 0 000 15z" stroke="#FF6B00" stroke-width="1.5"/>
                            <path d="M9 4.5v7.5M11.625 6.75H8.25a1.125 1.125 0 100 2.25h1.5a1.125 1.125 0 010 2.25H6.375" stroke="#FF6B00" stroke-width="1.5" stroke-linecap="round"/>
                        </svg>
                        회원권 가격
                    </div>
                    <div class="price-grid">
                        <div class="price-item">
                            <label class="price-label">1개월 회원권</label>
                            <input type="text" class="form-input" placeholder="89000" id="price1Month">
                        </div>
                        <div class="price-item">
                            <label class="price-label">3개월 회원권</label>
                            <input type="text" class="form-input" placeholder="240000" id="price3Month">
                        </div>
                        <div class="price-item">
                            <label class="price-label">6개월 회원권</label>
                            <input type="text" class="form-input" placeholder="450000" id="price6Month">
                        </div>
                        <div class="price-item">
                            <label class="price-label">1년 회원권</label>
                            <input type="text" class="form-input" placeholder="840000" id="price1Year">
                        </div>
                    </div>
                </div>

                <!-- Operating Hours Section -->
                <div class="section">
                    <div class="section-title">
                        <svg class="section-icon" fill="none" viewBox="0 0 18 18">
                            <path d="M9 16.5a7.5 7.5 0 100-15 7.5 7.5 0 000 15z" stroke="#FF6B00" stroke-width="1.5"/>
                            <path d="M9 4.5V9l3 1.5" stroke="#FF6B00" stroke-width="1.5" stroke-linecap="round"/>
                        </svg>
                        운영 시간
                    </div>

                    <!-- Weekday -->
                    <div class="hours-section">
                        <div class="day-title">평일 (월~금)</div>
                        <div class="time-grid">
                            <div class="time-group">
                                <label class="time-label">시작 시간</label>
                                <input type="text" class="form-input" placeholder="06:00" id="weekdayStart">
                            </div>
                            <div class="time-group">
                                <label class="time-label">종료 시간</label>
                                <input type="text" class="form-input" placeholder="23:00" id="weekdayEnd">
                            </div>
                        </div>
                        <div class="time-note">예시: 평일 00:00 ~ 23:59</div>
                    </div>

                    <!-- Weekend -->
                    <div class="hours-section">
                        <div class="day-title">주말 (토~일)</div>
                        <div class="time-grid">
                            <div class="time-group">
                                <label class="time-label">시작 시간</label>
                                <input type="text" class="form-input" placeholder="08:00" id="weekendStart">
                            </div>
                            <div class="time-group">
                                <label class="time-label">종료 시간</label>
                                <input type="text" class="form-input" placeholder="20:00" id="weekendEnd">
                            </div>
                        </div>
                        <div class="time-note">예시: 주말 00:00 ~ 23:59</div>
                    </div>
                </div>

                <!-- Facilities Section -->
                <div class="section">
                    <div class="section-title">
                        <svg class="section-icon" fill="none" viewBox="0 0 18 18">
                            <rect x="2.25" y="2.25" width="13.5" height="13.5" rx="2" stroke="#FF6B00" stroke-width="1.5"/>
                            <path d="M6.75 8.25l1.5 1.5 3-3" stroke="#FF6B00" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/>
                        </svg>
                        시설 정보
                    </div>
                    <div class="facilities-label">제공하는 시설을 선택해주세요</div>
                    <div class="facilities-subtitle">(클릭하여 헬스장 피트니스 센터)</div>
                    
                    <div class="facilities-grid">
                        <button class="facility-button" data-facility="24시간">
                            <svg class="facility-icon" fill="none" viewBox="0 0 24 24">
                                <circle cx="12" cy="12" r="10" stroke="#FFA366" stroke-width="2"/>
                                <path d="M12 6v6l4 2" stroke="#FFA366" stroke-width="2" stroke-linecap="round"/>
                            </svg>
                            <span>24시간</span>
                        </button>
                        <button class="facility-button" data-facility="주차가능">
                            <svg class="facility-icon" fill="none" viewBox="0 0 24 24">
                                <path d="M5 17h14a2 2 0 002-2V9a2 2 0 00-2-2H5a2 2 0 00-2 2v6a2 2 0 002 2z" stroke="#FFA366" stroke-width="2"/>
                                <path d="M9 10h2a1.5 1.5 0 010 3H9v-3zM9 7v10" stroke="#FFA366" stroke-width="2" stroke-linecap="round"/>
                            </svg>
                            <span>주차가능</span>
                        </button>
                        <button class="facility-button" data-facility="샤워실">
                            <svg class="facility-icon" fill="none" viewBox="0 0 24 24">
                                <path d="M12 2v6M9 4l3 3 3-3M12 18a2 2 0 100-4 2 2 0 000 4zM8 14l-2 2M16 14l2 2M12 14v8" stroke="#FFA366" stroke-width="2" stroke-linecap="round"/>
                            </svg>
                            <span>샤워실</span>
                        </button>
                        <button class="facility-button" data-facility="락커실">
                            <svg class="facility-icon" fill="none" viewBox="0 0 24 24">
                                <rect x="4" y="3" width="16" height="18" rx="2" stroke="#FFA366" stroke-width="2"/>
                                <circle cx="12" cy="13" r="2" stroke="#FFA366" stroke-width="2"/>
                                <path d="M12 15v3" stroke="#FFA366" stroke-width="2" stroke-linecap="round"/>
                            </svg>
                            <span>락커실</span>
                        </button>
                        <button class="facility-button" data-facility="무료 WiFi">
                            <svg class="facility-icon" fill="none" viewBox="0 0 24 24">
                                <path d="M5 12.55a11 11 0 0114.08 0M8.53 16.11a6 6 0 016.95 0M12 20h.01" stroke="#FFA366" stroke-width="2" stroke-linecap="round"/>
                            </svg>
                            <span>무료 WiFi</span>
                        </button>
                        <button class="facility-button" data-facility="PT">
                            <svg class="facility-icon" fill="none" viewBox="0 0 24 24">
                                <circle cx="9" cy="7" r="4" stroke="#FFA366" stroke-width="2"/>
                                <path d="M3 21v-2a4 4 0 014-4h4a4 4 0 014 4v2M16 11l2 2 4-4" stroke="#FFA366" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                            </svg>
                            <span>PT</span>
                        </button>
                        <button class="facility-button" data-facility="GX 프로그램">
                            <svg class="facility-icon" fill="none" viewBox="0 0 24 24">
                                <path d="M17 21v-2a4 4 0 00-4-4H5a4 4 0 00-4 4v2M9 7a4 4 0 100-8 4 4 0 000 8zM23 21v-2a4 4 0 00-3-3.87M16 3.13a4 4 0 010 7.75" stroke="#FFA366" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                            </svg>
                            <span>GX 프로그램</span>
                        </button>
                    </div>

                    <div class="time-tags-label">선택된 시설 미리보기:</div>
                    <div class="time-tags" id="selectedFacilities">
                        <!-- 선택된 시설이 여기에 표시됩니다 -->
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script>
        // Facility buttons toggle
        const facilityButtons = document.querySelectorAll('.facility-button');
        const selectedFacilities = [];
        
        facilityButtons.forEach(button => {
            button.addEventListener('click', () => {
                button.classList.toggle('selected');
                const facility = button.getAttribute('data-facility');
                
                if (button.classList.contains('selected')) {
                    if (!selectedFacilities.includes(facility)) {
                        selectedFacilities.push(facility);
                    }
                } else {
                    const index = selectedFacilities.indexOf(facility);
                    if (index > -1) {
                        selectedFacilities.splice(index, 1);
                    }
                }
                
                updateFacilityTags();
            });
        });

        // 선택된 시설 태그 업데이트
        function updateFacilityTags() {
            const tagsContainer = document.getElementById('selectedFacilities');
            tagsContainer.innerHTML = '';
            
            selectedFacilities.forEach(facility => {
                const tag = document.createElement('button');
                tag.className = 'time-tag selected';
                tag.textContent = facility;
                tag.addEventListener('click', () => {
                    const button = Array.from(facilityButtons).find(btn => btn.getAttribute('data-facility') === facility);
                    if (button) {
                        button.classList.remove('selected');
                        const index = selectedFacilities.indexOf(facility);
                        if (index > -1) {
                            selectedFacilities.splice(index, 1);
                        }
                        updateFacilityTags();
                    }
                });
                tagsContainer.appendChild(tag);
            });
        }

        // Save button
        function saveGymInfo() {
            alert('정보가 저장되었습니다!');
            // 실제 저장 로직은 여기에 추가
        }

        // Image upload
        function uploadImage() {
            const input = document.createElement('input');
            input.type = 'file';
            input.accept = 'image/*';
            input.multiple = true;
            input.onchange = (e) => {
                const files = Array.from(e.target.files);
                console.log('Uploaded files:', files);
                alert(`${files.length}개의 이미지가 업로드되었습니다.`);
            };
            input.click();
        }
    </script>
</body>
</html>

