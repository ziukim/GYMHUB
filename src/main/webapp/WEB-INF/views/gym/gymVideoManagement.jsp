<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>GymHub - 영상 관리</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common.css">
    <style>
        /* main-content 가로로 가득 차게 - !important로 common.css 오버라이드 */
        .main-content {
            width: calc(100% - 255px) !important;
            margin-left: 255px !important;
            padding: 24px 24px 24px 24px !important;
            margin-right: 0 !important;
        }

        /* Section Container */
        .section {
            background-color: #2d1810;
            border: 2px solid #ff6b00;
            border-radius: 8px;
            padding: 26px;
            box-shadow: 0 0 15px rgba(255, 107, 0, 0.3);
        }

        .section-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding-bottom: 16px;
            border-bottom: 2px solid #ff6b00;
            margin-bottom: 24px;
        }

        .section-title {
            font-size: 18px;
            color: #ff6b00;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .upload-button {
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

        .upload-button:hover {
            box-shadow: 0 0 25px rgba(255, 107, 0, 0.6);
            transform: translateY(-2px);
        }

        /* Video Grid */
        .video-grid {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 20px;
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

        .video-badge {
            position: absolute;
            top: 10px;
            right: 10px;
            background-color: #ff3333;
            color: white;
            padding: 4px 10px;
            border-radius: 12px;
            font-size: 11px;
            font-weight: 600;
        }

        .video-info {
            padding: 16px;
            position: relative;
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

        .video-delete-button {
            position: absolute;
            bottom: 12px;
            right: 12px;
            width: 32px;
            height: 32px;
            background: transparent;
            border: 1px solid #ff6b00;
            border-radius: 8px;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            transition: all 0.2s;
            z-index: 10;
        }

        .video-delete-button:hover {
            background: rgba(255, 82, 82, 0.1);
            border-color: #ff5252;
        }

        .video-delete-icon {
            width: 18px;
            height: 18px;
        }

        /* Modal Overlay */
        .modal-overlay {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background-color: rgba(0, 0, 0, 0.8);
            z-index: 1000;
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

        /* 업로드 모달 폼 스타일 */
        .upload-modal-form {
            display: flex;
            flex-direction: column;
            gap: 20px;
        }

        .form-group {
            display: flex;
            flex-direction: column;
            gap: 8px;
        }

        .form-label {
            font-size: 14px;
            color: #ff6b00;
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
            box-sizing: border-box;
        }

        .form-input:focus {
            outline: none;
            box-shadow: 0 0 15px rgba(255, 107, 0, 0.4);
            border-color: #ff8800;
        }

        .form-input::placeholder {
            color: #666;
        }

        .modal-footer {
            display: flex;
            justify-content: flex-end;
            gap: 12px;
            margin-top: 24px;
            padding-top: 20px;
            border-top: 2px solid #ff6b00;
        }

        .modal-btn {
            padding: 12px 24px;
            border-radius: 8px;
            font-size: 14px;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.3s;
            border: 2px solid;
            font-family: 'Noto Sans KR', sans-serif;
        }

        .modal-btn-cancel {
            background-color: transparent;
            border-color: #ff6b00;
            color: #b0b0b0;
        }

        .modal-btn-cancel:hover {
            background-color: rgba(255, 107, 0, 0.1);
            color: #ff6b00;
        }

        .modal-btn-upload {
            background-color: #ff6b00;
            border-color: #ff6b00;
            color: white;
        }

        .modal-btn-upload:hover {
            background-color: #ff8800;
            box-shadow: 0 0 20px rgba(255, 107, 0, 0.6);
            transform: translateY(-2px);
        }

        /* 반응형 */
        @media (max-width: 768px) {
            .main-content {
                width: 100% !important;
                margin-left: 0 !important;
            }
            
            .video-grid {
                grid-template-columns: repeat(2, 1fr);
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
            <div class="page-intro">
                <h1>영상 관리</h1>
                <p>운동 강의 영상을 업로드하고 관리하세요</p>
            </div>
            <div class="section">
                <div class="section-header">
                    <h2 class="section-title">
                        운동 강의 영상 관리
                    </h2>
                    <button class="upload-button" onclick="uploadVideo()">영상 업로드</button>
                </div>

                <div class="video-grid">
                    <!-- Video Card 1 -->
                    <div class="video-card" onclick="playVideo('랭킹다운 상세')">
                        <div class="video-thumbnail">
                            <img src="https://images.unsplash.com/photo-1571019614242-c5c5dee9f50b?w=400&h=300&fit=crop" alt="랭킹다운 상세">
                            <div class="play-button">▶</div>
                        </div>
                        <div class="video-info">
                            <div class="video-title">랭킹다운 상세</div>
                            <div class="video-date">2025.10.20</div>
                            <button class="video-delete-button" onclick="event.stopPropagation(); deleteVideo('랭킹다운 상세', 1)">
                                <img src="${pageContext.request.contextPath}/resources/images/icon/delete.png" alt="삭제" class="video-delete-icon">
                            </button>
                        </div>
                    </div>

                    <!-- Video Card 2 -->
                    <div class="video-card" onclick="playVideo('데드리프트 완벽 가이드')">
                        <div class="video-thumbnail">
                            <img src="https://images.unsplash.com/photo-1534438327276-14e5300c3a48?w=400&h=300&fit=crop" alt="데드리프트 완벽 가이드">
                            <div class="play-button">▶</div>
                        </div>
                        <div class="video-info">
                            <div class="video-title">데드리프트 완벽 가이드</div>
                            <div class="video-date">2025.10.18</div>
                            <button class="video-delete-button" onclick="event.stopPropagation(); deleteVideo('데드리프트 완벽 가이드', 2)">
                                <img src="${pageContext.request.contextPath}/resources/images/icon/delete.png" alt="삭제" class="video-delete-icon">
                            </button>
                        </div>
                    </div>

                    <!-- Video Card 3 -->
                    <div class="video-card" onclick="playVideo('벤치프레스 마스터')">
                        <div class="video-thumbnail">
                            <img src="https://images.unsplash.com/photo-1517836357463-d25dfeac3438?w=400&h=300&fit=crop" alt="벤치프레스 마스터">
                            <div class="play-button">▶</div>
                        </div>
                        <div class="video-info">
                            <div class="video-title">벤치프레스 마스터</div>
                            <div class="video-date">2025.10.15</div>
                            <button class="video-delete-button" onclick="event.stopPropagation(); deleteVideo('벤치프레스 마스터', 3)">
                                <img src="${pageContext.request.contextPath}/resources/images/icon/delete.png" alt="삭제" class="video-delete-icon">
                            </button>
                        </div>
                    </div>

                    <!-- Video Card 4 -->
                    <div class="video-card" onclick="playVideo('아침 운동 루틴')">
                        <div class="video-thumbnail">
                            <img src="https://images.unsplash.com/photo-1581009146145-b5ef050c2e1e?w=400&h=300&fit=crop" alt="아침 운동 루틴">
                            <div class="play-button">▶</div>
                        </div>
                        <div class="video-info">
                            <div class="video-title">아침 운동 루틴</div>
                            <div class="video-date">2025.10.12</div>
                            <button class="video-delete-button" onclick="event.stopPropagation(); deleteVideo('아침 운동 루틴', 4)">
                                <img src="${pageContext.request.contextPath}/resources/images/icon/delete.png" alt="삭제" class="video-delete-icon">
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- 영상 재생 Modal -->
    <div class="modal-overlay" id="videoModal">
        <div class="modal-content">
            <div class="modal-header">
                <h3 class="modal-title" id="modalTitle">영상 재생</h3>
                <button class="close-button" onclick="closeModal()">×</button>
            </div>
            <div class="modal-body">
                <p>영상 플레이어가 곧 업데이트 될 예정입니다.</p>
                <p style="color: #b0b0b0; margin-top: 20px;">현재 구현은 YouTube 또는 외부 비디오 플레이어가 들어갑니다</p>
            </div>
        </div>
    </div>

    <!-- 영상 업로드 Modal -->
    <div class="modal-overlay" id="uploadModal">
        <div class="modal-content">
            <div class="modal-header">
                <h3 class="modal-title">영상 업로드</h3>
                <button class="close-button" onclick="closeUploadModal()">×</button>
            </div>
            <div class="modal-body">
                <form id="uploadVideoForm" class="upload-modal-form">
                    <div class="form-group">
                        <label class="form-label" for="youtubeUrl">유튜브 url</label>
                        <input type="text" id="youtubeUrl" name="youtubeUrl" class="form-input" placeholder="url 입력" required>
                    </div>
                    <div class="form-group">
                        <label class="form-label" for="videoTitle">영상 제목</label>
                        <input type="text" id="videoTitle" name="videoTitle" class="form-input" placeholder="영상 제목을 입력하세요" required>
                    </div>
                    <div class="form-group">
                        <label class="form-label" for="videoAuthor">작성자</label>
                        <input type="text" id="videoAuthor" name="videoAuthor" class="form-input" placeholder="작성자를 입력하세요" required>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="modal-btn modal-btn-cancel" onclick="closeUploadModal()">취소</button>
                        <button type="submit" class="modal-btn modal-btn-upload">업로드</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script>
        // 영상 재생
        function playVideo(title) {
            document.getElementById('modalTitle').textContent = title;
            document.getElementById('videoModal').classList.add('active');
        }

        // 모달 닫기
        function closeModal() {
            document.getElementById('videoModal').classList.remove('active');
        }

        // 모달 외부 클릭 시 닫기
        document.getElementById('videoModal').addEventListener('click', function(e) {
            if (e.target === this) {
                closeModal();
            }
        });

        // ESC 키로 모달 닫기
        document.addEventListener('keydown', function(e) {
            if (e.key === 'Escape') {
                closeModal();
                closeUploadModal();
            }
        });

        // 영상 업로드 모달 열기
        function uploadVideo() {
            document.getElementById('uploadModal').classList.add('active');
        }

        // 영상 업로드 모달 닫기
        function closeUploadModal() {
            document.getElementById('uploadModal').classList.remove('active');
            document.getElementById('uploadVideoForm').reset();
        }

        // 영상 업로드 모달 외부 클릭 시 닫기
        document.getElementById('uploadModal').addEventListener('click', function(e) {
            if (e.target === this) {
                closeUploadModal();
            }
        });

        // 영상 업로드 폼 제출
        document.getElementById('uploadVideoForm').addEventListener('submit', function(e) {
            e.preventDefault();
            
            const youtubeUrl = document.getElementById('youtubeUrl').value.trim();
            const videoTitle = document.getElementById('videoTitle').value.trim();
            const videoAuthor = document.getElementById('videoAuthor').value.trim();
            
            if (!youtubeUrl || !videoTitle || !videoAuthor) {
                alert('모든 필드를 입력해주세요.');
                return;
            }
            
            // TODO: 실제 서버로 데이터 전송
            alert('영상이 업로드되었습니다.');
            closeUploadModal();
            
            // 실제로는 서버로 데이터 전송
            // fetch('/api/video/upload', {
            //     method: 'POST',
            //     headers: { 'Content-Type': 'application/json' },
            //     body: JSON.stringify({ youtubeUrl, videoTitle, videoAuthor })
            // })
            // .then(response => response.json())
            // .then(data => {
            //     alert('영상이 업로드되었습니다.');
            //     closeUploadModal();
            //     location.reload();
            // })
            // .catch(error => {
            //     alert('업로드 중 오류가 발생했습니다.');
            // });
        });

        // 영상 삭제
        function deleteVideo(title, id) {
            if (confirm('정말로 "' + title + '" 영상을 삭제하시겠습니까?')) {
                // TODO: 실제 서버로 삭제 요청
                // fetch('/api/video/delete', {
                //     method: 'DELETE',
                //     headers: { 'Content-Type': 'application/json' },
                //     body: JSON.stringify({ videoId: id })
                // })
                // .then(response => response.json())
                // .then(data => {
                //     alert('영상이 삭제되었습니다.');
                //     location.reload();
                // })
                // .catch(error => {
                //     alert('삭제 중 오류가 발생했습니다.');
                // });
                
                alert('영상이 삭제되었습니다.');
                // 실제로는 카드 제거 또는 페이지 새로고침
                // location.reload();
            }
        }

        // 카드 진입 애니메이션
        window.addEventListener('load', function() {
            const cards = document.querySelectorAll('.video-card');
            cards.forEach((card, index) => {
                card.style.opacity = '0';
                card.style.transform = 'translateY(20px)';
                setTimeout(() => {
                    card.style.transition = 'all 0.5s ease';
                    card.style.opacity = '1';
                    card.style.transform = 'translateY(0)';
                }, index * 50);
            });
        });
    </script>
</body>
</html>

