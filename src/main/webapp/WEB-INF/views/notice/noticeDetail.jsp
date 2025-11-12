<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>GymHub - 공지사항 상세</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common.css">
    <style>
        /* main-content 가로로 가득 차게 */
        .main-content {
            width: calc(100% - 255px) !important;
            margin-left: 255px !important;
            padding: 24px !important;
        }

        /* Header */
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

        .back-button {
            background: transparent;
            border: none;
            color: #ff6b00;
            font-size: 24px;
            cursor: pointer;
            padding: 8px;
            transition: transform 0.2s;
        }

        .back-button:hover {
            transform: translateX(-3px);
        }

        .page-title-wrapper {
            display: flex;
            flex-direction: column;
        }

        .page-subtitle {
            font-size: 12px;
            color: #b0b0b0;
            margin-top: 4px;
        }

        /* Notice Detail Card */
        .notice-detail-card {
            background-color: #2d1810;
            border: 2px solid #ff6b00;
            border-radius: 8px;
            padding: 32px;
            box-shadow: 0 0 15px rgba(255, 107, 0, 0.3);
        }

        /* Notice Header */
        .notice-detail-header {
            margin-bottom: 24px;
            padding-bottom: 24px;
            border-bottom: 2px solid #ff6b00;
        }

        .notice-badge {
            display: inline-block;
            padding: 6px 16px;
            border-radius: 8px;
            font-size: 13px;
            font-weight: 600;
            margin-bottom: 16px;
        }

        .notice-badge.urgent {
            background-color: rgba(255, 82, 82, 0.2);
            border: 1px solid #ff5252;
            color: #ff5252;
        }

        .notice-badge.event {
            background-color: rgba(255, 107, 0, 0.2);
            border: 1px solid #ff6b00;
            color: #ff6b00;
        }

        .notice-badge.important {
            background-color: rgba(255, 193, 7, 0.2);
            border: 1px solid #ffc107;
            color: #ffc107;
        }

        .notice-badge.general {
            background-color: rgba(176, 176, 176, 0.2);
            border: 1px solid #b0b0b0;
            color: #b0b0b0;
        }

        .notice-detail-title {
            font-size: 28px;
            font-weight: 700;
            color: #ff6b00;
            line-height: 1.4;
            margin-bottom: 20px;
        }

        .notice-meta {
            display: flex;
            gap: 24px;
            font-size: 13px;
            color: #666;
        }

        .notice-meta-item {
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .notice-icon {
            font-size: 16px;
        }

        .notice-meta-item strong {
            color: #ffa366;
        }

        /* Notice Content */
        .notice-content-section {
            background-color: #1a0f0a;
            border: 2px solid #ff6b00;
            border-radius: 8px;
            padding: 32px;
            margin-bottom: 24px;
        }

        .notice-content {
            font-size: 15px;
            color: #b0b0b0;
            line-height: 1.8;
            white-space: pre-wrap;
        }

        /* Thumbnail Area */
        .thumbnail-area {
            margin-top: 24px;
            padding-top: 24px;
            border-top: 1px solid #333;
        }

        .thumbnail-area img {
            max-width: 100%;
            height: auto;
            border-radius: 8px;
            border: 2px solid #ff6b00;
            box-shadow: 0 0 10px rgba(255, 107, 0, 0.3);
            cursor: pointer;
            transition: all 0.3s;
        }

        .thumbnail-area img:hover {
            transform: scale(1.02);
            box-shadow: 0 0 20px rgba(255, 107, 0, 0.5);
        }

        /* Action Buttons */
        .action-buttons {
            display: flex;
            justify-content: center;
            gap: 16px;
        }

        /* 반응형 */
        @media (max-width: 768px) {
            .main-content {
                width: 100% !important;
                margin-left: 0 !important;
            }
            
            .notice-detail-card {
                padding: 24px;
            }
        }
    </style>
</head>
<body>
    <div class="app-container">
        <!-- Sidebar Include -->

        <!-- notice 폴더에 있는 jsp 파일들은 모두 C:if 를 사용하여, 회원 타입 별 사이드바가 다르게 나오도록 해야한다. -->
        <!--include page="../common/sidebar/sidebarMember.jsp.jsp" />
        jsp:include page="../common/sidebar/sidebarTrainer.jsp.jsp" -->
        <jsp:include page="../common/sidebar/sidebarGym.jsp" />
        <!-- Main Content -->
        <div class="main-content">
            <!-- Header -->
            <div class="page-header">
                <div class="header-left">
                    <button class="back-button" onclick="history.back()">←</button>
                    <div class="page-title-wrapper">
                        <h1 class="page-title">공지사항</h1>
                    </div>
                </div>
            </div>

            <!-- Notice Detail Card -->
            <c:choose>
                <c:when test="${not empty notice}">
                    <c:set var="categoryClass" value="general" />
                    <c:set var="categoryLabel" value="일반" />
                    <c:choose>
                        <c:when test="${notice.noticeCategory == 'urgent' or notice.noticeCategory == '긴급'}">
                            <c:set var="categoryClass" value="urgent" />
                            <c:set var="categoryLabel" value="긴급" />
                        </c:when>
                        <c:when test="${notice.noticeCategory == 'event' or notice.noticeCategory == '이벤트'}">
                            <c:set var="categoryClass" value="event" />
                            <c:set var="categoryLabel" value="이벤트" />
                        </c:when>
                        <c:when test="${notice.noticeCategory == 'important' or notice.noticeCategory == '중요'}">
                            <c:set var="categoryClass" value="important" />
                            <c:set var="categoryLabel" value="중요" />
                        </c:when>
                        <c:otherwise>
                            <c:set var="categoryClass" value="general" />
                            <c:set var="categoryLabel" value="일반" />
                        </c:otherwise>
                    </c:choose>
                    
                    <div class="notice-detail-card">
                        <!-- Notice Header -->
                        <div class="notice-detail-header">
                            <span class="notice-badge ${categoryClass}">${categoryLabel}</span>
                            <h2 class="notice-detail-title">${notice.noticeTitle}</h2>
                            <div class="notice-meta">
                                <div class="notice-meta-item">
                                    <img src="${pageContext.request.contextPath}/resources/images/icon/person.png" alt="작성자" class="notice-icon" style="width: 16px; height: 16px;">
                                    <span><strong>${notice.noticeWriter}</strong></span>
                                </div>
                                <div class="notice-meta-item">
                                    <img src="${pageContext.request.contextPath}/resources/images/icon/calendar.png" alt="날짜" class="notice-icon" style="width: 16px; height: 16px;">
                                    <span><fmt:formatDate value="${notice.noticeDate}" pattern="yyyy-MM-dd" /></span>
                                </div>
                            </div>
                        </div>

                        <!-- Notice Content -->
                        <div class="notice-content-section">
                            <div class="notice-content">${notice.noticeContent}</div>
                            <div class="thumbnail-area">
                                <c:if test="${not empty notice.filePath}">
                                    <img src="${pageContext.request.contextPath}${notice.filePath}" 
                                         alt="공지사항 첨부이미지"
                                         onclick="window.open('${pageContext.request.contextPath}${notice.filePath}', '_blank')">
                                </c:if>
                            </div>
                        </div>

                        <!-- Action Buttons -->
                        <div class="action-buttons">
                            <button class="btn btn-secondary" onclick="location.href='${pageContext.request.contextPath}/notice.no'">목록으로</button>
                            <c:if test="${not empty sessionScope.loginMember and sessionScope.loginMember.memberType == 3}">
                                <button class="btn btn-danger" onclick="deleteNotice(${notice.noticeNo})">삭제하기</button>
                                <button class="btn btn-primary" onclick="location.href='${pageContext.request.contextPath}/noticeUpdateForm.no?id=${notice.noticeNo}'">수정하기</button>
                            </c:if>
                        </div>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="notice-detail-card">
                        <div style="text-align: center; padding: 60px 20px; color: #666;">
                            <h3 style="color: #b0b0b0; margin-bottom: 16px;">공지사항을 찾을 수 없습니다</h3>
                            <p style="color: #666; margin-bottom: 24px;">요청하신 공지사항이 존재하지 않거나 삭제되었습니다.</p>
                            <button class="btn btn-secondary" onclick="location.href='${pageContext.request.contextPath}/notice.no'">목록으로</button>
                        </div>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <script>
        // Delete notice function
        function deleteNotice(noticeNo) {
            if (!noticeNo) {
                alert('공지사항 ID를 찾을 수 없습니다.');
                return;
            }

            if (confirm('정말로 이 공지사항을 삭제하시겠습니까?\n삭제된 공지사항은 복구할 수 없습니다.')) {
                // TODO: 실제 서버 삭제 요청 구현 필요
                // fetch('${pageContext.request.contextPath}/noticeDelete.no?id=' + noticeNo, {
                //     method: 'POST',
                //     headers: {
                //         'Content-Type': 'application/json'
                //     }
                // })
                // .then(response => response.json())
                // .then(data => {
                //     if (data.success) {
                //         alert('공지사항이 삭제되었습니다.');
                //         location.href = '${pageContext.request.contextPath}/notice.no';
                //     } else {
                //         alert('삭제 중 오류가 발생했습니다.');
                //     }
                // })
                // .catch(error => {
                //     console.error('Error:', error);
                //     alert('삭제 중 오류가 발생했습니다.');
                // });
                
                alert('삭제 기능은 아직 구현되지 않았습니다.');
            }
        }
    </script>
</body>
</html>

