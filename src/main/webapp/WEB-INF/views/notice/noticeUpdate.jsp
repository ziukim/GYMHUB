<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>GymHub - 공지사항 수정</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common.css">
    <style>
        /* main-content 가로로 가득 차게 */
        .main-content {
            width: calc(100% - 255px) !important;
            margin-left: 255px !important;
            padding: 24px !important;
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

        .existing-file {
            font-size: 14px;
            color: #8a6a50;
            margin-top: 8px;
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
        <jsp:include page="../common/sidebar/sidebarGym.jsp" />

        <!-- Main Content -->
        <div class="main-content">
            <!-- Header -->
            <div class="page-intro">
                <h1>공지사항 수정</h1>
                <p>공지사항 내용을 수정하세요</p>
            </div>

            <!-- Form Container -->
            <div class="notice-form-container">
                <form id="noticeUpdateForm" method="post" enctype="multipart/form-data">
                    <!-- 공지사항 ID (hidden) -->
                    <input type="hidden" id="noticeId" name="noticeId" value="${notice.noticeNo}">
                    
                    <!-- Notice Type Checkboxes -->
                    <div class="notice-type-group">
                        <div class="checkbox-item">
                            <input type="checkbox" id="typeImportant" name="noticeType" value="important" 
                                   <c:if test="${notice.noticeType == 'important'}">checked</c:if>>
                            <label for="typeImportant">중요 공지로 표시</label>
                        </div>
                        <div class="checkbox-item">
                            <input type="checkbox" id="typeEvent" name="noticeType" value="event"
                                   <c:if test="${notice.noticeType == 'event'}">checked</c:if>>
                            <label for="typeEvent">이벤트 공지로 표시</label>
                        </div>
                        <div class="checkbox-item">
                            <input type="checkbox" id="typeUrgent" name="noticeType" value="urgent"
                                   <c:if test="${notice.noticeType == 'urgent'}">checked</c:if>>
                            <label for="typeUrgent">점검 공지로 표시</label>
                        </div>
                        <div class="checkbox-item">
                            <input type="checkbox" id="typeGeneral" name="noticeType" value="general"
                                   <c:if test="${notice.noticeType == 'general' || empty notice.noticeType}">checked</c:if>>
                            <label for="typeGeneral">일반 공지로 표시</label>
                        </div>
                    </div>

                    <!-- Title -->
                    <div class="form-group">
                        <label class="form-label" for="noticeTitle">제목</label>
                        <input type="text" id="noticeTitle" name="noticeTitle" class="form-input" 
                               placeholder="공지사항 제목을 입력하세요" 
                               value="<c:out value='${notice.noticeTitle}'/>" required>
                    </div>

                    <!-- Author -->
                    <div class="form-group">
                        <label class="form-label" for="noticeAuthor">작성자</label>
                        <input type="text" id="noticeAuthor" name="noticeAuthor" class="form-input" 
                               placeholder="작성자 입력" 
                               value="<c:out value='${notice.noticeWriter}'/>" required>
                    </div>

                    <!-- Content -->
                    <div class="form-group">
                        <label class="form-label" for="noticeContent">내용</label>
                        <textarea id="noticeContent" name="noticeContent" class="form-textarea" 
                                  placeholder="공지 내용을 입력하세요" required><c:out value='${notice.noticeContent}'/></textarea>
                    </div>

                    <!-- File Upload -->
                    <div class="file-upload-section">
                        <label class="form-label">첨부파일</label>
                        <c:if test="${not empty notice.noticeFile}">
                            <div class="existing-file">
                                기존 파일: <c:out value='${notice.noticeFile}'/>
                            </div>
                        </c:if>
                        <div class="file-upload-wrapper">
                            <input type="file" id="noticeFile" name="noticeFile" accept="image/*" onchange="updateFileName()">
                            <button type="button" class="file-upload-button" onclick="document.getElementById('noticeFile').click()">
                                📎 이미지
                            </button>
                            <span class="file-name" id="fileName">
                                <c:choose>
                                    <c:when test="${not empty notice.noticeFile}">
                                        <c:out value='${notice.noticeFile}'/>
                                    </c:when>
                                    <c:otherwise>
                                        선택된 파일 없음
                                    </c:otherwise>
                                </c:choose>
                            </span>
                        </div>
                    </div>

                    <!-- Action Buttons -->
                    <div class="form-actions">
                        <button type="button" class="btn btn-secondary" onclick="location.href='${pageContext.request.contextPath}/notice.no'">취소</button>
                        <button type="submit" class="btn btn-primary">수정</button>
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
                <c:choose>
                    <c:when test="${not empty notice.noticeFile}">
                        fileNameSpan.textContent = '<c:out value="${notice.noticeFile}"/>';
                    </c:when>
                    <c:otherwise>
                        fileNameSpan.textContent = '선택된 파일 없음';
                    </c:otherwise>
                </c:choose>
            }
        }

        // 폼 제출 처리
        document.getElementById('noticeUpdateForm').addEventListener('submit', function(e) {
            e.preventDefault();
            
            // 체크박스 유효성 검사
            const checkboxes = document.querySelectorAll('input[name="noticeType"]:checked');
            if (checkboxes.length === 0) {
                alert('공지사항 유형을 최소 1개 선택해주세요.');
                return;
            }
            
            // 제목 유효성 검사
            const title = document.getElementById('noticeTitle').value.trim();
            if (title === '') {
                alert('제목을 입력해주세요.');
                document.getElementById('noticeTitle').focus();
                return;
            }
            
            // 작성자 유효성 검사
            const author = document.getElementById('noticeAuthor').value.trim();
            if (author === '') {
                alert('작성자를 입력해주세요.');
                document.getElementById('noticeAuthor').focus();
                return;
            }
            
            // 내용 유효성 검사
            const content = document.getElementById('noticeContent').value.trim();
            if (content === '') {
                alert('내용을 입력해주세요.');
                document.getElementById('noticeContent').focus();
                return;
            }
            
            // 실제로는 서버로 폼 데이터 전송
            alert('공지사항이 수정되었습니다.');
            location.href = '${pageContext.request.contextPath}/notice.no';
            
            // TODO: 실제 서버 전송 코드
            // this.submit();
        });

        // 체크박스 상호 배타적 처리 (하나만 선택 가능하도록)
        const checkboxes = document.querySelectorAll('input[name="noticeType"]');
        checkboxes.forEach(checkbox => {
            checkbox.addEventListener('change', function() {
                if (this.checked) {
                    checkboxes.forEach(cb => {
                        if (cb !== this) {
                            cb.checked = false;
                        }
                    });
                }
            });
        });
    </script>
</body>
</html>

