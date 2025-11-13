<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
                <div class="page-intro">
                    <h1>헬스장 정보 관리</h1>
                    <p>헬스장의 기본 정보를 수정하고 관리하세요</p>
                </div>
                <div class="page-header">
                    <div class="header-left">
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
                        <!-- 이미지 미리보기 및 업로드 영역 -->
                        <div style="display: flex; flex-direction: column; align-items: center; gap: 20px; width: 100%;">
                            <div class="profile-image-container" style="position: relative; width: 100%; display: flex; justify-content: center;">
                                <div class="profile-image" id="mainGymImage" style="width: 100%; height: 600px; background-color: #2d1810; border: 2px solid #ff6b00; border-radius: 8px; display: flex; align-items: center; justify-content: center; overflow: hidden;">
                                    <c:choose>
                                        <c:when test="${not empty gym.gymPhotoPath}">
                                            <img src="${pageContext.request.contextPath}${gym.gymPhotoPath}"
                                                 alt="헬스장 이미지"
                                                 style="width: 100%; height: 100%; object-fit: cover;">
                                        </c:when>
                                        <c:otherwise>
                                            <svg viewBox="0 0 48 48" fill="none" style="width: 80px; height: 80px;">
                                                <path d="M24 24C28.4183 24 32 20.4183 32 16C32 11.5817 28.4183 8 24 8C19.5817 8 16 11.5817 16 16C16 20.4183 19.5817 24 24 24Z" stroke="#FF6B00" stroke-width="4" stroke-linecap="round" stroke-linejoin="round"/>
                                                <path d="M40 40C40 35.757 38.3143 31.6869 35.3137 28.6863C32.3131 25.6857 28.243 24 24 24C19.757 24 15.6869 25.6857 12.6863 28.6863C9.68571 31.6869 8 35.757 8 40" stroke="#FF6B00" stroke-width="4" stroke-linecap="round" stroke-linejoin="round"/>
                                            </svg>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                                <input type="file" id="gymImageInput" accept="image/*" style="display: none;">
                            </div>

                            <button class="upload-button" onclick="document.getElementById('gymImageInput').click()">
                                <img src="${pageContext.request.contextPath}/resources/images/icon/upload.png" alt="업로드" style="width: 16px; height: 16px;">
                                <span>이미지 업로드</span>
                            </button>
                        </div>
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
                            <input type="text" class="form-input" placeholder="피트니스 센터 강남점" id="gymName" value="${gym.gymName}">
                        </div>
                        <div class="form-group full-width">
                            <label class="form-label">헬스장 소개</label>
                            <textarea class="form-textarea" placeholder="헬스장에 대한 간단한 소개를 입력해주세요" id="gymDescription"><c:if test="${not empty gymDetail}">${gymDetail.intro}</c:if></textarea>
                        </div>
                        <div class="form-group">
                            <label class="form-label">
                                <img src="${pageContext.request.contextPath}/resources/images/icon/call.png" alt="전화번호" class="label-icon">
                                전화번호
                            </label>
                            <input type="text" class="form-input" placeholder="02-1234-5678" id="gymPhone" value="${gym.gymPhone}">
                        </div>
                        <div class="form-group">
                            <label class="form-label">
                                <img src="${pageContext.request.contextPath}/resources/images/icon/location.png" alt="주소" class="label-icon">
                                주소
                            </label>
                            <input type="text" class="form-input" placeholder="서울 강남구 테헤란로 123" id="gymAddress" value="${gym.gymAddress}">
                        </div>
                        <div class="form-group full-width">
                            <label class="form-label">상세 주소 / 위치 안내</label>
                            <input type="text" class="form-input" placeholder="3층 (해성빌딩 2번 출구 기준 5분)" id="gymDetailAddress" value="<c:if test="${not empty gymDetail}">${gymDetail.detailAddress}</c:if>">
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
                                <input type="text" class="form-input" placeholder="06:00" id="weekdayStart" value="<c:if test="${not empty gymDetail and not empty gymDetail.weekBusinessHour}">${gymDetail.weekBusinessHour.split(' ~ ')[0]}</c:if>">
                            </div>
                            <div class="time-group">
                                <label class="time-label">종료 시간</label>
                                <input type="text" class="form-input" placeholder="23:00" id="weekdayEnd" value="<c:if test="${not empty gymDetail and not empty gymDetail.weekBusinessHour}">${gymDetail.weekBusinessHour.split(' ~ ')[1]}</c:if>">
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
                                <input type="text" class="form-input" placeholder="08:00" id="weekendStart" value="<c:if test="${not empty gymDetail and not empty gymDetail.weekendBusinessHour}">${gymDetail.weekendBusinessHour.split(' ~ ')[0]}</c:if>">
                            </div>
                            <div class="time-group">
                                <label class="time-label">종료 시간</label>
                                <input type="text" class="form-input" placeholder="20:00" id="weekendEnd" value="<c:if test="${not empty gymDetail and not empty gymDetail.weekendBusinessHour}">${gymDetail.weekendBusinessHour.split(' ~ ')[1]}</c:if>">
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
                            <span>주차장</span>
                        </button>
                        <button class="facility-button" data-facility="샤워실">
                            <img src="${pageContext.request.contextPath}/resources/images/icon/shower.png" alt="샤워실" class="facility-icon">
                            <span>샤워실</span>
                        </button>
                        <button class="facility-button" data-facility="락커실">
                            <img src="${pageContext.request.contextPath}/resources/images/icon/locker.png" alt="락커실" class="facility-icon">
                            <span>락커룸</span>
                        </button>
                        <button class="facility-button" data-facility="무료 WiFi">
                            <img src="${pageContext.request.contextPath}/resources/images/icon/wifi.png" alt="무료 WiFi" class="facility-icon">
                            <span>무료WiFi</span>
                        </button>
                        <button class="facility-button" data-facility="PT">
                            <img src="${pageContext.request.contextPath}/resources/images/icon/person.png" alt="PT" class="facility-icon">
                            <span>PT</span>
                        </button>
                        <button class="facility-button" data-facility="GX 프로그램">
                            <img src="${pageContext.request.contextPath}/resources/images/icon/people.png" alt="GX 프로그램" class="facility-icon">
                            <span>GX 프로그램</span>
                        </button>
                        <button class="facility-button" data-facility="카페">
                            <img src="${pageContext.request.contextPath}/resources/images/icon/people.png" alt="카페" class="facility-icon">
                            <span>카페</span>
                        </button>
                        <button class="facility-button" data-facility="수영장">
                            <img src="${pageContext.request.contextPath}/resources/images/icon/people.png" alt="수영장" class="facility-icon">
                            <span>수영장</span>
                        </button>
                        <button class="facility-button" data-facility="필라테스">
                            <img src="${pageContext.request.contextPath}/resources/images/icon/people.png" alt="필라테스" class="facility-icon">
                            <span>필라테스</span>
                        </button>
                        <button class="facility-button" data-facility="사우나">
                            <img src="${pageContext.request.contextPath}/resources/images/icon/people.png" alt="사우나" class="facility-icon">
                            <span>사우나</span>
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

        // Initialize facilities from the model
        const gymFacilities = "<c:if test="${not empty gymDetail}">${gymDetail.facilitiesInfo}</c:if>";
        if (gymFacilities) {
            const facilitiesArray = gymFacilities.split(',');
            facilitiesArray.forEach(facility => {
                const trimmedFacility = facility.trim();
                if (trimmedFacility) {
                    selectedFacilities.push(trimmedFacility);
                    const button = Array.from(facilityButtons).find(btn => btn.getAttribute('data-facility') === trimmedFacility);
                    if (button) {
                        button.classList.add('selected');
                    }
                }
            });
            updateFacilityTags();
        }
        
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
            const formData = new FormData();
            formData.append('gymName', document.getElementById('gymName').value);
            formData.append('gymDescription', document.getElementById('gymDescription').value);
            formData.append('gymPhone', document.getElementById('gymPhone').value);
            formData.append('gymAddress', document.getElementById('gymAddress').value);
            formData.append('gymDetailAddress', document.getElementById('gymDetailAddress').value);
            formData.append('weekdayStart', document.getElementById('weekdayStart').value);
            formData.append('weekdayEnd', document.getElementById('weekdayEnd').value);
            formData.append('weekendStart', document.getElementById('weekendStart').value);
            formData.append('weekendEnd', document.getElementById('weekendEnd').value);
            formData.append('facilities', selectedFacilities.join(', '));

            fetch('${pageContext.request.contextPath}/gym/info/update', {
                method: 'POST',
                body: new URLSearchParams(formData)
            })
                .then(response => response.text())
                .then(data => {
                    if (data === 'success') {
                        alert('정보가 성공적으로 저장되었습니다.');
                    } else {
                        alert('정보 저장에 실패했습니다.');
                    }
                })
                .catch(error => {
                    console.error('Error:', error);
                    alert('오류가 발생했습니다.');
                });
        }

        // 헬스장 이미지
        document.getElementById('gymImageInput').addEventListener('change', function(e) {
            if (e.target.files && e.target.files[0]) {
                var file = e.target.files[0];

                // 파일 크기 체크 (5MB 제한)
                if (file.size > 5 * 1024 * 1024) {
                    alert('파일 크기는 5MB를 초과할 수 없습니다.');
                    return;
                }

                // 이미지 파일 형식 체크
                if (!file.type.startsWith('image/')) {
                    alert('이미지 파일만 업로드 가능합니다.');
                    return;
                }

                // 미리보기 표시
                var reader = new FileReader();
                reader.onload = function(event) {
                    var img = document.createElement('img');
                    img.src = event.target.result;
                    img.style.width = '100%';
                    img.style.height = '100%';
                    img.style.objectFit = 'cover';

                    document.getElementById('mainGymImage').innerHTML = '';
                    document.getElementById('mainGymImage').appendChild(img);
                }
                reader.readAsDataURL(file);

                // 서버에 업로드
                var formData = new FormData();
                formData.append('gymImage', file);

                fetch('${pageContext.request.contextPath}/uploadGymImage.gym', {
                    method: 'POST',
                    body: formData
                })
                    .then(response => response.json())
                    .then(data => {
                        if (data.success) {
                            alert(data.message);
                        } else {
                            alert(data.message);
                            // 실패 시 원래 이미지로 복구
                            location.reload();
                        }
                    })
                    .catch(error => {
                        console.error('Error:', error);
                        alert('이미지 업로드 중 오류가 발생했습니다.');
                        location.reload();
                    });
            }
        });
    </script>
</body>
</html>

