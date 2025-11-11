<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>GymHub - 운동 기구 등록</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common.css">
    <style>
        .main-content {
            width: calc(100% - 255px) !important;
            margin-left: 255px !important;
            padding: 24px 24px 24px 24px !important;
            margin-right: 0 !important;
        }

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

        .save-button:disabled {
            background-color: #666;
            cursor: not-allowed;
            transform: none;
        }

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

        .equipment-item {
            background-color: #2d1810;
            border: 2px solid #ff6b00;
            border-radius: 8px;
            padding: 20px;
            margin-bottom: 16px;
            box-shadow: 0 0 15px rgba(255, 107, 0, 0.3);
            position: relative;
        }

        .equipment-item.success {
            border-color: #4CAF50;
            opacity: 0.6;
            pointer-events: none;
        }

        .equipment-item.error {
            border-color: #f44336;
        }

        .status-badge {
            position: absolute;
            top: 10px;
            right: 10px;
            padding: 6px 12px;
            border-radius: 4px;
            font-size: 12px;
            font-weight: bold;
            z-index: 10;
        }

        .status-badge.success {
            background-color: #4CAF50;
            color: white;
        }

        .status-badge.error {
            background-color: #f44336;
            color: white;
        }

        .equipment-header {
            background-color: #ff6b00;
            color: white;
            padding: 12px 16px;
            border-radius: 6px;
            font-size: 14px;
            font-weight: 600;
            margin-bottom: 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .equipment-number {
            font-size: 16px;
        }

        .equipment-content {
            padding: 20px;
        }

        .image-upload-area {
            width: 100%;
            height: 250px;
            background-color: #1a0f0a;
            border: 3px dashed #ff6b00;
            border-radius: 8px;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            transition: all 0.3s;
            margin-bottom: 20px;
            position: relative;
            overflow: hidden;
        }

        .image-upload-area:hover {
            border-color: #ff8800;
            background-color: #2d1810;
        }

        .image-upload-area.has-image {
            border-style: solid;
        }

        .upload-icon {
            width: 48px;
            height: 48px;
            margin-bottom: 12px;
            opacity: 0.6;
        }

        .upload-text {
            font-size: 16px;
            color: #b0b0b0;
            margin-bottom: 8px;
        }

        .upload-subtext {
            font-size: 13px;
            color: #666;
        }

        .preview-image {
            display: none;
            width: 100%;
            height: 100%;
            object-fit: contain;
        }

        .preview-image.show {
            display: block;
        }

        .hidden {
            display: none;
        }

        .form-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 20px;
            margin-bottom: 20px;
        }

        .form-group {
            margin-bottom: 0;
        }

        .form-label {
            display: block;
            font-size: 14px;
            color: white;
            margin-bottom: 8px;
            font-weight: 500;
        }

        .required {
            color: #ff6b00;
            margin-left: 4px;
        }

        .form-input {
            width: 100%;
            padding: 12px 16px;
            background-color: #1a0f0a;
            border: 2px solid #ff6b00;
            border-radius: 8px;
            color: white;
            font-size: 14px;
            font-family: 'Noto Sans KR', sans-serif;
            transition: all 0.3s;
            box-sizing: border-box;
        }

        .form-input:focus {
            outline: none;
            box-shadow: 0 0 15px rgba(255, 107, 0, 0.4);
            border-color: #ff8800;
            transform: scale(1.02);
        }

        .delete-btn {
            width: 100%;
            background-color: transparent;
            border: 2px solid #f44336;
            border-radius: 8px;
            padding: 12px;
            color: #ff6666;
            font-size: 14px;
            cursor: pointer;
            transition: all 0.3s;
        }

        .delete-btn:hover {
            background-color: #f44336;
            color: white;
        }

        .section {
            background-color: #2d1810;
            border: 2px solid #ff6b00;
            border-radius: 8px;
            padding: 26px;
            box-shadow: 0 0 15px rgba(255, 107, 0, 0.3);
        }

        .section-title {
            font-size: 18px;
            color: #ff6b00;
            font-weight: 600;
            margin-bottom: 24px;
            padding-bottom: 16px;
            border-bottom: 2px solid #ff6b00;
        }

        @media (max-width: 768px) {
            .main-content {
                width: 100% !important;
                margin-left: 0 !important;
            }

            .form-grid {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
<div class="app-container">
    <jsp:include page="../common/sidebar/sidebarGym.jsp" />

    <div class="main-content">
        <div class="page-intro">
            <h1>운동 기구 등록</h1>
            <p>헬스장에서 사용할 운동 기구 정보를 등록하세요</p>
        </div>

        <div class="page-header">
            <div class="header-left"></div>
            <button class="save-button" id="saveButton" onclick="saveEquipment()">
                전체 등록하기
            </button>
        </div>

        <button class="add-equipment-button" onclick="addEquipmentItem()">
            + 기구 추가
        </button>

        <div class="section">
            <div class="section-title">운동기구</div>

            <div id="equipmentContainer">
                <!-- 첫 번째 기구 항목 -->
                <div class="equipment-item" data-item-id="1">
                    <div class="equipment-header">
                        <span class="equipment-number">기구 #1</span>
                    </div>

                    <div class="equipment-content">
                        <div class="image-upload-area" onclick="document.getElementById('imageInput1').click()">
                            <img id="previewImage1" class="preview-image" alt="미리보기">
                            <div id="uploadPlaceholder1">
                                <div class="upload-icon">
                                    <img src="${pageContext.request.contextPath}/resources/images/icon/image.png" alt="이미지" style="width: 48px; height: 48px;">
                                </div>
                                <div class="upload-text">클릭하여 이미지 업로드</div>
                                <div class="upload-subtext">JPG, PNG 파일 (최대 10MB)</div>
                            </div>
                        </div>
                        <input type="file" id="imageInput1" class="hidden" accept="image/*" onchange="handleImageUpload(this, 1)" required>

                        <div class="form-grid">
                            <div class="form-group">
                                <label class="form-label">
                                    머신 이름<span class="required">*</span>
                                </label>
                                <input type="text" class="form-input" placeholder="예: 트레드밀, 레그프레스" id="machineName1" required>
                            </div>
                            <div class="form-group">
                                <label class="form-label">
                                    브랜드<span class="required">*</span>
                                </label>
                                <input type="text" class="form-input" placeholder="예: Life Fitness, Technogym" id="brand1" required>
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

    function addEquipmentItem() {
        equipmentCount++;
        const container = document.getElementById('equipmentContainer');

        const newItem = document.createElement('div');
        newItem.className = 'equipment-item';
        newItem.setAttribute('data-item-id', equipmentCount);
        newItem.innerHTML = `
            <div class="equipment-header">
                <span class="equipment-number">기구 #${equipmentCount}</span>
            </div>

            <div class="equipment-content">
                <div class="image-upload-area" onclick="document.getElementById('imageInput${equipmentCount}').click()">
                    <img id="previewImage${equipmentCount}" class="preview-image" alt="미리보기">
                    <div id="uploadPlaceholder${equipmentCount}">
                        <div class="upload-icon">
                            <img src="${pageContext.request.contextPath}/resources/images/icon/image.png" alt="이미지" style="width: 48px; height: 48px;">
                        </div>
                        <div class="upload-text">클릭하여 이미지 업로드</div>
                        <div class="upload-subtext">JPG, PNG 파일 (최대 10MB)</div>
                    </div>
                </div>
                <input type="file" id="imageInput${equipmentCount}" class="hidden" accept="image/*" onchange="handleImageUpload(this, ${equipmentCount})" required>

                <div class="form-grid">
                    <div class="form-group">
                        <label class="form-label">
                            머신 이름<span class="required">*</span>
                        </label>
                        <input type="text" class="form-input" placeholder="예: 트레드밀, 레그프레스" id="machineName${equipmentCount}" required>
                    </div>
                    <div class="form-group">
                        <label class="form-label">
                            브랜드<span class="required">*</span>
                        </label>
                        <input type="text" class="form-input" placeholder="예: Life Fitness, Technogym" id="brand${equipmentCount}" required>
                    </div>
                </div>

                <button class="delete-btn" onclick="deleteEquipmentItem(this)">
                    이 운동기구 삭제
                </button>
            </div>
        `;

        container.appendChild(newItem);

        newItem.style.opacity = '0';
        newItem.style.transform = 'translateY(20px)';
        setTimeout(() => {
            newItem.style.transition = 'all 0.3s';
            newItem.style.opacity = '1';
            newItem.style.transform = 'translateY(0)';
        }, 10);
    }

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

    function handleImageUpload(input, itemNumber) {
        if (input.files && input.files[0]) {
            const file = input.files[0];

            if (file.size > 10 * 1024 * 1024) {
                alert('파일 크기가 10MB를 초과할 수 없습니다.');
                input.value = '';
                return;
            }

            if (!file.type.startsWith('image/')) {
                alert('이미지 파일만 업로드 가능합니다.');
                input.value = '';
                return;
            }

            const reader = new FileReader();
            reader.onload = function(e) {
                const previewImage = document.getElementById('previewImage' + itemNumber);
                const uploadPlaceholder = document.getElementById('uploadPlaceholder' + itemNumber);
                const uploadArea = previewImage.parentElement;

                previewImage.src = e.target.result;
                previewImage.classList.add('show');
                uploadPlaceholder.style.display = 'none';
                uploadArea.classList.add('has-image');
            };
            reader.readAsDataURL(file);
        }
    }

    async function saveEquipment() {
        const items = document.querySelectorAll('.equipment-item');
        let allValid = true;
        const equipmentData = [];

        // 성공한 항목은 제외 (success 클래스가 있는 항목)
        items.forEach((item, index) => {
            // 이미 성공한 항목은 건너뛰기
            if (item.classList.contains('success')) {
                return;
            }

            const itemId = item.getAttribute('data-item-id');
            const imageInput = document.getElementById('imageInput' + itemId);
            const machineName = document.getElementById('machineName' + itemId);
            const brand = document.getElementById('brand' + itemId);

            if (!imageInput.files || imageInput.files.length === 0) {
                alert('기구 #' + itemId + '의 이미지를 업로드해주세요.');
                allValid = false;
                return;
            }

            if (!machineName.value.trim()) {
                alert('기구 #' + itemId + '의 머신 이름을 입력해주세요.');
                machineName.focus();
                allValid = false;
                return;
            }

            if (!brand.value.trim()) {
                alert('기구 #' + itemId + '의 브랜드를 입력해주세요.');
                brand.focus();
                allValid = false;
                return;
            }

            equipmentData.push({
                itemId: itemId,
                element: item,
                imageFile: imageInput.files[0],
                machineName: machineName.value.trim(),
                brand: brand.value.trim()
            });
        });

        if (!allValid) return;

        if (equipmentData.length === 0) {
            alert('등록할 기구가 없습니다.');
            return;
        }

        if (!confirm(`${equipmentData.length}개의 기구를 등록하시겠습니까?`)) {
            return;
        }

        // 버튼 비활성화
        const saveButton = document.getElementById('saveButton');
        saveButton.disabled = true;
        saveButton.textContent = '등록 중... (0/' + equipmentData.length + ')';

        let successCount = 0;
        let failCount = 0;

        // 각 기구를 순차적으로 등록
        for (let i = 0; i < equipmentData.length; i++) {
            const data = equipmentData[i];
            const formData = new FormData();

            formData.append('machineImage', data.imageFile);
            formData.append('machineName', data.machineName);
            formData.append('brand', data.brand);

            try {
                const response = await fetch('${pageContext.request.contextPath}/machineInsert.gym', {
                    method: 'POST',
                    body: formData
                });

                if (response.ok) {
                    successCount++;
                    // 성공한 항목 표시 및 비활성화
                    data.element.classList.add('success');
                    const badge = document.createElement('div');
                    badge.className = 'status-badge success';
                    badge.textContent = '✓ 등록 완료';
                    data.element.appendChild(badge);
                } else {
                    failCount++;
                    // 실패한 항목 표시
                    data.element.classList.add('error');
                    const badge = document.createElement('div');
                    badge.className = 'status-badge error';
                    badge.textContent = '✗ 등록 실패';
                    data.element.appendChild(badge);
                }
            } catch (error) {
                console.error('Error:', error);
                failCount++;
                // 실패한 항목 표시
                data.element.classList.add('error');
                const badge = document.createElement('div');
                badge.className = 'status-badge error';
                badge.textContent = '✗ 등록 실패';
                data.element.appendChild(badge);
            }

            // 진행 상황 업데이트
            saveButton.textContent = '등록 중... (' + (i + 1) + '/' + equipmentData.length + ')';
        }

        // 결과 알림
        if (failCount === 0) {
            // 모두 성공
            alert(`${successCount}개의 기구가 성공적으로 등록되었습니다!`);
            setTimeout(() => {
                location.href = '${pageContext.request.contextPath}/machineList.gym';
            }, 500);
        } else {
            // 일부 실패
            alert(`${successCount}개 성공, ${failCount}개 실패\n\n실패한 기구만 수정 후 다시 등록해주세요.`);
            saveButton.disabled = false;
            saveButton.textContent = '실패한 기구만 다시 등록';

            // 성공한 항목들은 부드럽게 제거 (선택사항)
            setTimeout(() => {
                const successItems = document.querySelectorAll('.equipment-item.success');
                successItems.forEach(item => {
                    item.style.transition = 'all 0.5s';
                    item.style.opacity = '0';
                    item.style.maxHeight = '0';
                    item.style.marginBottom = '0';
                    item.style.padding = '0';
                    setTimeout(() => {
                        item.remove();
                    }, 500);
                });
            }, 2000); // 2초 후 성공한 항목 제거
        }
    }
</script>
</body>
</html>
