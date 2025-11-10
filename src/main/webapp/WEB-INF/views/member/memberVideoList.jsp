<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>GymHub - 영상 관리</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common.css">

    <style>
        /* Video Grid */
        .video-grid {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 20px;
            margin-top: 24px;
        }

        /* Video Card */
        .video-card {
            background-color: #3d2810;
            border: 2px solid #ff6b00;
            border-radius: 8px;
            overflow: hidden;
            cursor: pointer;
            transition: all 0.3s;
            position: relative;
        }

        .video-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 5px 20px rgba(255, 107, 0, 0.4);
        }

        .video-thumbnail {
            position: relative;
            width: 100%;
            height: 160px;
            overflow: hidden;
            background-color: #1a0f0a;
        }

        .video-thumbnail img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .play-button {
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            width: 50px;
            height: 50px;
            background-color: #ff6b00;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 20px;
            color: white;
            box-shadow: 0 0 15px rgba(255, 107, 0, 0.6);
            transition: all 0.3s;
        }

        .video-card:hover .play-button {
            transform: translate(-50%, -50%) scale(1.1);
            box-shadow: 0 0 25px rgba(255, 107, 0, 0.8);
        }

        .video-info {
            padding: 16px;
        }

        .video-title {
            font-size: 14px;
            color: white;
            margin-bottom: 8px;
            font-weight: 500;
        }

        .video-date {
            font-size: 12px;
            color: #b0b0b0;
        }

        /* Modal */
        .modal-overlay {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background-color: rgba(0, 0, 0, 0.8);
            z-index: 2000;
            align-items: center;
            justify-content: center;
        }

        .modal-overlay.active {
            display: flex;
        }

        .modal-content {
            background-color: #2d1810;
            border: 2px solid #ff6b00;
            border-radius: 8px;
            padding: 30px;
            max-width: 600px;
            width: 90%;
            box-shadow: 0 0 30px rgba(255, 107, 0, 0.5);
        }

        .modal-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }

        .modal-title {
            font-size: 20px;
            color: #ff6b00;
        }

        .close-button {
            background: transparent;
            border: none;
            color: #ff6b00;
            font-size: 24px;
            cursor: pointer;
            padding: 0;
            width: 30px;
            height: 30px;
        }

        .modal-body {
            color: white;
        }

        .modal-body p {
            margin-bottom: 10px;
            line-height: 1.6;
        }

        /* 카드 애니메이션 */
        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .video-card {
            animation: fadeInUp 0.5s ease forwards;
            opacity: 0;
        }

        /* 반응형 */
        @media (max-width: 1400px) {
            .video-grid {
                grid-template-columns: repeat(3, 1fr);
            }
        }

        @media (max-width: 992px) {
            .video-grid {
                grid-template-columns: repeat(2, 1fr);
            }
        }

        @media (max-width: 576px) {
            .video-grid {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
<div class="app-container">
    <!-- Sidebar Include -->
    <jsp:include page="../common/sidebar/sidebarMember.jsp" />

    <!-- Main Content -->
    <div class="main-content">
        <div class="page-intro">
            <h1>운동 강의 영상</h1>
            <p>다양한 운동 강의 영상을 시청하고 학습하세요</p>
        </div>

        <div class="section">
            <div class="section-header">
                <h2 class="section-title">
                    📹 운동 강의 영상 관리
                </h2>
            </div>

            <div class="video-grid">
                <c:choose>
                    <c:when test="${not empty videoList}">
                        <c:forEach var="video" items="${videoList}" varStatus="status">
                            <div class="video-card"
                                 onclick="playVideo('${video.videoTitle}', '${video.videoNo}')"
                                 style="animation-delay: ${status.index * 0.05}s">
                                <div class="video-thumbnail">
                                    <c:choose>
                                        <c:when test="${not empty video.thumbnailPath}">
                                            <img src="${pageContext.request.contextPath}/${video.thumbnailPath}"
                                                 alt="${video.videoTitle}">
                                        </c:when>
                                        <c:otherwise>
                                            <img src="https://images.unsplash.com/photo-1571019614242-c5c5dee9f50b?w=400&h=300&fit=crop"
                                                 alt="${video.videoTitle}">
                                        </c:otherwise>
                                    </c:choose>
                                    <div class="play-button">▶</div>
                                </div>
                                <div class="video-info">
                                    <div class="video-title">${video.videoTitle}</div>
                                    <div class="video-date">${video.createDate}</div>
                                </div>
                            </div>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <div style="grid-column: 1 / -1; text-align: center; padding: 60px 0; color: #b0b0b0;">
                            <p style="font-size: 18px; margin-bottom: 10px;">등록된 영상이 없습니다.</p>
                            <p style="font-size: 14px;">영상을 업로드해 주세요.</p>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
</div>

<!-- Modal -->
<div class="modal-overlay" id="videoModal">
    <div class="modal-content">
        <div class="modal-header">
            <h3 class="modal-title" id="modalTitle">영상 재생</h3>
            <button class="close-button" onclick="closeModal()">×</button>
        </div>
        <div class="modal-body">
            <p>영상 플레이어가 여기에 표시됩니다.</p>
            <p style="color: #b0b0b0; margin-top: 20px;">
                실제 구현 시 YouTube 또는 자체 비디오 플레이어가 들어갑니다.
            </p>
        </div>
    </div>
</div>

<script>
    // 영상 재생
    function playVideo(title, videoNo) {
        document.getElementById('modalTitle').textContent = title;
        document.getElementById('videoModal').classList.add('active');

        // 실제 구현 시 Ajax로 비디오 정보 가져오기
        console.log('Video No: ' + videoNo + ' 재생');
    }

    // 모달 닫기
    function closeModal() {
        document.getElementById('videoModal').classList.remove('active');
    }

    // 모달 외부 클릭시 닫기
    document.getElementById('videoModal').addEventListener('click', function(e) {
        if (e.target === this) {
            closeModal();
        }
    });

    // ESC 키로 모달 닫기
    document.addEventListener('keydown', function(e) {
        if (e.key === 'Escape') {
            closeModal();
        }
    });
</script>
</body>
</html>