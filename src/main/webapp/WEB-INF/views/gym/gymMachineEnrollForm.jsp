<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>GymHub - 운동 기구 등록</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common.css">
    <style>
        /* gymMachineEnrollForm 전용 스타일 */
        /* main-content는 common.css에 있음 */

        /* page-header, header-left는 common.css에 있음 */

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

        <!-- Add Equipment Button -->
        <button class="add-equipment-button" onclick="addEquipmentItem()">
            + 기구 추가
        </button>

        <!-- Form Section -->
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
    var equipmentCount = 1;

    // 기구 추가
    function addEquipmentItem() {
        equipmentCount++;
        var container = document.getElementById('equipmentContainer');

        var newItem = document.createElement('div');
        newItem.className = 'equipment-item';
        newItem.setAttribute('data-item-id', equipmentCount);
        
        var itemHTML = '<div class="equipment-header">' +
            '<span class="equipment-number">기구 #' + equipmentCount + '</span>' +
            '</div>' +
            '<div class="equipment-content">' +
            '<div class="image-upload-area" onclick="document.getElementById(\'imageInput' + equipmentCount + '\').click()">' +
            '<img id="previewImage' + equipmentCount + '" class="preview-image" alt="미리보기">' +
            '<div id="uploadPlaceholder' + equipmentCount + '">' +
            '<div class="upload-icon">' +
            '<img src="${pageContext.request.contextPath}/resources/images/icon/image.png" alt="이미지" style="width: 48px; height: 48px;">' +
            '</div>' +
            '<div class="upload-text">클릭하여 이미지 업로드</div>' +
            '<div class="upload-subtext">JPG, PNG 파일 (최대 10MB)</div>' +
            '</div>' +
            '</div>' +
            '<input type="file" id="imageInput' + equipmentCount + '" class="hidden" accept="image/*" onchange="handleImageUpload(this, ' + equipmentCount + ')" required>' +
            '<div class="form-grid">' +
            '<div class="form-group">' +
            '<label class="form-label">머신 이름<span class="required">*</span></label>' +
            '<input type="text" class="form-input" placeholder="예: 트레드밀, 레그프레스" id="machineName' + equipmentCount + '" required>' +
            '</div>' +
            '<div class="form-group">' +
            '<label class="form-label">브랜드<span class="required">*</span></label>' +
            '<input type="text" class="form-input" placeholder="예: Life Fitness, Technogym" id="brand' + equipmentCount + '" required>' +
            '</div>' +
            '</div>' +
            '<button class="delete-btn" onclick="deleteEquipmentItem(this)">이 운동기구 삭제</button>' +
            '</div>';
        
        newItem.innerHTML = itemHTML;
        container.appendChild(newItem);

        newItem.style.opacity = '0';
        newItem.style.transform = 'translateY(20px)';
        setTimeout(function() {
            newItem.style.transition = 'all 0.3s';
            newItem.style.opacity = '1';
            newItem.style.transform = 'translateY(0)';
        }, 10);
    }

    // 기구 삭제
    function deleteEquipmentItem(button) {
        var items = document.querySelectorAll('.equipment-item');
        if (items.length <= 1) {
            alert('최소 1개의 기구가 있어야 합니다');
            return;
        }

        if (confirm('이 기구를 삭제하시겠습니까?')) {
            var item = button.closest('.equipment-item');
            item.style.transition = 'all 0.3s';
            item.style.opacity = '0';
            item.style.transform = 'translateX(-20px)';
            setTimeout(function() {
                item.remove();
            }, 300);
        }
    }

    // 이미지 업로드 처리
    function handleImageUpload(input, itemNumber) {
        if (input.files && input.files[0]) {
            var file = input.files[0];

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

            var reader = new FileReader();
            reader.onload = function(e) {
                var previewImage = document.getElementById('previewImage' + itemNumber);
                var uploadPlaceholder = document.getElementById('uploadPlaceholder' + itemNumber);
                var uploadArea = previewImage.parentElement;

                previewImage.src = e.target.result;
                previewImage.classList.add('show');
                uploadPlaceholder.style.display = 'none';
                uploadArea.classList.add('has-image');
            };
            reader.readAsDataURL(file);
        }
    }

    // 저장
    function saveEquipment() {
        var items = document.querySelectorAll('.equipment-item');
        var allValid = true;
        var equipmentData = [];

        for (var i = 0; i < items.length; i++) {
            var item = items[i];
            if (item.classList.contains('success')) {
                continue;
            }

            var itemId = item.getAttribute('data-item-id');
            var imageInput = document.getElementById('imageInput' + itemId);
            var machineName = document.getElementById('machineName' + itemId);
            var brand = document.getElementById('brand' + itemId);

            if (!imageInput.files || imageInput.files.length === 0) {
                alert('기구 #' + itemId + '의 이미지를 업로드해주세요.');
                allValid = false;
                continue;
            }

            if (!machineName.value.trim()) {
                alert('기구 #' + itemId + '의 머신 이름을 입력해주세요.');
                machineName.focus();
                allValid = false;
                continue;
            }

            if (!brand.value.trim()) {
                alert('기구 #' + itemId + '의 브랜드를 입력해주세요.');
                brand.focus();
                allValid = false;
                continue;
            }

            equipmentData.push({
                itemId: itemId,
                element: item,
                imageFile: imageInput.files[0],
                machineName: machineName.value.trim(),
                brand: brand.value.trim()
            });
        }

        if (!allValid) return;

        if (equipmentData.length === 0) {
            alert('등록할 기구가 없습니다.');
            return;
        }

        if (!confirm(equipmentData.length + '개의 기구를 등록하시겠습니까?')) {
            return;
        }

        var saveButton = document.getElementById('saveButton');
        saveButton.disabled = true;
        saveButton.textContent = '등록 중... (0/' + equipmentData.length + ')';

        var successCount = 0;
        var failCount = 0;
        var currentIndex = 0;

        function processNext() {
            if (currentIndex >= equipmentData.length) {
                if (failCount === 0) {
                    alert(successCount + '개의 기구가 성공적으로 등록되었습니다!');
                    setTimeout(function() {
                        location.href = '${pageContext.request.contextPath}/machineList.gym';
                    }, 500);
                } else {
                    alert(successCount + '개 성공, ' + failCount + '개 실패\n\n실패한 기구만 수정 후 다시 등록해주세요.');
                    saveButton.disabled = false;
                    saveButton.textContent = '실패한 기구만 다시 등록';
                }
                return;
            }

            var data = equipmentData[currentIndex];
            var formData = new FormData();

            formData.append('machineImage', data.imageFile);
            formData.append('machineName', data.machineName);
            formData.append('brand', data.brand);

            fetch('${pageContext.request.contextPath}/machineInsert.gym', {
                method: 'POST',
                body: formData
            })
            .then(function(response) {
                return response.ok;
            })
            .then(function(isOk) {
                if (isOk) {
                    successCount++;
                    data.element.classList.add('success');
                    var badge = document.createElement('div');
                    badge.className = 'status-badge success';
                    badge.textContent = '✓ 등록 완료';
                    data.element.appendChild(badge);
                } else {
                    failCount++;
                    data.element.classList.add('error');
                    var badge = document.createElement('div');
                    badge.className = 'status-badge error';
                    badge.textContent = '✗ 등록 실패';
                    data.element.appendChild(badge);
                }
            })
            .catch(function(error) {
                console.error('Error:', error);
                failCount++;
                data.element.classList.add('error');
                var badge = document.createElement('div');
                badge.className = 'status-badge error';
                badge.textContent = '✗ 등록 실패';
                data.element.appendChild(badge);
            })
            .finally(function() {
                currentIndex++;
                saveButton.textContent = '등록 중... (' + currentIndex + '/' + equipmentData.length + ')';
                processNext();
            });
        }

        processNext();
    }

    // 입력 필드 포커스 효과
    document.addEventListener('DOMContentLoaded', function() {
        var inputs = document.querySelectorAll('.form-input');
        for (var i = 0; i < inputs.length; i++) {
            inputs[i].addEventListener('focus', function() {
                this.style.transform = 'scale(1.02)';
            });
            inputs[i].addEventListener('blur', function() {
                this.style.transform = 'scale(1)';
            });
        }
    });
</script>
</body>
</html>