<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>GymHub - 운동 기구 등록</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common.css">
    <style>
        /* main-content 가로로 가득 차게 - !important로 common.css 오버라이드 */
        .main-content {
            width: calc(100% - 255px) !important;
            margin-left: 255px !important;
            padding: 24px 24px 24px 24px !important;
            margin-right: 0 !important;
        }

        /* 페이지 헤더 */
        .page-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 24px;
        }

        .header-left {
            display: flex;
            align-items: center;
            gap: 16px;
        }

        .page-title-group h1 {
            font-size: 24px;
            color: #ff6b00;
            margin-bottom: 4px;
        }

        .page-title-group p {
            font-size: 14px;
            color: #b0b0b0;
        }

        /* 저장 버튼 */
        .save-button {
            background-color: #ff6b00;
            border: none;
            border-radius: 8px;
            padding: 12px 24px;
            color: white;
            font-size: 14px;
            cursor: pointer;
            box-shadow: 0 0 15px rgba(255, 107, 0, 0.4);
            transition: all 0.3s;
        }

        .save-button:hover {
            box-shadow: 0 0 25px rgba(255, 107, 0, 0.6);
            transform: translateY(-2px);
        }

        /* 기구 추가 버튼 */
        .add-equipment-button {
            width: 100%;
            background: transparent;
            border: 2px dashed #ff6b00;
            border-radius: 8px;
            padding: 16px;
            color: #ff6b00;
            font-size: 14px;
            cursor: pointer;
            transition: all 0.3s;
            margin-bottom: 24px;
        }

        .add-equipment-button:hover {
            background-color: rgba(255, 107, 0, 0.1);
        }

        /* 기구 아이템 */
        .equipment-item {
            background-color: #3d2810;
            border: 2px solid #ff6b00;
            border-radius: 8px;
            padding: 20px;
            margin-bottom: 16px;
        }

        .equipment-header {
            background-color: #ff6b00;
            color: white;
            padding: 10px 16px;
            border-radius: 6px;
            font-size: 14px;
            font-weight: 600;
            margin-bottom: 20px;
        }

        .equipment-content {
            padding: 20px;
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
        <!-- Header -->
        <div class="page-header">
            <div class="header-left">
                <button class="back-button" onclick="goBack()">←</button>
                <div class="page-title-group">
                    <h1>운동 기구 등록</h1>
                    <p>헬스장에서 사용할 운동 기구 정보를 등록하세요</p>
                </div>
            </div>
            <button class="save-button" onclick="saveEquipment()">
                전체 등록하기
            </button>
        </div>

        <!-- Add Equipment Button -->
        <button class="add-equipment-button" onclick="addEquipmentItem()">
            + 기구 추가
        </button>

        <!-- Form Section -->
        <div class="section">
            <div class="section-title">운동기구</div>

            <!-- Equipment Item Container -->
            <div id="equipmentContainer">
                <!-- Equipment Item 1 -->
                <div class="equipment-item">
                    <div class="equipment-header">
                        첨부된 이미지 파일명
                    </div>

                    <div class="equipment-content">
                        <!-- Image Upload -->
                        <div class="image-upload-area" onclick="document.getElementById('imageInput1').click()">
                            <div class="upload-icon">
                                <img src="${pageContext.request.contextPath}/resources/images/icon/image.png" alt="이미지" style="width: 48px; height: 48px;">
                            </div>
                            <div class="upload-text">클릭하여 이미지 업로드</div>
                            <div class="upload-subtext">JPG, PNG 파일 (최대 5MB)</div>
                        </div>
                        <input type="file" id="imageInput1" class="hidden" accept="image/*" onchange="handleImageUpload(this, 1)">

                        <!-- Form Grid -->
                        <div class="form-grid">
                            <div class="form-group">
                                <label class="form-label">
                                    머신 이름<span class="required">*</span>
                                </label>
                                <input type="text" class="form-input" placeholder="예: 스쿼트, 벤치프레스" id="machineName1">
                            </div>
                            <div class="form-group">
                                <label class="form-label">
                                    브랜드<span class="required">*</span>
                                </label>
                                <input type="text" class="form-input" placeholder="예: Life Fitness, Technogym" id="brand1">
                            </div>
                        </div>

                        <button class="delete-btn" onclick="deleteEquipmentItem(this)">
                            이 운동기구 삭제
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    let equipmentCount = 1;

    // 뒤로가기
    function goBack() {
        if (confirm('작성중인 내용이 사라집니다. 뒤로 가시겠습니까?')) {
            location.href = '${pageContext.request.contextPath}/facility.gym';
        }
    }

    // 기구 추가
    function addEquipmentItem() {
        equipmentCount++;
        const container = document.getElementById('equipmentContainer');

        const newItem = document.createElement('div');
        newItem.className = 'equipment-item';
        newItem.innerHTML = `
                <div class="equipment-header">
                    첨부된 이미지 파일명
                </div>

                <div class="equipment-content">
                    <div class="image-upload-area" onclick="document.getElementById('imageInput${equipmentCount}').click()">
                        <div class="upload-icon">
                            <img src="${pageContext.request.contextPath}/resources/images/icon/image.png" alt="이미지" style="width: 48px; height: 48px;">
                        </div>
                        <div class="upload-text">클릭하여 이미지 업로드</div>
                        <div class="upload-subtext">JPG, PNG 파일 (최대 5MB)</div>
                    </div>
                    <input type="file" id="imageInput${equipmentCount}" class="hidden" accept="image/*" onchange="handleImageUpload(this, ${equipmentCount})">

                    <div class="form-grid">
                        <div class="form-group">
                            <label class="form-label">
                                머신 이름<span class="required">*</span>
                            </label>
                            <input type="text" class="form-input" placeholder="예: 스쿼트, 벤치프레스" id="machineName${equipmentCount}">
                        </div>
                        <div class="form-group">
                            <label class="form-label">
                                브랜드<span class="required">*</span>
                            </label>
                            <input type="text" class="form-input" placeholder="예: Life Fitness, Technogym" id="brand${equipmentCount}">
                        </div>
                    </div>

                    <button class="delete-btn" onclick="deleteEquipmentItem(this)">
                        이 운동기구 삭제
                    </button>
                </div>
            `;

        container.appendChild(newItem);

        // 애니메이션 효과
        newItem.style.opacity = '0';
        newItem.style.transform = 'translateY(20px)';
        setTimeout(() => {
            newItem.style.transition = 'all 0.3s';
            newItem.style.opacity = '1';
            newItem.style.transform = 'translateY(0)';
        }, 10);
    }

    // 기구 삭제
    function deleteEquipmentItem(button) {
        const items = document.querySelectorAll('.equipment-item');
        if (items.length <= 1) {
            alert('최소 1개의 기구가 있어야 합니다');
            return;
        }

        if (confirm('이 기구를 삭제하시겠습니까?')) {
            const item = button.closest('.equipment-item');
            item.style.transition = 'all 0.3s';
            item.style.opacity = '0';
            item.style.transform = 'translateX(-20px)';
            setTimeout(() => {
                item.remove();
            }, 300);
        }
    }

    // 이미지 업로드 처리
    function handleImageUpload(input, itemNumber) {
        if (input.files && input.files[0]) {
            const file = input.files[0];

            // 파일 크기 체크 (5MB)
            if (file.size > 5 * 1024 * 1024) {
                alert('파일 크기가 5MB를 초과할 수 없습니다.');
                input.value = '';
                return;
            }

            // 파일 타입 체크
            if (!file.type.startsWith('image/')) {
                alert('이미지 파일만 업로드 가능합니다.');
                input.value = '';
                return;
            }

            const reader = new FileReader();
            reader.onload = function(e) {
                const uploadArea = input.previousElementSibling;
                uploadArea.style.backgroundImage = `url(${e.target.result})`;
                uploadArea.style.backgroundSize = 'cover';
                uploadArea.style.backgroundPosition = 'center';
                uploadArea.innerHTML = '<div style="background: rgba(0,0,0,0.5); padding: 10px; border-radius: 8px; color: white;">이미지 변경하기</div>';
            };
            reader.readAsDataURL(file);
        }
    }

    // 저장
    function saveEquipment() {
        const items = document.querySelectorAll('.equipment-item');
        let allFilled = true;

        items.forEach((item, index) => {
            const machineNameInput = item.querySelector('input[id^="machineName"]');
            const brandInput = item.querySelector('input[id^="brand"]');

            if (!machineNameInput.value || !brandInput.value) {
                allFilled = false;
            }
        });

        if (!allFilled) {
            alert('모든 필수 항목을 입력해주세요.');
            return;
        }

        if (confirm(`총 ${items.length}개의 기구를 등록하시겠습니까?`)) {
            alert('운동 기구가 성공적으로 등록되었습니다');
            // 실제로는 서버에 데이터 전송
            location.href = '${pageContext.request.contextPath}/facility.gym';
        }
    }

    // 입력 필드 포커스 효과
    document.addEventListener('DOMContentLoaded', function() {
        const inputs = document.querySelectorAll('.form-input');
        inputs.forEach(input => {
            input.addEventListener('focus', function() {
                this.style.transform = 'scale(1.02)';
            });
            input.addEventListener('blur', function() {
                this.style.transform = 'scale(1)';
            });
        });
    });
</script>
</body>
</html>