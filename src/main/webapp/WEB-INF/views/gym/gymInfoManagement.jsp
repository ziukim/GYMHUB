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
                            <img src="${pageContext.request.contextPath}/resources/images/icon/arrow.png" alt="뒤로가기" style="width: 16px; height: 16px;">
                        </button>
                        <h1 class="page-title">헬스장 정보 관리</h1>
                    </div>
                    <button class="save-button" onclick="saveGymInfo()">
                        <span>저장</span>
                    </button>
                </div>

                <!-- Image Upload Section -->
                <div class="section">
                    <div class="section-title">
                        <img src="${pageContext.request.contextPath}/resources/images/icon/image.png" alt="대표 이미지" class="section-icon">
                        대표 이미지
                    </div>
                    <div class="image-upload-area">
                        <button class="upload-button" onclick="uploadImage()">
                            <img src="${pageContext.request.contextPath}/resources/images/icon/upload.png" alt="업로드" style="width: 16px; height: 16px;">
                            <span>이미지 업로드</span>
                        </button>
                    </div>
                </div>

                <!-- Basic Information Section -->
                <div class="section">
                    <div class="section-title">
                        <img src="${pageContext.request.contextPath}/resources/images/icon/book.png" alt="기본 정보" class="section-icon">
                        기본 정보
                    </div>
                    <div class="form-grid">
                        <div class="form-group">
                            <label class="form-label">
                                <img src="${pageContext.request.contextPath}/resources/images/icon/add.png" alt="헬스장 이름" class="label-icon">
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
                                <img src="${pageContext.request.contextPath}/resources/images/icon/call.png" alt="전화번호" class="label-icon">
                                전화번호
                            </label>
                            <input type="text" class="form-input" placeholder="02-1234-5678" id="gymPhone">
                        </div>
                        <div class="form-group">
                            <label class="form-label">
                                <img src="${pageContext.request.contextPath}/resources/images/icon/location.png" alt="주소" class="label-icon">
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

                <!-- Operating Hours Section -->
                <div class="section">
                    <div class="section-title">
                        <img src="${pageContext.request.contextPath}/resources/images/icon/clock.png" alt="운영 시간" class="section-icon">
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
                        <img src="${pageContext.request.contextPath}/resources/images/icon/done.png" alt="시설 정보" class="section-icon">
                        시설 정보
                    </div>
                    <div class="facilities-label">제공하는 시설을 선택해주세요</div>
                    <div class="facilities-subtitle">(클릭하여 헬스장 피트니스 센터)</div>
                    
                    <div class="facilities-grid">
                        <button class="facility-button" data-facility="24시간">
                            <img src="${pageContext.request.contextPath}/resources/images/icon/clock.png" alt="24시간" class="facility-icon">
                            <span>24시간</span>
                        </button>
                        <button class="facility-button" data-facility="주차가능">
                            <img src="${pageContext.request.contextPath}/resources/images/icon/parking.png" alt="주차가능" class="facility-icon">
                            <span>주차가능</span>
                        </button>
                        <button class="facility-button" data-facility="샤워실">
                            <img src="${pageContext.request.contextPath}/resources/images/icon/shower.png" alt="샤워실" class="facility-icon">
                            <span>샤워실</span>
                        </button>
                        <button class="facility-button" data-facility="락커실">
                            <img src="${pageContext.request.contextPath}/resources/images/icon/locker.png" alt="락커실" class="facility-icon">
                            <span>락커실</span>
                        </button>
                        <button class="facility-button" data-facility="무료 WiFi">
                            <img src="${pageContext.request.contextPath}/resources/images/icon/wifi.png" alt="무료 WiFi" class="facility-icon">
                            <span>무료 WiFi</span>
                        </button>
                        <button class="facility-button" data-facility="PT">
                            <img src="${pageContext.request.contextPath}/resources/images/icon/person.png" alt="PT" class="facility-icon">
                            <span>PT</span>
                        </button>
                        <button class="facility-button" data-facility="GX 프로그램">
                            <img src="${pageContext.request.contextPath}/resources/images/icon/people.png" alt="GX 프로그램" class="facility-icon">
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

