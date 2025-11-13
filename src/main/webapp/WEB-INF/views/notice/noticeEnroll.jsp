<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>GymHub - 공지사항 작성</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common.css">
    <style>
        /* noticeEnroll 전용 스타일 */
        /* main-content, page-header, header-left는 common.css에 있음 */
        
        /* back-button은 common.css에 있으므로 hover 효과만 추가 */
        .back-button:hover {
            transform: translateX(-3px);
        }

        /* Form Container */
        .notice-form-container {
            background-color: #2d1810;
            border: 2px solid #ff6b00;
            border-radius: 8px;
            padding: 32px;
            box-shadow: 0 0 15px rgba(255, 107, 0, 0.3);
        }

        /* Checkbox Group */
        .notice-type-group {
            display: flex;
            gap: 24px;
            margin-bottom: 24px;
        }

        .checkbox-item {
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .checkbox-item input[type="checkbox"] {
            width: 18px;
            height: 18px;
            accent-color: #ff6b00;
            cursor: pointer;
        }

        .checkbox-item label {
            font-size: 14px;
            color: #ffa366;
            cursor: pointer;
        }

        /* Form Group */
        .form-group {
            margin-bottom: 24px;
        }

        .form-label {
            display: block;
            font-size: 14px;
            color: #ffa366;
            margin-bottom: 8px;
            font-weight: 500;
        }

        .form-input {
            width: 100%;
            background-color: #1a0f0a;
            border: 2px solid #ff6b00;
            border-radius: 8px;
            padding: 12px 16px;
            color: white;
            font-size: 14px;
            font-family: 'Noto Sans KR', sans-serif;
            transition: all 0.3s;
        }

        .form-input:focus {
            outline: none;
            box-shadow: 0 0 15px rgba(255, 107, 0, 0.4);
            border-color: #ff8800;
        }

        .form-input::placeholder {
            color: #666;
        }

        .form-textarea {
            width: 100%;
            min-height: 300px;
            background-color: #1a0f0a;
            border: 2px solid #ff6b00;
            border-radius: 8px;
            padding: 16px;
            color: white;
            font-size: 14px;
            font-family: 'Noto Sans KR', sans-serif;
            resize: vertical;
            transition: all 0.3s;
        }

        .form-textarea:focus {
            outline: none;
            box-shadow: 0 0 15px rgba(255, 107, 0, 0.4);
            border-color: #ff8800;
        }

        .form-textarea::placeholder {
            color: #666;
        }

        /* File Upload */
        .file-upload-section {
            margin-bottom: 24px;
        }

        .file-upload-wrapper {
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .file-upload-button {
            background-color: #ff6b00;
            color: white;
            padding: 10px 20px;
            border-radius: 8px;
            border: none;
            cursor: pointer;
            font-size: 14px;
            transition: all 0.3s;
        }

        .file-upload-button:hover {
            background-color: #ff8800;
        }

        .file-name {
            font-size: 14px;
            color: #b0b0b0;
        }

        input[type="file"] {
            display: none;
        }

        /* Action Buttons */
        .form-actions {
            display: flex;
            justify-content: center;
            gap: 16px;
            margin-top: 32px;
            padding-top: 24px;
            border-top: 2px solid #ff6b00;
        }

        /* 반응형 */
        @media (max-width: 768px) {
            .main-content {
                width: 100% !important;
                margin-left: 0 !important;
            }

            .notice-type-group {
                flex-wrap: wrap;
                gap: 16px;
            }

            .notice-form-container {
                padding: 24px;
            }
        }
    </style>
</head>
<body>
    <div class="app-container">
        <!-- Sidebar Include -->
        <c:choose>
            <c:when test="${not empty sessionScope.loginMember and sessionScope.loginMember.memberType == 1}">
                <jsp:include page="../common/sidebar/sidebarMember.jsp" />
            </c:when>
            <c:when test="${not empty sessionScope.loginMember and sessionScope.loginMember.memberType == 2}">
                <jsp:include page="../common/sidebar/sidebarTrainer.jsp" />
            </c:when>
            <c:when test="${not empty sessionScope.loginMember and sessionScope.loginMember.memberType == 3}">
                <jsp:include page="../common/sidebar/sidebarGym.jsp" />
            </c:when>
            <c:otherwise>
                <jsp:include page="../common/sidebar/sidebarGym.jsp" />
            </c:otherwise>
        </c:choose>

        <!-- Main Content -->
        <div class="main-content">
            <!-- Header -->
            <div class="page-header">
                <div class="header-left">
                    <button class="back-button" onclick="location.href='${pageContext.request.contextPath}/notice.no'">←</button>
                    <h1 class="page-title">공지사항 작성</h1>
                </div>
            </div>

            <!-- Form Container -->
            <div class="notice-form-container">
                <form id="noticeEnrollForm" method="post" action="${pageContext.request.contextPath}/noticeEnroll.no" enctype="multipart/form-data">
                    <!-- Notice Type Checkboxes -->
                    <div class="notice-type-group">
                        <div class="checkbox-item">
                            <input type="checkbox" id="typeImportant" name="noticeType" value="important">
                            <label for="typeImportant">중요 공지로 표시</label>
                        </div>
                        <div class="checkbox-item">
                            <input type="checkbox" id="typeEvent" name="noticeType" value="event">
                            <label for="typeEvent">이벤트 공지로 표시</label>
                        </div>
                        <div class="checkbox-item">
                            <input type="checkbox" id="typeUrgent" name="noticeType" value="urgent">
                            <label for="typeUrgent">점검 공지로 표시</label>
                        </div>
                        <div class="checkbox-item">
                            <input type="checkbox" id="typeGeneral" name="noticeType" value="general" checked>
                            <label for="typeGeneral">일반 공지로 표시</label>
                        </div>
                    </div>

                    <!-- Title -->
                    <div class="form-group">
                        <label class="form-label" for="noticeTitle">제목</label>
                        <input type="text" id="noticeTitle" name="noticeTitle" class="form-input" placeholder="공지사항 제목을 입력하세요" required>
                    </div>

                    <!-- Author -->
                    <div class="form-group">
                        <label class="form-label" for="noticeAuthor">작성자</label>
                        <input type="text" id="noticeAuthor" name="noticeAuthor" class="form-input" 
                               value="${loginMember.memberName}" placeholder="작성자 입력" required>
                    </div>

                    <!-- Content -->
                    <div class="form-group">
                        <label class="form-label" for="noticeContent">내용</label>
                        <textarea id="noticeContent" name="noticeContent" class="form-textarea" placeholder="공지 내용을 입력하세요" required></textarea>
                    </div>

                    <!-- File Upload -->
                    <div class="file-upload-section">
                        <label class="form-label">첨부파일</label>
                        <div class="file-upload-wrapper">
                            <input type="file" id="noticeFile" name="noticeFile" accept="image/*" onchange="updateFileName()">
                            <button type="button" class="file-upload-button" onclick="document.getElementById('noticeFile').click()">
                                📎 이미지
                            </button>
                            <span class="file-name" id="fileName">선택된 파일 없음</span>
                        </div>
                    </div>

                    <!-- Action Buttons -->
                    <div class="form-actions">
                        <button type="button" class="btn btn-secondary" onclick="location.href='${pageContext.request.contextPath}/notice.no'">취소</button>
                        <button type="submit" class="btn btn-primary">등록</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script>
        // 파일명 업데이트
        function updateFileName() {
            const fileInput = document.getElementById('noticeFile');
            const fileNameSpan = document.getElementById('fileName');
            
            if (fileInput.files.length > 0) {
                fileNameSpan.textContent = fileInput.files[0].name;
            } else {
                fileNameSpan.textContent = '선택된 파일 없음';
            }
        }

        // 폼 제출 처리
        document.getElementById('noticeEnrollForm').addEventListener('submit', function(e) {
            // 체크박스 유효성 검사
            const checkboxes = document.querySelectorAll('input[name="noticeType"]:checked');
            if (checkboxes.length === 0) {
                e.preventDefault();
                alert('공지사항 유형을 최소 1개 선택해주세요.');
                return false;
            }
            
            // 제목 유효성 검사
            const title = document.getElementById('noticeTitle').value.trim();
            if (title === '') {
                e.preventDefault();
                alert('제목을 입력해주세요.');
                document.getElementById('noticeTitle').focus();
                return false;
            }
            
            // 작성자 유효성 검사
            const author = document.getElementById('noticeAuthor').value.trim();
            if (author === '') {
                e.preventDefault();
                alert('작성자를 입력해주세요.');
                document.getElementById('noticeAuthor').focus();
                return false;
            }
            
            // 내용 유효성 검사
            const content = document.getElementById('noticeContent').value.trim();
            if (content === '') {
                e.preventDefault();
                alert('내용을 입력해주세요.');
                document.getElementById('noticeContent').focus();
                return false;
            }
            
            // 유효성 검사 통과 시 폼 제출 (서버로 전송)
            return true;
        });

        // 체크박스 상호 배타적 처리 (하나만 선택 가능하도록)
        const checkboxes = document.querySelectorAll('input[name="noticeType"]');
        checkboxes.forEach(function(checkbox) {
            checkbox.addEventListener('change', function() {
                const currentCheckbox = this;
                if (currentCheckbox.checked) {
                    checkboxes.forEach(function(cb) {
                        if (cb !== currentCheckbox) {
                            cb.checked = false;
                        }
                    });
                }
            });
        });
    </script>
</body>
</html>

